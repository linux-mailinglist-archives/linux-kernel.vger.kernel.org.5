Return-Path: <linux-kernel+bounces-39346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553E83CF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C2CB25129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7713AA57;
	Thu, 25 Jan 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/LggRvS"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE813AA22
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706220705; cv=none; b=XwngDP8JOFNZUbve5VBCNrwymMcpQ/QnuFZwxDyvTvKh92QxVxTDo9R9Kc8xBOOdVoIkdvGzGfU3BuzJrxmSwgf12rjkkr8T1zV6TEDy9z8o94NMjOqLmH9WRJgPoVbnXh3AY5Bq//EEJl+iBUGVIS7vXqPRwt6lPTW/AqdQ8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706220705; c=relaxed/simple;
	bh=DbrULba5JMpUHoRfF0b2ZW/wUZBr+NdaB81g1Az+ZwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3d4Qp0/pAyVjH2j0XOSrfg/D1LnD0gERJjg5ZfE6nHSSIKk/1xGRE45Ajk+ObCgt8WOkJ9EiaF0NrX1/JnRow79UKzdU1gzG8sB0ek5vGTIV8c2QBWhDj/9HRE5OoSUESC+GrZI8gpMpxPEkjE61t3QsHPCP9uuqZeXUD7ExKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/LggRvS; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc226dca91aso6901728276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706220701; x=1706825501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xLMcToKhdmiwb+Vgm0ASzJXUITbFWiE3/ITy5z4WO+Y=;
        b=W/LggRvSCWuXdK9eWrjp3B7WDHlvdrpo8hU+xMznLtEIyxmcbJ2x5eqB2uyncxAHt5
         kIO+xZfYPWClzevogWGF8FY2OObj9b+T7WOvQdhtSyrSj5BmwvtBTB0U0yDwc7o7488S
         RO9VAHWs9KreOkYP7nnAZSe5ySVe1gValr97KdrUqZF+lXOhcg6hR0J7UD1WV5ovReO7
         xvlsg1oA8kHDSdTZPAhF44qGbpGe7CFQRxxWRfGhlB6zAXzp/XmkH6jkSX4WIl1IAkLm
         2ju2HbMAYK+u7+dr8NfeWXUnv63rUxo6Rq2AW7QeoXSKBLRfVzUJz5cPxgMFvEbRrJNM
         fF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706220701; x=1706825501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLMcToKhdmiwb+Vgm0ASzJXUITbFWiE3/ITy5z4WO+Y=;
        b=VpCEwQeDATUVkDIYvkkEJz/GOgw4t2KUENHq+gPve1J7a2QrxUzmGrkwK13Ezev3vx
         7oB7Nt9296FzwvN//lk5UygYIa2tKiwF4H3Ut6rr9RnM+sv2NIki7c2/fHtwT3B3lCFD
         qY0k1ivAFifp9sBIfQlNwEOQQA1e9wmaMFTGyal7PPO+L5E9KgYVxETrGgiw8Nvel5VC
         OTl3vJ72Ig631U2xfnkFtB2I4AYYLZfCm2lr8MnEVIGe2UweFW0pVZa7qov1G89AsZZM
         FSrsv+Teb9xsOR+SVb1gi9rPYE81v0n/IE+a+hVwpEaUigJnAJocwkPdiR02v17BEoZ2
         jKzw==
X-Gm-Message-State: AOJu0YxTox9rGpNBLhUuSPd8/93xVzGgzrULNg7Y6g1Qx1S5LNV8/Ef3
	11POfqiH3MHkrhnwD/uUY6unItQYbvrslBlncM7puZ3b9zHa0+H2HjakUAc4YMkhXHvj2JfwUex
	7nghaSW3TG1xUAHQiToKDw5ewh5/SGhMdPYOvlg==
X-Google-Smtp-Source: AGHT+IGyhYkUs57iPAfgqwjJQmmq3Qlba1EBKrI7ojK1xvRb2h7JC3m/aWADVmXJGmcqgLz60U06quUiTM0G9gFNWJw=
X-Received: by 2002:a25:2e07:0:b0:dbd:5be1:1768 with SMTP id
 u7-20020a252e07000000b00dbd5be11768mr471772ybu.73.1706220701308; Thu, 25 Jan
 2024 14:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz> <20240125-msm8953-mdss-reset-v2-3-fd7824559426@z3ntu.xyz>
In-Reply-To: <20240125-msm8953-mdss-reset-v2-3-fd7824559426@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Jan 2024 00:11:30 +0200
Message-ID: <CAA8EJpoVxyX-cVggL2RJvM1eG+XzF_kkgAsKdS8ybv7u_MAyXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8953: add reset for display subsystem
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Lypak <vladimir.lypak@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 23:36, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>
> With this reset we can avoid situations like IRQ storms from DSI host
> before it even started probing (because boot-loader left DSI IRQs on).
>
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

