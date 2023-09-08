Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1177990CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbjIHUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbjIHUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844D10CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=FVtUIV6tsX+mNwu0dPRU6/krl9z5hF9660WzUhQAK5v5pfb1taPidTii67cjZRQlB36Opz
        N+VKXKxTwg38ubSiFAI1yy6hyWdSyAD3Z7LrfcGoLSuQKA4NOSmveGTGWAGYLY8TfIMfNB
        qIVcvn0Vo93t4/92WiM7XdHw3ws5SLQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-5Ue3-Wm7Nv-F8iB9xFRzZQ-1; Fri, 08 Sep 2023 16:03:11 -0400
X-MC-Unique: 5Ue3-Wm7Nv-F8iB9xFRzZQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76f1cc68e65so58231985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203391; x=1694808191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=xCB3WEIkUMV0O43N0o/F6lHYOcZDVxHt9vFNmc9RK62SMyd4OL4XJzg2/IBL7xJayq
         ID0qgJQ5HJrRS4Rzl1S+quNQCXKi7b0cRmOk6n81fg/CfYYLeP/ktZQ+3qERJRu0tfKo
         VXfuOc2Ysh6ngJmYsAWIG/D1XedwFc2P/D5114wv8GKK/e3fgMgxrXmzaiMNlnRu1/0+
         r7zUrWlZ4TrPiqIMdh25axxNoFdRzvzVu7Qw99swcg5/dXh8SF2KwlgrTv8phtVTG/VI
         4QM4A7Oo9U1EAXwsr2HWLk983vEOZK7rSyENVTHxwk7D22IBoA6jKr0+VSEZylPv7L7m
         9S3Q==
X-Gm-Message-State: AOJu0YxzojJqkikR9Kks/8+XJ/J8dHwJIghtGk1HLkduUk78/HIDLOK6
        F+jbR6pYCDFBshfIhKdRVpnpAmKYHAm7eWwYSk1CzUELNvZSUbUhWZE/Ar1Z0LIh7qtKu0DV58x
        Y22QgmjSjS7e8XXZcvOZwa7On
X-Received: by 2002:a05:620a:46a6:b0:75b:23a1:69ee with SMTP id bq38-20020a05620a46a600b0075b23a169eemr3480476qkb.5.1694203391480;
        Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuCpViWH7IrGzpUqlTBi1h+iY/5ABj5ubmz/i5MJtwSQDaqOps3aQUe1r5isWfpnPKjPasBg==
X-Received: by 2002:a05:620a:46a6:b0:75b:23a1:69ee with SMTP id bq38-20020a05620a46a600b0075b23a169eemr3480460qkb.5.1694203391259;
        Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id c17-20020ae9e211000000b0076f15f2918fsm825920qkc.63.2023.09.08.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:10 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH v2 3/5] kernel: watch_queue: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:42 +0200
Message-ID: <b333514f0be426385b5215b47d24062b4f551584.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d0b6b390ee42..778b4056700f 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -331,7 +331,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
-- 
2.41.0

