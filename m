Return-Path: <linux-kernel+bounces-157672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE4D8B1453
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0AF1F2738B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726B1442F3;
	Wed, 24 Apr 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kssF1u+2"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FC13DB88
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989686; cv=none; b=mhhAIPM6wjSI4IzURo0bo/ljHjzW2wfu3d7lt1PImngYPZPNO2aHhBWG/Cv2zRWUb+Yi9y1Ez5GWbPTGWMsFJekV0asSIEo3x96oB/7EbPBaImpw62u9TanH41hj0/a8ruatSFubk3UxAG91S13pnhoc7XV+h1gBZdNZ631ewV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989686; c=relaxed/simple;
	bh=5juKDdGEYxNl2ENPjsF/4a/Y2iZb9ON1oaGj0sw8O/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSRWoghMr5oYvtpkNTrzMyAkuY72JHr8uPK1JJHi2s+md+bsc2oq0UeJbT02NrUVkpBZDXAhymXawFpyktKc+W9zLzL843zb3t46QK1KnmXz8dpPDPtTTdkmh2TYY2mg54m/xMVe5apj91a9NLF03OP5QJuPUrfSl8dYN2RZIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kssF1u+2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d872102372so10546071fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713989683; x=1714594483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcWOpWv1JwDPxWKBqvGmsKPJY5XCaFq86YjpwkCYxAM=;
        b=kssF1u+2ueTxkV7YbInRzGjki5stAj8wmtxHqAiCG9YpVuKukEl02cjJp3Zs87r/92
         k95bQlhf9OjGvOloeorkLFi1ncIHw+MuzURhFILZ/UZK3m4/UaiYNsq99TjjGl+myvQh
         RJyr51AJjEhvXIWq36n12VxViLhi/+8xGqSCFmkPC2xVJ1FJ56LJ1wSz48vASnqQaAEp
         QroSl4+vKtt4nuKn76G1HGSvxNoNUP4h6DoDC67+TkA/xd/HTWpapwaviLhSN/wA2OmM
         jwGodqGsaJvqJa0hpwfuzA1dgmdJr3OgQ9Z6S5dbD5ZQhggcD9/Xr03jBUR6m+jhFuws
         VGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989683; x=1714594483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcWOpWv1JwDPxWKBqvGmsKPJY5XCaFq86YjpwkCYxAM=;
        b=qtuWm0gW5Eht+kIYtjqT5xI6RN2MrIKpkQzD5U4W6kKheOSJKUI8ILOeZlV0uJ8qr0
         05+nWa/ChTAKOU6kI0RsfsV2QLPUywN2tcRIkQwB4ahpRryn6510Vm9wc0V7mkyOkjg6
         qumIfn/eCDIAew2aQNtpZ8aALVuTi5ZlPnKly9xs4qip47gsMbsnT331+NF4FrEdYSBq
         UJzWDOSURifiL0v+PXoJblWXnYMzc2jgczZaBOc8pb/I+11X06Lxc2SYm0dbiHJMdoWF
         TYbf3yf/GK2WCQznLW3rXUZJAwuL991cQVlvtWoB+FOHKTN7cYydCCeMxuEjTOOeEe3H
         q5RA==
X-Forwarded-Encrypted: i=1; AJvYcCU2cufkKmV5GI3FLS+Vqc7P0UX8jCZ+OCDKu7U/CJIhYHG5B3mjdH1eGSQPoT31aiPYGWhVgUJ+/3EIntf74KfaWRhT4wFJWv/Sd0jU
X-Gm-Message-State: AOJu0YwFzdWtebmXndOLjSUaxwqGzBkzfwYsY9kjYOZbG71LFemL8NZe
	3p2gaH/X/QsKwhiAe/8NP1x1Bi3kw8sQ1GXK9HhjDPwzJqV6Ahdw/tc9U8e4X8Q=
X-Google-Smtp-Source: AGHT+IH9wlcx4Zg+9QomKNqCiiTVcanWix96jlPdIDd7H3SL1paT78g+EIL8htxmS7imEX6O6XqwzA==
X-Received: by 2002:a19:914a:0:b0:513:d71e:eebd with SMTP id y10-20020a19914a000000b00513d71eeebdmr190966lfj.32.1713989683584;
        Wed, 24 Apr 2024 13:14:43 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n1-20020ac242c1000000b00515b5cd2361sm2485942lfl.164.2024.04.24.13.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:14:43 -0700 (PDT)
Message-ID: <439e44a6-8026-4283-a2b9-6a2d655f28fb@linaro.org>
Date: Wed, 24 Apr 2024 22:14:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: msm8953: Use mboxes properties for
 APCS
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
 <20240424-apcs-mboxes-v1-5-6556c47cb501@z3ntu.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424-apcs-mboxes-v1-5-6556c47cb501@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 18:23, Luca Weiss wrote:
> Instead of passing the syscon to the various nodes, use the mbox
> interface using the mboxes property.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

