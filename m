Return-Path: <linux-kernel+bounces-52604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A09849A57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0666BB265B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F361CAA0;
	Mon,  5 Feb 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWcAb1um"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6D1CA88
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136331; cv=none; b=J2TrYyHzsD1awyI5b740QZRxlImhqXrk3orwDt5780MeVbqGwsH4p3cDlXObkwKHoVAwWGnkmiF8cm/7bVT41JxeBoPlrI8PzbNEUtS1MwxQmhkWDKyTJgC531ngIxUxbBY9u7CTKU42BaORBvjs6bTlFjTwsSjr83s5cwVOe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136331; c=relaxed/simple;
	bh=F1z41l7Z7e/jSHjrr+FGrKBFyuoXBDs1ejoNPFBfZwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h0sL+1pUhhhP02UODqP8hB4fybm1mZ6VaOX8WYR1vTEvMKmWTOUCZsp77+9Fsd/6pLoH5PHXvq3x2O7IIiEX9omaHIxoAo9IEntKRluOA7kRIrqGlv5kgQDKaYiUGtIyKeN29PaT2BO+w1F7y2JbqGXua+H2yg10DGu4LgfFc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWcAb1um; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51124e08565so6606129e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707136328; x=1707741128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQSlfcZABw5oM4k117qg/VOCg+HuBjTCp9wS3cnGuAo=;
        b=sWcAb1umaH3dQPXU2QSiiHfeuoY2aVHc9vBGCYsQLzZ8VKXzI6i+YzJLKQxfeB1MUz
         otohY8/tm1zi5d1fC/3SVvREcOb73r/ZKrQi7yaFVvuW5Pt7HY7Enz3PWT9ieA8azFdl
         Yycs1d2ClXUSC+YV1ZunyXBrUqupl7OoaND9CvYonSw8NZ1CnSULhU8GkISb7Est94Tm
         y+3Bzsu6SMv37ktHs7oPJ4Z1lB4J9O+y+QA34lpn7ppt8v5KLlgTLNuONaDwFWicAgtX
         S8vP5YARILhQek0hoF4ffdp892M1xojCIb9eLUvj8Cgd2Lvsugj2nQcqpZ9z8x3yJ5dy
         0YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136328; x=1707741128;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQSlfcZABw5oM4k117qg/VOCg+HuBjTCp9wS3cnGuAo=;
        b=fDncadgBNIcdHnXEfrHsTCd1J2PDFuJtcq50GWhkCy4GXCH3wYrT1M7bv9TM4rvlCV
         1LEGhattduNssVgMt7/GirHahQ/j+egzXyqT+FcHsWkUWLuCzYyiDwXNdMBUjd8RWEkM
         GGgBr75k5GO7L6Sd01m83FhTFSiLiq8kYbELKooPm4EsSGa7S0R574r7qXWPBF1Ps8TP
         Z6m5xbQwx5PY1eSIxp58XDX2UiNsN8RE+h/fYE271Gz+JIzUMAMAkqMw2/RjX+t3CHRu
         jlHMxzsQTrfazLYq1f7DuT8J3B4OUt7wXb/9WC/8e63UXisQ2v8D0wD0IBuPkpv19fMd
         8kKg==
X-Gm-Message-State: AOJu0YwbSV8YHD7xFK01/qLGIKe0/Y6f9EPo/bANrxq8Oxq7jaEAbriX
	9bh15Oy80Slolpc+Oa1FjEHlwWyuZC/9/6nuI8sILQt1dl+w1JEAxJtckyRiVPk=
X-Google-Smtp-Source: AGHT+IG/+JCnrxBmmQ8061gKTQNA6x8e9cIaS4nSAzGosJjaQCSUaJmB2tguPKfjQAehoKWfIrgGJw==
X-Received: by 2002:ac2:52b2:0:b0:511:48aa:d621 with SMTP id r18-20020ac252b2000000b0051148aad621mr3504930lfm.66.1707136327768;
        Mon, 05 Feb 2024 04:32:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5/jVhMWAbyCiDwSAFnqAUMJx5v3i95llgo9laFwrB5lTV6L8wHevdjtC4K58jGyE3vBHPB2jtlQsD2Fa0IFZ7QRWEb8M+Cn2tBXeudrCUviCDjd38D8wkoy0368Rs35822YFFlTpKFukpk+DxXYKY69nKJ/LTN3l7cwbR55qNSOP63dEw3HhdW2BV6tSLyyK+Ikg5xpLZhUI8j/LkP5TDbwN+ZwLujP9ST3Fn0RRuGX2aHxIZFMBqUXU=
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0040fdd7cbc8dsm1414453wmo.47.2024.02.05.04.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:32:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Russell King <linux@armlinux.org.uk>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240204-bus_cleanup-arm-v1-1-41d651dd8411@marliere.net>
References: <20240204-bus_cleanup-arm-v1-1-41d651dd8411@marliere.net>
Subject: Re: [PATCH] arm: s3c64xx: make s3c64xx_subsys const
Message-Id: <170713632561.37217.11792751448407951770.b4-ty@linaro.org>
Date: Mon, 05 Feb 2024 13:32:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sun, 04 Feb 2024 11:46:21 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the s3c64xx_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] arm: s3c64xx: make s3c64xx_subsys const
      https://git.kernel.org/krzk/linux/c/db085a6c66337799ad5983c5c6d4b1d8386f4256

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


