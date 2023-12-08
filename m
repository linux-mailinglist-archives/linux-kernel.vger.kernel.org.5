Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91E780AF00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjLHVvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:51:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CCEA;
        Fri,  8 Dec 2023 13:51:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c19467a63so28429865e9.3;
        Fri, 08 Dec 2023 13:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702072286; x=1702677086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDn8NwTCQ+8/XvF68whD6iZE3c1B6URP/KepTuq9faE=;
        b=mEI3bgscaaakSSrpLb8xKYBWGo1GSzbBrw2fppCIbFiYwFrHF53frMSs9c6OR4Icsv
         HsjXYsNKyWQNRi5rikr5JcaeBm5+r3G6g0IFSnXzEoVNNUxGQxctwF/kWxEQ8HzUyCrQ
         0Yh3cXaLAticszPodb4ZisCIS3FQxCEs/cWhkWkylsBd2aYETKo2Ke09q2dIQ1fQtQQh
         OGLrPCBlZGKQ/QBTXXmBZBiTqEvxYPXAo9Ef3k/ErGvun2hwRM3i2bb/SAXg4fHB94Ob
         jmsaGMMgw+Tjy9tHeYzk8UB/GWNT4YDZiTAvkDjTeYtnVptllmv+qQaOdEWv/qKyvY9k
         /+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072286; x=1702677086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDn8NwTCQ+8/XvF68whD6iZE3c1B6URP/KepTuq9faE=;
        b=FmGzmSmPdQuyLO0v0lRbPpb1VZPZMat1qyJiNcMXAI+7HxLy6a3r6mk2R8gO6mxfjG
         THAMXtc89gMtKU5pV77N0pSI2jVwPKnE769Eb0o57gWcuuU9NaEH3TvWMbcuRhxFeFrQ
         4KcXGfCbhp17ei8tq6gMzJWd/VEsjUecOIpBjI5Zvpp2ki5eIJahkeJ52Wtf9idCHF02
         5lUXnF04cS4LyM91v4eqp3PGrCWFpzAPM8fU61Gld9QujO7lfNiC5AaIvAFEgiYCdyaf
         JVREj9963pBnEJrVIQy+Z1Xum0W8MOkHZb+2ozCpEobKhCQDBQ+l4Nz0NdDruiseMsNF
         ragw==
X-Gm-Message-State: AOJu0YwGboVXkv5ZR6W9kfBrOzy0TCMTXtBhZuKRCRBeJInHSWtxRsou
        jJcvOoE3ohqFURKG8DscIFs=
X-Google-Smtp-Source: AGHT+IG4SG7UtNtnsAVP+QwJRQm/GC1qLdmy76z4efwgZoC4am/jhFYqbTF6krX1YXtOoQcvZ6GnUw==
X-Received: by 2002:a05:600c:2249:b0:40c:1ebd:11c4 with SMTP id a9-20020a05600c224900b0040c1ebd11c4mr328867wmm.15.1702072285316;
        Fri, 08 Dec 2023 13:51:25 -0800 (PST)
Received: from nz.home ([2a00:23c8:a613:101:5d8:ec3b:9abe:2b3d])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0040c37c4c229sm1660581wmq.14.2023.12.08.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:51:24 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
        id 1E2A413AA9C8D3; Fri,  8 Dec 2023 21:51:24 +0000 (GMT)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyich@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2] libbpf: add pr_warn() for EINVAL cases in linker_sanity_check_elf
Date:   Fri,  8 Dec 2023 21:51:00 +0000
Message-ID: <20231208215100.435876-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <159e94e7ce82e9432bd2bba0141c8feab0a9a2e6.camel@gmail.com>
References: <159e94e7ce82e9432bd2bba0141c8feab0a9a2e6.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the change on `i686-linux` `systemd` build failed as:

    $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
    Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o': Invalid argument (22)

After the change it fails as:

    $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
    libbpf: ELF section #9 has inconsistent alignment addr=8 != d=4 in src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
    Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o': Invalid argument (22)

Now it's slightly easier to figure out what is wrong with an ELF file.

CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: John Fastabend <john.fastabend@gmail.com>
CC: KP Singh <kpsingh@kernel.org>
CC: Stanislav Fomichev <sdf@google.com>
CC: Hao Luo <haoluo@google.com>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: bpf@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 tools/lib/bpf/linker.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)
Change since v1:
Following Eduard's suggestion added one extra pr_warn() call around
section alignment and added compared values into warning messages.

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 5ced96d99f8c..52a2901e8bd0 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -719,13 +719,25 @@ static int linker_sanity_check_elf(struct src_obj *obj)
 			return -EINVAL;
 		}
 
-		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign))
+		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign)) {
+			pr_warn("ELF section #%zu alignment %llu is non pow-of-2 alignment in %s\n",
+				sec->sec_idx, (long long unsigned)sec->shdr->sh_addralign,
+				obj->filename);
 			return -EINVAL;
-		if (sec->shdr->sh_addralign != sec->data->d_align)
+		}
+		if (sec->shdr->sh_addralign != sec->data->d_align) {
+			pr_warn("ELF section #%zu has inconsistent alignment addr=%llu != d=%llu in %s\n",
+				sec->sec_idx, (long long unsigned)sec->shdr->sh_addralign,
+				(long long unsigned)sec->data->d_align, obj->filename);
 			return -EINVAL;
+		}
 
-		if (sec->shdr->sh_size != sec->data->d_size)
+		if (sec->shdr->sh_size != sec->data->d_size) {
+			pr_warn("ELF section #%zu has inconsistent section size sh=%llu != d=%llu in %s\n",
+				sec->sec_idx, (long long unsigned)sec->shdr->sh_size,
+				(long long unsigned)sec->data->d_size, obj->filename);
 			return -EINVAL;
+		}
 
 		switch (sec->shdr->sh_type) {
 		case SHT_SYMTAB:
@@ -737,8 +749,12 @@ static int linker_sanity_check_elf(struct src_obj *obj)
 			break;
 		case SHT_PROGBITS:
 			if (sec->shdr->sh_flags & SHF_EXECINSTR) {
-				if (sec->shdr->sh_size % sizeof(struct bpf_insn) != 0)
+				if (sec->shdr->sh_size % sizeof(struct bpf_insn) != 0) {
+					pr_warn("ELF section #%zu has unexpected size alignment %llu in %s\n",
+						sec->sec_idx, (long long unsigned)sec->shdr->sh_size,
+						obj->filename);
 					return -EINVAL;
+				}
 			}
 			break;
 		case SHT_NOBITS:
-- 
2.42.0

