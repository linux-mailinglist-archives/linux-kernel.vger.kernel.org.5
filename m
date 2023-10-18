Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532787CD63C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjJRIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjJRIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4BB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:20:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F510C433CC;
        Wed, 18 Oct 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617221;
        bh=kAQb1Dauqk/QmzH5qzVaRj1IjK5Gc50QF1fiNXcjCvg=;
        h=From:To:Cc:Subject:Date:From;
        b=NpVviRdtHRVoKEz8+v/XeRzsmtBxXo6p6FdYbxN1CAH3LiF6E7SLbpR5QjiICYSlJ
         VYrwkTxRrDlA//QFpH+j4HuUy3inTYg5TKbIVzoeZqXscZXbBlhVN4RRNj5AT8zI50
         v4sNRLq7jS9besmy9bcpCnejfDVEq+UvGP2osZB1SC7T6GuS7Bt3lBPB/c+3vAwZ2d
         BSnt84RfYVZSMslz8CTIYga64p+IeGakRUTx38AnZ3TsrThi1huQrHkTSJI3W55n5m
         c7lZWP+3yzZkWwnypG2WFtgBf1iwfSigW955I16oA67UPvZ5yOgqmO4Llf51IXhDcM
         k4GuEa3oUkrwg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 0/5] mlx5 ConnectX diagnostic misc driver
Date:   Wed, 18 Oct 2023 01:19:36 -0700
Message-ID: <20231018081941.475277-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

Hello Greg and Arnd,

The ConnectX HW family supported by the mlx5 drivers uses an architecture
where a FW component executes "mailbox RPCs" issued by the driver to make
changes to the device. This results in a complex debugging environment
where the FW component has information and complex low level state that
needs to be accessed to userspace for debugging purposes.

Historically a userspace program was used that accessed the PCI register
and config space directly through /sys/bus/pci/.../XXX and could operate
these debugging interfaces in parallel with the running driver.
This approach is incompatible with secure boot and kernel lockdown so this
driver provides a secure and restricted interface to that.

To solve this we add a misc driver "mlx5ctl" that would interface with
mlx5_core ConnectX driver to access the underlaying device debug
information. 

1) The first patch in the series introduces the main driver file with the
implementation of a new mlx5 auxiliary device driver to run on top
mlx5_core device instances, on probe it creates a new misc device and in
this patch we implement the open and release fops, On open the driver
would allocate a special FW UID (user context ID) restricted to debug
RPCs only, where all user debug RPCs will be executed under this UID,
and on release the UID will be freed.

2) The second patch adds an info ioctl that will show the allocated UID
and the available capability masks of the device and the current UID, and
some other useful device information such as the underlying ConnectX
device

Example:
    $ mlx5ctl mlx5_core.ctl.0
    mlx5dev: 0000:00:04.0
    UCTX UID: 1
    UCTX CAP: 0x3
    DEV UCTX CAP: 0x3
    USER CAP: 0x1d

3) Third patch adds RPC ioctl to execute debug RPCs under the
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

The registered/pinned memory will be described by a device UMEM object
which has a unique umem_id, this umem_id can be later used in the rpc
inbox to tell the device where to populate the response output,
e.g HW traces and other debug object queries.

Example usecase, a ConnectX device coredump can be as large as 2MB.
Using inline rpcs will take thousands of rpcs to get the full
coredump which can consume multiple seconds.

With UMEM, it can be done in a single rpc, using 2MB of umem user buffer.

Other usecases with umem:
  - dynamic HW and FW trace monitoring
  - high frequency diagnostic counters sampling
  - batched objects and resource dumps

See links below for information about user-space tools that use this
interface:

[1] https://github.com/saeedtx/mlx5ctl

[2] https://github.com/Mellanox/mstflint
see:
    d) mstregdump utility
      This utility dumps hardware registers from Mellanox hardware
      for later analysis by Mellanox.

    g) mstconfig
      This tool sets or queries non-volatile configurable options

    i) mstreg
      The mlxreg utility allows users to obtain information
      regarding supported access registers, such as their fields

Saeed Mahameed (5):
  mlx5: Add aux dev for ctl interface
  misc: mlx5ctl: Add mlx5ctl misc driver
  misc: mlx5ctl: Add info ioctl
  misc: mlx5ctl: Add command rpc ioctl
  misc: mlx5ctl: Add umem reg/unreg ioctl

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/mlx5ctl/Kconfig                  |  14 +
 drivers/misc/mlx5ctl/Makefile                 |   5 +
 drivers/misc/mlx5ctl/main.c                   | 528 ++++++++++++++++++
 drivers/misc/mlx5ctl/umem.c                   | 325 +++++++++++
 drivers/misc/mlx5ctl/umem.h                   |  17 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
 include/uapi/misc/mlx5ctl.h                   |  51 ++
 10 files changed, 951 insertions(+)
 create mode 100644 drivers/misc/mlx5ctl/Kconfig
 create mode 100644 drivers/misc/mlx5ctl/Makefile
 create mode 100644 drivers/misc/mlx5ctl/main.c
 create mode 100644 drivers/misc/mlx5ctl/umem.c
 create mode 100644 drivers/misc/mlx5ctl/umem.h
 create mode 100644 include/uapi/misc/mlx5ctl.h

-- 
2.41.0

