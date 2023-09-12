Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E472779DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjILWrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjILWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:47:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D110EF;
        Tue, 12 Sep 2023 15:47:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso2002075e9.0;
        Tue, 12 Sep 2023 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558819; x=1695163619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oda7cl9iVFTkbJ1PzPqgjhpi/bhkWFnkRBdUJ5tFX88=;
        b=A0LVimUD4sN1eWovAba0UeemlTHr1Tuq8rUcEuOVdN+tR5d+coPDvMOgJuYjAVdAbm
         avOUEh23dyVcHfqdeSBjvJTKhFmZFgiugM9sqBLZBwJG+ZOnfvraKpFL0C3cYjYg2tEL
         qMpZwX3ctidI0VSQqWpvDjgqo0MSpWHPjFEPuodaQM5kMAnGpdgqRPB+ZqmKOia9e0ii
         TXYNMWsfZkJtWi+2CuC04+WV9sSx/S6GayCx5Fv1AN4qqtsTw3PMv5RfBTakinDHFY9n
         hmzLMj9nHVfFzXPSD7ZC0zG15ojRpc08f4YQRTeCbXLT5YNUbU9j7PcKAetzp7L/3Iwd
         O9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558819; x=1695163619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oda7cl9iVFTkbJ1PzPqgjhpi/bhkWFnkRBdUJ5tFX88=;
        b=s0u6rqHSHPpYXWXhIJZmwZRnCB13K7KHk/fbYbwLr0LOt9rtV28XR51h/iVp5d50Vj
         lAsY/LzFHTQnm76WjR0OMOdiGnP9Z9KPz1f+pz2Wc0Cl14n9SdhtnXll/4AQZOjwN2x1
         elauW8Oljcp1tGa1MVVnqCGQ232eHK9EsLcMy8OCYkP+wmCDhvw9aERncTG/mBlTSoOM
         XRz+OXxlB+rbZjR9GAtm2/+tGQDdTR2x3hW6LWimXjax/gckmT9BAfS+nTyw56qt8X9Y
         HENeTx3sUaaxACpmV6BXv3fGqdOO3grdu16cKYKG+9V+X3uShjEJPPSPM46dCbHhKLZy
         8jlA==
X-Gm-Message-State: AOJu0YydvsWexjX2w1nZYxvqVo33RHAu7LG5VB6RM0+ysdh8XhopvPay
        9znvVgCmscqNDk1diXEy6po=
X-Google-Smtp-Source: AGHT+IHcd9xLp1ws84Is5QLcU4SiUEHRnEtZ9HHHFgMinXaJVjwni/sneatzZERdYAHhMylr9POa6g==
X-Received: by 2002:a5d:484a:0:b0:31a:cca0:2f3a with SMTP id n10-20020a5d484a000000b0031acca02f3amr3150339wrs.0.1694558819326;
        Tue, 12 Sep 2023 15:46:59 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:46:59 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/6] bpf, parisc32: Always zero extend for LDX with B/W/H
Date:   Tue, 12 Sep 2023 22:46:51 +0000
Message-Id: <20230912224654.6556-4-puranjay12@gmail.com>
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
 arch/parisc/net/bpf_jit_comp32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/net/bpf_jit_comp32.c b/arch/parisc/net/bpf_jit_comp32.c
index 5ff0cf925fe9..cc3972d6c971 100644
--- a/arch/parisc/net/bpf_jit_comp32.c
+++ b/arch/parisc/net/bpf_jit_comp32.c
@@ -1026,18 +1026,15 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
 	switch (size) {
 	case BPF_B:
 		emit(hppa_ldb(off + 0, srcreg, lo(rd)), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit_hppa_copy(HPPA_REG_ZERO, hi(rd), ctx);
+		emit_hppa_copy(HPPA_REG_ZERO, hi(rd), ctx);
 		break;
 	case BPF_H:
 		emit(hppa_ldh(off + 0, srcreg, lo(rd)), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit_hppa_copy(HPPA_REG_ZERO, hi(rd), ctx);
+		emit_hppa_copy(HPPA_REG_ZERO, hi(rd), ctx);
 		break;
 	case BPF_W:
 		emit(hppa_ldw(off + 0, srcreg, lo(rd)), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit_hppa_copy(HPPA_REG_ZERO, hi(rd), ctx);
+		emit_hppa_copy(HPPA_REG_ZERO, hi(rd), ctx);
 		break;
 	case BPF_DW:
 		emit(hppa_ldw(off + 0, srcreg, hi(rd)), ctx);
-- 
2.39.2

