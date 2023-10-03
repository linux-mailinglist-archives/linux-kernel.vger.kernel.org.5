Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699DA7B7195
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbjJCTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:15:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E008E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:15:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f53027158so21103817b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696360509; x=1696965309; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4htVJIGGb5h3erLQS3Hd93PuTJER9wVr3iHSknNQY=;
        b=UFcwdhuuCbyuM9r8KJhOm8K7BhN5+pS+CtOGM3l/0IvsEnA1tiC2mnu9jFWkcHE/Kb
         TWEYpPbi2vdIyHbih0y68SHVGdX6K2QTn+EQWvNGfdUAInEbMZg0SHy/cTNiZCum7tXg
         mQFUVSoBm2LnKHNel8V6j1Otww5Tcp31ZCaws2QrQgLBbhg/k6kcfND8goBaLj1wwlk6
         pRXsQtmbmzdiNHPnjbBbqbfZnnYwgljubGwP8Czu4QITDq2qq+2KLPxTddEvDnACl1Jc
         WtufP0K18NXD+QJtLRj6uwJm7lMiVYV1coCOjKbBac1DZXa69AIb9LUuz23i6K45F5iu
         /gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360509; x=1696965309;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4htVJIGGb5h3erLQS3Hd93PuTJER9wVr3iHSknNQY=;
        b=mRGQOnA6FycHHb9Tg6U2W5oDkDxDUpIjBK4xqfApa9J0nzlFk0+3ctvgSWr9HstIEY
         COaXsmfQH8HLgopsPIhnn2C3u1QMbYkOJoHgWL7WiAs8oNff0+n+x3BxvlgNJL/Csjlc
         SV5tnBWulcQu51xvPZ91kimPlE3QkzNZdzQt7MShqMiEj/4mt6iawA4QNaDAPlied836
         S3cvFNgOFc1sUMOt0ZXxFG/xTzP10pRIfSDR8uUdOxlFMFqHHIMOnTauZUCeU/VrQ/i4
         Zcth/jP/AOezq7fkuZX5TOLU2eGkZbsn9fN9abDJMJjWXngyJ/Xhup2uEzsVCFLZHA2u
         JASw==
X-Gm-Message-State: AOJu0Yyb2cX/H1qIiaAc6S4MZVp4LWbYoKkkmkYRG+IAmY/Wefuk8M5L
        btLTf8e50GCv9XjZkzlcdZ2LW7kvVvm1
X-Google-Smtp-Source: AGHT+IEYZ1pBWCmXLN1j2N35fPF2rv8nARnMlWixIYVn+j22HysMgdNODZ6bnzSYzPGqFXn01/UUVNBsXHhZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51d:1f25:c2d8:4514])
 (user=irogers job=sendgmr) by 2002:a81:d444:0:b0:59b:ebe0:9fcd with SMTP id
 g4-20020a81d444000000b0059bebe09fcdmr9061ywl.7.1696360508657; Tue, 03 Oct
 2023 12:15:08 -0700 (PDT)
Date:   Tue,  3 Oct 2023 12:14:12 -0700
In-Reply-To: <20231003191412.3171385-1-irogers@google.com>
Message-Id: <20231003191412.3171385-2-irogers@google.com>
Mime-Version: 1.0
References: <20231003191412.3171385-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v2 2/2] bpftool: Align bpf_load_and_run_opts insns and data
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A C string lacks alignment so use aligned arrays to avoid potential
alignment problems. Switch to using sizeof (less 1 for the \0
terminator) rather than a hardcode size constant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
I was unable to find a test case for this part of the codegen using
Linux perf and libbpf tools code bases.
---
 tools/bpf/bpftool/gen.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b8ebcee9bc56..e9a59b254c66 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -708,17 +708,22 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
 		codegen("\
 		\n\
-			skel->%1$s = skel_prep_map_data((void *)\"\\	    \n\
-		", ident);
+			{						    \n\
+				static const char data[] __attribute__((aligned__(8))) = \"\\\n\
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
+			}						    \n \
+		", ident, bpf_map_mmap_sz(map));
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
+			static const char opts_data[] __attribute__((aligned__(8))) = \"\\\n\
 		",
-		obj_name, opts.data_sz);
+		obj_name);
 	print_hex(opts.data, opts.data_sz);
 	codegen("\
 		\n\
 		\";							    \n\
+			static const char opts_insn[] __attribute__((aligned__(8))) = \"\\\n\
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
2.42.0.582.g8ccd20d70d-goog

