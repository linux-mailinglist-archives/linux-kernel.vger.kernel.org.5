Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D556E7B5D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjJBWca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjJBWc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:32:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE79D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:32:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so1834817b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696285945; x=1696890745; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSFAh0qqGx45G6TQa/MZdM1IdFSztj1awjWbA+mcycU=;
        b=DxTvXFlnBlAEnK/Z/LDEasydqWeFp+BhkZSX1w3U/+eDhazMQfmeswKD3BdvlVraOn
         cTVbL4SHp5AOOa0dJqktCXfyWyfioimKkY/MAdiT3aF4A6cuqRjZq8mfW0TyfVdz+bAt
         IKvlW98J3gUn9EB5fPTWhk0GdC0rUcqK5QI/rrGgw7DgFWGKIJ3b9X6xKkuv6A9BlrsH
         kyEypAK0DNk+MltSxAJQKP3lgCvIvgAA50cJi+pAlVDpu+FDvTz6ZbfHbkqn3GYAf/ng
         ZrAjKdd8+0RsfW5mCkCYHk93OkdeloZ6ZOPRNY2M2zrUq+jdo70qm6UgMKIS/o80PYQP
         oyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696285945; x=1696890745;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSFAh0qqGx45G6TQa/MZdM1IdFSztj1awjWbA+mcycU=;
        b=Vhl6WlaMnHPJ15BJxT2cwBKX8DmRLixtEwYWyVm0xNJMePcFJU3x8tw7WIwQXMUgUg
         KgWgjgerlQ3yWAEFlFLcaiNnT7lbvvj6gmY5tyS0+zo9u6VBiLuqB4+caWpuLmh+NRPu
         SdULC7mEjDBzHI4QiG4HvsKFkwdxAvWYjLo9bce9KQzQAvKVJMkbQgcD0y6qebdvzGzW
         TH/mmvTOkH0tOE2DTrkSmed85sVofmGic9WhVt8ahYeDcs5C1nX7kIyKfPABaTsMyp7w
         IouCBxuFy2Y8ax2wCZ1SDiRAkj8oM3sORSQkoP98sGOK8pZOkcRTEtAuv4kaJE4S9IQ/
         weBQ==
X-Gm-Message-State: AOJu0YykDGeXvQBXurPZVZR/McpRxpBqgt3YFnZNcpnShXyvLHdE/HGQ
        Aq8vpcNgKwgPrwxhHxgFdXLXta6WUpuy
X-Google-Smtp-Source: AGHT+IGeGI7meiKgN62+V+QzM1QfTNOH6LmefzUD57qfCucPSiPf185y4PcRsqMKPnnkUk8hSDt7462RNtWP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a907:e439:3a86:b259])
 (user=irogers job=sendgmr) by 2002:a05:690c:4607:b0:595:7304:68e5 with SMTP
 id gw7-20020a05690c460700b00595730468e5mr19825ywb.0.1696285945027; Mon, 02
 Oct 2023 15:32:25 -0700 (PDT)
Date:   Mon,  2 Oct 2023 15:32:19 -0700
Message-Id: <20231002223219.2966816-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v1] bpftool: Align output skeleton ELF code
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libbpf accesses the ELF data requiring at least 8 byte alignment,
however, the data is generated into a C string that doesn't guarantee
alignment. Fix this by assigning to an aligned char array, use sizeof
on the array, less one for the \0 terminator.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/gen.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2883660d6b67..b8ebcee9bc56 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 									    \n\
-			s->data = (void *)%2$s__elf_bytes(&s->data_sz);	    \n\
+			s->data = (void *)%1$s__elf_bytes(&s->data_sz);	    \n\
 									    \n\
 			obj->skeleton = s;				    \n\
 			return 0;					    \n\
@@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
 			return err;					    \n\
 		}							    \n\
 									    \n\
-		static inline const void *%2$s__elf_bytes(size_t *sz)	    \n\
+		static inline const void *%1$s__elf_bytes(size_t *sz)	    \n\
 		{							    \n\
-			*sz = %1$d;					    \n\
-			return (const void *)\"\\			    \n\
-		"
-		, file_sz, obj_name);
+			static const char data[] __attribute__((__aligned__(8))) = \"\\\n\
+		",
+		obj_name
+	);
 
 	/* embed contents of BPF object file */
 	print_hex(obj_data, file_sz);
@@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 		\";							    \n\
+									    \n\
+			*sz = sizeof(data) - 1;				    \n\
+			return (const void *)data;			    \n\
 		}							    \n\
 									    \n\
 		#ifdef __cplusplus					    \n\
-- 
2.42.0.582.g8ccd20d70d-goog

