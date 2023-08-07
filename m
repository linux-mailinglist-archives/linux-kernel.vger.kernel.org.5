Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF1772C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHGRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHGRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134AB1;
        Mon,  7 Aug 2023 10:11:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523108efb36so5373265a12.1;
        Mon, 07 Aug 2023 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428313; x=1692033113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DciKbSFWjq2a4hr5WGLiRBew39Nly0oMydCVVcPx1pg=;
        b=niNzslaPuqd7b5KcbIfKjJtnuLsnsuv8tUmWZXErPSYM+0cghYrb6PsPGWaXsoTZfa
         HvRLqZYfWeo+6mPmYKRm/BUGjcxWYp/SMd6RQwFr/K5Lq5Zo3wUOFRwIuJ+z+JYoWmG9
         OUyj22fJqir6AXH+A0uAj581d59d+XKDPXa1SLBhV5e1f/tmCAeQ7RDb13QBfiF6poCQ
         9KuR3QziNequ0LHYYUJQzF3p2cyP6JoUpPbPtYDig+eCMNFTm62HLnrxzXwAq3Qeje4Q
         ULkZpnaQoVAeL2sGiMK7E8VpUrPX7GE5hFgJ0npTUtYzTooVzBNTCxUlcNrT8eCEYRLA
         pmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428313; x=1692033113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DciKbSFWjq2a4hr5WGLiRBew39Nly0oMydCVVcPx1pg=;
        b=TU+eXmr5eEwPoSwuYP01Ou7o/a67b5xCi7crLakIinR9qzuSxhXwB11mndkZHzw8lF
         EYsMYRDoiSurWZRDVwotmO9dVvS2qIgFEYctl4D94HKBKgKxjDDKGl8BJVoj2zTMdjwQ
         E5b5otzradPqUg4iPe2UHSpG+pZnIt3K9DM6TPMbfO8jyx3mIffMliYBGAU8rZ+Wsk6q
         /Txnx5DgXaGZywM+gI9Iedp1ElhkODyhYwhli4oxdvNGWzS5YF/qMRCcHELLsBrVDTX8
         JbPZwqiAoxFvWyg7jteSfBS5gDioo8ukfyi5WGsiMmqK5mC1HHJZYljH6EHYgNEeGFmC
         eBzw==
X-Gm-Message-State: AOJu0YxBL5meCtRVq7r2/sEYOAqsfEygR6ywbQuY3+UfeRy8DDRgD6OC
        ih7zTldA75eJSRl014FJnZBpqFBG3gOxbg==
X-Google-Smtp-Source: AGHT+IGMWW5UHgdmjZcN2ePQR5vAJfX2smxgWAJLR8hzBilZy6fdyVbz8CGYjav2SVBi4knUhDerVg==
X-Received: by 2002:a05:6402:1059:b0:522:2782:532 with SMTP id e25-20020a056402105900b0052227820532mr7892346edu.30.1691428313067;
        Mon, 07 Aug 2023 10:11:53 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] selinux: update type for number of class permissions in services code
Date:   Mon,  7 Aug 2023 19:11:37 +0200
Message-Id: <20230807171143.208481-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807171143.208481-1-cgzones@googlemail.com>
References: <20230807171143.208481-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Security classes have only up to 32 permissions, hence using an u16 is
sufficient (while improving padding in struct selinux_mapping).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - drop type change of arithmetic variable; it might effect performance
    as suggested by David.
  - split bogus and corrected cast into separate patch
v2:
   update commit description:
     - mention struct selinux_mapping  in the padding argument
       (currently between the first and second member there are 2 bytes
        padding)
     - mention overflow in the cast argument and the result of setting
       no bits due to it
---
 security/selinux/ss/services.c | 2 +-
 security/selinux/ss/services.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3ec0bb39c234..dacec2ebdcd7 100644
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

