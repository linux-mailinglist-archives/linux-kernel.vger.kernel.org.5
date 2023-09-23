Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4D7AC354
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjIWPkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:40:03 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Sep 2023 08:39:54 PDT
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB5010C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=SHF1YmrFCIJnQPO4SO
        EuTOBqKGbDRVpdwSQop0QEt0s=; b=NmAUw/UVzmmSzpHBGJCvJCmcCa+IUgIoXz
        43TqUY58E+Amtv4Ch26cmFArlE6j7An0nbeCyZK0TmA8vSxLa5/5dP2S/R5msBoU
        r3aQoRRBwqE5HHEahIfb+6CTNwfF+4hryAmZ8ay27N37WHRJ79KSVa9b3bFuiJ50
        uI+2egXQ4=
Received: from localhost.localdomain (unknown [223.104.131.178])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wA3SD8rAw9lJi+ICw--.49026S2;
        Sat, 23 Sep 2023 23:24:29 +0800 (CST)
From:   liuhaoran <liuhaoran14@163.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, liuhaoran <liuhaoran14@163.com>
Subject: [PATCH] arm: kernel: Add error handling in get_dma_residue()
Date:   Sat, 23 Sep 2023 23:24:15 +0800
Message-Id: <20230923152415.41073-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wA3SD8rAw9lJi+ICw--.49026S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWr4fXr17tr1DXrWrtr45Awb_yoWxXrcEqr
        4xtw4kWrn5ZFZF9r15Ca1fGrnxt3s8KFyFgwnFqFy7J34DXw15Wwn0van7ZF1kJFnFkFZ3
        CFWUJFZ3tw1v9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREHqc7UUUUU==
X-Originating-IP: [223.104.131.178]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiGALzglv2oALsuAABsx
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error-handling for the dma_channel() inside
the get_dma_residue().

Signed-off-by: liuhaoran <liuhaoran14@163.com>
---
 arch/arm/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/dma.c b/arch/arm/kernel/dma.c
index ba15b8666498..80b3e3506cfa 100644
--- a/arch/arm/kernel/dma.c
+++ b/arch/arm/kernel/dma.c
@@ -253,7 +253,7 @@ int get_dma_residue(unsigned int chan)
 	dma_t *dma = dma_channel(chan);
 	int ret = 0;
 
-	if (dma->d_ops->residue)
+	if (dma && dma->d_ops->residue)
 		ret = dma->d_ops->residue(chan, dma);
 
 	return ret;
-- 
2.17.1

