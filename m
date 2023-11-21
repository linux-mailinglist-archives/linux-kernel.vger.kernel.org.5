Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04F7F261A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKUHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKUHGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:06:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD3BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:06:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8E0C433C7;
        Tue, 21 Nov 2023 07:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700550386;
        bh=7ALIGETgmGAhWegSW05DZVOp/CcyW8H4VslLpZ4CuHY=;
        h=From:To:Cc:Subject:Date:From;
        b=DMYGUKPx1/GZCdOMI5wFuWDmLKewoFeSPXZK95ZmfBdE5EwMY2TzMsFhVQHY3z7Lg
         n57IVnoBhvTIZ9l/4BdttKPXDZFFjrr3gKXeIIezQfv3Zs5zwboZhtZRJMBOtotsGS
         k2b5zYd0k7zMYF2mCM9oSPCuV31KD1voIjJkX6IZMt581xwpfjTBfnGkHEcUng8wAA
         4TDYYeAMbU33upIfHen9scPIuquncMD/dFxWH+vMBiUpzOZMPa0953VpNE9Iuwt9i8
         580NBBMtFBAln48hVLCzloc/3FZDS/HzPPIObVZTq5TOl0D/4YsRdiGpHudM6Zwi7L
         5sDlmQtHp/GCQ==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH V3 0/5] mlx5 ConnectX control misc driver
Date:   Mon, 20 Nov 2023 23:06:14 -0800
Message-ID: <20231121070619.9836-1-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

V1: https://lore.kernel.org/all/20231018081941.475277-1-saeed@kernel.org/#r
V2: https://lore.kernel.org/all/20231119092450.164996-1-saeed@kernel.org/#r

V2->V3:
  - Fix bad Sign-off line
  - Fix kernel robot warnings, define a user ptr arg for umem_unreg ioctl
    instead of plain integer to simplify compat_ioctl usage added in V2

V1->V2:
  - Provide legal statement and sign-off for dual license use
  - Fix License clause to use: BSD-3-Clause OR GPL-2.0
  - Fix kernel robot warnings
  - Use dev_dbg directly instead of umem_dbg() local wrapper
  - Implement .compat_ioctl for 32bit compatibility
  - Fix mlx5ctl_info ABI structure size and alignment
  - Local pointer to correct type instead of in-place cast
  - Check unused fields and flags are 0 on ioctl path
  - Use correct macro to declare scalar arg ioctl command
    #define MLX5CTL_IOCTL_UMEM_UNREG \
           _IO(MLX5CTL_IOCTL_MAGIC, 0x3)

mlx5 ConnectX control misc driver
=================================

The ConnectX HW family supported by the mlx5 drivers uses an architecture
where a FW component executes "mailbox RPCs" issued by the driver to make
changes to the device. This results in a complex debugging environment
where the FW component has information and low level configuration that
needs to be accessed to userspace for debugging purposes.

Historically a userspace program was used that accessed the PCI register
and config space directly through /sys/bus/pci/.../XXX and could operate
these debugging interfaces in parallel with the running driver.
This approach is incompatible with secure boot and kernel lockdown so this
driver provides a secure and restricted interface to that.

1) The first patch in the series introduces the main driver file with the
implementation of a new mlx5 auxiliary device driver to run on top
mlx5_core device instances, on probe it creates a new misc device and in
this patch we implement the open and release fops, On open the driver
would allocate a special FW UID (user context ID) restricted to debug
RPCs only, where all user debug rpcs will be executed under this UID,
and on release the UID will be freed.

2) The second patch adds an info ioctl that will show the allocated UID
and the available capability masks of the device and the current UID, and
some other useful device information such as the underlying ConnectX

Example:
    $ sudo ./mlx5ctlu mlx5_core.ctl.0
    mlx5dev: 0000:00:04.0
    UCTX UID: 1
    UCTX CAP: 0x3
    DEV UCTX CAP: 0x3
    USER CAP: 0x1d

3) Third patch will add the capability to execute debug RPCs under the
special UID.

In the mlx5 architecture the FW RPC commands are of the format of
inbox and outbox buffers. The inbox buffer contains the command
rpc layout as described in the ConnectX Programmers Reference Manual
(PRM) document and as defined in linux/include/mlx5/mlx5_ifc.h.

On success the user outbox buffer will be filled with the device's rpc
response.

For example to query device capabilities:
a user fills out an inbox buffer with the inbox layout:
    struct mlx5_ifc_query_hca_cap_in_bits
and expects an outbox buffer with the layout:
     struct mlx5_ifc_cmd_hca_cap_bits

4) The fourth patch adds the ability to register user memory into the
ConntectX device and create a umem object that points to that memory.

Command rpc outbox buffer is limited in size, which can be very
annoying when trying to pull large traces out of the device.
Many rpcs offer the ability to scatter output traces, contexts
and logs directly into user space buffers in a single shot.

The registered memory will be described by a device UMEM object which
has a unique umem_id, this umem_id can be later used in the rpc inbox
to tell the device where to populate the response output,
e.g HW traces and other debug object queries.

Example usecase, a ConnectX device coredump can be as large as 2MB.
Using inline rpcs will take thousands of rpcs to get the full
coredump which can consume multiple seconds.

With UMEM, it can be done in a single rpc, using 2MB of umem user buffer.

Other usecases with umem:
  - dynamic HW and FW trace monitoring
  - high frequency diagnostic counters sampling
  - batched objects and resource dumps

See links below for information about user space tools that use this
interface:

[1] https://github.com/saeedtx/mlx5ctl

[2] https://github.com/Mellanox/mstflint
see:

   d) mstregdump utility
      This utility dumps hardware registers from Mellanox hardware
      for later analysis by Mellanox.

    g) mstconfig
      This tool sets or queries non-volatile configurable options
      for Mellanox HCAs.

    h) mstfwmanager
      Mellanox firmware update and query utility which scans the system
      for available Mellanox devices (only mst PCI devices) and performs
      the necessary firmware updates.

    i) mstreg
      The mlxreg utility allows users to obtain information regarding
      supported access registers, such as their fields

License: BSD-3-Clause OR GPL-2.0
================================
After a review of this thread [3], and a conversation with the LF,
Mellanox and NVIDIA legal continue to approve the use of a Dual GPL &
Permissive License for mlx5 related driver contributions. This makes it
clear to future contributors that this file may be adapted and reused
under BSD-3-Clause terms on other operating systems. Contributions will
be handled in the normal way and the dual license will apply
automatically. If people wish to contribute significantly and opt out of
a dual license they may separate their GPL only contributions in dedicated
files.

Jason has a signing authority for NVIDIA and has gone through our internal
process to get approval.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com> # for legal

[3] https://lore.kernel.org/all/20231018081941.475277-3-saeed@kernel.org/#r

================================

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Saeed Mahameed (5):
  mlx5: Add aux dev for ctl interface
  misc: mlx5ctl: Add mlx5ctl misc driver
  misc: mlx5ctl: Add info ioctl
  misc: mlx5ctl: Add command rpc ioctl
  misc: mlx5ctl: Add umem reg/unreg ioctl

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/mlx5ctl/Kconfig                  |  14 +
 drivers/misc/mlx5ctl/Makefile                 |   5 +
 drivers/misc/mlx5ctl/main.c                   | 579 ++++++++++++++++++
 drivers/misc/mlx5ctl/umem.c                   | 322 ++++++++++
 drivers/misc/mlx5ctl/umem.h                   |  17 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
 include/uapi/misc/mlx5ctl.h                   |  59 ++
 11 files changed, 1015 insertions(+)
 create mode 100644 drivers/misc/mlx5ctl/Kconfig
 create mode 100644 drivers/misc/mlx5ctl/Makefile
 create mode 100644 drivers/misc/mlx5ctl/main.c
 create mode 100644 drivers/misc/mlx5ctl/umem.c
 create mode 100644 drivers/misc/mlx5ctl/umem.h
 create mode 100644 include/uapi/misc/mlx5ctl.h

--
2.42.0

