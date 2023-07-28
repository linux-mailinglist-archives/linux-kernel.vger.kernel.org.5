Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5A76713A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjG1Pzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbjG1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59744B4;
        Fri, 28 Jul 2023 08:55:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99b9421aaebso309328266b.2;
        Fri, 28 Jul 2023 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559714; x=1691164514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMehyge5V6oc71n+ts8VpdssHuMwLHVzBSgZt/TQ3lg=;
        b=gK1wcG5ifE9K7WNKaw+EopeVu9Z112sNyDDmRS0xr1oSRlvZx+ntyoKbpqVXAN6aIv
         ONynaAKRwpwdemhY31y9cbpw0n3af4i7a0XTd0kVXy9djH0qGp1OwDWxK8ilC8Ywuv23
         PlkjUXw2p8k0odbo3/hI9EAY013EfsXnUJgkpy9c4Hq9qK8VzzH9BUf20RdJz9L7/Rmh
         8tnWInKdYdLL118OyZKQqhVg/lB/uBH1tM/HHNtswCjvV0jnR7NybCQG1dmzpBe2Muzp
         7k4+2QWxjr4rTM+hi5BiRgdfNbl/Wo03dHZXCFFP6C/8iT2efWxYmbwUC90hzqfaQpfl
         i7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559714; x=1691164514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMehyge5V6oc71n+ts8VpdssHuMwLHVzBSgZt/TQ3lg=;
        b=eSu+AvkCf98cdJJfW3vWg7BiR6ysQzjOBWu6JpQJHA7tylytDbaK+ZS3Ot0tcpquTU
         NRwzBhcY9HxbEt+Qef+QjAunEG4es5UrQkfoKhRR66YTh5GoGMmSwUi+4FILSv7m62Ip
         3ianQCglmdo+GLVTPooXw7KYd4NNCvBWgZHYCCwvlFBRIEoJAJnwCZXwL0X5yZREOByR
         mNfvoGAJSAaJ5kdT3AXQaEf7n1AFR4vPyhWH+p8PE9ST47XcomP5tiisL7LzVYU7AuNF
         QkojuM31FzF9xuMxjNRNAb13ea/XHQ3O+hEc/FoiSvg7TO7ZPnb2kLI/CYl9bNkgnCoi
         VO1Q==
X-Gm-Message-State: ABy/qLZFgHKCpytK1pMUqPbeBDNsr5j0sYHIHhCgkkkZzUYWZKI1Uw0v
        0gldRj6d3hpP23lGfB0Slq30PzNmVci2Nr/J
X-Google-Smtp-Source: APBJJlFHnyeXTlVdIgpl2Ciud2FmYJ6My335BQvS0iplGidK9z8NhEPKsS8FXNVVJ+ibAf99PTmmRQ==
X-Received: by 2002:a17:907:2711:b0:992:a85d:278b with SMTP id w17-20020a170907271100b00992a85d278bmr2274139ejk.59.1690559714482;
        Fri, 28 Jul 2023 08:55:14 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] selinux: services: update type for number of class permissions
Date:   Fri, 28 Jul 2023 17:54:55 +0200
Message-Id: <20230728155501.39632-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Security classes have only up to 32 permissions, hence using an u16 is
sufficient (while improving padding in struct selinux_mapping).

Also use a fixed sized cast in a bit shift to avoid (well defined)
overflows on architectures where sizeof(unsigned int) != sizeof(u32)
resulting in no bits set.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   update commit description:
     - mention struct selinux_mapping  in the padding argument
       (currently between the first and second member there are 2 bytes
        padding)
     - mention overflow in the cast argument and the result of setting
       no bits due to it
---
 security/selinux/ss/services.c | 6 +++---
 security/selinux/ss/services.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2c5be06fbada..cf4b87ec4a0e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -97,7 +97,6 @@ static int selinux_set_mapping(struct policydb *pol,
 			       struct selinux_map *out_map)
 {
 	u16 i, j;
-	unsigned k;
 	bool print_unknown_handle = false;
 
 	/* Find number of classes in the input mapping */
@@ -117,6 +116,7 @@ static int selinux_set_mapping(struct policydb *pol,
 	while (map[j].name) {
 		const struct security_class_mapping *p_in = map + (j++);
 		struct selinux_mapping *p_out = out_map->mapping + j;
+		u16 k;
 
 		/* An empty class string skips ahead */
 		if (!strcmp(p_in->name, "")) {
@@ -202,7 +202,7 @@ static void map_decision(struct selinux_map *map,
 {
 	if (tclass < map->size) {
 		struct selinux_mapping *mapping = &map->mapping[tclass];
-		unsigned int i, n = mapping->num_perms;
+		u16 i, n = mapping->num_perms;
 		u32 result;
 
 		for (i = 0, result = 0; i < n; i++) {
@@ -230,7 +230,7 @@ static void map_decision(struct selinux_map *map,
 		 * should audit that denial
 		 */
 		for (; i < (sizeof(u32)*8); i++)
-			result |= 1<<i;
+			result |= 1<<((u32)i);
 		avd->auditdeny = result;
 	}
 }
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index ed2ee6600467..d24b0a3d198e 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -12,7 +12,7 @@
 /* Mapping for a single class */
 struct selinux_mapping {
 	u16 value; /* policy value for class */
-	unsigned int num_perms; /* number of permissions in class */
+	u16 num_perms; /* number of permissions in class */
 	u32 perms[sizeof(u32) * 8]; /* policy values for permissions */
 };
 
-- 
2.40.1

