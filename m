Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D287D0D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376844AbjJTK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376746AbjJTK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAAD76
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697797748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAwIECtYVyyG0ycsKK/dkQSvkucJjxHaji8c1p28cm0=;
        b=ZXEXlvDExpDFT+ecN6O52JbOEEprlswmuAgmvivZebjLjoal3m3ZaBebwfNwqpcKteNjXF
        5262WBDP8Oknaa+CGl60qBwMybSk1u5fR9Nd8/sQau0SZUvWDBGcH7VJLbJl0TdPWsRTyb
        nZ+Qhpa++TCMR4id2L0+dSd7SkU7vqQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-7HBSM1hRNwWad6eNUDXMWg-1; Fri, 20 Oct 2023 06:29:06 -0400
X-MC-Unique: 7HBSM1hRNwWad6eNUDXMWg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso49074566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797745; x=1698402545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAwIECtYVyyG0ycsKK/dkQSvkucJjxHaji8c1p28cm0=;
        b=tQl0FbV42UkhlwfGo7xowwHukoy1vjlwHrJhSz3XFhLAUmu8mB9fDjy0KCOr9+nO7k
         mv8b1O2r9yET49kJLgu/a9ilsJL52WtX5Rti4PIMQ/s6MtHzrbFTyLzj3LQIJfnxRIQO
         oWUri6DaDkd/QdZKxM2ThMn1ZYjzMg4wFtoOh53K7I5cuKUmCQPpxJcid6SfqnHTn2V2
         zJHsrc8G69mmVAg2AVTDwVVSkUy+OvX5sKM65UCs5NmaMmOKCC4J+ta9mhNIY0yiLBOT
         fMnSbC9gpjsSVb8YTS3/NteAf2wy2WJltx4/CwjFO67lkiBjnGC1uLxI73KpPwzmVXCQ
         bH4A==
X-Gm-Message-State: AOJu0Yy5/+yv0lDxz8Y+gebdXyiGdVaIJBPUkcs0KZnlHSKHOmsrYBuh
        fxdocXl5TfXeb2Ijh0YCoPJ0b2pJaO9XoO+9PgdDGqhezYni7oWyZjI5xTbdensT2W5RYkYOyL9
        w4gOKGpdnkl/5ZKP4Pul/pLsFGxaxMtPyAa5MUMPJTO6tthDwfaDqg82h1lciZofLY6v/h3/+MA
        T5eRg0x/eg
X-Received: by 2002:a17:906:dace:b0:9c3:730e:6947 with SMTP id xi14-20020a170906dace00b009c3730e6947mr1088821ejb.41.1697797744894;
        Fri, 20 Oct 2023 03:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQXRZYGyysHWg3ScpVvICcbxHV4qwqIKH1OPYKhSv7OQPkKzDMkHzyh0qijVLw3L2y0xmseQ==
X-Received: by 2002:a17:906:dace:b0:9c3:730e:6947 with SMTP id xi14-20020a170906dace00b009c3730e6947mr1088801ejb.41.1697797744512;
        Fri, 20 Oct 2023 03:29:04 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709062dc900b009930c80b87csm1223140eji.142.2023.10.20.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:29:04 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [RFC PATCH 1/2] add list_for_each_entry_del()
Date:   Fri, 20 Oct 2023 12:28:59 +0200
Message-ID: <20231020102901.3354273-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020102901.3354273-1-mszeredi@redhat.com>
References: <20231020102901.3354273-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new list iteration macro that always takes the first element of the
list and removes it, until the list is empty.

Add a list_for_each_entry_del_init() variant too.

This is a common pattern.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/linux/list.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 164b4d0e9d2a..db23a9ee98f0 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -921,6 +921,35 @@ static inline size_t list_count_nodes(struct list_head *head)
 #define list_safe_reset_next(pos, n, member)				\
 	n = list_next_entry(pos, member)
 
+/**
+ * list_for_each_entry_del - iterate list and remove elements
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Delete first element from list before the iteration.  Iterate until
+ * the list is empty.
+ */
+#define list_for_each_entry_del(pos, head, member)			\
+	while (!list_empty(head) &&					\
+		({ pos = list_first_entry(head, typeof(*(pos)), member);\
+		   list_del(&(pos)->member); 1; }))
+
+/**
+ * list_for_each_entry_del_init - iterate list, remove and reinitialize elements
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Delete first element from list before the iteration using list_del_init().
+ * Iterate until the list is empty.
+ */
+#define list_for_each_entry_del_init(pos, head, member)			\
+	while (!list_empty(head) &&					\
+		({ pos = list_first_entry(head, typeof(*(pos)), member);\
+		   list_del_init(&(pos)->member); 1; }))
+
+
 /*
  * Double linked lists with a single pointer list head.
  * Mostly useful for hash tables where the two pointer list head is
-- 
2.41.0

