Return-Path: <linux-kernel+bounces-35306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1B838F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5690D1C2735E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F15F542;
	Tue, 23 Jan 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9wfgzI6"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1365EE87
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014866; cv=none; b=nv05dqF0sqoDR2ji3iXtu8uw8n2B+3goelgf3tUJ/SRQ5JEo/T55W1aXvsaEwmCeGSxQxocr9/bvGXg9x6ITwnas080H3F1/9/bzaItKVZrI2Yb91AWeLLde2rbWjec/s4IpYsZt2s1Bjb3CaXUjfROo6BEH2J3l74OmjkYQz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014866; c=relaxed/simple;
	bh=Rhu11kHNwAkr6YhiKhtbh07fNK4FgW0qEO9f97hhyI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVc+S5CoU80Q7iyZxx2JEYJtQZElM0GaP0kxYBDcoPuQeexLV5vIEfJUXO0o8yqMQwS9qEtznOe6EudvvuI4WihawUHAaObfEz1Jv9c/ZmC7kL9ustTDfLF+F8jpgjlxyWHVzTj+HAoMLRP5qsTqMEMFvYsUp6XBjkbmFNhjsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9wfgzI6; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff84214fc7so40300797b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706014864; x=1706619664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3nn+YYpd5382zai0iv6hd4Aw6J6UtUSEjEEQnVFo5no=;
        b=I9wfgzI6RteeWG1uauP3YOui1uTmV6L6MSgtpnlxpfaDBAP2QnFBqznn72Eo+yVLaw
         pIIC9TNCz86Gt5KAB1zfMJPV7y+Jlk1c716sywU/ReVSNFeS+NS9l6lRSAdpBfL2vYFI
         d3ODVcH8eFq31y6GnOUEd+Fd2S/Yx3UJmxAGbjghCrzsGS89jS4Wjfc6GVVE7gN9zg5i
         hyq1w6lUjh4AfRv1oXv1wCQKHwKRAiV3CvJKNS2dbvPpp0brHUBwx5nVxmOaRM0j3mR5
         uf9urjHMPC/lGqq0E9rtKEhSw3opM8+WEBrwPBDzQS+WheRWlzpT9PwJ8bzYKUiHpT3h
         NV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014864; x=1706619664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nn+YYpd5382zai0iv6hd4Aw6J6UtUSEjEEQnVFo5no=;
        b=FNTqLkr9boFmn097cJc8zh9S43QA/Qig2xso4z5wkhfxXEywoZQbFgTtXDPU0pSB86
         jgse4n4ELSbT6GMGMZfMMyjGMA7NAu5FwU5nmFDoaQx6Uq9RWG1+931nvAlBjx5nN7DO
         8ggyPrpoVnIyXy/KUXTwFUft1CqhV+dnptPy/a+ugnG9uCkBrBHWXT0yiey+z6pEh7L2
         mNAoBKNRZC1QLq5wHMdgxLPOy236WQyQl9SMMjrO4TIL2IH0rcHsxHjPROGi+utCybuG
         DgArbQoGWMZ9+rSZ4wVFVQzAjn/jhN7Et7KsMiAMiV0xf/uaGfYi4sAIORdyMGMrl0JQ
         Cp7A==
X-Gm-Message-State: AOJu0Yx3ieAlljY55AyYFpvFeASBt1Fr7eG1CEndxWVjyPaaxGZO99kA
	17hUsQpu0GEF9S7rzGcP0JqRvOnMSmVIoSY18yefa0YZyPSg74kpnn5q18HZvNYcW13O7aBNbPe
	tmPv9AD6gK5WIJJ6f6/zPMI2dRERUy/K1rLmlJw==
X-Google-Smtp-Source: AGHT+IGjEf+QjHzCIZuEvzPO4c751eB6RGzISMIAvrjoFnsPa6N8IGO0Gksu7V5PY9K+8g3LsFuqwdUTtXYbGpYeIk0=
X-Received: by 2002:a81:48cd:0:b0:5ff:7cca:a434 with SMTP id
 v196-20020a8148cd000000b005ff7ccaa434mr4298126ywa.51.1706014864029; Tue, 23
 Jan 2024 05:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
In-Reply-To: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 14:00:28 +0100
Message-ID: <CAPDyKFqVGJ3DUfPaifvqhyTBMH1bM30AExr3M2apZMx00vv9Jw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] PM: domains: Add control for switching back and
 forth to HW control
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 09:47, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v4:
> - Re-worded 1st patch commit message, as per Bjorn's suggestion, and added
>   Dmitry's R-b tag
> - Added Bjorn's and Dmitry's R-b tags to the 2nd patch
> - Re-worded 3rd patch commit message, to better explain the HW_CTRL_TRIGGER flag.
> - Added mode transition delay when setting mode for GDSC
> - Added status polling if GDSSC is enabled when transitioning from HW to SW
> - Re-worded 4th patch commit message to better explain why the
>   HW_CTRL_TRIGGER needs to be used instead
> - Drop changes to SC7180, SDM845 and SM8550 video CC drivers, as only
>   SC7280 and SM8250 have been tested so far. More platforms (with v6 venus)
>   will be added eventually.
> - Call genpd set_hwmode API only for v6 and dropped the vcodec_pmdomains_hwctrl.
> - Re-worded 5th patch commit message accordingly.
> - Link to v3:
>   https://lore.kernel.org/r/20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org/
>
> ---
> Abel Vesa (1):
>       PM: domains: Add the domain HW-managed mode to the summary
>
> Jagadeesh Kona (3):
>       clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>       clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>       venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
>
> Ulf Hansson (1):
>       PM: domains: Allow devices attached to genpd to be managed by HW
>
>  drivers/clk/qcom/gdsc.c                        | 54 +++++++++++++++++
>  drivers/clk/qcom/gdsc.h                        |  1 +
>  drivers/clk/qcom/videocc-sc7280.c              |  2 +-
>  drivers/clk/qcom/videocc-sm8250.c              |  4 +-
>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++----
>  drivers/pmdomain/core.c                        | 83 +++++++++++++++++++++++++-
>  include/linux/pm_domain.h                      | 17 ++++++
>  7 files changed, 169 insertions(+), 15 deletions(-)
> ---

Bjorn, if it helps, I can funnel this complete series via my pmdomain tree?

Another option is that I host an immutable branch with patch1 and
patch2 for you to pull in? Just let me know what you prefer.

Kind regards
Uffe

