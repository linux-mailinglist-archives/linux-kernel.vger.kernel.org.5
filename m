Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42997767139
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjG1Pzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjG1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAF444B1;
        Fri, 28 Jul 2023 08:55:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo641871e87.2;
        Fri, 28 Jul 2023 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559713; x=1691164513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj8EXANVUnt9bxQH+/nx3iBETrgoqthp/pWZeVRl9D8=;
        b=lJEotxX4ThykyTKoZQKZCBYw/acPZZ4atSdyoRuShZW2/I43mCDRmqkeglAanKpIEt
         5MF9aBJM/t4X+/bcmUHnhzJ5MG36wDlLuYSiqgB71dPp1/ipxcp8w+sz83iMb2uuUOuc
         FwYcM8KxC4EBTRGkUgcFZVZo5bYQMjemYzMmw0fgSNNGr6CnhWzVfNOeaaT756gAM31m
         85VZxhu/MTx2mxVzxFT/79zMBTSQpZMWxL5WFuClAxvjZ2/GgKSRWKyUqV6QTDmCzUWH
         0JqbhdjgZp73AsnE94Sz3kVw2fIYpGOi82E/3cWhgIvhEkyT3eRb2PtibfZ8ZAI3/Wtm
         CgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559713; x=1691164513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj8EXANVUnt9bxQH+/nx3iBETrgoqthp/pWZeVRl9D8=;
        b=jQnpun6OMkjwNUye76r5PMmVRUGhnAlVokQQR21Fw9LA1dy+bxpUTZ+M21UnBw/jV8
         Ao1nNfbId08f83VzBVR+kqA5bZ35/patGT2EKNP1KZM4KpZs+0grAP7pK8O2DRsWUT2k
         lALsbWp7S+KOIBVpFK7gNT2oGMyRYPuWQhOLP2dM9WhLMpSy6qkYafDwJ/889g7QdhZA
         +rWVA8/5IDzrGeJNmaNxPZt7Vm7d2XpCyEjiw4LZ8hcGT0RhW6yQNUiH+8bPiiGVY/v3
         5LwZ3FfZNI8i91AzmV6BSe+JZ5PgFZo7CvottT+rmFbyEt+NecB+3HbfME/xQFHzIuk1
         ucuA==
X-Gm-Message-State: ABy/qLbwkLEelXiTFjXUijo34TwWbsfmLA9xbt7vYpU5NuO+BueawwDM
        QlTksjNfKc+vyNeK+kJgDMl2uwDseNy+hmpv
X-Google-Smtp-Source: APBJJlFChGNT7gEME70QQCgEcUDXUUeIk3Hp2QhmpWS5T2oMgOoYeIEbnodCbfPol+UWhsWLPz0k0Q==
X-Received: by 2002:a19:2d49:0:b0:4f9:7aee:8dc5 with SMTP id t9-20020a192d49000000b004f97aee8dc5mr1989307lft.19.1690559712679;
        Fri, 28 Jul 2023 08:55:12 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:12 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] selinux: avoid implicit conversions in mls code
Date:   Fri, 28 Jul 2023 17:54:54 +0200
Message-Id: <20230728155501.39632-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
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

Use u32 for ebitmap bits.

Use char for the default range of a class.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/ss/mls.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index b2c6c846ea03..cd38f5913b63 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -45,7 +45,7 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 
 	len = 1; /* for the beginning ":" */
 	for (l = 0; l < 2; l++) {
-		int index_sens = context->range.level[l].sens;
+		u32 index_sens = context->range.level[l].sens;
 		len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
 
 		/* categories */
@@ -240,7 +240,8 @@ int mls_context_to_sid(struct policydb *pol,
 	char *sensitivity, *cur_cat, *next_cat, *rngptr;
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum, *rngdatum;
-	int l, rc, i;
+	u32 i;
+	int l, rc;
 	char *rangep[2];
 
 	if (!pol->mls_enabled) {
@@ -451,7 +452,8 @@ int mls_convert_context(struct policydb *oldp,
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum;
 	struct ebitmap_node *node;
-	int l, i;
+	u32 i;
+	int l;
 
 	if (!oldp->mls_enabled || !newp->mls_enabled)
 		return 0;
@@ -495,7 +497,7 @@ int mls_compute_sid(struct policydb *p,
 	struct range_trans rtr;
 	struct mls_range *r;
 	struct class_datum *cladatum;
-	int default_range = 0;
+	char default_range = 0;
 
 	if (!p->mls_enabled)
 		return 0;
-- 
2.40.1

