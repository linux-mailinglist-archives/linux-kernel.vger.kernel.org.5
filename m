Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81487BC4BC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbjJGEpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJGEpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:45:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB38BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 21:45:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d815354ea7fso3622175276.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696653902; x=1697258702; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GMqnFgEnYGV7L+VhDywAwYo6eyJsbJGDIIS4AN+4+k0=;
        b=gJmQsX4ASu/vmfsVM3oqNJuHpQXc7XAfWkC2eiQ4RR/oB+LOZj+vGfsxCXn7z7xVwy
         O6QYv3lw0AKDxTPHbJ1GLqpITn+hkUK/t4mvgFBLV93YwE6aGo1grDQiazSP01S6/sq0
         ze6QHX67Vp1sTOAfV5aR7CpUf84vxwT/ufGqFj2QwbxMygO8SLZW/UM6GP8t8EL3yUnb
         V68LvzDKT8f57pWaoGLVdiTokom8uPdIjpN5pkx4cwwou5VHPGv1YvWFP7frbqG6Aldn
         xu6TxQQHGfnd4rQPwHWa6CBffAu978hQjb3sIWmixUHYMw/laKxmj6JIYTZ/9cvwIWdW
         OG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696653902; x=1697258702;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMqnFgEnYGV7L+VhDywAwYo6eyJsbJGDIIS4AN+4+k0=;
        b=hpHOS++0FbfoBEVu57CInKxCADmhbgXvF7HNxFEf3GqF3+VFRX2Wp/IHa52OwEHLBp
         FvsR4JLe33YEL8Wacgwqv+iASWCJ16X7oJ6wXuBFMjvmgRpJ+j/4ZfMhfuyjDQw1WWM6
         QZwWHe1lOR7PS7bqRql0P5XFgCh/V7jNwIcYqoBy20TTe9eC/2KM7OtV5Q0ealSdyMzK
         FS2lR8/2/pfealPOBcmnn4lEl5k1jmTOc/VCAUIakee/43IjsTDSGvelSwiojAVmeEeV
         UeyPOzrddJiQmUY+4I3O1rgOnVbnCFjY2odYBHeIKutpoR5OeInoHLqK8fBkw5F7EHTC
         Z/hQ==
X-Gm-Message-State: AOJu0YzOR7YISZzb/TRLWKzKqOTXkVmxAqvweG9XaI1hTKWXR2fcqs9a
        iU60DE0OKVCOj7DOKxpz7fcbU3XFK6yj
X-Google-Smtp-Source: AGHT+IGqsoSCI+X+R3Da3bNooRUWbQL/a6S4rxNuVu2HDFeQLf3tBnt4ztfQwRKhCpzS6Mtmexsna3XbgGof
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:9390:0:b0:d07:7001:495b with SMTP id
 a16-20020a259390000000b00d077001495bmr161858ybm.11.1696653902279; Fri, 06 Oct
 2023 21:45:02 -0700 (PDT)
Date:   Fri,  6 Oct 2023 21:44:38 -0700
Message-Id: <20231007044439.25171-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v6 1/2] bpftool: Align output skeleton ELF code
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
        Matt Smith <alastorze@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
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
index 04c47745b3ea..882bf8e6e70e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 									    \n\
-			s->data = %2$s__elf_bytes(&s->data_sz);		    \n\
+			s->data = %1$s__elf_bytes(&s->data_sz);		    \n\
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

