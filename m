Return-Path: <linux-kernel+bounces-137141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5FE89DD76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3C4287679
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2812FF84;
	Tue,  9 Apr 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taWyYBVG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC212D1F9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674816; cv=none; b=eeeQs3YtF01EPtBIv7+RItdO05sC/kmk9xNYsfJuzomYjVPmfvOk7z1yI4NnagoXLmE5JGAwcHh747LB1cShqkheDZve83L0VzcOEHcz6aAldy+6spoNdTG7ZwXgOdMqiATkwVerfgRGE7pJHK28692Ik/wd0eEs5k1a9xXR//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674816; c=relaxed/simple;
	bh=qItj2QD9lAb71zQHuCbigKkildQRgrro60WwdGPxFY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhLXgJOr9wyS9zHPwFQQqSNnvhciD47iHEcNzmHOPJVQ3An9iIgT9dI0rzi8NeesKhunRnznh1Mj6DT8u0HykH39CzhWOZeFgozrG/JUonkNOYWafcQm4I1TKOI8BWbXMxPLrbwPODgIh/DGVgyrzOkh98BLxZvjD6SOTXnSF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=taWyYBVG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so31281731fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712674813; x=1713279613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crTB/gy+FeOZ86NhZBPcpLgT33Zu4oRIi6sok1xfkbU=;
        b=taWyYBVGZWHX+Qw1SGlHtWtMA2Zpk+nAfQTgdZi84bT5zepe37bMSv4RyRiwdpOEok
         271f2DpkfvgtQAbV78AP00lVTrGROxfckznB75nVnJxyCtQa4qGZ4I2VV0xXmHcCO6zr
         gTiYSFFBLNO5wIR5WYv1njwzj7kKkM7087ajCUVGaXSX79tc5umRtApNf9aynFiTFQdv
         0XbXm+4SRKl/mMD0g5HakVd/pz9KpHQ88TnpINN6ZqFphg6Kb99zE8/Ko6PHFX26CtWJ
         LmZKLEsg1pGIy8O7GTe/peOE8teG06EsOZF6UwL4XCeylUEmrqwrfd7VNCqgd46nQc+w
         HX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674813; x=1713279613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crTB/gy+FeOZ86NhZBPcpLgT33Zu4oRIi6sok1xfkbU=;
        b=GzvCVPmDIDZ/gmlEDdx5hWfHUFONN9UjwUcxfkzbNhss71yuVMik/kvzNBgPVYFn/T
         ibm+fwXdIFDFKdGfQL9YgSZWsXLj7yWWEDH7l1U8+s+mYArIGg9r31EasreG420v2Min
         TgJqoU93KEs6C9TqQ3OZsfwVWAv4Pj6D9H8ewtY8r6oiang0Vel9g0OTXcvY4RI/aaZZ
         l/42ORKjMzQ9nSeYM53r161bH/u9OScl6MkVTu7pBGcadBYzfbdm7/V69eI75UlZFhtJ
         PpCGVekcliMRr/swQhag7oZ6znXui6Sxa54+n7xzC4hIiOOApf38/8XhvpvcoHpQ9Tmg
         SnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5v1W7idH80mI9H4CFXp7tQI5e/6dyIDt1qRpL28kvjH3u6n5Y+Hz53/aeM2Vkpz9TH/lLcYb1gTyH8MtsZ5ldsdxvZWewRnyxWY1L
X-Gm-Message-State: AOJu0Yx9Sgx/ItbMxqSkZKW7KMMNEdzgVOqiWHrwDo2BA3QpJ2+ohUSO
	toz6fdFkHOqi6H1x+WNfNVE2gTO/eG33Gpm1WXDc5CZs6Ofu05t1NgxJEOYpH0A=
X-Google-Smtp-Source: AGHT+IG18AzDt8XyooNje4R5lhWjWzghy6yLZKsZ0hE9gJCtN4aCZBqy5lbYEvW6mlqQAurtx+37jQ==
X-Received: by 2002:a2e:a7c2:0:b0:2d8:3cd3:35d with SMTP id x2-20020a2ea7c2000000b002d83cd3035dmr48727ljp.33.1712674812999;
        Tue, 09 Apr 2024 08:00:12 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y32-20020a05651c222000b002d871fe2f41sm1401375ljq.18.2024.04.09.08.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:00:12 -0700 (PDT)
Message-ID: <c7ac10fe-3fef-4f78-b634-e22bb61f9618@linaro.org>
Date: Tue, 9 Apr 2024 17:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: qcom: sm8350-hdk: add USB-C
 orientation GPIO
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
 <20240409-hdk-orientation-gpios-v2-2-658efd993987@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240409-hdk-orientation-gpios-v2-2-658efd993987@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 16:28, Dmitry Baryshkov wrote:
> Define the USB-C orientation GPIO so that the USB-C port orientation is
> known without having to resort to the altmode notifications.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

