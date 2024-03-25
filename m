Return-Path: <linux-kernel+bounces-117451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2461D88B0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A80EC60C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81CB12F38E;
	Mon, 25 Mar 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STs4OBDC"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793D12F38A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383580; cv=none; b=N1O8HWdtdO6sK9YdESIq4opG0dTH3rTgctsY9BpPsa84LjbdPuXHGCW20xprLT9fi2ZZDE85s2YXjyRuntPvLntGbk86L+iS66jR1IYnpq2f0df39HC4wml6LT35hYRpPgFKZ9Dm6TvY1p6iraLKgr7zF5yLfhd/UvBFOt3K5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383580; c=relaxed/simple;
	bh=uh9WFKIeWkaAivfeZSQMhbdOFpPDb/6h8qrwur73QbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxRz99dr7FTyT+wGr0zFhCve6v/Y37S+HfaUJcJLtQrSW+glK6aP/Ul8Pwz2NufP7GztA82kaA8a2FrG5/GYYa8YE6IRinI+8wzW1uf7/g1BJlUQ6cBtYmRKxNi0ezYkFuGMnla0Hi0D0MJBKt78OSFiLbgz81ouyXoVvmyVMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STs4OBDC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430a25ed4e7so30690021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711383577; x=1711988377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipKnULZuL+tAFscQ7D07riaZRlX7/8LgeP9Tufvdjpg=;
        b=STs4OBDCWDClnS/Zqy5enQa3IEG5Ipm/B+t5l4qjnnmnjuSveCkLwkZsjdlsaBtJ//
         b+fdjDrNc2cGlauNRhPSjEM7pGHauKXmieF59d1eAhEXvX9Qw4uQogBg4FQSmbvMw/zF
         dgBlGvGI4vZcvxnzfYYGar4GOcckqxoUOylsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383577; x=1711988377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipKnULZuL+tAFscQ7D07riaZRlX7/8LgeP9Tufvdjpg=;
        b=gh0V+zOuJk8iIURnamxZghM/mIO5qINnT7IiXD+orF0sZ2P0rcrRt4jVFB98BF74hk
         9bLNmyxEdFaTwp8hiyVGrjRynKMYAst95ZhRrEWBwukry0/wzunHj+iUTUV0s+rgmAKE
         wy955IiOIBVPDiDGHg+Elv/d9shWvc+4gQUyj40kBBrqbbYDOc82ugNurV4Bcvdw3TmL
         nbsVZNCDgvOcHrVFoPGwk13uYPHcgl+S8ahBxRlhKPegpqnsckToTU9UsCeMd8aP+cA+
         LUkmyBAlDYmWdhjw5y6GnNuVWGjAC8+iSoqwlE/IkQ7N3sEU6TXNZWfHKP20NoF2S68h
         cjhg==
X-Forwarded-Encrypted: i=1; AJvYcCWva5L9PcnmjHTKFYq5jeXhoUlmW2WEqlEkQ43Q9uu3/RLf84SASZmroI039wcMbLV00PYyXVYDuqrUx5lG84dXvYJmcvzjFjGHZsBL
X-Gm-Message-State: AOJu0YzQMN6fICRjFnC2pUpMoTf6q3YW9pE5rAoojUBOYy9WlWOoGgrR
	oHwRNERsZc+zM3KqKCBRWWxs1zMRhH0aJRfMOdU2WB5PSnh54wokPm8VVfRD1EkA0iYNtjaVhqQ
	=
X-Google-Smtp-Source: AGHT+IFVD365XuFYIF3sL5YfGWDTo0uWWSLjMy/Trrm4bYE5GZG9zdvv02zxFpDmLp6QCcqsuzjcjw==
X-Received: by 2002:a05:6214:2aa5:b0:696:97f4:aee with SMTP id js5-20020a0562142aa500b0069697f40aeemr812302qvb.47.1711383575283;
        Mon, 25 Mar 2024 09:19:35 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id gy6-20020a056214242600b0069046d929a3sm4209555qvb.145.2024.03.25.09.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:19:34 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so535281cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1GpiR72RyUQs7ZiBumstvMmpP27Oi8jiAx6kDNzCQWyjUdOgSXQYI92xK5lZzHps8pi1i5PssXTDOdBq6VG1c49UwHNSHOV5y0hZf
X-Received: by 2002:ac8:5c0f:0:b0:431:1e00:996a with SMTP id
 i15-20020ac85c0f000000b004311e00996amr1088763qti.27.1711383574002; Mon, 25
 Mar 2024 09:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-4-sboyd@kernel.org>
In-Reply-To: <20240325054403.592298-4-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 09:19:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vc-oe=JVJmg4w50VB_-AyxNoWe5KotnXPzrXUfgqhpkQ@mail.gmail.com>
Message-ID: <CAD=FV=Vc-oe=JVJmg4w50VB_-AyxNoWe5KotnXPzrXUfgqhpkQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] clk: Initialize struct clk_core kref earlier
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hik

On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Initialize this kref once we allocate memory for the struct clk_core so
> that we can reuse the release function to free any memory associated
> with the structure. This mostly consolidates code, but also clarifies
> that the kref lifetime exists once the container structure (struct
> clk_core) is allocated instead of leaving it in a half-baked state for
> most of __clk_core_init().
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9fc522c26de8..ee80b21f2824 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3959,8 +3959,6 @@ static int __clk_core_init(struct clk_core *core)
>         }
>
>         clk_core_reparent_orphans_nolock();
> -
> -       kref_init(&core->ref);
>  out:
>         clk_pm_runtime_put(core);
>  unlock:
> @@ -4189,6 +4187,16 @@ static void clk_core_free_parent_map(struct clk_co=
re *core)
>         kfree(core->parents);
>  }
>
> +/* Free memory allocated for a struct clk_core */
> +static void __clk_release(struct kref *ref)
> +{
> +       struct clk_core *core =3D container_of(ref, struct clk_core, ref)=
;
> +
> +       clk_core_free_parent_map(core);
> +       kfree_const(core->name);
> +       kfree(core);
> +}
> +
>  static struct clk *
>  __clk_register(struct device *dev, struct device_node *np, struct clk_hw=
 *hw)
>  {
> @@ -4209,6 +4217,8 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
>                 goto fail_out;
>         }
>
> +       kref_init(&core->ref);
> +
>         core->name =3D kstrdup_const(init->name, GFP_KERNEL);
>         if (!core->name) {
>                 ret =3D -ENOMEM;
> @@ -4263,12 +4273,10 @@ __clk_register(struct device *dev, struct device_=
node *np, struct clk_hw *hw)
>         hw->clk =3D NULL;
>
>  fail_create_clk:
> -       clk_core_free_parent_map(core);
>  fail_parents:
>  fail_ops:
> -       kfree_const(core->name);
>  fail_name:
> -       kfree(core);
> +       kref_put(&core->ref, __clk_release);
>  fail_out:
>         return ERR_PTR(ret);

If it were me, I probably would have:

* Removed "fail_out" and turned the one "goto fail_out" to just return
the error.

* Consolidated the rest of the labels into a single "fail" label.

That's definitely just a style opinion though, and IMO the patch is
fine as-is and overall cleans up the code.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

