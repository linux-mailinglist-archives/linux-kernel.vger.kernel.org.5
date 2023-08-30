Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E690678D932
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjH3ScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbjH3P6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:58:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F02419A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:58:35 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6C6563F177
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693411113;
        bh=kNl44J2ZpGtCg94K9UACjS58K5Vqnr8rgjyDZbU7cks=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AdC/2E0roNN+6OR32B4t1a77YI+T7dEdLwaY/YtJjHsNbRCbwutgfydNyWwx9cMw7
         C3cgn9uh/JWB4VV13s9VPu7lRgviWTAWjQO0KA/9J8XajPZThsun28T0UJ3QhSBAoI
         LYr1M4tau/mqI6EEvnBdHqhwKfHujnW8H+T7Sa93AKfBQdvKdiwo1sc/+Z9niINfVQ
         SA5d7WIaruF3U87h86NM9NsJ8O9fSnkbbA75BhguS6EluLju72GdT4AZiy5FV3KBDz
         +fCTPjjT1/jQtvS1umb9+ClJGuQ5upKH7LWuOVvJK85uhim6VF4HnJjlfgBJkILCKU
         qZ93ba0tMWtuw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so4568133a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411113; x=1694015913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNl44J2ZpGtCg94K9UACjS58K5Vqnr8rgjyDZbU7cks=;
        b=kQPLkh37gdWr/2ODYVizVsvYWOJa2t8uKh0ILBE+v7p1RGejJxhkLIVMRU+Xm+1hUQ
         ESaarivs7Mts18vL93wO1oQNpqAjmy+L2zK1rkqDZEstcPWj1W5vb1iTXoMyjWpyrjGX
         qLwBihboadftCW5TfdBVps9l4Tf0L7wY186YfNxKvXs9fxRLQek6El0W1wl/m4Za6l+k
         79ejkUWAuawZvPKLb5sIILG6LBKKpH4Y/ZZggeVUY50WJ3WaVFKrGKAj+wAxxZMMYQqc
         h/V2h/9khD6qpH2NO5nT/Ht+rqrid4kQE3YDEH4T5Gy/GwGLY6DIuxL8s2L14WSIvJ3n
         Cdxg==
X-Gm-Message-State: AOJu0Yymiwgg+EsKenItJsmwyzUKDcpqwLiS9nHPvkUYTM/pvPTANeaW
        Gsx2ywO9Z7Qiw41GHoidOT8bUWgx3Ac9nWUzYjhI9OHg1akzkBaUEGKFeaLi5Fi95XH59ky/ib4
        6wE5/YJZhdAKTQAcOZvA1ku8twrtBBcsyd2NaT+pWpQ==
X-Received: by 2002:aa7:db54:0:b0:523:b225:701a with SMTP id n20-20020aa7db54000000b00523b225701amr2358936edt.11.1693411113072;
        Wed, 30 Aug 2023 08:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsdD7OzcrsdeyrB/2Brhvlhgug8gC90+0ErPZscEzGSa0PRuYEokx7nmqzcPnfwSlgGRmjuA==
X-Received: by 2002:aa7:db54:0:b0:523:b225:701a with SMTP id n20-20020aa7db54000000b00523b225701amr2358915edt.11.1693411112729;
        Wed, 30 Aug 2023 08:58:32 -0700 (PDT)
Received: from localhost.localdomain (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm6906970edr.78.2023.08.30.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:58:32 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module/decompress: use vmalloc() for gzip decompression workspace
Date:   Wed, 30 Aug 2023 17:58:20 +0200
Message-Id: <20230830155820.138178-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a similar approach as commit a419beac4a07 ("module/decompress: use
vmalloc() for zstd decompression workspace") and replace kmalloc() with
vmalloc() also for the gzip module decompression workspace.

In this case the workspace is represented by struct inflate_workspace
that can be fairly large for kmalloc() and it can potentially lead to
allocation errors on certain systems:

$ pahole inflate_workspace
struct inflate_workspace {
	struct inflate_state       inflate_state;        /*     0  9544 */
	/* --- cacheline 149 boundary (9536 bytes) was 8 bytes ago --- */
	unsigned char              working_window[32768]; /*  9544 32768 */

	/* size: 42312, cachelines: 662, members: 2 */
	/* last cacheline: 8 bytes */
};

Considering that there is no need to use continuous physical memory,
simply switch to vmalloc() to provide a more reliable in-kernel module
decompression.

Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/module/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 87440f714c0c..4156d59be440 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -100,7 +100,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	s.next_in = buf + gzip_hdr_len;
 	s.avail_in = size - gzip_hdr_len;
 
-	s.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
+	s.workspace = vmalloc(zlib_inflate_workspacesize());
 	if (!s.workspace)
 		return -ENOMEM;
 
@@ -138,7 +138,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 out_inflate_end:
 	zlib_inflateEnd(&s);
 out:
-	kfree(s.workspace);
+	vfree(s.workspace);
 	return retval;
 }
 #elif defined(CONFIG_MODULE_COMPRESS_XZ)
-- 
2.40.1

