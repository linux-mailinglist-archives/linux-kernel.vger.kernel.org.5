Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4997BAE96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjJEWDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjJEWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:03:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85946DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:03:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81c02bf2beso1898668276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696543411; x=1697148211; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVyzgez16PpY3NCo1AOr8fto/XvcbmDay0gklILgDzE=;
        b=Z+L/G+PAEQqWxbIH7a/YbWyMUvB4LUwQtbBVnS18wQjgn0pXbtgniWzBwiOnVrE1Dj
         HkNr/aeuVpwz9BNgDORqh5SVcD9asR7OtiXAHggYVHB8mro3yRV6GV83aBJbz5dVMUi3
         z561OOMKPcgEcGMqvJLoGb8Wf63+J63oODgm+R6o2fByN+Iqi7XbBDEKqxThOa6l4DbY
         QR3yRENPY9daxSSby0gpdo69v8ig8SkpZJGcQ8Hou9VAdqn9IZfgeDzXSKNLm6uoCJ9A
         SFmhtqwGIMkGE3nK6y+HN/hXckJg2ia7XSVZFuue1CImrOVzI0VkHiahwljLVvog5KIX
         vWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543411; x=1697148211;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVyzgez16PpY3NCo1AOr8fto/XvcbmDay0gklILgDzE=;
        b=IUYarwCLDO0Q1NadZUpQa4liasS3wV9FyFsIp9pTJZbf2chS/N/rjb8SGPsiatkuur
         puGSAkknFGRtb2NvRanYfG2zjf930cjC6hQCTXgrQfQM3amzdtzRuDXRRj29Xw2WIqm5
         BFfRGqtD9Qn4bCqw3LSoYpFNv5zuI6JHN/foIuJWpTknHpn2CVOGYBav2zW0vATj789k
         XLR1AFF5+leys1BESWFGGiOGKHeNUwAfNiOc6ZGNJVU7h0GWrp+Kfpag00lMD6KU3aLU
         akleXOggKrwdejMLKmDMxZifcU94RPefRkDWJLltxYVxuNcWXR4AFoPhK2xofYLczVfW
         zARg==
X-Gm-Message-State: AOJu0YzYrWYVi1GpX0ptKuVZTD8mRUx7lPCxsux+1CSCsLGK+nv/eQxw
        x25fN45VU1tyNNLLfhYSmfF99rDROYpI
X-Google-Smtp-Source: AGHT+IFzGQ7/u5GAMNrdTuQZOM1fzUztDurt1lna0A99CvX1ih1Jeqr/kZ1vBVk0V7ny/McibUOziYwOwkV8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:e002:0:b0:d80:bea:ca87 with SMTP id
 x2-20020a25e002000000b00d800beaca87mr102852ybg.1.1696543410782; Thu, 05 Oct
 2023 15:03:30 -0700 (PDT)
Date:   Thu,  5 Oct 2023 15:03:24 -0700
In-Reply-To: <20231005220324.3635499-1-irogers@google.com>
Message-Id: <20231005220324.3635499-2-irogers@google.com>
Mime-Version: 1.0
References: <20231005220324.3635499-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v5 2/2] bpftool: Align bpf_load_and_run_opts insns and data
From:   Ian Rogers <irogers@google.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A C string lacks alignment so use aligned arrays to avoid potential
alignment problems. Switch to using sizeof (less 1 for the \0
terminator) rather than a hardcode size constant.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/gen.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b8ebcee9bc56..bcd26946d10e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -708,17 +708,22 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
 		codegen("\
 		\n\
-			skel->%1$s = skel_prep_map_data((void *)\"\\	    \n\
-		", ident);
+			{						    \n\
+				static const char data[] __attribute__((__aligned__(8))) = \"\\\n\
+		");
 		mmap_data = bpf_map__initial_value(map, &mmap_size);
 		print_hex(mmap_data, mmap_size);
 		codegen("\
 		\n\
-		\", %1$zd, %2$zd);					    \n\
-			if (!skel->%3$s)				    \n\
-				goto cleanup;				    \n\
-			skel->maps.%3$s.initial_value = (__u64) (long) skel->%3$s;\n\
-		", bpf_map_mmap_sz(map), mmap_size, ident);
+		\";							    \n\
+									    \n\
+				skel->%1$s = skel_prep_map_data((void *)data, %2$zd,\n\
+								sizeof(data) - 1);\n\
+				if (!skel->%1$s)			    \n\
+					goto cleanup;			    \n\
+				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
+			}						    \n\
+			", ident, bpf_map_mmap_sz(map));
 	}
 	codegen("\
 		\n\
@@ -733,32 +738,30 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		{							    \n\
 			struct bpf_load_and_run_opts opts = {};		    \n\
 			int err;					    \n\
-									    \n\
-			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
-			opts.data_sz = %2$d;				    \n\
-			opts.data = (void *)\"\\			    \n\
+			static const char opts_data[] __attribute__((__aligned__(8))) = \"\\\n\
 		",
-		obj_name, opts.data_sz);
+		obj_name);
 	print_hex(opts.data, opts.data_sz);
 	codegen("\
 		\n\
 		\";							    \n\
+			static const char opts_insn[] __attribute__((__aligned__(8))) = \"\\\n\
 		");
-
-	codegen("\
-		\n\
-			opts.insns_sz = %d;				    \n\
-			opts.insns = (void *)\"\\			    \n\
-		",
-		opts.insns_sz);
 	print_hex(opts.insns, opts.insns_sz);
 	codegen("\
 		\n\
 		\";							    \n\
+									    \n\
+			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
+			opts.data_sz = sizeof(opts_data) - 1;		    \n\
+			opts.data = (void *)opts_data;			    \n\
+			opts.insns_sz = sizeof(opts_insn) - 1;		    \n\
+			opts.insns = (void *)opts_insn;			    \n\
+									    \n\
 			err = bpf_load_and_run(&opts);			    \n\
 			if (err < 0)					    \n\
 				return err;				    \n\
-		", obj_name);
+		");
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
-- 
2.42.0.609.gbb76f46606-goog

