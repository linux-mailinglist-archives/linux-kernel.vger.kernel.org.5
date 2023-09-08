Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4140E7989AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244432AbjIHPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbjIHPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:14:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F41BFF;
        Fri,  8 Sep 2023 08:14:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso2956039a12.1;
        Fri, 08 Sep 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694186081; x=1694790881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atZ+M5AFC89fns5yYktOP5n7YffWb8eq/JNYGoPls6o=;
        b=czggR3fKA1p2+uy0wuJXsWiZDazQKefsR+ONs8eB4zh/6IpEW+ExlqsviXsySv+8A7
         xGmqzsSGqRfcY+SkF2d2nvVnBqmzvZE59H2oqwgz3nWbZiRIoh3pbqCpYx2d9b8ksSae
         5NmJGPHr6AGAtV3sE9h6GRsxeKk/R87kMC9vmidxkumMvqpmdKGorHTxrO0PnYFzAXyp
         N4c/gNPbWPVs9hqsB1GQ7zHxBR5Dl2/beRp1x04qLmheewaDdoCDBh7ZA+KCuYOJPW3G
         Z8IHE9jTNMK1bVv/gNNNIAV2l/NMcWa9snhaKyaylJKSpvrDAsP4n6WKmgrB54YUZV1i
         dbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186081; x=1694790881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atZ+M5AFC89fns5yYktOP5n7YffWb8eq/JNYGoPls6o=;
        b=TgvZ2h11t9cGBEQmGYl/lyj6MAARa1BVecnewxkNYrQxcN0bcsYKULyxAD5fOT/3Zj
         iDqjXyECs4POggERvYyH0/3o4UX3+7T+lyD+QAfs/EVs/vhsJiWJKZSDHcPlhyt5OcV8
         GaiSC8SM/MAaPZc2M/QNyHTOnHz5OFoAdHdcpf3OmXQogEtTY1SPWvfneZCC7FRmfsFQ
         76xIDXtCwt/O7QlkbuMpZZCkeh1RYIUfIwzlxFp4ZxGDWTDaIEKsyzSvYwNnqiznSKzL
         92tCCtHyWLq78tvy+UfoHnANonP8I9aXnGi4n9V8clwOabfEGzoG5pMQRLntk8lQoq8z
         aLjg==
X-Gm-Message-State: AOJu0YznDNboZCrYSqVndv87Q8BI1I52G3KqjluKXqnEWjbSIahfvgH3
        RuVt0iE0Mig4gA1cuhjI8YNCKpZRfQ==
X-Google-Smtp-Source: AGHT+IFcJg5hcXsjXX0knl5z8cFkGsjaOKH0kKB8/DaoOrPf/A4VjnAQxhPGCOwVx1lN98OATVYLfw==
X-Received: by 2002:a50:ed97:0:b0:523:387d:f5f1 with SMTP id h23-20020a50ed97000000b00523387df5f1mr2303303edr.24.1694186080517;
        Fri, 08 Sep 2023 08:14:40 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b005288f0e547esm1150373edx.55.2023.09.08.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:14:40 -0700 (PDT)
Date:   Fri, 8 Sep 2023 18:14:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        keescook@chromium.org
Subject: [PATCH v2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__DECLARE_FLEX_ARRAY(T, member) macro expands to

	struct {
		struct {} __empty_member;
		T member[];
	};

which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
changing UAPI structures layouts.

This can be fixed by expanding to

	T member[];

Now g++ doesn't like "T member[]" either throwing errors on code like
this:

	struct S {
		union {
			T1 member1[];
			T2 member2[];
		};
	};

or

	struct S {
		T member[];
	};

So use

	T member[0];

which seems to work and does the right thing wrt structure layout.

Fix header guard while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/linux/stddef.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -39,6 +39,10 @@
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
+#ifdef __cplusplus
+#define __DECLARE_FLEX_ARRAY(T, member)		\
+	T member[0]
+#else
 #define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
 	struct { \
 		struct { } __empty_ ## NAME; \
@@ -49,3 +53,5 @@
 #ifndef __counted_by
 #define __counted_by(m)
 #endif
+
+#endif
