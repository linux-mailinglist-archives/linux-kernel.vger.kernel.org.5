Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD57EA995
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjKNEev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjKNEeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:34:46 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD096D48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:34:37 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231114043433epoutp0122ee9538f15dc04d0953789cd6c9b295~XYzc4QUd22106521065epoutp01I
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:34:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231114043433epoutp0122ee9538f15dc04d0953789cd6c9b295~XYzc4QUd22106521065epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699936473;
        bh=RIC7YkwBl2NC41T0dxI39QTyveUYqtvDqehJ7FnOOFs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NZTBzGgoOVG6hebG9UQ6xx9fLLHHfAh8QmJv4HyU7MERsPBM1w+TbgI/jrcoo3YpD
         Mh449cXlAGsvOLKe3hQaPVEvdhvP6okRzK69pXetS1i2z9/jxfpVj0om7/sy1G1T0U
         hI+0FvXJyNE07Dxg7vttH83ZrVtxk/IhE6T1ZyHY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231114043432epcas2p32ae4aa7e0e8c3a5ff39886719567fb94~XYzce87360064800648epcas2p3U;
        Tue, 14 Nov 2023 04:34:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4STtk00TyWz4x9QC; Tue, 14 Nov
        2023 04:34:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.0F.09607.7D8F2556; Tue, 14 Nov 2023 13:34:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea~XYzbStkKp2631626316epcas2p4X;
        Tue, 14 Nov 2023 04:34:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231114043431epsmtrp140ee62eba0a9185ec95371dd20cc306b~XYzbRwS8a0312303123epsmtrp1B;
        Tue, 14 Nov 2023 04:34:31 +0000 (GMT)
X-AuditID: b6c32a48-1d26ea8000002587-d2-6552f8d73c13
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.06.08817.7D8F2556; Tue, 14 Nov 2023 13:34:31 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231114043431epsmtip259eb9cf00d84b20dcdd351af9a2a4391~XYzbFknSk0798907989epsmtip2M;
        Tue, 14 Nov 2023 04:34:31 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v2] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Date:   Tue, 14 Nov 2023 13:37:04 +0900
Message-Id: <20231114043704.52525-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmme71H0GpBpfXW1s8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni5SFNi19/17NbrF78gMVi0Y1tTBa7/jYzWWy9sZPF4uaWoywWl3fNYbPo
        vr6DzWL58X9MFlNfHGe36Lp7g9Fi6b+3LA6CHpeveHtMWHSA0eP7+g42j49Pb7F4TNxT59G3
        ZRWjx+dNch7tB7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNT
        bZVcfAJ03TJzgJ5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al
        6+WlllgZGhgYmQIVJmRnLOg8z1bwXrCieZVAA2MrfxcjJ4eEgInE5nsNjCC2kMAORolT90S7
        GLmA7E+MEj0NE9kgnG+MEq82/2WF6Xj74QsjRGIvo8SziWtZIJwfjBJnp/WAzWIT0JBYc+wQ
        E0hCRKCNWWLln8tsIAlmATWJz3eXAXVwcAgL+Eus/w92B4uAqsSD6Y1gG3gFLCWeLNzEDrFN
        XmJRw28miLigxMmZT1ggxshLNG+dzQwyX0JgJYfEyZdnGSEaXCSeTtgAZQtLvDq+BWqQlMTL
        /jYoO1uicc9aKLtCYu7myVD1xhKznrUzgtzGLKApsX6XPogpIaAsceQW1Fo+iY7Df6E6eSUa
        Nv5mhyjhlehoE4IIK0mcmXsbKiwhcXB2DkTYQ+Lx37fMkICOlbj3rId5AqPCLCR/zULy1yyE
        ExYwMq9iFEstKM5NTy02KjCBx25yfu4mRnCC1vLYwTj77Qe9Q4xMHIyHGCU4mJVEePM0A1KF
        eFMSK6tSi/Lji0pzUosPMZoCQ3ois5Rocj4wR+SVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQ
        nliSmp2aWpBaBNPHxMEp1cAk+v/89w8faz9aOfM1M5Tbv+ErPvBsx11773P5O89snGKQFvp9
        +szK1ZmLjB9aXVUOX8Z95LFY1tHaU+kRax593nGu5O/l9M16q1hm+mx+sOd2zrOEKRPN3YTk
        VDvNZKtzJd9GrLpfl1jxtz2Pz2ly5RV1xusKBhc/T7mx67xD9bbFn6Qe101RmKe2V68t+7tC
        iWLp9VwrJsFak1OrRR0PCGyKXGSu42C/N+Wp+5W7F42vfj5kvb3u2+Yp1TOWxRmuPH4xZrHP
        ZKZ38abJNt49C4U2Tl+bVRnhWmevYpR1j/Ff/j3OBpPNR9qsuCKXzZRm5Vd9c40hyYdtl+oD
        boYk/3fCu8qefq9T2VxwS11SiaU4I9FQi7moOBEA8/b98lkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO71H0GpBof3iVs8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni5SFNi19/17NbrF78gMVi0Y1tTBa7/jYzWWy9sZPF4uaWoywWl3fNYbPo
        vr6DzWL58X9MFlNfHGe36Lp7g9Fi6b+3LA6CHpeveHtMWHSA0eP7+g42j49Pb7F4TNxT59G3
        ZRWjx+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDIWdJ5nK3gvWNG8SqCBsZW/i5GTQ0LAROLt
        hy+MXYxcHEICuxklpq37xQqRkJD4v7iJCcIWlrjfcoQVougbo8SZc3/AEmwCGhJrjh1iAkmI
        CMxillhy6w8bSIJZQE3i891lLF2MHBzCAr4Se6Y7g4RZBFQlHkxvBFvAK2Ap8WThJnaIBfIS
        ixp+M0HEBSVOznzCAjFGXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhb
        XJqXrpecn7uJERwhWlo7GPes+qB3iJGJg/EQowQHs5IIb55mQKoQb0piZVVqUX58UWlOavEh
        RmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTHXc+/2evNl5qV24V0T/9dJW3ROVtk6L
        bx88ceMjW6y86JvVfmmpljrqmRuWS52cp5O5PSIieVXunU/bco+sNTl05vLihwELX+Ys2ch6
        jDf+w7YKZ8OZ06/eOPKj1jrd/qdnQs/yYzdmcf2X0uyIFxDdlcZrW5pT1JOz+4Zv1su8hp9e
        nlcyRLJiFvvl6gcxz0pOkJeVTH1hk335Pc/ueMZGnjsVPc/05WwSDubuXHDqlO6lWQdfWlz7
        51ndsMm/js/rk9CCm4kdoRHVrKf4/S+orQl/0H7F/k2xo47SSecjlU0PLuwNiFK8+e2SwVLD
        xZMeepbWMG61yVc0/MQQ/NHpZ8W/+c09SwV+ZSR/UmIpzkg01GIuKk4EACsPldD/AgAA
X-CMS-MailID: 20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea
References: <CGME20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9a730a794b66..55f4c0eeda7b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7574,6 +7574,10 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		goto out;
 	}
 
+	if (!ufshcd_cmd_inflight(lrbp->cmd) ||
+	    test_bit(SCMD_STATE_COMPLETE, &lrbp->cmd->state))
+		goto out;
+
 	err = ufshcd_clear_cmd(hba, tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
-- 
2.26.0

