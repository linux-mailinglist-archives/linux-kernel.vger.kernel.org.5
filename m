Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE2C791073
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 05:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351395AbjIDDlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 23:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjIDDlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:41:01 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA7AC5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 20:40:56 -0700 (PDT)
Received: from localhost (unknown [124.16.138.129])
        by APP-03 (Coremail) with SMTP id rQCowABnbqK9UfVk2+twCg--.59946S2;
        Mon, 04 Sep 2023 11:40:45 +0800 (CST)
From:   Chen Ni <nichen@iscas.ac.cn>
To:     ychuang3@nuvoton.com, schung@nuvoton.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] tty: serial: ma35d1_serial: Add missing check for ioremap
Date:   Mon,  4 Sep 2023 03:40:31 +0000
Message-Id: <20230904034031.23311-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnbqK9UfVk2+twCg--.59946S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4UtryUXr1xuFW7ZF4rAFb_yoWfZFX_C3
        Wku3yIvr409rs0kw1Sqry5urWftryqvF4kWF1vv34akr98CayDWFWjvrnFkr47uw43WF15
        tr47KryfAw1qqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjQBMtUUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for ioremap() and return the error if it fails in order to
guarantee the success of ioremap(), same as in
ma35d1serial_console_setup().

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/tty/serial/ma35d1_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 465b1def9e11..dbfcb711e710 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -695,6 +695,9 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 
 	up->port.iobase = res_mem->start;
 	up->port.membase = ioremap(up->port.iobase, MA35_UART_REG_SIZE);
+	if (!up->port.membase)
+		return -ENOMEM;
+
 	up->port.ops = &ma35d1serial_ops;
 
 	spin_lock_init(&up->port.lock);
-- 
2.25.1

