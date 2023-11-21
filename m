Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587777F2628
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjKUHJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKUHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:09:00 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9590
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:08:56 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231121070853epoutp028c299961ee8e26d405b925ef21f272a7~ZkbNJ4Q-Y1557215572epoutp02l
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:08:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231121070853epoutp028c299961ee8e26d405b925ef21f272a7~ZkbNJ4Q-Y1557215572epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700550533;
        bh=lBjdn6WWcT1XANKqVORRZYdex80nzvC7N8zEsyJf6Uc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MriSAoWSMv8o6qsTLKYl8vXpprQgAITO+vCOcv2r7M7vDWEnFiMTlzHqfmFwRKqMa
         PAjLunenJdYl+BCUoFMSPf8YuiU567mgTZirMs0qYdmUOuuArocex6mKMuMTZVYVQR
         4WkvUxbhZQSvrQmwFncmLxrEFDYq8Q7E1nw+WhBg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231121070852epcas2p373496f57296f392bab8982f8cef423a7~ZkbMkEoUQ1994119941epcas2p3p;
        Tue, 21 Nov 2023 07:08:52 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SZFpr0lfWz4x9QF; Tue, 21 Nov
        2023 07:08:52 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.60.08648.3875C556; Tue, 21 Nov 2023 16:08:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231121070851epcas2p2ba11977edde23d3dcb87581e410806c8~ZkbLVSrDL2441824418epcas2p2G;
        Tue, 21 Nov 2023 07:08:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231121070851epsmtrp272dcc865251bb4d0db158deb0b0d4358~ZkbLTBCH_1371513715epsmtrp2r;
        Tue, 21 Nov 2023 07:08:51 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-fa-655c578335df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.A4.08755.3875C556; Tue, 21 Nov 2023 16:08:51 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231121070851epsmtip292335baadde9a40ebd123e2e92ac0bc0~ZkbLE5_sG2915529155epsmtip2U;
        Tue, 21 Nov 2023 07:08:51 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v3] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Date:   Tue, 21 Nov 2023 16:11:28 +0900
Message-Id: <20231121071128.7743-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmqW5LeEyqwaf9TBYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjT4tff9ewWqxc/YLFYdGMbk8Wuv81MFltv7GSxuLnlKIvF5V1z2Cy6
        r+9gs1h+/B+TxdQXx9ktuu7eYLRY+u8ti4Ogx+Ur3h4TFh1g9Pi+voPN4+PTWyweE/fUefRt
        WcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxU
        WyUXnwBdt8wcoCeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnp
        enmpJVaGBgZGpkCFCdkZh44+Zi9YLlrR1XOCsYHxm2AXIyeHhICJxIv7G5i6GLk4hAR2MEpM
        /D4FyvnEKDHt4EF2COcbo8SGhY8ZYVqajj6ASuxllLje+J0NwvnBKPF5Okg/JwebgIbEmmOH
        wGaJCLQxS6z8c5kNJMEsoCbx+e4yli5GDg5hAX+J1fvLQEwWAVWJGY21IBW8AhYSnT9XskEs
        k5dY1PCbCSIuKHFy5hMWiCnyEs1bZzODjJcQWMkhsXHZI1aIBheJ5Td2M0PYwhKvjm9hh7Cl
        JD6/2ws1NFuicc9aqHiFxNzNk6E+M5aY9aydEeQeZgFNifW79EFMCQFliSO3oNbySXQc/gvV
        ySvRsPE3O0QJr0RHmxBEWEnizNzbUGEJiYOzcyDCHhKNc16BPSIkECtxeOYulgmMCrOQ/DUL
        yV+zEE5YwMi8ilEstaA4Nz012ajAEB69yfm5mxjBKVrLeQfjlfn/9A4xMnEwHmKU4GBWEuHd
        wh6TKsSbklhZlVqUH19UmpNafIjRFBjQE5mlRJPzgVkiryTe0MTSwMTMzNDcyNTAXEmc917r
        3BQhgfTEktTs1NSC1CKYPiYOTqkGJssPU47c/1+0Z775owVvJm//JSr230rG9tLTjGdr+E5K
        mM17eSzlRGZ88jzJNVJre8qlXrDtOrdT97Nl0NPFQucN1Q9ei6p6nVtxLslI6dXU2oebTkZL
        zdNt5Fzx45zWzcM3L9u/L/7m6Lpjw2eZ4oQDKzkPSgl7qM6p/bKYtffforgzkvz5v3X93hvf
        DO/S6Nkt7Wy8s7TVKe6e3AS3axtZrBm0Odn0wlT099sH/FWaOLc4eqNHaqtA0v54mxPdxg/M
        P76cWbKoLXHOoSdaYnrf5DVDq1s9m/cKWZc+5GQ8eG+pvNiFK8pp+c63bFU23OJdaHkl+nrY
        RhsN9oTWzZKyZutXRtwvbl1hUdIbqMRSnJFoqMVcVJwIAB74KIRaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvG5zeEyqwYdj0hYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjT4tff9ewWqxc/YLFYdGMbk8Wuv81MFltv7GSxuLnlKIvF5V1z2Cy6
        r+9gs1h+/B+TxdQXx9ktuu7eYLRY+u8ti4Ogx+Ur3h4TFh1g9Pi+voPN4+PTWyweE/fUefRt
        WcXo8XmTnEf7gW6mAI4oLpuU1JzMstQifbsEroxDRx+zFywXrejqOcHYwPhNsIuRk0NCwESi
        6egD9i5GLg4hgd2MEndPPGOCSEhI/F/cBGULS9xvOcIKUfSNUeLdzXuMIAk2AQ2JNccOMYEk
        RARmMUssufWHDSTBLKAm8fnuMhYQW1jAV2Jq8zYgm4ODRUBVYkZjLUiYV8BCovPnSjaIBfIS
        ixp+M0HEBSVOznzCAjFGXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhb
        XJqXrpecn7uJERwjWpo7GLev+qB3iJGJg/EQowQHs5II7xb2mFQh3pTEyqrUovz4otKc1OJD
        jNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTHEGfKqf1n1tusLN9KBEf5ewbFxicZNh
        xp71mSsnMaT+//Jt7usXP1f4F7+XPbHtbE+G8p1Apt4t84rSzmr2X4opOHd2Ne/nA4942XwY
        u6fzHO2ZLltS/c29WdrndGe8fb189KStXC9qFknt6nrev3PpiYkt2S/ytmrHa30Qmu6t9l5P
        5MBGgZ+715Z+4jioG2YjP53f77pO56zSbXozzR2l9RR9TVRFuS5aftsUbnAhWPi53mlRxtPl
        y8VmxvW+szh7xam/5Ofzw7osqq9qljwtnJ4Ytmvi/tl2bwolenuk9U8GnP45lUeBoeJ3mP5s
        0d+zq5RaD7RubHjd6r64vfRf4WNu97q62fFaPySMlViKMxINtZiLihMBYZrBiQADAAA=
X-CMS-MailID: 20231121070851epcas2p2ba11977edde23d3dcb87581e410806c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231121070851epcas2p2ba11977edde23d3dcb87581e410806c8
References: <CGME20231121070851epcas2p2ba11977edde23d3dcb87581e410806c8@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cq complete irq raise during abort processing,
the command has already been complete.
So could not get utag to erase cmd like below log.
Because the cmd that was handling abort has already been completed

ufshcd_try_to_abort_task: cmd pending in the device. tag = 25
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000194
Mem abort info:
ESR = 0x0000000096000006
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x06: level 2 translation fault
Data abort info:
ISV = 0, ISS = 0x00000006
CM = 0, WnR = 0

pc : blk_mq_unique_tag+0x8/0x14
lr : ufshcd_mcq_sq_cleanup+0x6c/0x1b8
sp : ffffffc03e3b3b10
x29: ffffffc03e3b3b10 x28: 0000000000000001 x27: ffffff8830b34f68
x26: ffffff8830b34f6c x25: ffffff8830b34040 x24: 0000000000000000
x23: 0000000000000f18 x22: ffffffc03e3b3bb8 x21: 0000000000000019
x20: 0000000000000019 x19: ffffff8830b309b0 x18: ffffffc00a1b5380
x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 0000000000000000
x14: 0000000000000010 x13: 0000000000000032 x12: 0000001169e8a5bc
x11: 0000000000000001 x10: ffffff885dfc1588 x9 : 0000000000000019
x8 : 0000000000000000 x7 : 0000000000000001 x6 : fffffffdef706f28
x5 : 000000000000283d x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000003 x1 : 0000000000000019 x0 : ffffff8855781200
Call trace:
blk_mq_unique_tag+0x8/0x14
ufshcd_clear_cmd+0x34/0x118
ufshcd_try_to_abort_task+0x1c4/0x4b0
ufshcd_err_handler+0x8d0/0xd24
process_one_work+0x1e4/0x43c
worker_thread+0x25c/0x430
kthread+0x104/0x1d4
ret_from_fork+0x10/0x20

v1 -> v2: fix build error

v2 -> v3: move to ufshcd_mcq_sq_cleanup() function

Bart said that lrbp->cmd could be changed before ufshcd_clear_cmd() was
called, so lrbp->cmd check was moved to ufshcd_clear_cmd().
In the case of legacy mode, spin_lock is used to protect before clear cmd,
but spin_lock cannot be used due to mcq mode, so it is necessary to check
the status of lrbp->cmd.

Change-Id: Id8412190e60286d00a30820591566835cefbf47e
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufs-mcq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 2ba8ec254dce..deb6dac724c8 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -507,6 +507,10 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
 		return -ETIMEDOUT;
 
+	if (!ufshcd_cmd_inflight(cmd) ||
+	    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
+		return 0;
+
 	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
 		if (!cmd)
 			return -EINVAL;
-- 
2.26.0

