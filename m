Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DA7B97ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjJDWXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJDWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:23:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE8010D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:23:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86766bba9fso455648276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696458208; x=1697063008; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzX5wmLYyGVenVJvmQO+om+eWA+EBs8Xg6bCWmXIBDQ=;
        b=1p1zilIWrwSNTANPn5G0v5HRoO9ieIdCyRoZ2y5TUs4Zoj/KYvQPn5DRdzJ+y+HqEn
         PEot3QoYi9lkp0CkZRMVEsDqyXVs1jwRDaqbW6rPNVbljYsGZiKFsJaRJRS5sgXPdmz1
         bnTGa8kl1/WHAXgepXDpkmnV/W59yKpHJ2qcMHseoFiw7TYekiAlM2GrOYkp+Y+bAPK5
         sunIZL8eCph5unFqJX2M0wMILp0yvCLG0y5iEXtXwFinvbTWFQd8Z/e+wZdblcMTfGrd
         832u5tudEExvzGxhHW6RSycKL0jsHbKdCevJm5T8azlYuV15MfcqLaVABM/VGUXTMzVB
         erNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458208; x=1697063008;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzX5wmLYyGVenVJvmQO+om+eWA+EBs8Xg6bCWmXIBDQ=;
        b=oHRtiZbqQxtHTlmdTXSkM06E66Pp8A9ij9/cToOp26MXjHJFOQl71A9E1fdvq1zn4u
         g7xyFozws4o7CjkWlWNcdDqC9XRUuuL6PESelwQDh7GKZZ5Tv1zAEJ+25V3wLzuetd2V
         HwKhJJKHJS/1+zP+vct3X24unrhCXYTKtP2AZnaulDsA2NrqIPu4SO76wxPu56ujl8ka
         ttbLCx8nT4H3pUY2lBBm3lIz3/zEiYDY28+iRCInod3GpoDs2cH20W9QskPnWZiiAOzT
         +gGtvu/4ThEeCrukYV1n0qrP7ytBTaW8vH/Ud6Srs7EofSSlvdmLu1SpsssK3XFgGBPE
         T8/Q==
X-Gm-Message-State: AOJu0Yz0EdAIzfJPkObchi5PWnWwYF0hfARJxFYkih1jV+wyACAFi4A2
        gWwSV092wHi9m4SrYlYeZIMjVa21tKYg
X-Google-Smtp-Source: AGHT+IHvF9BgEMqd3YfEZKmvnvOMOqNldSm6WrYskTN1Aec+uolfJJ3OTjlsrxKR9NYynPcHuWje6mMl7RUT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f42:a09e:8ee2:1491])
 (user=irogers job=sendgmr) by 2002:a25:dc51:0:b0:d7a:bd65:18ba with SMTP id
 y78-20020a25dc51000000b00d7abd6518bamr52326ybe.3.1696458208397; Wed, 04 Oct
 2023 15:23:28 -0700 (PDT)
Date:   Wed,  4 Oct 2023 15:23:23 -0700
In-Reply-To: <20231004222323.3503030-1-irogers@google.com>
Message-Id: <20231004222323.3503030-2-irogers@google.com>
Mime-Version: 1.0
References: <20231004222323.3503030-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v4 2/2] bpftool: Align bpf_load_and_run_opts insns and data
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 tools/bpf/bpftool/gen.c | 47 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b8ebcee9bc56..7a545dcabe38 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -408,8 +408,8 @@ static void codegen(const char *template, ...)
 		/* skip baseline indentation tabs */
 		for (n = skip_tabs; n > 0; n--, src++) {
 			if (*src != '\t') {
-				p_err("not enough tabs at pos %td in template '%s'",
-				      src - template - 1, template);
+				p_err("not enough tabs at pos %td in template '%s'\n'%s'",
+					src - template - 1, template, src);
 				free(s);
 				exit(-1);
 			}
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

