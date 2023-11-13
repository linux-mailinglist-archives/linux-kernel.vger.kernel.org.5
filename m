Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77697E9B31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjKML2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjKML2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:28:12 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D71BCB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:27:08 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231113112705epoutp03cb1c5b280bbccd38db2ecf5ebc2976da~XKyXCmRtp0999009990epoutp03D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:27:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231113112705epoutp03cb1c5b280bbccd38db2ecf5ebc2976da~XKyXCmRtp0999009990epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699874825;
        bh=xqrqYZw6eTgRnKiPjUfNQCd5VyLsM//c453UU33PHao=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MF88TPyzGS49wWJETp0Q4JLzAzjMJhqST3TnLzDwP6lWgftespDPv7qKB09Q6hwMN
         sTPmWOW8ttWSwlV9MH7VxV28vAjrk3kzj3Z8mmvn0+Q/8yOmbKg+qhGzVt1bO90Tky
         023brkcmgQOYGBJqoQYZXwicz5sIg/ithkqACJ2g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231113112704epcas2p4f141f9884383ec174681505d4d027355~XKyWA-BnF1819518195epcas2p4V;
        Mon, 13 Nov 2023 11:27:04 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4STRwR54ZHz4x9Pw; Mon, 13 Nov
        2023 11:27:03 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.E7.18994.70802556; Mon, 13 Nov 2023 20:27:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231113112703epcas2p3522b4ea309a6f767adc4170ded172cf4~XKyUvgJeQ2873328733epcas2p3_;
        Mon, 13 Nov 2023 11:27:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231113112703epsmtrp1d1ce8435b890313c3bc9ccd9428312c7~XKyUuonuE0325603256epsmtrp1g;
        Mon, 13 Nov 2023 11:27:03 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-8c-6552080759a2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.98.18939.60802556; Mon, 13 Nov 2023 20:27:02 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231113112702epsmtip11f5d49c67bf332898a6ca6599a11dac7~XKyUd7iKP0808008080epsmtip1a;
        Mon, 13 Nov 2023 11:27:02 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Date:   Mon, 13 Nov 2023 20:29:35 +0900
Message-Id: <20231113112935.16343-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0wbdRzP7+643gjVo6vxZ41QbtGthEeLlB4T0IRp6sAMRzTGQOqFXniV
        a9Nr51wmgfHqwMfYJtECTkBQ2Vx5CwgC5Z0t8geSFQiGRdbBBEXQjAkFW9rN/ff5fj7f1+f3
        IFDRJC4hsjkTa+QYHYX7Y13DMlW4gDjJyq2dh+nFL7tweuXBDE4P3T6P0VXrD1B6xS6j/3XZ
        BPTVhkWMrnd0IXSvqwihOx09GD3bMYrR0701OF1xqxunvxnfRejPlscFdPmCA9CNu2vYK4Hq
        6V+S1BfqB4H6vs2Cq/+6M4epK/vy1Z90NAP1ZluQumywAkkh3s2Ny2IZLWuUslyGXpvNZcZT
        SamaRI0yRq4IV8TSKkrKMXlsPHUsOSX8tWyd2wQlPcXozG4qheF5KjIhzqg3m1hplp43xVOs
        QaszqAwRPJPHm7nMCI41HVXI5VFKd+J7uVkX21WGyoDTn/ev4AWg2L8cHCAgGQ37fx7Ay4E/
        ISL7ALxy5zfMG2wAOFj1J3gU3L5RIXhYctPZKvAKPW5hr9cXbAFY19yAe7Jw8gi8NmZHPIKY
        LEXhdzvT+wJKvgA3F5rcQwjiIHkCnltlPDRGPg8rCztwDy0kY6G1nvAOC4b1BduIBwvJQDj5
        xRLm7RIMizqrUU97SDYScGKtFPUWHIN1c7s+fBDeG+/wbS2BK5+W+nAuLOz73odPw9r2S8CL
        X4RWZxnw7ICSMmjrjfRASB6CI3O+sU9Ay7DLVymEBa3bAm+KEFpKRV6agjdr5300hEPVOi9U
        w/Od+1ZFZDrsGR7CLgCp9TFb1sdsWf/f4CuANgMJa+DzMtmMKIMinGPff3TBGfq8NrD/pkPf
        6Aa/21wRdoAQwA4ggVJiISdLYUVCLfPBGdao1xjNOpa3A6X7rCtRyVMZeven4EwaRXSsPDom
        RqGKUspV1NPCX0tqtSIykzGxuSxrYI0P6xDigKQAebXOjk7MBuREdq/PtjFRfo1I2+HeisR/
        GrlzpqRth+3QvWBk87oyrPjJdgUdPZIOZKkJzj+YNAe3unAx2TV1ZGvqxmjrT2n5sY67gSfW
        3xJuD/R/u3F38odnl0ecDdeWS2oNQVdD4oPOXppx8eL0K4sle6kvvzMqrkm4PlA4mNuDhxyv
        Dov7WBxYE+S3dWaBOPp2MdU1rztegqjHm/akZebuJqHjpCMr9O+ll8pviVf6wU6OM0kb5pdm
        Wzor27BZzKecO2WlMyGWnJbEosAJ/x8Dxi5/2DpGTs0/R4u5r9/kn4GVltenwHJSmkawWqVp
        +aisui05335ft7fW6tdCYXwWowhFjTzzH5HVIxxcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnC4bR1CqwdQHFhYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjT4tff9ewWqxc/YLFYdGMbk8Wuv81MFltv7GSxuLnlKIvF5V1z2Cy6
        r+9gs1h+/B+TxdQXx9ktuu7eYLRY+u8ti4Ogx+Ur3h4TFh1g9Pi+voPN4+PTWyweE/fUefRt
        WcXo8XmTnEf7gW6mAI4oLpuU1JzMstQifbsEroxJm80LJvJUzNj7kq2BsYWri5GTQ0LAROLM
        s43sXYxcHEIC2xklJi27zAaRkJD4v7iJCcIWlrjfcoQVxBYS+MYosfRPIYjNJqAhsebYISaQ
        ZhGBWcwSS279AWtmFlCT+Hx3GQuILSzgK/HyahtYM4uAqsTExi1ANRwcvAKWErMWcUDMl5dY
        1PAbbBevgKDEyZlPWCDGyEs0b53NPIGRbxaS1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS
        9ZLzczcxguNCK2gH47L1f/UOMTJxMB5ilOBgVhLhzdMMSBXiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgaq7/LPNVZNrOL2Jvk37dZ1CPzE6MfCQsk7HW
        KeIP+/LOw2svFhoeS07aNWlLRl5EvFu9zO87DjwnNv6NOKX87uMPL5WktQH5ZyY/4d1YJcT6
        /pV/qpaAowuP5f9XtW5TAr60zWL0F/94+96KIw1P585c6HNE/64ix8LNvz/0WSmLHmk4FVMr
        bfUkkGPtKSfeOjuvtc7v188+tGND38xHsyRs3E8XCMnfU595KLJML+jK7b0bFbPKrocUn9zP
        8Syn18o8730M/+13/VExdy9dtf6oWipio859MzE69nCPdoTo4rKLlnXrSjmnueycpPiRZfam
        cNOzrvkskzT8Fxhs4veN3vL8hHfN5ce8tcanlFiKMxINtZiLihMBMvQxEPoCAAA=
X-CMS-MailID: 20231113112703epcas2p3522b4ea309a6f767adc4170ded172cf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231113112703epcas2p3522b4ea309a6f767adc4170ded172cf4
References: <CGME20231113112703epcas2p3522b4ea309a6f767adc4170ded172cf4@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
Call trace:
blk_mq_unique_tag+0x8/0x14
ufshcd_clear_cmd+0x34/0x118
ufshcd_try_to_abort_task+0x1c4/0x4b0
ufshcd_err_handler+0x8d0/0xd24
process_one_work+0x1e4/0x43c
worker_thread+0x25c/0x430
kthread+0x104/0x1d4
ret_from_fork+0x10/0x20

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9a730a794b66..1a58869b91fc 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7574,6 +7574,10 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		goto out;
 	}
 
+	if (!ufshcd_cmd_inflight(cmd) ||
+	    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
+		goto out;
+
 	err = ufshcd_clear_cmd(hba, tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
-- 
2.26.0

