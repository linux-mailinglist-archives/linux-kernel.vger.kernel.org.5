Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92B780ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378075AbjHRPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378095AbjHRPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:12:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1AB4689;
        Fri, 18 Aug 2023 08:12:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdcade7fbso126168766b.1;
        Fri, 18 Aug 2023 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692371553; x=1692976353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJbw1GCaNkp1mvMvks0R4KmZq/5vNngaaWzPgKdzcBI=;
        b=ksW2sAFDtA29aAzJUwQOx9s35kbGa38cSw6gn/6bghi/w/hDCnNOR6d/pJJgxsFJQV
         nvIYkxT8bY//ugPLl/NoVCre/uRgA5eCdjhQoQSHiu12/NDkdjwBfpUKHGoIFPOXJuLR
         0ioWDR+toiAoESkX9Oxv0bYbzeomZBKccuBMZqudKFJkPfRWr/IwxWr59i4SFHDVVisn
         hN6cazsNtrLYTA4f8kBto5U5JkH2dLdj8AjdPLzGCpIQU7TDV1Ud0ATqRZ8JJ5tiTMXT
         FoCevzYhG8NajA9g0nsdkLA0nne+OINEbkYvZtv2XR6/HMvS7Ld24hF9GEWJVxuskGDv
         kSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371553; x=1692976353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJbw1GCaNkp1mvMvks0R4KmZq/5vNngaaWzPgKdzcBI=;
        b=C1pGWcmtnXFwdObk/YYv0h9Ld6MjrHehMZSzVNmVbMkrQChhVNNWY6Gx/qivTm5x9W
         1EolcPP4utl7VyuMwLS7xYBfgjZVspo1/ig8MBhY+LEbgocAA/2d8wuQNWk1WoTRmFHx
         RsB3GmWasUx9ykvDMMY4aClxTvTTeehzp2TQA7zFnmniv18Jr3dTMltU7m6p/glrRMYr
         qcFGP1XiSEz5kGmJCVwZKKlBfMqYZSF7KaYtvrWLoC64a8kEJ8yQn8z/YZCkPa+ApyYm
         LjawS6BQJznR+hT2aRxA3Pn98WfWO+vUgRqZOO+jEJylIbvlqKT2h/nygnxhjxIVMwx2
         pjGQ==
X-Gm-Message-State: AOJu0YwidPqswAb6xVfDPLIihPch0joL7cbu1gpbb+D9y5iOFvg1MLZT
        QczQeO4dcfpX7dmTtbw9SdkAY30uih0g4w==
X-Google-Smtp-Source: AGHT+IEA+txfXn8wU5i+Z9VkmOutImS3pUopFpT0HIgeXmvf7AQabi5uU9iMJS44FIOXvLcfFkKsHw==
X-Received: by 2002:a17:907:762a:b0:988:9ec1:a8c5 with SMTP id jy10-20020a170907762a00b009889ec1a8c5mr1931135ejc.55.1692371553557;
        Fri, 18 Aug 2023 08:12:33 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm1285913ejb.92.2023.08.18.08.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] selinux: improve symtab string hashing
Date:   Fri, 18 Aug 2023 17:12:17 +0200
Message-Id: <20230818151220.166215-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818151220.166215-1-cgzones@googlemail.com>
References: <20230818151220.166215-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of buckets is calculated by performing a binary AND against
the mask of the hash table, which is one less than its size (which is a
power of two).  This leads to all top bits being discarded, requiring
for short or similar inputs a hash function with a good avalanche
effect.

Use djb2a:

    # current
    common prefixes:  7 entries and 5/8 buckets used, longest chain length 2, sum of chain length^2 11
    classes:  134 entries and 100/256 buckets used, longest chain length 5, sum of chain length^2 234
    roles:  15 entries and 6/16 buckets used, longest chain length 5, sum of chain length^2 57
    types:  4448 entries and 3016/8192 buckets used, longest chain length 41, sum of chain length^2 14922
    users:  7 entries and 3/8 buckets used, longest chain length 3, sum of chain length^2 17
    bools:  306 entries and 221/512 buckets used, longest chain length 4, sum of chain length^2 524
    levels:  1 entries and 1/1 buckets used, longest chain length 1, sum of chain length^2 1
    categories:  1024 entries and 400/1024 buckets used, longest chain length 4, sum of chain length^2 2740

    # patch
    common prefixes:  7 entries and 5/8 buckets used, longest chain length 2, sum of chain length^2 11
    classes:  134 entries and 101/256 buckets used, longest chain length 3, sum of chain length^2 210
    roles:  15 entries and 9/16 buckets used, longest chain length 3, sum of chain length^2 31
    types:  4448 entries and 3459/8192 buckets used, longest chain length 5, sum of chain length^2 6778
    users:  7 entries and 5/8 buckets used, longest chain length 3, sum of chain length^2 13
    bools:  306 entries and 236/512 buckets used, longest chain length 5, sum of chain length^2 470
    levels:  1 entries and 1/1 buckets used, longest chain length 1, sum of chain length^2 1
    categories:  1024 entries and 518/1024 buckets used, longest chain length 7, sum of chain length^2 2992

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/symtab.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 43d7f0319ccd..b6761b96eee4 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -11,16 +11,14 @@
 
 static unsigned int symhash(const void *key)
 {
-	const char *p, *keyp;
-	unsigned int size;
-	unsigned int val;
-
-	val = 0;
-	keyp = key;
-	size = strlen(keyp);
-	for (p = keyp; (p - keyp) < size; p++)
-		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
-	return val;
+	/* djb2a */
+	unsigned int hash = 5381;
+	unsigned char c;
+
+	while ((c = *(const unsigned char *)key++))
+		hash = ((hash << 5) + hash) ^ c;
+
+	return hash;
 }
 
 static int symcmp(const void *key1, const void *key2)
-- 
2.40.1

