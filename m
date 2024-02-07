Return-Path: <linux-kernel+bounces-56072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DC84C5A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4560A28489E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C21F952;
	Wed,  7 Feb 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5BR/Drb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CE1F61C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290904; cv=none; b=RW9BW6cVGHfW6w5uAfiPBezNBcJzwZsFMMn6CsZq9i5zq5kkPM2+F15nb+22iAaInGIfPdK4y0/Si0VA5frETgMzxHriMCt6rIpWp+rxZ4LU4fxnLlwKFY6q3Lbj35AzhAGUF7lks+o0sjV0a2X0TS3GbTzM1fC7jE6CpV2Ee0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290904; c=relaxed/simple;
	bh=eGtrr4VW10JCFCUBkjAf6PTQszmNmJaBy09Ocx3LzZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E43YO/wlDHL7VCLwD1TMefNGHEyXxhDMDhSvEoMGeHTX1NwW/J97UUFQup+0LvzQS9v8YfRJiWrKB61g8aqOvyRuoryPECSlVIbCg7FR1PRAqODo6hEbjZc76irrMHLddioj4txLTrm59b+3uoO4MjJKBdhprYsFwS8jcjV6QGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5BR/Drb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB6C433C7;
	Wed,  7 Feb 2024 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707290903;
	bh=eGtrr4VW10JCFCUBkjAf6PTQszmNmJaBy09Ocx3LzZk=;
	h=From:To:Cc:Subject:Date:From;
	b=k5BR/DrbkoYmLsOW1P3a06ls7ei+TGqP/YQvryerjvBVCOJTy+Yl3eVUh5IV3yd+/
	 MdLE8TGDOFvDzNyAIFADTTReAU2noF5KT3WUvjBDB6yqomhmW63VFiY4JZ9Vl3Uf/s
	 BliPXa3reIZOVMKTKSlXeQd2a/2uU7+dwwDVGM6CBZr+swA8JHASdx7h6LRE2U3AP1
	 bnAY4ECSU04peF60ukbSFOrYdfPOwD7uLeljTonEcS8IO5FAUmd8k1a8cKo/5CIAEI
	 KzVx/BeXhRidQJ1RdG+fDVx+gVoEBMEnWG6cNzsgsYa/jp4951SMnILOEK+gtfFh8T
	 y+6M3VVyA2pMw==
From: Saeed Mahameed <saeed@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Date: Tue,  6 Feb 2024 23:24:30 -0800
Message-ID: <20240207072435.14182-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Recap from V3 discussion:
=========================

LWN has published an article on this series aptly summarizing the debate.
LINK: https://lwn.net/Articles/955001/

We continue to think that mlx5ctl is reasonable and aligned with the
greater kernel community values. People have pointed to the HW RAID
miscdevices as a good analog. The MD developers did not get to block HW
RAID configuration on the basis that it undermines their work on the
software RAID stack. Further, while there is a superficial similarity to
the DRM/accel debate, that was grounded in a real concern that DRM values
on open source would be bypassed. That argument does not hold up here as
this does come with open source userspace and the functionality mlx5ctl
enables on lockdown has always been available to ConnectX users through
the non-lockdown PCI sysfs. netdev has been doing just fine despite the
long standing presence of this tooling and we have continued to work with
Jakub on building common APIs when appropriate. mlx5 already implements
a wide range of the netdev common interfaces, many of which were pushed
forward by our staff - the DPLL configuration netlink being a recent
example.

Version history:
================
V3: https://lore.kernel.org/all/20231121070619.9836-1-saeed@kernel.org/#r
V2: https://lore.kernel.org/all/20231119092450.164996-1-saeed@kernel.org/#r
V1: https://lore.kernel.org/all/20231018081941.475277-1-saeed@kernel.org/#r

V3->V4:
 - Document locking scheme for device lifecycle
 - Document reserved bits will always be checked for 0 by driver
 - Use GFP_KERNEL instead of ACCOUNT for short lived buffers
 - Create sysfs link to parent device under the misc device's sysfs
 - Remove unnecessary device name from info ioctl output
 - Remove reserved and future flags fields from ioctls
 - Precise size checking for ioctl user input.

V2->V3:
  - Fix bad Sign-off line.
  - Fix kernel robot warnings, define a user ptr arg for umem_unreg ioctl
    instead of plain integer to simplify compat_ioctl usage.

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

mlx5 ConnectX control misc driver:
==================================

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

Patch breakdown:
================

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

[3] https://lore.kernel.org/all/20231018081941.475277-3-saeed@kernel.org/#r

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com> # for legal
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Nacked-by: Jakub Kicinski <kuba@kernel.org>

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
 drivers/misc/mlx5ctl/main.c                   | 597 ++++++++++++++++++
 drivers/misc/mlx5ctl/umem.c                   | 322 ++++++++++
 drivers/misc/mlx5ctl/umem.h                   |  17 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
 include/uapi/misc/mlx5ctl.h                   |  50 ++
 11 files changed, 1024 insertions(+)
 create mode 100644 drivers/misc/mlx5ctl/Kconfig
 create mode 100644 drivers/misc/mlx5ctl/Makefile
 create mode 100644 drivers/misc/mlx5ctl/main.c
 create mode 100644 drivers/misc/mlx5ctl/umem.c
 create mode 100644 drivers/misc/mlx5ctl/umem.h
 create mode 100644 include/uapi/misc/mlx5ctl.h

--
2.43.0


