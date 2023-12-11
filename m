Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8313380C094
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjLKFJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKFJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:09:38 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59674BB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:09:43 -0800 (PST)
Message-ID: <4457e84f-4417-4a60-a814-9288b0756d91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702271381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHbu0t6RQovwgG4UpuUModKkP5V4juUKznEMDieJw5c=;
        b=RCiat+Uo7cm2znHWbA9yCBo0bvR2PQHKM5fx4OOKc4eXxGrlfD3OgC3R3fod5AWvvSqa63
        HHGJIXbVekzu+sj1SZGpMhwMIGSZ/bH+OgZjd/RTAbQCGONJxtzvaCB0jjFjH7IjIDDxlL
        Tz4ppcnpwzRSqRgYzDVAt9KqpV8Ql1g=
Date:   Sun, 10 Dec 2023 21:09:32 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for
 regs
Content-Language: en-GB
To:     Menglong Dong <menglong8.dong@gmail.com>, andrii@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231210130001.2050847-1-menglong8.dong@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231210130001.2050847-1-menglong8.dong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 5:00 AM, Menglong Dong wrote:
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
>
>    /* The type of "a" is u16 */
>    if (a > 0 && a < 100) {
>      /* the range of the register for a is [0, 99], not [1, 99],
>       * and will cause the following error:
>       *
>       *   invalid zero-sized read
>       *
>       * as a can be 0.
>       */
>      bpf_skb_store_bytes(skb, xx, xx, a, 0);
>    }

Could you have a C test to demonstrate this example?
Also, you should have a set of inline asm code (progs/verifier*.c)
to test various cases as in mark_reg32_not_equal() and
mark_reg_not_equal().

>
> In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>   kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 727a59e4a647..7b074ac93190 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg_state *reg)
>   	reg->type = SCALAR_VALUE;
>   }
>   
> +#define CHECK_REG_MIN(value)			\
> +do {						\
> +	if ((value) == (typeof(value))imm)	\
> +		value++;			\
> +} while (0)
> +
> +#define CHECK_REG_MAX(value)			\
> +do {						\
> +	if ((value) == (typeof(value))imm)	\
> +		value--;			\
> +} while (0)
> +
> +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
> +{

What if reg->s32_min_value == imm and reg->s32_max_value == imm?
Has this been handled in previous verifier logic?

> +		CHECK_REG_MIN(reg->s32_min_value);
> +		CHECK_REG_MAX(reg->s32_max_value);
> +		CHECK_REG_MIN(reg->u32_min_value);
> +		CHECK_REG_MAX(reg->u32_max_value);
> +}
> +
> +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
> +{
> +		CHECK_REG_MIN(reg->smin_value);
> +		CHECK_REG_MAX(reg->smax_value);
> +
> +		CHECK_REG_MIN(reg->umin_value);
> +		CHECK_REG_MAX(reg->umax_value);
> +
> +		CHECK_REG_MIN(reg->s32_min_value);
> +		CHECK_REG_MAX(reg->s32_max_value);
> +		CHECK_REG_MIN(reg->u32_min_value);
> +		CHECK_REG_MAX(reg->u32_max_value);
> +}
> +
>   static void mark_reg_known_zero(struct bpf_verifier_env *env,
>   				struct bpf_reg_state *regs, u32 regno)
>   {
> @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   		}
>   		break;
>   	case BPF_JNE:
> -		/* we don't derive any new information for inequality yet */
> +		/* try to recompute the bound of reg1 if reg2 is a const and
> +		 * is exactly the edge of reg1.
> +		 */
> +		if (is_reg_const(reg2, is_jmp32)) {
> +			val = reg_const_value(reg2, is_jmp32);
> +			if (is_jmp32)
> +				mark_reg32_not_equal(reg1, val);
> +			else
> +				mark_reg_not_equal(reg1, val);
> +		}
>   		break;
>   	case BPF_JSET:
>   		if (!is_reg_const(reg2, is_jmp32))
