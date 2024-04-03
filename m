Return-Path: <linux-kernel+bounces-130327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E688976CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF971C294C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECB15F413;
	Wed,  3 Apr 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oco9Qqhw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDC153BC4;
	Wed,  3 Apr 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164756; cv=none; b=CR9y0yMKzxK5bJTmlbUKJD8Yqhw/w6DvlF6bGASbESEXUj6rqvgJJIcfNrQPQfZL9S/jBxOa+lMGd0+r2m6l0jBmyNJj/37XtTWsV6/BdkycquXCM4s1rRWGcip9OP46uOPuQu36T92wcof9s5B24J0pHC4s5xq6RUNg4pne0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164756; c=relaxed/simple;
	bh=AuWm8VPtxA3NvMNa5GLc39tWpB+s5a8wdjvLONGKg8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwZUv7NwDH1MEABYx5XJVDgCBSXWLx3DwuuuUZiT+ajtC12qf42XA5rNdwfxMUNJxQLaakDjrluBtXp/V2yWXVpwmKD7FlfrKsCAbuFpdXG7w1HAU5qmAOI8kMwM6MUtFp4t6XzaDNQsAd/IqYcw4CHeYzxgpccfXLzUNrJ3Z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oco9Qqhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6FCC433C7;
	Wed,  3 Apr 2024 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164756;
	bh=AuWm8VPtxA3NvMNa5GLc39tWpB+s5a8wdjvLONGKg8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oco9Qqhw7DTIF/n97JmJIgnrxl7XDxpRUWRL5bYqceG/lwmyRedzpbNwOE7kTgIWo
	 ebOlpFxrmtLX+EXTPC4UePVNg3/IQRA5bD8TH2FHjHEddcwcpfYWaVKjPnvIndnfep
	 2ICDAllE1cTAubcvyho6j7Dd/YqRlM6Pc3schz0qctpKjebU6eM98zx4KhO1FCkD1X
	 BQaj1m638mNYELbzed4RGzFmCFtQM7qFFOUn5wOTvlqyJYK6K0CBwg4NEAodi8mDCi
	 1q8UBT50550vGnrUTY8YxPJkAv/nOno+J6rmxpr8tRf0WQ/o+lYH2SJVsQTd1K9sg3
	 DLHGOeGZfPMhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	quic_qianyu@quicinc.com,
	Julia.Lawall@inria.fr,
	quic_pkanojiy@quicinc.com,
	quic_krichai@quicinc.com,
	rostedt@goodmis.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/15] bus: mhi: host: Add MHI_PM_SYS_ERR_FAIL state
Date: Wed,  3 Apr 2024 13:18:47 -0400
Message-ID: <20240403171909.345570-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Jeffrey Hugo <quic_jhugo@quicinc.com>

[ Upstream commit bce3f770684cc1d91ff9edab431b71ac991faf29 ]

When processing a SYSERR, if the device does not respond to the MHI_RESET
from the host, the host will be stuck in a difficult to recover state.
The host will remain in MHI_PM_SYS_ERR_PROCESS and not clean up the host
channels.  Clients will not be notified of the SYSERR via the destruction
of their channel devices, which means clients may think that the device is
still up.  Subsequent SYSERR events such as a device fatal error will not
be processed as the state machine cannot transition from PROCESS back to
DETECT.  The only way to recover from this is to unload the mhi module
(wipe the state machine state) or for the mhi controller to initiate
SHUTDOWN.

This issue was discovered by stress testing soc_reset events on AIC100
via the sysfs node.

soc_reset is processed entirely in hardware.  When the register write
hits the endpoint hardware, it causes the soc to reset without firmware
involvement.  In stress testing, there is a rare race where soc_reset N
will cause the soc to reset and PBL to signal SYSERR (fatal error).  If
soc_reset N+1 is triggered before PBL can process the MHI_RESET from the
host, then the soc will reset again, and re-run PBL from the beginning.
This will cause PBL to lose all state.  PBL will be waiting for the host
to respond to the new syserr, but host will be stuck expecting the
previous MHI_RESET to be processed.

Additionally, the AMSS EE firmware (QSM) was hacked to synthetically
reproduce the issue by simulating a FW hang after the QSM issued a
SYSERR.  In this case, soc_reset would not recover the device.

For this failure case, to recover the device, we need a state similar to
PROCESS, but can transition to DETECT.  There is not a viable existing
state to use.  POR has the needed transitions, but assumes the device is
in a good state and could allow the host to attempt to use the device.
Allowing PROCESS to transition to DETECT invites the possibility of
parallel SYSERR processing which could get the host and device out of
sync.

Thus, invent a new state - MHI_PM_SYS_ERR_FAIL

This essentially a holding state.  It allows us to clean up the host
elements that are based on the old state of the device (channels), but
does not allow us to directly advance back to an operational state.  It
does allow the detection and processing of another SYSERR which may
recover the device, or allows the controller to do a clean shutdown.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240112180800.536733-1-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/init.c     |  1 +
 drivers/bus/mhi/host/internal.h |  9 ++++++---
 drivers/bus/mhi/host/pm.c       | 20 +++++++++++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 04fbccff65ac2..60c1df048fa20 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -62,6 +62,7 @@ static const char * const mhi_pm_state_str[] = {
 	[MHI_PM_STATE_FW_DL_ERR] = "Firmware Download Error",
 	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS ERROR Detect",
 	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS ERROR Process",
+	[MHI_PM_STATE_SYS_ERR_FAIL] = "SYS ERROR Failure",
 	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
 	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "Linkdown or Error Fatal Detect",
 };
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 01fd10a399b61..6abf09da4f618 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -88,6 +88,7 @@ enum mhi_pm_state {
 	MHI_PM_STATE_FW_DL_ERR,
 	MHI_PM_STATE_SYS_ERR_DETECT,
 	MHI_PM_STATE_SYS_ERR_PROCESS,
+	MHI_PM_STATE_SYS_ERR_FAIL,
 	MHI_PM_STATE_SHUTDOWN_PROCESS,
 	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
 	MHI_PM_STATE_MAX
@@ -104,14 +105,16 @@ enum mhi_pm_state {
 #define MHI_PM_FW_DL_ERR				BIT(7)
 #define MHI_PM_SYS_ERR_DETECT				BIT(8)
 #define MHI_PM_SYS_ERR_PROCESS				BIT(9)
-#define MHI_PM_SHUTDOWN_PROCESS				BIT(10)
+#define MHI_PM_SYS_ERR_FAIL				BIT(10)
+#define MHI_PM_SHUTDOWN_PROCESS				BIT(11)
 /* link not accessible */
-#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(11)
+#define MHI_PM_LD_ERR_FATAL_DETECT			BIT(12)
 
 #define MHI_REG_ACCESS_VALID(pm_state)			((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
 						MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
 						MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
-						MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+						MHI_PM_SYS_ERR_FAIL | MHI_PM_SHUTDOWN_PROCESS |  \
+						MHI_PM_FW_DL_ERR)))
 #define MHI_PM_IN_ERROR_STATE(pm_state)			(pm_state >= MHI_PM_FW_DL_ERR)
 #define MHI_PM_IN_FATAL_STATE(pm_state)			(pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
 #define MHI_DB_ACCESS_VALID(mhi_cntrl)			(mhi_cntrl->pm_state & mhi_cntrl->db_access)
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 8a4362d75fc43..27f8a40f288cf 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -36,7 +36,10 @@
  *     M0 <--> M0
  *     M0 -> FW_DL_ERR
  *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
- * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS
+ *     SYS_ERR_PROCESS -> SYS_ERR_FAIL
+ *     SYS_ERR_FAIL -> SYS_ERR_DETECT
+ *     SYS_ERR_PROCESS --> POR
  * L2: SHUTDOWN_PROCESS -> LD_ERR_FATAL_DETECT
  *     SHUTDOWN_PROCESS -> DISABLE
  * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
@@ -93,7 +96,12 @@ static const struct mhi_pm_transitions dev_state_transitions[] = {
 	},
 	{
 		MHI_PM_SYS_ERR_PROCESS,
-		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_POR | MHI_PM_SYS_ERR_FAIL | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_FAIL,
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
 		MHI_PM_LD_ERR_FATAL_DETECT
 	},
 	/* L2 States */
@@ -624,7 +632,13 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 					!in_reset, timeout);
 		if (!ret || in_reset) {
 			dev_err(dev, "Device failed to exit MHI Reset state\n");
-			goto exit_sys_error_transition;
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			cur_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_FAIL);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			/* Shutdown may have occurred, otherwise cleanup now */
+			if (cur_state != MHI_PM_SYS_ERR_FAIL)
+				goto exit_sys_error_transition;
 		}
 
 		/*
-- 
2.43.0


