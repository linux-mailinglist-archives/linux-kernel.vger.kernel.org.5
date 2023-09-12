Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2A79DC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjILWrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjILWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:47:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DA10EB;
        Tue, 12 Sep 2023 15:47:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso205520f8f.0;
        Tue, 12 Sep 2023 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558818; x=1695163618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT29HscYryKGVaLS4ITmGogx99J9Puoxilk7JdApwLE=;
        b=bwB5e18CqTc89LsjuJwxjDmt+aK1qXTSzO/IfsJFcHHFm99ufKgkx1qLse08YVt2EM
         +yS2Sdz4oyvxwzEDMeSuU3LKmhEHeVA6qEHfFFMB2dbtSpaGl8/Q8p+n3KEdFhxYB7m1
         gRGLK2zLEM+w0wSl3nOxp2PlgGZmPftv9maovSn1OSflD+9kjp0CtiHgR4QIDq97Z7g9
         B7fuZ3YPZ3rmTUX1B9wshXzI8J3DzHXxNBthDb4B3ncgagEbdYt1VD+zuujIpq0Xhtfe
         DeLrSx5tL5OeEozFNjoZYXteI5bC9Y9nC9ha12WjY91xOIzjXq959vzmVsy8dJ6gMLTC
         M1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558818; x=1695163618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT29HscYryKGVaLS4ITmGogx99J9Puoxilk7JdApwLE=;
        b=tES/UnK7u1pq+cDf2/+eD52aICP352rjjLfkXNOi/vBy2HZ+Bf4WKVVoRUSCx9fZh+
         lNw2/94EvyjX6S03FhydVbSxo+63mYQgQoFehHQ0HyV+UN9iVc81WpQhwVO0AT/H544w
         jf2F8holtlcq0WEClUd7yXymt+MwXWigtA9GWHs3Ti+d1pbfKEJwyXVBvvOQ1SgStAL7
         kbSVdOQHvxJY0mtZFf0sdhMNxOVHobeRb3cLztLs9fSeP01a8m/nLPN+lRqQpcpf+GV5
         3DHwRC3Jb5UqS1OEY9eCiTCQhDfEorb0T8TMCsfRhZJ345TyZtnDh1wgi/GsUy3QmmBR
         hdBg==
X-Gm-Message-State: AOJu0YxcVvOw8fPjBzNvVAg71R7n1aYpDR1B9g2bUdUeVjWeXGNZupdU
        7l396FuaXYQFGSQxwmKdJbU=
X-Google-Smtp-Source: AGHT+IGmXcseiJIR5TJ93E0zDMbc0daNf/KmJUUYoyIE/Gf3HMcwKKCMLML9MVROQedqC+pALyVq0A==
X-Received: by 2002:adf:dc85:0:b0:319:5234:5c92 with SMTP id r5-20020adfdc85000000b0031952345c92mr596882wrj.35.1694558818289;
        Tue, 12 Sep 2023 15:46:58 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:46:58 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Wang YanQing <udknight@gmail.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next 2/6] bpf, x86-32: Always zero extend for LDX with B/W/H
Date:   Tue, 12 Sep 2023 22:46:50 +0000
Message-Id: <20230912224654.6556-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912224654.6556-1-puranjay12@gmail.com>
References: <20230912224654.6556-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JITs should not depend on the verifier for zero extending the upper
32 bits of the destination register when loading a byte, half-word, or
word.

A following patch will make the verifier stop patching zext instructions
after LDX.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..aef9183ff107 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2050,8 +2050,6 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			case BPF_B:
 			case BPF_H:
 			case BPF_W:
-				if (bpf_prog->aux->verifier_zext)
-					break;
 				if (dstk) {
 					EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
 					      STACK_VAR(dst_hi));
-- 
2.39.2

