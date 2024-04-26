Return-Path: <linux-kernel+bounces-159916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D48B3622
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A851C227B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3E143890;
	Fri, 26 Apr 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6r/LC9f"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3F14430D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129010; cv=none; b=OHU6I2lpMK7sYLm95QrxuJMuBosVEslOd8ZwmPM/Pc6+9n8Dm0mgku1OCLb29fdSBuH5HNbvdt27x90hIbCBU7W12MWMvEyDZYc5SED02Nvl7funNTg1mHjQlsJ+VuWv46JtATZbj15sRHv4WJ9VuM7lU198EWlNLcKHlLP6W0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129010; c=relaxed/simple;
	bh=udxVw+++iagTZz2k70xeWORhBBMM1NSdmmV1VIlzjVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqKDthOQ1NJfvLBxko+JnM/hy6LEUExZ5xj0KkcWDNOncR9h7JxwbZo81spVb4Q2ygr7XCAdYTDb5XKJ4HC/YDBb7gqfr2/oPha/ETRgZV3PpWrEheDyAEfbncH2rzBnxXtw/1tgyrSEkhY9JOg8nkhrU7w/7IKke1A03JyjQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6r/LC9f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b79450f78so5469345e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714129007; x=1714733807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoFcIxQR0t8oCPEZALjo58lCFFW8rW/ix4KBRT7bHB4=;
        b=v6r/LC9fsLJejint+tmI8ixVtC9J04TR25xcGgsSboGkocJh2fvRXvqzWVBr83x/va
         tSmAL+QrEOMOYYAUwzpVPDpgYgnKPDa72yElAlzfpRAHphTySHpuhDErwhrOZ4IvFb6A
         DsQQ9WC+ur1kk9Kx8xoOeIGPjUSzqrB/GjtxgRC+OrtUslX6ak8wHIbCMtpJFIoWrhN+
         oJyYmzyVWafENaLgz3ED56eJTSlWMwa+Ok2yVv9a1qVq5v+gz8R8Mrp6MObi222jLNpx
         tWUPwaZbeZT4xB6vPFuH2RkOuDgSnqampKlnar5FNwz4nTRLHg8YNfK21u5zCQoAWNfT
         F8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714129007; x=1714733807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoFcIxQR0t8oCPEZALjo58lCFFW8rW/ix4KBRT7bHB4=;
        b=AnG9GtjU5XG/LnxQEuS2g26BDmbFP21zxG9dwbDnZ6WM8C/HcHiOAxC5be3C4H35zd
         s+lbUan/qOfVAwbXiBw8q0vB5a/5tRV6ueft3IhMeY5Qd5DIhBTYuk8eu0a946MergXk
         I/cBfP+0oDwJt7bygYpoQDR1/E41YbdHO+7YRwjuE4NjBhRO2nytMiL/sQwkLVyraSL1
         lhsfcFxbZaqFx0Pq6yMRlaAlfaprBILQa6ZVibFqoZUlm8W6fFEpbxwq0rsPwUQ3O1Ia
         LCBg7E++WG1O20+APfoIgfD6XreiOig/1TfgxQReDDHVSlEDY6s/UYvdyovZPJ4BAzop
         LmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHkfJLyMD9CEk6NwdHr2Nw+QhLJZ5dUFu/FFE0wuZ7wBal2rCT+QsLsVO/Dk5NyYIJQ+hewLHaqZEIZbD05Xxz0y2jNL4yWDHFraEB
X-Gm-Message-State: AOJu0Ywsse78mtvR33PJnQGxcfgUWwegb0TztUdN4CZmWaP1tTyfzn04
	HP7DRjNQha4vG6DdAI64riCiZ6rFODeY5xDCfRWdFsx0Vw2XWNJQ2y2x3KMEb/k=
X-Google-Smtp-Source: AGHT+IFH1L79332kHOc1PS5JXFd6A4jTTtznIl2/7hWiWbCz0rliE+qlQeT9xmpERZC+fKb3uldVYw==
X-Received: by 2002:a05:600c:470a:b0:41b:8b3b:7a3e with SMTP id v10-20020a05600c470a00b0041b8b3b7a3emr1669796wmo.22.1714129007204;
        Fri, 26 Apr 2024 03:56:47 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id hg16-20020a05600c539000b0041aa8ad46d6sm13030298wmb.16.2024.04.26.03.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 03:56:46 -0700 (PDT)
Message-ID: <e36591a1-8e6c-4fb1-a2c7-d8b161d5fbe9@linaro.org>
Date: Fri, 26 Apr 2024 11:56:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: exynos: gs101: enable cmu-hsi2 clock
 controller
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
 <20240426-hsi0-gs101-v2-3-2157da8b63e3@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240426-hsi0-gs101-v2-3-2157da8b63e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/26/24 11:03, André Draszik wrote:
> From: Peter Griffin <peter.griffin@linaro.org>
> 
> Enable the cmu_hsi2 clock management unit. It feeds some of
> the high speed interfaces such as PCIe and UFS.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: André Draszik <andre.draszik@linaro.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

handling the patch already implies that you reviewed the patch. I'd drop
your R-b tag, but maybe just a matter of preference.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

