Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1B796EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjIGB7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjIGB7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:59:35 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9183619A0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 18:59:29 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230907015927epoutp0382e36857b5fbf5778aab0c1b4cd81d44~Ce0oLFvwa1564515645epoutp03v
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 01:59:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230907015927epoutp0382e36857b5fbf5778aab0c1b4cd81d44~Ce0oLFvwa1564515645epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694051967;
        bh=DNJJ1OytfW755Q77Ddf8MGHEt9FiJitFL4Jj1PUMvuU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cSbQsq5xFSniRzS1xG17Kn1EI5zLGsm9PV5vzlsaFayps3Y36C0J2VQqMxFWnexMI
         SK5foa4MJVy7Q2tTbkJn66Zhl1xPAXRHGtgzmODWzon++jpyMrw/h2fBY2XQig8vcq
         xkduHN5aqO9aNI8Ds2FFPeQlmfM3c2ruKnBwiH7M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230907015927epcas2p40eb32c1f77160943ed1460b27ccf6055~Ce0ncRM4a3251232512epcas2p4a;
        Thu,  7 Sep 2023 01:59:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rh2VQ0J4Tz4x9Px; Thu,  7 Sep
        2023 01:59:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.09.09649.D7E29F46; Thu,  7 Sep 2023 10:59:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8~Ce0mAU8Bi0386603866epcas2p35;
        Thu,  7 Sep 2023 01:59:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230907015925epsmtrp1e7e856445819f2b2e225f54619cad90e~Ce0l-bC-C2578225782epsmtrp1p;
        Thu,  7 Sep 2023 01:59:25 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-2a-64f92e7d8d61
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.B9.08788.D7E29F46; Thu,  7 Sep 2023 10:59:25 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230907015925epsmtip24ffc8da5764d90c4092974328dfb3e58~Ce0lxBjgC2709427094epsmtip2D;
        Thu,  7 Sep 2023 01:59:25 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v4] ufs: poll pmc until another pa request is completed
Date:   Thu,  7 Sep 2023 10:48:26 +0900
Message-Id: <1694051306-172962-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVLdW72eKQdcNc4uTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csFpsvfWNxEPC4fMXbY/Gel0weExYdYPT4vr6DzePj01ssHn1bVjF6
        fN4k59F+oJspgCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGiiPbmAu6TSoWnH3P2sB4T6uLkZNDQsBE4v6dU0xdjFwcQgI7GCVe3/3K
        DpIQEvjEKPHvhSBE4hujxJ62VnaYjvnH70N17GWUOHFtJguE84NRYsKLxywgVWwCmhJPb04F
        qxIR+MAk8X/5NkaQBLOAusSuCSeYQGxhAXeJ7QvuM4PYLAKqErvvvQKr4RVwk/h+5APUOjmJ
        m+c6mSHsTg6Jm6v0IGwXiRnfVzFB2MISr45vgaqXknjZ3wZkcwDZ2RJ7FopBhCskFk97ywJh
        G0vMetbOCFLCDHTn+l36ENXKEkdusUAcySfRcfgv1BBeiY42IYhGZYlfkyYzQtiSEjNv3oHa
        6SHRc+ssCyTcYiU+H5/NMoFRdhbC/AWMjKsYxVILinPTU4uNCozgUZScn7uJEZwktdx2ME55
        +0HvECMTB+MhRgkOZiUR3nfy31KEeFMSK6tSi/Lji0pzUosPMZoCA2sis5Rocj4wTeeVxBua
        WBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cC0d8WKP5kLtHstT5y9pWmo
        4H8z+iAjg0Zt4s2urW//uoZrBc738jgR/z1d4GXfAec2Tenj33UtPBlUMowfBHotvC4473RF
        ka5uwlbDnXnS7NGxDjJdnX0TvkoqlOx6GldytfMiz26jaenXf96KFrgm9kifffrUMMO4DObi
        hhhG4fhdB2IcdT49eaKv333O8Nrl0PKMu5feXq4U3mCgecm5Wfjbm9xpHr6PjMLTJjDzcDwO
        K5Y5UJ38KHPGHJ00zvc+36PZ5EWbLdb1bJRa8LGW1epBxIsq2SurrcV4/gRvPb01sYqZ2eHQ
        vl9Fi5Km3At4KCRzRlNxs73ejojPzHrMG1QvbXF6tOeNr6q9thJLcUaioRZzUXEiAI8lWWgb
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvG6t3s8UgxVLRS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI4oLpuU1JzMstQifbsErowVR7YxF3SbVCw4+561gfGeVhcjJ4eEgInE/OP3
        mboYuTiEBHYzSuxceIARIiEpcWLncyhbWOJ+yxFWiKJvjBJ/DkxgAUmwCWhKPL05FaxbRKCJ
        WeLS7OlgCWYBdYldE04wgdjCAu4S2xfcZwaxWQRUJXbfewU2lVfATeL7kQ/sEBvkJG6e62Se
        wMizgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcPhqae1g3LPqg94hRiYOxkOM
        EhzMSiK87+S/pQjxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TB
        KdXAlL/erPhTVqbYsp3zDnbo//pmyrZ7/vcJoS5lSW+bNL4Y7V50JH3a8pbNVYlLOHY9/dR7
        Q9B60uQL5y3mfQ05zpO9Vnl10/eY2/6efhxh4Vu8HNQFb//tFY+NXTu77phhvSrHQ3mpdJGD
        XFULlDKDvq8tebtV8tIcgyihz3Fb131el7TkAOOzHyrKLtFR+gXeEt8NbzWv+c++NGve1nJb
        76tSrW7vG5bfN3rBmr7c6MuyT9p7UuZFvNijzbspcIaGVvUt61t7V67ZdpxnvcyNqMjJsRna
        b4wmuRmuuuvSt6Ntx0zLaWezL67nPPg6WqAtwrzWJN/4rmHco+Sn06WeHA29ovZX92jE9pOH
        b+eX3FdiKc5INNRiLipOBAAVqN8izgIAAA==
X-CMS-MailID: 20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8
References: <CGME20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding 5.7.12.1.1 in Unipro v1.8, PA rejects sebsequent
requests following the first request from upper layer or remote.
In this situation, PA responds w/ BUSY in cases
when they come from upper layer and does nothing for
the requests. So HCI doesn't receive ind, a.k.a. indicator
for its requests and an interrupt, IS.UPMS isn't generated.

When LINERESET occurs, the error handler issues PMC which is
recognized as a request for PA. If a host's PA gets or raises
LINERESET, and a request for PMC, this could be a concurrent
situation mentioned above. And I found that situation w/ my
environment.

[  222.929539]I[0:DefaultDispatch:20410] exynos-ufs 13500000.ufs: ufshcd_update_uic_error: uecdl : 0x80000002
[  222.999009]I[0: arch_disk_io_1:20413] exynos-ufs 13500000.ufs: ufshcd_update_uic_error: uecpa : 0x80000010
[  222.999200] [6:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufs_pwr_mode_restore_needed : mode = 0x15, pwr_rx = 1, pwr_tx = 1
[  223.002876]I[0: arch_disk_io_3:20422] exynos-ufs 13500000.ufs: ufshcd_update_uic_error: uecpa : 0x80000010
[  223.501050] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: pwr ctrl cmd 0x2 with mode 0x11 completion timeout
[  223.502305] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufshcd_change_power_mode: power mode change failed -110
[  223.502312] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufshcd_err_handler: Failed to restore power mode, err = -110
[  223.502392] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufshcd_is_pwr_mode_restore_needed : mode = 0x11, pwr_rx = 1, pwr_tx = 1

This patch is to poll PMC's result w/o checking its ind until
the result is not busy, i.e. 09h, to avoid the rejection.

And this patch requires the following patch because it assumes
__ufshcd_send_uic_cmd doesn't require host_lock.
https://lore.kernel.org/linux-scsi/bec84ee1ce8f5c5971b98d8e501aeabb9b5b26d1.1686716811.git.kwmad.kim@samsung.com/

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>

---
v3 -> v4
1) change description

v2 -> v3
1) check time in the loop with jiffies, instead of miliseconds.
2) change a variable's name and fix a typo and wrong alignment.

v1 -> v2
1) remove clearing hba->active_uic_cmd at the end of __ufshcd_poll_uic_pwr
2) change commit message on the cited clause: 5.7.12.11 -> 5.7.12.1.1
3) add mdelay to avoid too many issueing
4) change the timeout for the polling to 100ms because I found it
sometimes takes much longer than expected.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 93 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7bc3fc4..f6b8659 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -98,6 +98,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Polling time to wait until PA is ready */
+#define UIC_PA_RDY_TIMEOUT	100	/* millisecs */
+
 /* UFSHC 4.0 compliant HC support this mode. */
 static bool use_mcq_mode = true;
 
@@ -4120,6 +4123,62 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 }
 EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
 
+static int __ufshcd_poll_uic_pwr(struct ufs_hba *hba, struct uic_command *cmd,
+		struct completion *cnf)
+{
+	unsigned long flags;
+	int ret;
+	u32 mode = cmd->argument3;
+	unsigned long deadline = jiffies +
+		msecs_to_jiffies(UIC_PA_RDY_TIMEOUT);
+
+	do {
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		hba->active_uic_cmd = NULL;
+		if (ufshcd_is_link_broken(hba)) {
+			spin_unlock_irqrestore(hba->host->host_lock, flags);
+			ret = -ENOLINK;
+			goto out;
+		}
+		hba->uic_async_done = cnf;
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+		cmd->argument2 = 0;
+		cmd->argument3 = mode;
+		ret = __ufshcd_send_uic_cmd(hba, cmd, true);
+		if (ret) {
+			dev_err(hba->dev,
+				"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
+				cmd->command, cmd->argument3, ret);
+			goto out;
+		}
+
+		/* This value is heuristic */
+		if (!wait_for_completion_timeout(&cmd->done,
+						 msecs_to_jiffies(5))) {
+			ret = -ETIMEDOUT;
+			dev_err(hba->dev,
+				"pwr ctrl cmd 0x%x with mode 0x%x timeout\n",
+				cmd->command, cmd->argument3);
+			if (cmd->cmd_active)
+				goto out;
+
+			dev_info(hba->dev, "%s: pwr ctrl cmd has already been completed\n", __func__);
+		}
+
+		/* retry only for busy cases */
+		ret = cmd->argument2 & MASK_UIC_COMMAND_RESULT;
+		if (ret != UIC_CMD_RESULT_BUSY)
+			break;
+
+		dev_info(hba->dev, "%s: PA is busy and can't handle a requeest, %d\n", __func__, ret);
+		mdelay(1);
+
+	} while (time_before(jiffies, deadline));
+out:
+	return ret;
+}
+
 /**
  * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
  * state) and waits for it to take effect.
@@ -4142,33 +4201,13 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	unsigned long flags;
 	u8 status;
 	int ret;
-	bool reenable_intr = false;
 
-	mutex_lock(&hba->uic_cmd_mutex);
-	ufshcd_add_delay_before_dme_cmd(hba);
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (ufshcd_is_link_broken(hba)) {
-		ret = -ENOLINK;
-		goto out_unlock;
-	}
-	hba->uic_async_done = &uic_async_done;
-	if (ufshcd_readl(hba, REG_INTERRUPT_ENABLE) & UIC_COMMAND_COMPL) {
-		ufshcd_disable_intr(hba, UIC_COMMAND_COMPL);
-		/*
-		 * Make sure UIC command completion interrupt is disabled before
-		 * issuing UIC command.
-		 */
-		wmb();
-		reenable_intr = true;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
+	ret = __ufshcd_poll_uic_pwr(hba, cmd, &uic_async_done);
 	if (ret) {
-		dev_err(hba->dev,
-			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
-			cmd->command, cmd->argument3, ret);
-		goto out;
+		if (ret == -ENOLINK)
+			goto out_unlock;
+		else
+			goto out;
 	}
 
 	if (!wait_for_completion_timeout(hba->uic_async_done,
@@ -4205,14 +4244,12 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->active_uic_cmd = NULL;
 	hba->uic_async_done = NULL;
-	if (reenable_intr)
-		ufshcd_enable_intr(hba, UIC_COMMAND_COMPL);
 	if (ret) {
 		ufshcd_set_link_broken(hba);
 		ufshcd_schedule_eh_work(hba);
 	}
-out_unlock:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+out_unlock:
 	mutex_unlock(&hba->uic_cmd_mutex);
 
 	return ret;
-- 
2.7.4

