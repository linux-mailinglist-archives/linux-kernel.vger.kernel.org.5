Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B177BAE92
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjJEWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEWDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:03:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318FD8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:03:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d816fa2404aso2060727276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696543408; x=1697148208; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3o6wyBSROZp99HOssTXqpXKVsTtNmt9jgf0aZMxwy0=;
        b=hbw1RH/rDSDbT8w7/RCxWggqTGsq2S5bgAEQ27PmhmbHFtuQ+/zb3EtJB9p6sIbf/o
         K6XKaIHZ6lksGCZnnuuPIc47XUl2jZBmuLFqmoaJAkEGy2OtlSmInG/OiVAfoWyAzFs/
         B6b4LktvD+4Msv8u0ij8yqEcgHJpvr5SOr20Yz2xaDQHIPsHoF9MyDpAfmFzUJMWiMqz
         jnbSeLm0AmsyTB9037GyffjDy9Fu4wAfTi0zW/VjBs4FlD4fmuKbi5rgrywINne650oO
         6ePP8B823zkmdiNmtCZCmAUEG3tooHIgb2SveK6GaiJaJFveY1ju0XQnuE2C+YlVfJnb
         oaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543408; x=1697148208;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3o6wyBSROZp99HOssTXqpXKVsTtNmt9jgf0aZMxwy0=;
        b=JtaShxpUb22AzVZW8uIxRlGzHQMPsNNtmtXCY7hDMUQnDWzix81r8ygmrsSLLBcoly
         0PjSN6+nSwfbUpoZWELceygtxuOmkHNhKZpiozpXyCYsZyo4K3MoRZMrLmdU+D2T1TLB
         0srCBkGmu4w7Ex2cDxjQsAMzfVGeslHTbk580fgt25PhssJeeGoEFxcGAw00dcQH4q8I
         VMg9GMurDBNLEd4yfCskYfERw16y35uPSJRwLqydrYj0bHrrQfRD/O/Hw0YacO8vbjXF
         rO+pu6PeeGKaJXClPhfcraNGoFj8flR4I7fJadz9PXzTP/ivl7/LVUne2tMD2/Cx0ROW
         DrnQ==
X-Gm-Message-State: AOJu0Yw6/JJvn3DPcOIgEij7dpOCnQt6pZG2OQiWrxxY/Mxy2gunDE7F
        YeD6vXgJeYdNoVEJs8uC8rAo5Q9/Nele
X-Google-Smtp-Source: AGHT+IFY6uusPq36KufL+4X+7Hc/k0/HksE1P0N2IyD7+YFnHmA6Aj/c8kip3ToyLXVbHX9+OrtD9F9e4WdQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1603:b0:d7a:bfcf:2d7 with SMTP id
 bw3-20020a056902160300b00d7abfcf02d7mr100869ybb.6.1696543408563; Thu, 05 Oct
 2023 15:03:28 -0700 (PDT)
Date:   Thu,  5 Oct 2023 15:03:23 -0700
Message-Id: <20231005220324.3635499-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v5 1/2] bpftool: Align output skeleton ELF code
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
Cc:     Ian Rogers <irogers@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
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
alignment. Fix this by assigning to an aligned char array. Use sizeof
on the array, less one for the \0 terminator, rather than generating a
constant.

Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skeleton's embedded ELF data")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
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
2.42.0.609.gbb76f46606-goog

