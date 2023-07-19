Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4C9758DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGSGgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGSGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:36:04 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60A481FD5;
        Tue, 18 Jul 2023 23:36:00 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8CxLOtOhLdkJCQHAA--.13004S3;
        Wed, 19 Jul 2023 14:35:58 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniNOhLdkQGc0AA--.38253S2;
        Wed, 19 Jul 2023 14:35:58 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/2] irqchip/loongson-eiointc: Add simple irq routing method
Date:   Wed, 19 Jul 2023 14:35:56 +0800
Message-Id: <20230719063558.3131045-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniNOhLdkQGc0AA--.38253S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFWxZr1xAw48tw1rWw15trc_yoW3ZrXEgr
        y2v395KrWIqFWFvasFyF17JFZFk398Ww15uF4v9r15Z348Ar1UJrZFyrZ7JFnFgF15ZFn3
        C3yrCryfZr1ayosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix return value checking of eiointc_index where int type
is converted uint32_t and check smaller than 0.

Add simple irq route support on system with only one eiointc node,
rather than use anysend method.

---
Changes in v5:
  Modify typo issue.

Changes in v4:
  Modify some spell checking problems.
  Add Fixes tag.

Changes in v3:
  Modify some spell checking problems.

Changes in v2:
  Use the simple irq routing on embeded board like 2K0500 and 2K2000
board, since there is only one eio node.

---
Bibo Mao (2):
  irqchip/loongson-eiointc: Fix return value checking of eiointc_index
  irqchip/loongson-eiointc: Simplify irq routing on some platforms

 drivers/irqchip/irq-loongson-eiointc.c | 93 +++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 11 deletions(-)

-- 
2.27.0

