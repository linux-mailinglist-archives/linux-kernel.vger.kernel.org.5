Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD47FF0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjK3NwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbjK3NwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:52:22 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22945C4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:52:28 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231130135226epoutp048bd78eca74de5b89d6f338836836fd4d~cavH16Ia40047900479epoutp04b
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231130135226epoutp048bd78eca74de5b89d6f338836836fd4d~cavH16Ia40047900479epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701352346;
        bh=Rb6ZYEMC2CZ1FlgIe8RrGVYfBR7ZO2OCDhKB4oyvqXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1yYNzadguXgU9y3JElAJc7xxwaPR1YPiniruWf+ewezNjVEm/Y1WiZuwKMYnyxCm
         wStMk1Yaf5TBibfLU5zTa0/7sLyZ3Wyx8ysT8B27RcAMCIcwEYy5UJxJX44akFpUth
         zB8dpBFg42tUEQ2G37eKaQgQX2wAu2+vy9dWCmNM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231130135225epcas5p30d8e4dbae3799ca0fdf09b1341c6234d~cavHLq4Jr2082920829epcas5p3N;
        Thu, 30 Nov 2023 13:52:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SgyLJ1fzNz4x9Pq; Thu, 30 Nov
        2023 13:52:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.07.10009.89398656; Thu, 30 Nov 2023 22:52:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231130115113epcas5p4bcd4ffb2baac60a0be51d6a3cb15c2a6~cZFSHGlY42306823068epcas5p4M;
        Thu, 30 Nov 2023 11:51:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231130115113epsmtrp15dc97bfd502f53d71aad80eac517fdab~cZFSGAqKE1720317203epsmtrp1-;
        Thu, 30 Nov 2023 11:51:13 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-87-656893989b87
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.A1.18939.13778656; Thu, 30 Nov 2023 20:51:13 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231130115111epsmtip1e774433553d715866892e41b465dc782~cZFQJB3Yi1251512515epsmtip1Y;
        Thu, 30 Nov 2023 11:51:11 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        josh@joshtriplett.org, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, pankaj.dubey@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2 3/3] PCI: dwc: Create debugfs files in DWC driver
Date:   Thu, 30 Nov 2023 17:20:44 +0530
Message-Id: <20231130115044.53512-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130115044.53512-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmpu6MyRmpBk/2slssacqw2HW3g91i
        1ra5jBYrvsxkt/i/IN+ioec3q8XlXXPYLM7OO85m0fKnhcWi5Wg7i8Xdlk5Wi0VbvwCV7dnB
        btF7uNaBz2PnrLvsHgs2lXrcem3rsWlVJ5vHnWt72DyeXJnO5LHx3Q4mj74tqxg9tuz/zOjx
        eZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO
        0PVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMj
        U6DChOyMP+u72AomsVccut3I3MDYydbFyMEhIWAicb3ZtYuRi0NIYDejxLm+LjYI5xOjxOnF
        m5jgnMbJ94EcTrCON9snsIHYQgI7GSU2rS+HKGplkrgw8RQLSIJNQEui8WsXM0hCRKCLSeLR
        ipPsIAlmgWSJef13mEB2Cwu4SKy9awwSZhFQlejcdAZsAa+AlcSexT/ZIJbJS6zecIAZxOYU
        sJZ4tuoKI8hMCYFeDonzu56wQxS5SPRufcsCYQtLvDq+BSouJfGyvw3KTpdYuXkGM4SdI/Ft
        8xKob+wlDlyZwwJyD7OApsT6XfoQYVmJqafWMUGczCfR+/sJVDmvxI55MLayxJe/e6DWSkrM
        O3aZFcL2kHiy/j005PoYJRbs3M04gVFuFsKKBYyMqxglUwuKc9NTi00LjPJSy+GRlpyfu4kR
        nEC1vHYwPnzwQe8QIxMH4yFGCQ5mJRHe60/TU4V4UxIrq1KL8uOLSnNSiw8xmgIDcCKzlGhy
        PjCF55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwFQXOMkg27v5
        yepL3QfjLm5Kq1A+dvPBv6x7M1TOcRvn37nieed31va750s75a8znbvxaIfmPZ9bp3nYm2z0
        u1inWP1N8tR8/6VEP1GwcumuiyJPHRp2cTROX/xOd9bM6089QtV3dVy6+anzjmjFD9ulKi+N
        9bIPhvpUXWhU6zaaqHGo0kfvguU7F/0FSQITWqZyXbnsdPhQ4rOPJnv1LNc6aRbHNO6o3yX+
        dXHqGu7c+k7vJpftXOfYog9c86svt15r/FNmvl2ywcvXE0NyH23cuMU7SfnKkycJ51wXSHyu
        SBH/lPO8/rdRxdfp29+ktlY9K157SC35eL+J9uMTMy4lH7q1TGGzyT92yUImlSQlluKMREMt
        5qLiRADiCo8TKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnK5heUaqwdoOMYslTRkWu+52sFvM
        2jaX0WLFl5nsFv8X5Fs09Pxmtbi8aw6bxdl5x9ksWv60sFi0HG1nsbjb0slqsWjrF6CyPTvY
        LXoP1zrweeycdZfdY8GmUo9br209Nq3qZPO4c20Pm8eTK9OZPDa+28Hk0bdlFaPHlv2fGT0+
        b5IL4IrisklJzcksSy3St0vgyvizvoutYBJ7xaHbjcwNjJ1sXYycHBICJhJvtk8As4UEtjNK
        LN8uBhGXlPh8cR0ThC0ssfLfc3aImmYmiXcvPEFsNgEticavXcxdjFwcIgIzmCRauu+zgCSY
        BVIlbh+eAzSUg0NYwEVi7V1jkDCLgKpE56YzYDN5Bawk9iz+CXWDvMTqDQeYQWxOAWuJZ6uu
        MELsspJY9OsH8wRGvgWMDKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxggNbK2gH47L1f/UO
        MTJxMB5ilOBgVhLhvf40PVWINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampB
        ahFMlomDU6qBqV12n9he159ys6eyTuRr5Eyp3hd6TVqkX9D7s81Wdq5LR6afmsefEHdkNbP4
        /+jc6ef+/vxXYefzIn97cLvWtLsaJ/pmPEs8J5t7WDF6UtOxCcxJtvLXp+tLvHFg1bKVdn63
        3f7UrGtpjjeq3iavqO43u1PzeQIvb7AJ20z7h9GvDir/33rkt2f3//OfH+3kWaJ8UF1d4u9s
        Xf38bdJi9rO3HE+9qLmff313/SeW8xkXNLovMn3JOmCnnllu9Zdx/a7DmyyX3EjRb/mXknmy
        /LSCvdqy1EnTPon8ujvzwPNd+UFBp+dfTxKf59ca6plclrE6ymC3C094mfLmmmlOde4FLUVc
        6Xcy1Vctfm5uocRSnJFoqMVcVJwIABe/IhXbAgAA
X-CMS-MailID: 20231130115113epcas5p4bcd4ffb2baac60a0be51d6a3cb15c2a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231130115113epcas5p4bcd4ffb2baac60a0be51d6a3cb15c2a6
References: <20231130115044.53512-1-shradha.t@samsung.com>
        <CGME20231130115113epcas5p4bcd4ffb2baac60a0be51d6a3cb15c2a6@epcas5p4.samsung.com>
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

Add call to initialize debugfs from DWC driver and create the RASDES
debugfs hierarchy for each platform driver. Since it can be used for
both DW HOST controller as well as DW EP controller, add it in the
common setup function.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 064b4951afd8..16c9018c2ada 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1074,4 +1074,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		break;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
+	val = dwc_pcie_rasdes_debugfs_init(pci);
+	if (val)
+		dev_err(pci->dev, "Couldn't create debugfs files\n");
 }
-- 
2.17.1

