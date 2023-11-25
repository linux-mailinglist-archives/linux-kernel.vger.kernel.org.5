Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D787F8961
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjKYInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjKYInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:43:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F31987
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce656b9780so19348615ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901801; x=1701506601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0MgZk1wjA7oN6wh0F/2QVcx7Di6tJCC9+3i36KMM74=;
        b=gZiEqYa8bHmIGeqQ8gKc1wQ9NjI0djpJqRsXlwIaF3uWwfg2r8MeSqg0OdbPCGO4tf
         pZL8KZoi7rgYvozNxXwCu/jDz6YJDzKFmxBOKjkRKDTpCbp/a2TglEWl5N1ifU7j8ZP+
         vDfTaUBL56IfarFBUrvcieiDKqzyt5nJk7uk47fGthCx3hcTCRHOQOLvs+xAvLly5WUe
         ZBJT0/OhcReVmNR/7/GpFloS8RcI6mKUD+D+QoPbNGFfHKP1QiLe7dFXqNi9uVHJPNcw
         5w+ZrxR1w4px3DUl7jM1dSaCN25q5vonmpEXU9PDXDfFnc4wCMEGZo3OymngIv+R2vgn
         UIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901801; x=1701506601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0MgZk1wjA7oN6wh0F/2QVcx7Di6tJCC9+3i36KMM74=;
        b=bK3T0qX+VYm75OM4498JVhKo45ss/oV0sMMohEcr93gGJ9dLVRRmkke2II6ofPP1O1
         7sRW6zf183WJNHpcfpX/cIWyb5APjy96dMjwDgRhEAfJUqJvEpgz3DF78bY2KqIFiJ5j
         +NrbSdig7g+nDFyavPzg3MUcWKo5X7U7zrD1N1uo6zzdmw9ILSkTcj2JPNLQcngQvnh6
         Rc65WX7eYWQSFV3CYouaO/wNFYpdCDh2SyeuPMUpncoNvTrWCCS5zdg4C06Ak9YJ0qjl
         j2RC/7A300klynPvzlmz16dqFpIBjAVqC31mD4CjQiam01JK0Zl/s1KnLkSe/GF8zN4B
         kdnw==
X-Gm-Message-State: AOJu0YzfC3aUsWF+gY1VS9gmhOdt/aV+1sfHWpJNV/CZ0uzksXeXac1S
        ArcqW7XAfVbkluGV19Au2MrpiA==
X-Google-Smtp-Source: AGHT+IHaALqakfp4Ql5TcXmGo6Ln+y2ernCX4AymHrvtStelwdd1wSXPTd6Nn3zAPPadG0W0MisnBg==
X-Received: by 2002:a17:902:cec3:b0:1cf:7cfc:c3b7 with SMTP id d3-20020a170902cec300b001cf7cfcc3b7mr5703205plg.10.1700901801375;
        Sat, 25 Nov 2023 00:43:21 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id a3-20020a170902ecc300b001cfba46e407sm260609plh.129.2023.11.25.00.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:21 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Use pkg-config for libelf
Date:   Sat, 25 Nov 2023 17:42:52 +0900
Message-ID: <20231125084253.85025-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 94825ef813d5..617ae55c3bb5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -29,13 +29,17 @@ SAN_CFLAGS	?=
 SAN_LDFLAGS	?= $(SAN_CFLAGS)
 RELEASE		?=
 OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
+
+LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
 CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -Wall -Werror 						\
-	  $(GENFLAGS) $(SAN_CFLAGS)					\
+	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.43.0

