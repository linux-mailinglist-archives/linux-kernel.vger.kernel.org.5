Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08805808F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443588AbjLGSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLGSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:09:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB510EF;
        Thu,  7 Dec 2023 10:09:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso3463175e9.0;
        Thu, 07 Dec 2023 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701972571; x=1702577371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5ZRbFTxvl5gVQWRXKJWEF7nKXIu01Clbw3olLA/fCQ=;
        b=RyFdm3yzSsl960UwhIGewoEz9GFnQayU/vHKRTxhQhEKfZfBtACNg6LPPteLmQ6nzG
         zrrA6tIlmET/SGgpdH2mVsIaQ/R70vMN43w8oJKcPZF8iZEX4aoI/WuNbcv6XLuUUYhv
         fYeAA4q4dwfTNbxTd51QX/Bg2mEsm7/E5uyLnQr7nbLoXs7kfEddHRtAjTQygAHIRkP7
         m6MzaZv5VR4fws7C7ERlhnoI+vRFC7svBjXpAUo1PmBtAbzpbKdospha9iAJtbSanqPa
         LtFG7r8xcc4qWDS3PtyeNzqDxLdagqJrkrd2ESAPCG+lh/Fkumx7mrVW3bXMW2Ahr9K1
         LyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972571; x=1702577371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5ZRbFTxvl5gVQWRXKJWEF7nKXIu01Clbw3olLA/fCQ=;
        b=elVx6moT+4seluOtyEw/uk5ar3xo8jgNqNwUTtckhz/toXpczAiafpotG8fY/pjZZS
         H2fBi+XTJutOWoHku/MxfIbF0nRpHEgJPRKAIC0TzrU00f8pyFv5E8ptcB6U/r11GALH
         87pWWfZ+hkkbYzGofZk/XiUqPPHgdczFBj6wLFdjdDvsMUzPMuqeDCH8ool+JjBNv1XA
         pkwHySpxhAPuhseURyppwyaiwLLIw6hfQgK2bY98wyCfIXPexglpfFNYUYUz3HmmZvS/
         PutPQzWwMMAdSDMwizkzUspsk1j5Pl0cvB3njzX7Q5IBMSWuIRdpfZr4R8NwRHN9yuNR
         wzkw==
X-Gm-Message-State: AOJu0YyFyk7GbZENKdUZRdlwxGPG5IAoiE0VMoaRvOakrDbN8CwTVJk8
        SltpnMfUKOAxNo1wX/qra7I=
X-Google-Smtp-Source: AGHT+IHZAXkSmZQqB9z+1AqDiUbZeS4/8xz5Dhc+U7CesSrublwy8/I0tLRPl3cQl5XGwCzyydffiw==
X-Received: by 2002:a7b:c4da:0:b0:40b:5e4a:234d with SMTP id g26-20020a7bc4da000000b0040b5e4a234dmr2876477wmk.79.1701972571228;
        Thu, 07 Dec 2023 10:09:31 -0800 (PST)
Received: from nz.home ([2a00:23c8:a613:101:600:de73:7edb:4f76])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm218359wrb.81.2023.12.07.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:09:30 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
        id 9608F139EC7060; Thu,  7 Dec 2023 18:09:29 +0000 (GMT)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     bpf@vger.kernel.org
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
Subject: [PATCH] tools/lib/bpf: add pr_warn() to more -EINVAL cases
Date:   Thu,  7 Dec 2023 18:09:19 +0000
Message-ID: <20231207180919.2379718-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
    libbpf: ELF section #9 has inconsistent alignment in src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
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
CC: bpf@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 tools/lib/bpf/linker.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 5ced96d99f8c..71bb4916b762 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -719,13 +719,22 @@ static int linker_sanity_check_elf(struct src_obj *obj)
 			return -EINVAL;
 		}
 
-		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign))
+		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign)) {
+			pr_warn("ELF section #%zu alignment is non pow-of-2 alignment in %s\n",
+				sec->sec_idx, obj->filename);
 			return -EINVAL;
-		if (sec->shdr->sh_addralign != sec->data->d_align)
+		}
+		if (sec->shdr->sh_addralign != sec->data->d_align) {
+			pr_warn("ELF section #%zu has inconsistent alignment in %s\n",
+				sec->sec_idx, obj->filename);
 			return -EINVAL;
+		}
 
-		if (sec->shdr->sh_size != sec->data->d_size)
+		if (sec->shdr->sh_size != sec->data->d_size) {
+			pr_warn("ELF section #%zu has inconsistent section size in %s\n",
+				sec->sec_idx, obj->filename);
 			return -EINVAL;
+		}
 
 		switch (sec->shdr->sh_type) {
 		case SHT_SYMTAB:
-- 
2.42.0

