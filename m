Return-Path: <linux-kernel+bounces-35862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6783978B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090D71C2575C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6181AA8;
	Tue, 23 Jan 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLW1xaQo"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8981AA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034104; cv=none; b=Enb/gz83AxT56zmEJI8wwzJAJTIQuHgncuH+0ApIjssZ783JhZZBe7bAd85v2RosMYi/gkSMW4BNop2qSqWO1z4uhoCg4z5MfHvUqVk4Em93njxjuQ1Y0s2O+kog42y0sMjzdeW07+MPuBTVB14xyQLZSbkUyulQ/K3N+fJuZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034104; c=relaxed/simple;
	bh=+jJX13JiWn0WzFDzsVHtUDjDS9VTJkHARiguvgQ8QDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4GlCezawvrr5CmBFGlIGyfUq70aBLux9adWZJKfFjdkuE9+QHlEqLR6PwE41NbbFB/M+g8X99fjrb1sdkuYyns6226mhy4bdTAiaRswQBWb+udJNxSldFququoGiLC889M6cM3W8jjnDvzRcLzRvS1VY84x4dgPypoAh75E2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLW1xaQo; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2dfbe5363so1757004241.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706034101; x=1706638901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEJHyFuaYKCgsakM/zGUCeuxpM0wfrr43AifuOuveRQ=;
        b=bLW1xaQoVWTub4lXwMi/1iVHHZG6Kp9OUBQHBlfjIYC7CNdx+s96dSLk+KSIPTb9x4
         l9zKLeBd9L5EE7eS5lXf5pj2OXRRecSX3wnCbymt4zAfL58bvIb4FW16AsjMb0xJY8FZ
         /rBGKW4qQZKPm89QzGqFywcglhuV6Hwj9t3lSAvcMRYFw4wmhLvQS0dl8kyAjkgHG/Wm
         /wBxRaPsSJhn3OvAdwD/Owo4jPnxL5RuyBOgZ8f/RsIeH9PSgQmFdoMBHafydiYucBU0
         SSktjzXlIGyp/tg0v0wMhnHcqpNzfb+i4IpYksHZd+Mt62Ber851s0lXex057C5Hpi8l
         cYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034101; x=1706638901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEJHyFuaYKCgsakM/zGUCeuxpM0wfrr43AifuOuveRQ=;
        b=LVXqs4c8tyUxPxFyFsHA1xmy9A2zsj4MPjfFDgjtht9oRG6lpxqKfg6HfVUa8TH5hZ
         sseLhEUECeRg2F3Bm+VjVfyQJbV8nL/ikWfX7zunDbPIIsA1YC/5wLcEfFvC9I1MP4tq
         sO6kBCDlS95NdCOnaBUZlto1mX5jJ4Ux/Wf8D70seOhxfRxFyRmtIqV7RowsN5CUzDld
         s+gaeF4CanX47Je9g+98X9kDFZ9EsAbxry2vZms8c+p7z66evs6BOEqOgeB9FkTMK9y5
         V+HmjotQeGY4LW+PkiIrwWdQYwThtPclBzgm27803YZJrYgJSPghadHNC2ANraA1bLMy
         sKxg==
X-Gm-Message-State: AOJu0Yytj8r07Zc6Rxn0sMM7Gsx/SmKWg5lKnHccFIQxbQ6OTOS0KxD/
	x6IL84XUktD6HnjNb5ujiQszhVod4Ea3MkQUN1z9FPdfxG14jZbWlWjD/BS2K68=
X-Google-Smtp-Source: AGHT+IHgo1cxS5gMB1wzoJDxpaZ8UCxenKbd5dQSnfzyIDTR8Gr5PWMjLlrYVwXnkusIDprEHbbT2Q==
X-Received: by 2002:a67:e953:0:b0:46a:fdd8:2502 with SMTP id p19-20020a67e953000000b0046afdd82502mr625006vso.17.1706034101446;
        Tue, 23 Jan 2024 10:21:41 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 36-20020a9f22a7000000b007ce1febd008sm1658773uan.34.2024.01.23.10.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:21:41 -0800 (PST)
Message-ID: <77da8aef-f480-4b6f-8482-fc5d2a6f2738@linaro.org>
Date: Tue, 23 Jan 2024 19:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] arm64: dts: qcom: x1e80100-qcp: Fix supplies for
 LDOs 3E and 2J
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-11-072dc2f5c153@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-11-072dc2f5c153@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 12:01, Abel Vesa wrote:
> The LDOs 3E and 2J are actually supplied by SMPS 5J. Fix accordingly.
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

