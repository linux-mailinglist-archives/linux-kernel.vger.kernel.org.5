Return-Path: <linux-kernel+bounces-59069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC71984F0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D59B2130F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD58657DA;
	Fri,  9 Feb 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYskFGxJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E36657B7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463775; cv=none; b=lBeWC0suW/zSchpDc05dSkLxUumjsfIsMKMnoPmSW+c1neW5P2hOeNROAxmHjJlQa+hTt76UZgHRBTSDqhVYPRtum465K3vCXMMz3ZsaRiCsmZj4ElvGNd1iLlQqDaRosQWigHWAfG0EKK/63GUhWs/5yR6AyJ9JlK31iUgdYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463775; c=relaxed/simple;
	bh=AgbsIvu0jxBk2WSTp2ODk82zoG3G2bVRhIz8ZYaly6s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aPehKi3RNjlG8O7zlfGNNiaDwj9EvFedFn8eZL3e6oGXcvXFFiXIY2szfztItKLbcTePuLa+VuskhbWBMalPcxOKcWzrZqCJBUoml6ml/BnV5IoN+HzTDmz6veru2VJ+kxtG0hjaGZJVNeGWtT9L3fOMqs0wLIeWNSmR2OGEavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYskFGxJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4103be6e938so5649455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707463772; x=1708068572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o+G27tuHSzFtV1VEFRsDJZj27f9BKeouixsOON0/Pw=;
        b=pYskFGxJlu5Q3nsJovmMyZbOraB8ugWibJPCP+YC9F3Z2j0e0EaNau9lAy3XP28czg
         ukt0S46It75D6bJGuz3rJlE2Hql/OoWGAEe4wQq0uRL8LbO50UBxPe1fhBPV9gUH8G3A
         FJHtW11W1lkK4HWMwGG7dybWaz1jG0gR/fgEk6bXgHtCRu6V+OLl9BOhOaL70x79IYFM
         GixjR8t9YGpmjsTD1xchPzp1fqWhWidy2AWBQvBb1O0uDPjDjrZqcv3vTnbmOVG8PS4p
         8JQfPhre2CY7vQtW6YI2xs1YM0SBZ3NEBWn0DfDf6m0DI/X4GZMMtpWSxtmQ8M09Ppe8
         96NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707463772; x=1708068572;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o+G27tuHSzFtV1VEFRsDJZj27f9BKeouixsOON0/Pw=;
        b=HqjtZ0EsP2UXrsJrAm1J+vBESFktHR9dsxM9EYaY25SjgjGxc0IDQuqUlXnse5AN/C
         Czp31C2SDIo9k/Bgatm4InCjgIV4A2U0gJDTPNgF6AbE4Af2mkznwKm2Sh6wU9FTw+qS
         Q4pmw0tXxleCQckv9iyJqxsdRePixD0091mHB0ScILdXb+gUuXsIa06EAt8fom1CANKR
         tlFH2HjBzrSkZsubjf9qK8G+FEDmO97mFwZfs2/xOjFcrz8lPjP1rT3iwuiJU1kQU29w
         bjyqNbJYJJ2eF34CdL8+i9ZczSTmX6VvVV+Rb7j/qS43Vry1TvkOPrKOsBzBzD090XKO
         feyg==
X-Gm-Message-State: AOJu0Yx9ZUyD1XJq9rlxRSrxQCs4weqLNTcPlRbZmS4kUjxoFni3RBec
	fwTP2CHuWsx5sc9j9HeYnm465yHElbBtXqabcDawlLCRRYQajf2LVp2MN14TtGA=
X-Google-Smtp-Source: AGHT+IGiPc5nkM2zPWLY107xKsup1vFnqdp30R3I78ncJp8MnFC+VkECVuUw6DhGBKujEcyWHh8z0w==
X-Received: by 2002:a5d:64cd:0:b0:33b:65f9:20ec with SMTP id f13-20020a5d64cd000000b0033b65f920ecmr465290wri.21.1707463772444;
        Thu, 08 Feb 2024 23:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/4sNXwo6KngFY+PAeu0oNwTHReu0pXi2BI6qhTwQTKj2hhZbDAjijWlYCn399BtQ3uFGZ1DPf8RF/C3YgEhvfAF0Zf8ddyWINZeblrODAiNZqSrqpjXC3yWjyMeLBbNUoouNKiDhIwHXefRiIKjgj4ZWMfDlunmo1CyQn9neFkCMLHrAgIogxKo6fVGkKjXWDYmmJjuMU/SKmo4TaO46p/XhYMtScpOrgIumaty1zqCra8BCZzWVmrGuh+OcNbvZDAH8isVM+oprB0qnLBK7VmJBiA90VcUdzaCTAsJXnUXJaZVCoeHdJzfeb12ujpLxItC8vq8CLrzkIJ7xAypKiyKsAayHxf8tpjLcWvE/e7F1nI2hnAZ0uwJ2fmLIACtrliCIE0vu3wrEqJ5EAu5Eb2qnL
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id c5-20020adfef45000000b0033b4719eb6esm1084936wrp.27.2024.02.08.23.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 23:29:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
References: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: minor whitespace cleanup
Message-Id: <170746377133.4997.4404186295778440756.b4-ty@linaro.org>
Date: Fri, 09 Feb 2024 08:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Thu, 08 Feb 2024 11:52:43 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{' and
> around '=' characters.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: gs101: minor whitespace cleanup
      https://git.kernel.org/krzk/linux/c/28fafd554d233ef2344ee4a8709175b69bc93787

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


