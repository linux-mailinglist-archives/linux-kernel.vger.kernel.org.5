Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0E80DAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjLKTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344349AbjLKTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:15:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5684DBD;
        Mon, 11 Dec 2023 11:16:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00c200782dso646912066b.1;
        Mon, 11 Dec 2023 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322161; x=1702926961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahgS9zwVZdE+3LBYLfhZe4mLB78iOJuc5vl8BeZCpa0=;
        b=lzTd1am16z4D0f6wkemiMfbzD1aZeHe6FM51Mb4DqXCAWrWn2ugvc9uFRlLq+wGH7v
         ocgbx8HLbUuyQZ712iFmzAQaGn2ch1Jx3kpUq44N0V5UViWlR3xx3l7ILwStu/c2w3jY
         S4XQDbEzr47aydRUMjg9+uWSg1Y+onoeD9HCEowcKd1Oo9UM1zMmaBlAK9M3Fn3zTOkp
         h25uvdW0WXwCZAsMEwVNKeb8mIH23BY2/uqX94zrexTP0jRw+jZVbH80QuN7UnVIYpmW
         znu5UvsjUfdxweVk6dXHaR3QVIwAEdAFvcWp4Qg4E1rvvD0Xt3j27ITSgjaIYxQi51Bo
         /t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322161; x=1702926961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahgS9zwVZdE+3LBYLfhZe4mLB78iOJuc5vl8BeZCpa0=;
        b=RFWZRyUIA/CzRqHz7xodn/KvuzQcgFUqvyI3yu2l43dpKvScoSbiw+jyPOOwgJd9LD
         XK/Y/61DsLWMkt5U8Pxr+Lgu044+Do/2ki5cy9MbezWHeD31GiYD/jBmv5svDyYGCNVp
         CadL6DZIY0XiGO6ngXY61t8u+MLosESOf3MD+LloLnGwZbBW2PMLshcSZ+WyOuBuo1Ga
         YK0WFluccO8qA6NP+uaizx2lYZLhW8tLuG/kIhWrP7674dr/uKROCFCs1bD5wnNYdRug
         N9rLv6ufOK4LgwQJbsbxe3nYAddD5I/fzvuYAmbawWlh5kn0p6XIxWA+G5I7o1nVAOSA
         6dHA==
X-Gm-Message-State: AOJu0Yy0zBZyueIBho+4MB1X8gDbnw14wl9cgV/6OawWkRhu80Id5Esb
        cRbAqzcUOBERnxKRFodYLd3mhyCsg0kaejoVxmA=
X-Google-Smtp-Source: AGHT+IFu2ekM6ytAI0ppxK14hz1GQ5IYXfxsgQJkKS5CKdxdQcBlI7o623MgI4jCnVrt0JDNf7zwd5faEvRWme1B12o=
X-Received: by 2002:a17:906:21b:b0:a1e:395:da5e with SMTP id
 27-20020a170906021b00b00a1e0395da5emr1134106ejd.273.1702322160506; Mon, 11
 Dec 2023 11:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20231210130001.2050847-1-menglong8.dong@gmail.com>
In-Reply-To: <20231210130001.2050847-1-menglong8.dong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Dec 2023 11:15:48 -0800
Message-ID: <CAEf4BzYUKkpFa5dp4Ye7jzK1RhYtS6Yv55GH18U21Qi6xxQetg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for regs
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 5:00=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
>
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
>
> In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0". I=
n the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>  kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 727a59e4a647..7b074ac93190 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg_s=
tate *reg)
>         reg->type =3D SCALAR_VALUE;
>  }
>
> +#define CHECK_REG_MIN(value)                   \
> +do {                                           \
> +       if ((value) =3D=3D (typeof(value))imm)      \
> +               value++;                        \
> +} while (0)
> +
> +#define CHECK_REG_MAX(value)                   \
> +do {                                           \
> +       if ((value) =3D=3D (typeof(value))imm)      \
> +               value--;                        \
> +} while (0)
> +
> +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
> +{
> +               CHECK_REG_MIN(reg->s32_min_value);
> +               CHECK_REG_MAX(reg->s32_max_value);
> +               CHECK_REG_MIN(reg->u32_min_value);
> +               CHECK_REG_MAX(reg->u32_max_value);
> +}
> +
> +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
> +{
> +               CHECK_REG_MIN(reg->smin_value);
> +               CHECK_REG_MAX(reg->smax_value);
> +
> +               CHECK_REG_MIN(reg->umin_value);
> +               CHECK_REG_MAX(reg->umax_value);
> +
> +               CHECK_REG_MIN(reg->s32_min_value);
> +               CHECK_REG_MAX(reg->s32_max_value);
> +               CHECK_REG_MIN(reg->u32_min_value);
> +               CHECK_REG_MAX(reg->u32_max_value);
> +}

please don't use macros for this, this code is tricky enough without
having to jump around double-checking what exactly macros are doing.
Just code it explicitly.

Also I don't see the need for mark_reg32_not_equal() and
mark_reg_not_equal() helper functions, there is just one place where
this logic is going to be called from, so let's add code right there.

> +
>  static void mark_reg_known_zero(struct bpf_verifier_env *env,
>                                 struct bpf_reg_state *regs, u32 regno)
>  {
> @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state
>                 }
>                 break;
>         case BPF_JNE:
> -               /* we don't derive any new information for inequality yet=
 */
> +               /* try to recompute the bound of reg1 if reg2 is a const =
and
> +                * is exactly the edge of reg1.
> +                */
> +               if (is_reg_const(reg2, is_jmp32)) {
> +                       val =3D reg_const_value(reg2, is_jmp32);
> +                       if (is_jmp32)
> +                               mark_reg32_not_equal(reg1, val);
> +                       else
> +                               mark_reg_not_equal(reg1, val);
> +               }
>                 break;
>         case BPF_JSET:
>                 if (!is_reg_const(reg2, is_jmp32))
> --
> 2.39.2
>
