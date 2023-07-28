Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537676714B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjG1P7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjG1P7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:59:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5236D30C5;
        Fri, 28 Jul 2023 08:59:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso15545331fa.2;
        Fri, 28 Jul 2023 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559980; x=1691164780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCo106lcr9OqOXKGEBc+DWq16XxEQ27Fez5FxReeABs=;
        b=KYAbHJ5LH+6aRGAn/7WkpYeyXXARCEkOEG+I8VHav2Bv9WJffcJ5uztxifyhpuTPjs
         nzZoDWg4Zj0pxIG10JMgsZLYFU7wmRpLHgd94u8c/fS9wVf5SKy1NYbyqx0ML9OHmNxs
         0tFWzO8QaS/s8kkjyx9TcvvZ4zkF9sE8Gmqk3pdGZ+ft1IhK46tFu3tl8bwk9yHs+B3C
         3oTTxD8Yrl3xKRqnNxuZiASXdockAuWDljHS3gjeqGAQ4GqhlSlnO74CCq+NvbuLE9Ug
         a/CAIPmyOKTqhDUyyMI7CnCVx5m40153Zw0dtvq497zHZNvi0hQiol0DTWLGqeiIM56R
         5U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559980; x=1691164780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCo106lcr9OqOXKGEBc+DWq16XxEQ27Fez5FxReeABs=;
        b=Mi7Yewi8DCq+O0YG5MEVsgM+mLvBXA9UFk+gSgzZVL46QggdkCRJUFmthRrnnUG10w
         49g/AxBgFoQBqr9tISZN1Wt/Zak1dNzEABjy/sgDmtMbvD7/Sp+y1sDxl+UnGe1sTcIB
         iB0hV6/hbNyOsPcElU7t40O3ZTA8n5NeXqRtuUJifmFxBwvaXABwDjUYEscQrH2QCTbK
         GoWyqxcqlr5OlXGYbF8jx0J5VdY9MjcEM0iScrHuAbNbPDogfRi2t3Ep2WTg0uSyDk8Y
         bdJgFiGemyCtgdFG8A7/5lae/eiLL2S0azUDuqjyKIiuh+V1Pytdqt0e4p6TtX2m3+yk
         K7qg==
X-Gm-Message-State: ABy/qLY+mjfZhZiq082lERLaGFJ8dnEC2pCCFc+xsz0B17tyfGinfAUc
        27nHBUncAlDiNPd0rgQaBhB3ehldEe5VRLDh
X-Google-Smtp-Source: APBJJlFngmMeT1B/NQJD0a55UKx2ii0K3srqbk3P4CC5ivKeUAKqKFzB0MR6HKuhwkNamexMh8lEcw==
X-Received: by 2002:a05:651c:156:b0:2b9:c644:415d with SMTP id c22-20020a05651c015600b002b9c644415dmr1981105ljd.46.1690559980215;
        Fri, 28 Jul 2023 08:59:40 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id lu44-20020a170906faec00b00992f309cfe8sm2215810ejb.178.2023.07.28.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:59:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: optimize ebitmap_and()
Date:   Fri, 28 Jul 2023 17:59:36 +0200
Message-Id: <20230728155937.41580-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate on nodes instead of single bits to save node resolution for each
single bit.

Similar to userspace patch efcd00814879 ("libsepol: optimize
ebitmap_and").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 48 ++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 77875ad355f7..5ac8acacf873 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -81,18 +81,52 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
 {
-	struct ebitmap_node *n;
-	int bit, rc;
+	const struct ebitmap_node *n1, *n2;
+	struct ebitmap_node *new = NULL, **prev;
 
 	ebitmap_init(dst);
 
-	ebitmap_for_each_positive_bit(e1, n, bit) {
-		if (ebitmap_get_bit(e2, bit)) {
-			rc = ebitmap_set_bit(dst, bit, 1);
-			if (rc < 0)
-				return rc;
+	prev = &dst->node;
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 && n2) {
+		if (n1->startbit == n2->startbit) {
+			unsigned long testmap[EBITMAP_UNIT_NUMS];
+			unsigned int i;
+			bool match = false;
+
+			for (i = 0; i < sizeof(testmap); i++) {
+				testmap[i] = n1->maps[i] & n2->maps[i];
+				if (testmap[i] != 0)
+					match = true;
+			}
+
+			if (match) {
+				new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
+				if (!new) {
+					ebitmap_destroy(dst);
+					return -ENOMEM;
+				}
+				new->startbit = n1->startbit;
+				memcpy(new->maps, testmap, EBITMAP_SIZE / 8);
+				new->next = NULL;
+
+				*prev = new;
+				prev = &(new->next);
+			}
+
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (n1->startbit > n2->startbit) {
+			n2 = n2->next;
+		} else {
+			n1 = n1->next;
 		}
 	}
+
+	if (new)
+		dst->highbit = new->startbit + EBITMAP_SIZE;
+
 	return 0;
 }
 
-- 
2.40.1

