Return-Path: <linux-kernel+bounces-65155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC78548AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F45E1C22833
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982F1AAD7;
	Wed, 14 Feb 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jz85hSk8"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449018EB0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911167; cv=none; b=X/F/GFR+1epxW3u0tNm4N1InOgiBq1man/s060flcu/XxCub5t9iek4XDjMDuxcIbw+G6u+dX+hTWnOONPcs1vZDTMcSH/4ygYbwdqMW3FCRc7+Hg6FBwhYw3tTm5sm/uGGxj6FvLyl+bjMZqD2XuQo8nCZlicaPfFX4VGBitPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911167; c=relaxed/simple;
	bh=5cBCTJmIkuZecSiGwWsCCZ+RQXy4vsGvUq70KIHkdRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI4i83mhSXgJ/Ns1YR7panUKeeurXOMYMQY6hN0VNrqbMNHCz0QL8KCGab0Npiz0gva7bWPYuxA3ZjKGgyS5nTkKzPjKbASOatarnlA5feheOV8qn8SyfVGwDBW2at1T7Mw22g0n6Wep/tKeZTdcIbkmqHEDFX9amN/9nbvlIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jz85hSk8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc745927098so4524874276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707911165; x=1708515965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMm6H1+3sxiadbeuUfjignaOEewFpqqASgu/afNzhas=;
        b=Jz85hSk8sJ3tV1YSHJgKQYN3avRkFwAkYHyFkfdkR5bGnkuHFUIL3Yxipq8W7CqHN+
         hF4lv1jpqa8Z7Rr6zUFjf+/JtdP93kROVM6KhxO5LhR0KWU4ryCRA1FErAHk8OECtgNh
         /5px+6vagjYxMf4+bfnGA3/1dP8fA3+6AG/l5IazpqEu7C7jYIL3VDzdIvE2SczX2NEJ
         WbJsK7X+MIDtrFU/9ZBLJBbUEJ7aNb90nExFsjedrQk4+CDo8k8UgS9r2fDK790FeZej
         u+ZL6TvA/ogi/AkX3MMnmCqsfA6PdVSz7ZqJGHJlQXPpXeAcIWAr7YdmVBa4fss4yMmC
         kaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911165; x=1708515965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMm6H1+3sxiadbeuUfjignaOEewFpqqASgu/afNzhas=;
        b=ppp4eQS6yoZVsVSopVSilVaNr/Dd5cuT7SrcIdPuou6dxQrIRMo143NDPnZQ6i5pxJ
         whbGP8xPoQ+9WsVYI03pa0p2QmlOXgBx2PZN+gbRZBLuI0vtGUyDpJ8PvhywVglKuUsq
         aGyimh2uI9EN7+nugyzj5pwsOOYIJoI18uZ6tCJPjvmI/QKBcbted7Bc0YgjpK0ga1Xl
         Rbpnn3P3/xa2yeZ33k04aOx3K24pasyyMLyPXMgfGsj22tgdSiK13Adjqi724fYHBTM2
         79svWGNArjOv4yYssOP+mgE02r1u6dgwPoGLGlPBI0AeVVXNS8PY9DwEsTanZbRpgQLP
         9Weg==
X-Forwarded-Encrypted: i=1; AJvYcCVIjaXwUrustkE4Mc0qF8S/6bdvkkX8GWGgKWQDpgYGma5XDGt3xroKein+2qZoZPIvDiyXHNkj+D+kkzeB7xzd+sTLWlYjzPoki8aV
X-Gm-Message-State: AOJu0YwVbGMvnkj6lvx/KEllv+nx6Vs7wdXUd8y9pbxUlpFUjB3XyeEt
	kO1nocOR21PY1xUs7oxQ23v8tDULdM62TwkfeJg+KIEcYs2Mkg0wzD6EyGrs6bUJ9JZYQ3m1KQ5
	39rJiBCj6la1/O3+4Qi3/xW3CYCp3NpCaaqK1tA==
X-Google-Smtp-Source: AGHT+IFTWaiUO0/FDR6+92ostMkJC/ZQk2A+9uMYuYsQostIt3tNe1w41GyxBHI4EGWLZGEFOqxCNQkKG0weW2iyQng=
X-Received: by 2002:a25:854d:0:b0:dcd:5e0f:19c7 with SMTP id
 f13-20020a25854d000000b00dcd5e0f19c7mr1595156ybn.54.1707911164746; Wed, 14
 Feb 2024 03:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com> <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
In-Reply-To: <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 14 Feb 2024 13:45:53 +0200
Message-ID: <CAA8EJpqO3j-BEQ9tcbH5HpskpbC7bJpEEpc5Y5ySb2B5c+WC3g@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 11:20, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 1/26/2024 1:35 AM, Andrew Lunn wrote:
> > On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
> >> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> >> enabled by default and it's RCG is properly configured by bootloader.
> >
> > Which bootloader? Mainline barebox?
>
>
> Thanks for taking time to review the patches. I couldn't get time to
> respond back, sorry for the delay.
>
> I was referring to the U-boot which is delivered as part of the QSDK. I
> will call it out explicitly in the next patch.
>
> >
> >> Some of the NSS clocks needs these clocks to be enabled. To avoid
> >> these clocks being disabled by clock framework, drop these entries
> >> from the clock table and enable it in the driver probe itself.
> >
> > If they are critical clocks, i would expect a device to reference
> > them. The CCF only disabled unused clocks in late_initcall_sync(),
> > which means all drivers should of probed and taken a reference on any
> > clocks they require.
>
>
> Some of the NSSCC clocks are enabled by bootloaders and CCF disables the
> same (because currently there are no consumers for these clocks
> available in the tree. These clocks are consumed by the Networking
> drivers which are being upstreamed). To access the NSSCC clocks,
> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk clocks
> needs to be enabled, else system is going to reboot. To prevent this, I
> enabled it in probe.
>
> However looking back, gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
> gcc_nssnoc_nsscc_clk are consumed by the networking drivers only. So is
> it okay to drop these clocks from the GCC driver and add it back once
> the actual consumer needs it? So that we don't have to enable it in probe.
>
> Please let me know your thoughts.

If there are no in-kernel consumers, there is no need to worry about
them at all, nobody is going to access corresponding hardware. If you
have out-of-tree modules, you also probably have your out-of-tree
overlays. So you can make use of these clocks in your overlay. I don't
see a point in dropping the clock if it is going to be readded later.

-- 
With best wishes
Dmitry

