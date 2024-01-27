Return-Path: <linux-kernel+bounces-41028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D762B83EA5A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C131C2254F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C691170E;
	Sat, 27 Jan 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJJbB3+a"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0CD2F7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706324452; cv=none; b=KG2995o5WuKFmz3G62bHGjwdA6Xg4WkoaQqvaxrvrHXcDZNG4BGpsmnxFew+nf0I1Dgz4ZTrr0zP32yDC+6KLFrmDGQcl+dpWikifzH+k7+gFQkIXGhkLXGUakjaYwo/9F6wEAHYG99rZTM0m9LDcxg/zsuUkdfzdNW5Ye9FpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706324452; c=relaxed/simple;
	bh=fxwpBrHCLri+RTMQY3fnJBWxKg4yfgWiUQsmPCA6BtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSuaB4ylOh/8QuMMOzz2jz0HtNhrus34MOjw7LLSxbBzAjAsi7Hlr7Mq/xCujThyik+ZjoEIGtrC497i7Xnra5tU8WHraAfsJ+LHjZfS4Ihn5v+yfTLZPgY/B6fLupSaIPykuUJOSD5fWWBnFxbo3SQ6h9lD+cZBZGNuwJNAWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJJbB3+a; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de0ba30994so430023b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706324450; x=1706929250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASDG88tlfgeDd63yyN+gHQWIWk9UcNiibycB8tKyrCc=;
        b=xJJbB3+aKwMwfx40biFHCwOpz3DyAzMG1Lu30ODtINVPXjesbQ5CW7DIhoG7jZs5Cq
         3lTXkpoEziwWHTJ1ov5N67+3/8ArKXyjxFgTny7778HTZSpHz72980FOFK2qg6AdWswf
         BO3sj34wqJ7N7w1MddqD4QknJTbgrX0xoPqQXBkaE9sriQCTd9vTFT92mvtrEE3b1iZH
         BCgfTnkLZDoWGL4Pk40wy+ZIrcBwvd4/W2Hn9mev3YGFjbYayCYbffMzx5vMRDGEefYM
         DkWiImBiEIQlNC/Zowh1nEvGj9cAFAfYtj0aB0kexLWAevz1Q7/C4x2ZoeqIPeIMFUog
         x2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706324450; x=1706929250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASDG88tlfgeDd63yyN+gHQWIWk9UcNiibycB8tKyrCc=;
        b=p9fUwTEQElbmQUJq6bUSuvF6tCZ0OQirAFL0ebPsM6lcWT7Nsikm9eLAtoZIOLsjDa
         qFrHhpji6H7yNGm8GQ5D00GK/0T0mBlWW+y3SWgwaEf5YhfrayeKW6LQXAAAoWWvDqwN
         6Kb6RGQhz1n1nEDquNJE27SmmogGIejlUtuWey+Kfl16zLSl9lS5uzdyLiQlom8927j3
         torN99OH8VXPDErDIPfp67gpO7j9KGHDlUOdmkkJHfz1RI7mLNZv7dylyOERRFwI1Vir
         z5bgMhGORkXO3jxbvCyFRJ+O4ksN4msOK9Lz7EP013YE2fX7K0JZVkIJjT2IBevn0jGQ
         iTow==
X-Gm-Message-State: AOJu0YyKwCjwwz6ooX65qczZx2UuN1sSqV4pZRkFEepXt2U/w17C3XkL
	puHJAyVi6qozQeQca6EM86angHSoFRp7U6qqPw30EYp+k90B+NHtVVbw//Rf2+313Gp78/1OHW4
	NO5QadvqeJ0SlkNZoVWFfx5yIP39SMUK52YcUzg==
X-Google-Smtp-Source: AGHT+IE+psUVgcfAuXyIVOj/UqBIia79JK47rQ97ywiZ75GGXOq3fH/c5XwGx6ioOdP0IGFyFC5jE2/nGGJ+PSlIuNc=
X-Received: by 2002:a05:6a00:22d4:b0:6db:ad3c:693f with SMTP id
 f20-20020a056a0022d400b006dbad3c693fmr2599088pfj.11.1706324450425; Fri, 26
 Jan 2024 19:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-9-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-9-andre.draszik@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 21:00:39 -0600
Message-ID: <CAPLW+4=PWCegZi8Wd=rhSUUiXNn_J46VGZoxDcRA89MX-2Y9tg@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: exynos: gs101: sysreg_peric1 needs a clock
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, alim.akhtar@samsung.com, 
	s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Without the clock running, we can not access its registers, and now
> that we have it, we should add it here so that it gets enabled as
> and when needed.
>

That sounds like this patch deserves "Fixes:" tag :) Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Update the DTSI accordingly.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index d66590fa922f..ac9cb46d8bc9 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -442,6 +442,7 @@ cmu_peric1: clock-controller@10c00000 {
>                 sysreg_peric1: syscon@10c20000 {
>                         compatible =3D "google,gs101-peric1-sysreg", "sys=
con";
>                         reg =3D <0x10c20000 0x10000>;
> +                       clocks =3D <&cmu_peric1 CLK_GOUT_PERIC1_SYSREG_PE=
RIC1_PCLK>;
>                 };
>
>                 pinctrl_peric1: pinctrl@10c40000 {
> --
> 2.43.0.429.g432eaa2c6b-goog
>

