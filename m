Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BC7AD45B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjIYJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjIYJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:18:08 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD8609B;
        Mon, 25 Sep 2023 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=REETuE6GPL
        qC+wOfMjtNk/ptknHVF6nEw+p3O+uBa4U=; b=PjIwLI76bsqDx1jJk3zTcnBqhg
        qMZ5BaoZ1ogBLOPlUPy31d1POoCRpiBWo1NZ/4wMnsKVjPB6iW87w4GnsKDjAeyJ
        l4xgiUEY30gf2T+D3mycri/VkH+oKvp5FjGzOqWWnCPdU8psnByFYQCwI6oMRaDM
        GNOtsLf+s9bnyVD3Q=
Received: from oslab.. (unknown [10.130.159.144])
        by coremail-app2 (Coremail) with SMTP id Nyz+CgDnq+E5UBFlidKuAA--.4843S4;
        Mon, 25 Sep 2023 17:17:47 +0800 (CST)
From:   Jia-Ju Bai <baijiaju@buaa.edu.cn>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju@buaa.edu.cn>
Subject: [PATCH] usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency
Date:   Mon, 25 Sep 2023 17:17:41 +0800
Message-Id: <20230925091741.797863-1-baijiaju@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Nyz+CgDnq+E5UBFlidKuAA--.4843S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48XF4UZr4xtr43tF4fZrb_yoW8XF1xpa
        1IqFyIyw4qvFsxtw45XFs5Wa17JwsxWryjkr4xtayrZws2v34xJ3WfGFySgrsYkrZ5AanI
        gF1DZw48CrWDta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: yrruji46exttoohg3hdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _dwc2_hcd_urb_enqueue(), "urb->hcpriv = NULL" is executed without 
holding the lock "hsotg->lock". In _dwc2_hcd_urb_dequeue():

    spin_lock_irqsave(&hsotg->lock, flags);
    ...
	if (!urb->hcpriv) {
		dev_dbg(hsotg->dev, "## urb->hcpriv is NULL ##\n");
		goto out;
	}
    rc = dwc2_hcd_urb_dequeue(hsotg, urb->hcpriv); // Use urb->hcpriv
    ...
out:
    spin_unlock_irqrestore(&hsotg->lock, flags);

When _dwc2_hcd_urb_enqueue() and _dwc2_hcd_urb_dequeue() are 
concurrently executed, the NULL check of "urb->hcpriv" can be executed
before "urb->hcpriv = NULL". After urb->hcpriv is NULL, it can be used 
in the function call to dwc2_hcd_urb_dequeue(), which can cause a NULL 
pointer dereference. 

To fix this possible bug, "urb->hcpriv = NULL" should be executed with
holding the lock "hsotg->lock".

Signed-off-by: Jia-Ju Bai <baijiaju@buaa.edu.cn>
---
 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 657f1f659ffa..35c7a4df8e71 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4769,8 +4769,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	if (qh_allocated && qh->channel && qh->channel->qh == qh)
 		qh->channel->qh = NULL;
 fail2:
-	spin_unlock_irqrestore(&hsotg->lock, flags);
 	urb->hcpriv = NULL;
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 	kfree(qtd);
 fail1:
 	if (qh_allocated) {
-- 
2.34.1

