Return-Path: <linux-kernel+bounces-100094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9381B8791B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB0D281C79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561AD78667;
	Tue, 12 Mar 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmhqjXA/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9478299
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238178; cv=none; b=utPKrj8CtDjuYBTH6TkYcPnEF4l40rxCVKZJfUxEyq5d7GQwIY4FnLlPxrdJOAG4zpf2QWgLik8orqiNsef3q8mYMDy2ej50CTmppOoROpu0IVYnq9TtgGUzMlq6oIS5X782yKlRonZhHAGW+w2dx3+s23/WLvzEX3R1nuZ14iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238178; c=relaxed/simple;
	bh=UsYofHyo4ltDXBqykR0WqBX41CM4bURUmCq1AXyvn7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOBNga3NAjLWMVmjkCWGGwuB17Z6ZLXxUFRiGgLXvdC1okS7g6xizLXBW3B3Tn4tOk9hxgy0d/K/36R4ks9fzREO9xzNNmEwc9oUSxTcxVFZx1dKIpw0GFWqC6aFMWLX6MXgXjI0bJANA7XLcj+CgUJPx5gc+W8jF7VshHiFEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmhqjXA/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51321e71673so5906856e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710238175; x=1710842975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5KrrCc46zY3EaqIGg4J3SGWx16jAIeBYBlePvonNCY=;
        b=HmhqjXA/RVCUGjVZganzZhYcONy6NeI7o+nTk5+cTVNCgU86gUlMd15tH+FM41O/1D
         TdfF1eC9An0MRFgcW2SSsOj51nn0Mj34OSboy9f08LfhQzWlphe6aqAwzI4EnTGt3FpN
         bUg3Jkl3ZIbHdnGa9NrCr4nxcWpm6L4c333JqYziR46u/f4Py0tfzgaXx/bN8qGXoIbS
         9IBNpygI95Bcvh+tfTdbaGQWQnshlRqzs2hm3kYr4KmAihX2Rj5/z6yCwpqjvklWsJIP
         rAfJ5KjQzTR89juKxM29IPc3GSWIYAO8LV866abSwkNOZHMdvKtlUXXHpytY3w7Fi5U/
         Hsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710238175; x=1710842975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5KrrCc46zY3EaqIGg4J3SGWx16jAIeBYBlePvonNCY=;
        b=mmuJ365BnZqm8vuxYD9oHIFKyZjjNGeiMC/38p4qHCWhdSegw+QniIcRq65b5er1yM
         uEelUmHZyMGWSy0CGkRgcPgb/aPe3LXGSg5h1XorKzYOWUyF+oUHjpUt+jAdF6S2+5a2
         cVYuLXCTJ45bjPZVq1nMNGLCX4R0lonv+eTQPbdsESnAVV2JWZB33zhvdQyXPOeXhv6A
         zs9t2xHlJZoLlWCcN/iOfLmgbhobU4T27Yd3uY2giM+8KycKzKJmiVfXNPOnabNtBCt3
         ooVGNoDywvSJQxRiKGxp9V6CLlYwd1L3xTJm22c/wrUqnSkf5+VR1gAMv1J22r8Xti2r
         lbqA==
X-Forwarded-Encrypted: i=1; AJvYcCV0rYeGIpKlkju6/O8Pl5/6Eb6mscUXt3uoruBSHUjapzpQRUoKPP1qiQDG9Ou+RpipGmfkEMg3csCghQBi2PovZcq76mYaul8boTN+
X-Gm-Message-State: AOJu0YwzKggDs0TQayi4Wx+ck4Ol8TRWQfPURve2CMJVafzvQETth9JU
	urb11kZ65NIBPUE486g23XJwpnAp1B3TBMUA8BHJk3r/UXYAOPqWWb9wmX9RX5s=
X-Google-Smtp-Source: AGHT+IEkXdl2lHpg/byD8Mwn15KSShXIciPqlDeiel+w9pEtBrJuFdZHUd3+FxLp1yhPfQh1t2aUog==
X-Received: by 2002:a19:3847:0:b0:513:7:fc3c with SMTP id d7-20020a193847000000b005130007fc3cmr5174830lfj.55.1710238175047;
        Tue, 12 Mar 2024 03:09:35 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r15-20020ac25f8f000000b005134c52debbsm1507310lfe.162.2024.03.12.03.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 03:09:34 -0700 (PDT)
Message-ID: <f3644045-6061-4281-8fbf-25054798bc45@linaro.org>
Date: Tue, 12 Mar 2024 11:09:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 touchscreen
To: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Joe Mason <buddyjojo06@outlook.com>
References: <20240312074536.62964-1-raymondhackley@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240312074536.62964-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/12/24 08:45, Raymond Hackley wrote:
> From: Joe Mason <buddyjojo06@outlook.com>
> 
> Like msm8916-samsung-a3u-eur, the Grand Prime uses a Zinitix BT541
> touchscreen. Add it together with the necessary fixed-regulator to the
> device tree.
> 
> Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
> [Raymond: Move to fortuna-common. Use interrupts-extended]
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

