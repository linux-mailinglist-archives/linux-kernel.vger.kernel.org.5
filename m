Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A07CDA18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjJRLPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjJRLPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:15:31 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2811A;
        Wed, 18 Oct 2023 04:15:28 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so5783122f8f.3;
        Wed, 18 Oct 2023 04:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627727; x=1698232527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMGHA1GqTA4NgUc9TGEceruFzKyhKbdLHyqCm7/lENQ=;
        b=c/FERCEXY3H+ereO2ZhahUZFv551Fg0BlePXzPHA6ERKa84nyPo+ZlPX/wBFtNfMXI
         XCPJjOHLIYxwtlIda9sKWXsudPlZ25LG3b2YL4uMnpHzd5y+jtN5+6hvikgw6uWAqtUl
         BoLswV3DYloSkrUrQO44ZSYpSUPUiPvtge8/2UuEG8u1A3+1MfLNhGr0JdgthxkndWnH
         7hJ6fuCsCvLiZ6p23R2MRB5IM4TxY2wzoHLczwVelwXFzr3/UW5oO3i+kyb47Q8LR+1O
         sG9JC4mzVMPAxJOy36ZDijZaSWQ5sOVgvObrCaKQahaL36ehX27RTnZBWp3dS7NzQhyk
         Z8xA==
X-Gm-Message-State: AOJu0Yw7xBjHDGuRDVTCotxPlPcu3pZ+2AJ+o2tWaxhuoW1naCf6gQXD
        ZJYQGdl8RHiGN9UZegbx1oEOjgJjUZJPFSmo
X-Google-Smtp-Source: AGHT+IEah1o37/XzeYly4CKX7YUd53M7DtYsKbFDQmUnaElJZgAAwHMCs07P6qGmetQDsrpsSs4ERA==
X-Received: by 2002:a5d:6046:0:b0:32d:a54a:f57c with SMTP id j6-20020a5d6046000000b0032da54af57cmr3949004wrt.25.1697627727199;
        Wed, 18 Oct 2023 04:15:27 -0700 (PDT)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe590000000b0032da46648dasm1902344wrm.8.2023.10.18.04.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:15:26 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
Date:   Wed, 18 Oct 2023 12:15:08 +0100
Message-Id: <20231018111508.3913860-1-git@andred.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904133321.104584-1-git@andred.net>
References: <20230904133321.104584-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: André Draszik <andre.draszik@linaro.org>

This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.

This patch breaks all existing userspace by requiring updates as
mentioned in the commit message, which is not allowed.

Revert to restore compatibility with existing userspace
implementations.

Cc: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
v2: ping & add ack
v1: resend because of missing people in Cc
---
 fs/fuse/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..b21ccc85c47b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1154,10 +1154,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags;
-
-			if (flags & FUSE_INIT_EXT)
-				flags |= (u64) arg->flags2 << 32;
+			u64 flags = arg->flags | (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
-- 
2.40.1

