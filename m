Return-Path: <linux-kernel+bounces-35316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC90838F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D81C27292
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900295FBA7;
	Tue, 23 Jan 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY5FiRHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A55FB93;
	Tue, 23 Jan 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015284; cv=none; b=UMnnzkmmoRbyQe5OSs2CFe/E7+clpHKCO/5Kav4BrShTBMCfC6YbWkWl4o2OQhhfW4tq9DN7lAnJjgBof+8kaiD5G0m+O/5xvrs67kRoDc/5KRtwiF2vU+3LwPvdV/dMf5TVtQUr/bLXdm/3t6FI8lfNXT83Osubu0erI97L+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015284; c=relaxed/simple;
	bh=Iht0LmkPxLLHVKnMAeIfFdEQMIe3jvBDV9Mk4EEPtBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8PtjW8XrBuF3DbhqFw3UK78QV4BKBgQIfqRfGtBfyzZuQMyd76L8I2bOq+x6O3Hj5R3MwY3akeMabtbnrN63ESk4iNpK8bF+b3hd9ZjXIIj7UpMknZ2MViPsSinssmHYjYiKdwLjlX3C9s0w33nGy6kqmcvVnIhU6xGlaQSKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY5FiRHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB40C433C7;
	Tue, 23 Jan 2024 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015284;
	bh=Iht0LmkPxLLHVKnMAeIfFdEQMIe3jvBDV9Mk4EEPtBk=;
	h=From:To:Cc:Subject:Date:From;
	b=eY5FiRHb6bU/8LTk7eX7LiBJrz/Ai4un0wTvOGZvNySeTHdpGIeKwR0RNBM4Qbb/z
	 mKM3RifQvpuWh+6CY+opvNFiBRrb9pRM0p15uGHADLRUfSNwOvGiFWNwtyYD+2qtDJ
	 PTzCu7zbx6xfNGUi524CsNnMDUEB07vJCloaKeTCn0XC63Sv8avlB6dkgC4CN0GSTJ
	 F7oukveaBmtZsOpIYFcqBIUFQDPG4fNhRvRXODkjVp6A5QN36nvqwI18mtdXP2vQ6x
	 ssa3yIO34lnp5m+SFKsqHmvIo+cMfqjg8CVOdy0wFHWpAMjc8qWc+rxG+5IL8T3n9I
	 5WEn9irEz6IfA==
From: Arnd Bergmann <arnd@kernel.org>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	Tomas Henzl <thenzl@redhat.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] scsi: mpi3mr: reduce stack usage in mpi3mr_refresh_sas_ports()
Date: Tue, 23 Jan 2024 14:07:36 +0100
Message-Id: <20240123130754.2011469-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Doubling the number of PHYs also doubled the stack usage of this function,
exceeding the 32-bit limit of 1024 bytes:

drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_refresh_sas_ports':
drivers/scsi/mpi3mr/mpi3mr_transport.c:1818:1: error: the frame size of 1636 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Since the sas_io_unit_pg0 structure is already allocated dynamically, use
the same method here. The size of the allocation can be smaller based on the
actual number of phys now, so use this as an upper bound.

Fixes: cb5b60894602 ("scsi: mpi3mr: Increase maximum number of PHYs to 64 from 32")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix number of ports to be always 64 rather than num_phys
---
 drivers/scsi/mpi3mr/mpi3mr_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr/mpi3mr_transport.c
index c0c8ab586957..d32ad46318cb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -1671,7 +1671,7 @@ mpi3mr_update_mr_sas_port(struct mpi3mr_ioc *mrioc, struct host_port *h_port,
 void
 mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
 {
-	struct host_port h_port[64];
+	struct host_port *h_port = NULL;
 	int i, j, found, host_port_count = 0, port_idx;
 	u16 sz, attached_handle, ioc_status;
 	struct mpi3_sas_io_unit_page0 *sas_io_unit_pg0 = NULL;
@@ -1685,6 +1685,10 @@ mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
 	sas_io_unit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_io_unit_pg0)
 		return;
+	h_port = kcalloc(64, sizeof(struct host_port), GFP_KERNEL);
+	if (!h_port)
+		goto out;
+
 	if (mpi3mr_cfg_get_sas_io_unit_pg0(mrioc, sas_io_unit_pg0, sz)) {
 		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
 		    __FILE__, __LINE__, __func__);
@@ -1814,6 +1818,7 @@ mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
 		}
 	}
 out:
+	kfree(h_port);
 	kfree(sas_io_unit_pg0);
 }
 
-- 
2.39.2


