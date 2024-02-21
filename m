Return-Path: <linux-kernel+bounces-75583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57385EB86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BAE2840D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6C128394;
	Wed, 21 Feb 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTeeYe+9"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF105126F3A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552904; cv=none; b=NJkmu9IY4MzWSWge3iFZTApOFO46N4oy2mnxfvvNzZav2md+WzSYZxl9v65OjGlqJzY2MOVBtCSmiPnD4fPjOjUSZPpjuAVbmAjUdaVbtB3b4eKZUKnJZxCDGPrW+n8J55QL+uNNobTWcmkkFJtImQYCEpewXnki5mkbgtlTcpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552904; c=relaxed/simple;
	bh=iNw2KqCWmRNQPgf2kdh7zI9t8Dz1bKx9uiQC7k43/yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRXoYknzMkBBS9CwDRR+kS0XaUy1V+x5OCMWeVh8Rm1c1/umC1FGHXlSQGqmsP2lEuxRVCKrc+u+yyWdahjvD8lQNPK9t/HA49zjx8oS2B3yIqY645Hmg41mOWRgou8A/ZHzIE6rlV4P5iDXxzjQEsxtL+8rP13K36mk5vqbh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTeeYe+9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60879e3e3ccso11872947b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708552901; x=1709157701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNw2KqCWmRNQPgf2kdh7zI9t8Dz1bKx9uiQC7k43/yw=;
        b=kTeeYe+9mzFWcwOls8v28c7uAyZJn+2A/r2fRPTp6DkUweL/tC2O9MF/P0xieaXz6F
         YxwdpnilpfASWSKMzIvfnJePfYkzSkMWQmEFpfE8ftwVWSlnCbrijpjZReIMCU/YYeNB
         EpnTnnax65u8RYJTY2+rMUXTIsopidhF5ArcxFggcwMNToDXmdAEUeJ/p4bDB29dufGr
         qmGPgSim1L1G2wdDZBnP64RBpz4Jy/R+gXq8nSAJTM4J+ZOYKLLk/a3hbYihySkGhOub
         i+p5H9FaYqf7trQRAoQUX90+8J7st/5GSW6qm4Ur03RKNknacDIm6rasgY02JYt9u+xx
         P3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552901; x=1709157701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNw2KqCWmRNQPgf2kdh7zI9t8Dz1bKx9uiQC7k43/yw=;
        b=tM6II0u5eFMaTxCAuyYH+zIP92YXDAhWNcvMZx13oQ+niMCKCmg1MzfCv/urvxtjc5
         B7cZ43IXBVqpoVEp8Cn2GrcITq6skrjEuxOjbzlayHxswnCy+w3sj4Eud8Wa4QP3y2HN
         Va5wYvqCMpz8Vay7jZwgv84YXmvv+KUTTG6zDtyT84HB4q7B7W6+2QZl/u4Wc6WG0NT3
         I59UNb1Ecxg74E0FSnPw4RNWN7cLDj8rt1Y5Bs7Ms3Q4xn4/RRneJ52dIfTT6WlL9C5w
         Sml8hcckUDvPPzWYWFZFFzMN78eIof4vc5p2SjjGSMXZNeCZey45WFKA+BJsAjwaBbeX
         3nPg==
X-Forwarded-Encrypted: i=1; AJvYcCVAaGme1dTzpYMH0MLuhbY1lxdBemkcMD910yM4TUBOG/vmryNdDgtpSJcxR3onMfIIFKZyNc45KVYaC1MOMxBaoOHrl+hjdJq7HAon
X-Gm-Message-State: AOJu0YwlFmofVU/b0LXV0S9+acyQ1iYZ99vEvvp7qWeFVdzK0qYVJdWB
	eAFKDFH5ZwYV73BxtEpcErAYWJGniburSouIG6akb0/ZlhTYQicdmTYQ7kxWeemdpx+GWdouK5W
	Jnh8cGkGcPp7XUtusoN4TwRMivXWDiejzGp9cJw==
X-Google-Smtp-Source: AGHT+IGt7B28bXGqHFPzSlnPE3u5pmDcd649uWARD4nozEqzjnhA0mNDtNnmwavCtFt30Cy0Tp2XEPHZZyHNc1h1yjc=
X-Received: by 2002:a0d:d905:0:b0:5ff:9aa1:8970 with SMTP id
 b5-20020a0dd905000000b005ff9aa18970mr21216281ywe.34.1708552900788; Wed, 21
 Feb 2024 14:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216102435.89867-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240216102435.89867-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 23:01:30 +0100
Message-ID: <CACRpkdbOEir0x7ivXRdMgdi+Sk2e1-m9u2pruh1-RWrkoNd41g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8650-lpass-lpi: correct Kconfig name
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:25=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Use proper model name in SM8650 LPASS pin controller Kconfig entry.
>
> Cc: <stable@vger.kernel.org>
> Fixes: c4e47673853f ("pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied as non-urgent fix.

Yours,
Linus Walleij

