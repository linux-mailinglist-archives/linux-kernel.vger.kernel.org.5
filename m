Return-Path: <linux-kernel+bounces-70601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC38599B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AFEB20CE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54030745C8;
	Sun, 18 Feb 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArnORYKH"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818974297
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294266; cv=none; b=UTmtTvQukl5ciO8vK0xxEuPE6RVHs/oKJu9XH/TYQmJjaoS/z7ke98lL8FIqYnbM9xhJx0z6P3Cv1lEN2usvjPh0EnNW2joBymjAfj4SfC+TeT8/QQRuurX7spzG5fat1UIpYUZn0YNF6c7z40klAFTjrQ+uoL1vVP11dDMoK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294266; c=relaxed/simple;
	bh=tvvDncg1WI0//tRyUMP3lqwcPgPfZh9W8WMZ0iFU1aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0EzpHksGwZThUu0ZNuBOmbzB4tNlBw76kCKh+oH4PqsgWUYn/lIIP2i6iCtD5rE14VTIIXSmL2zxTHIQLPuNGn7OycaijMmAUa+oEf6GHz3KkSQrdWyjHAHja7gpZSb3+D86u1NrSld+q3eLDsKHyMdBEaVDHRCZPf0zP5UYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArnORYKH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607c5679842so36927807b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708294264; x=1708899064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+AD8w89s+gvj0mKYSTbVikH3rVbe83iTAnvtx9TnsS0=;
        b=ArnORYKHXrzaDsxMqqx5jIlOb8lvmgFQ8BKGJdwK30BLj/bJ+ic3X7Lf5mj7SjN2oa
         bAr8nRDPLTdCCL/GJLHMLSZ0XbYm57Tl8hzGkrXmlJjLWdy1uTpQ97DQ5kzVLBDu4K4Y
         /coNYyFv2/d4cRtP4XtcCOSOsNY5HIbzsnGcnlnV/hSnw2YEMKTyV7AjyeLi0zr7WApa
         EwYd8jbAT9pdP8/axTwlJJu/c2oD5ePgG62AmELCmsVsF0ZaltSfDltXbhQS2bqqyqa6
         TLqrrvsHoDAadG7Bsopw245mOtQ4tuDEoYPDIggAscpRNjZVgHI4SIqj0u2qncC9lFdX
         gtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708294264; x=1708899064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AD8w89s+gvj0mKYSTbVikH3rVbe83iTAnvtx9TnsS0=;
        b=e3zuqQyY1qz9gBxUbI9tYLHkdiWueUgWqKXOeaW4oVZYf6khnIbqKe44MMEY866aFe
         /lrHSogJiwmjKJhUcqGLGrD9FppYh1iCGpB4dHB1KFuTJvvxQMGOBWH0dTtnVjuP5+LV
         45aUaRIl0WQ2ih0BS0l+lbV+YsaQbeJ2eDG6JR7uE++447cDql+gpmAHx2sWUI48Bg51
         mo0MCvqlVd8ebsEKMdxiZPCK4yZbUyJAZ+V2sfMtpOsyRXtN/XxqY0jvcF21AgDLmwBi
         MX+QSemH27OaALJRmnzcTe0GF7enXswNFjslKn9VDbT6ZCQPhZ9LJclpQZuJutgxdtHo
         zb6g==
X-Forwarded-Encrypted: i=1; AJvYcCWL/Q0n/6GFV+pma++/P1WjG8W6B0R8dVn3E53zfmRnK8vc2PzKpoGAsOKlJ0YrqHrDK5FrCBmEXQdpewOUfcRIDzbsHbhcBJ9kz9iQ
X-Gm-Message-State: AOJu0YyG03/ciJFDWX1Rlxl9mfw+IoPeZoQWlz9raExZYss6V7/qy4BU
	+7cWaBsdQKZWAvsG+sUHjoPsoC096lW3o/MGHNyrv489uYH0qZlt+29F6iPYKNYJIuVFrlJf9f4
	Z4nZDJGYw0iNfaeucOVCHufj5c6ghzJ3hcHp7BA==
X-Google-Smtp-Source: AGHT+IEgg0E5u1X5ebuYXnJ++SELErkiGN+TuPyNky9IKq31ECZO7bB1+ZtCKqmUvcixZwfyK121qgFIcMfvjQlbF9Y=
X-Received: by 2002:a05:690c:fd0:b0:608:d1d:d8ce with SMTP id
 dg16-20020a05690c0fd000b006080d1dd8cemr4935951ywb.12.1708294264190; Sun, 18
 Feb 2024 14:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz> <20240218-hfpll-yaml-v2-3-31543e0d6261@z3ntu.xyz>
In-Reply-To: <20240218-hfpll-yaml-v2-3-31543e0d6261@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 00:10:53 +0200
Message-ID: <CAA8EJppEyibLz3z4UQbTdR08332w0OoegbOWTz0QnD9rcRb2DA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs404: Use qcs404-hfpll
 compatible for hfpll
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Feb 2024 at 22:58, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Follow the updated bindings and use a QCS404-specific compatible for the
> HFPLL on this SoC.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Please note that this patch should only land after the patch for the
> clock driver.
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

