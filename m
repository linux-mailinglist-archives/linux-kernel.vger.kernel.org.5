Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6530785F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjHWSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjHWSOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025DCC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2C162D6C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A293FC433C8;
        Wed, 23 Aug 2023 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692814451;
        bh=6WYbdQvbaUTU7jAYsOoRLczdc6WiEmOJqx1owqQdczY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jnp9OnkqCFGBj/h9OTMFiamfq/+P0dMbhMG2wym3WRwS3We453QbP6a6Naa6WA/55
         d4lxewnPO9sJ/eOFdW8Id7q+oLH+qu5WfYDQfCvEZsEqA4fHS1ZXjl/MCVrHUqcm2V
         rQnTACprz2PN91Wy6YquXbrmyxgR7JTtwCnIMQ5ArUm5o9SmwEW1AslQAiAZraDgQF
         h2tDxxbMKoaqy+zaiPzYbMLAi/oaijp+DPUTHk158fgQD2Ywb/PZFPbzgyDYkg8qH9
         1W3Xw4IOX9qUdj1RLfiTo/cEPzNfdE8Ln2S04DCPkN4s+5vlwAgONpQFbmC2McakrT
         EjkJ7PP63sJqw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 3/7] riscv, bpf: Support sign-extension mov insns
In-Reply-To: <20230823231059.3363698-4-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-4-pulehui@huaweicloud.com>
Date:   Wed, 23 Aug 2023 20:14:07 +0200
Message-ID: <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add support sign-extension mov instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index fd36cb17101a..d1497182cacf 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1047,7 +1047,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  			emit_zext_32(rd, ctx);
>  			break;
>  		}
> -		emit_mv(rd, rs, ctx);
> +		switch (insn->off) {
> +		case 0:
> +			emit_mv(rd, rs, ctx);
> +			break;
> +		case 8:
> +		case 16:
> +			emit_slli(rs, rs, 64 - insn->off, ctx);
> +			emit_srai(rd, rs, 64 - insn->off, ctx);

You're clobbering the source register (rs) here, which is correct.

(Side note: Maybe it's time to add Zbb support to the JIT soon! ;-))


Bj=C3=B6rn
