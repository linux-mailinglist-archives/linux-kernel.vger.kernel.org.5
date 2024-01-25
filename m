Return-Path: <linux-kernel+bounces-38326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716D83BDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA17D1C22933
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2831BF27;
	Thu, 25 Jan 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oS0rLRbC"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC81BDEB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176169; cv=none; b=L8QVNgifx048OHgm/9YU5lAdkVCb+s8QlG2+syfbLmucM210a+hrhLQkRZPBRDxAMNmkm5Fa0kNBIgeWoXacBUP8S1ykapaacgSr4DMUB5xYGzMH1ksej/oFBgBLo0PCvrGGeUffC5Bjb5hMq8jACWTSCKa+rlFoDkZFAscOzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176169; c=relaxed/simple;
	bh=MpsKrdTIjIwvbcRwRfZF01jdybzRyWoMrLmCa/UdKpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udfvmwf17tn+d4oiLFEI078BiyAr5Xqj4ngyiLURlMsb+Rz4JFb4xqSC5at7WEWdUzo6cgBrmHyO2Q9Zztiw4Ge2M3nzDaDx7Cs4CPFtbVua5K45enUar+uKMNjInk8HhNGwLfnzRI8C+B953/skq6MDmp01FcsQlacw27u164Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oS0rLRbC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so70773561fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706176165; x=1706780965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPMySe0yXPWxWL/iJsUJSLzHKiI9qsvkmijA7/w7YXM=;
        b=oS0rLRbCRZNOyocDPkriqf4PgqaLwUWwsVRtwREmrXhsxieqPuSnw2MXFXXQ13Z0p6
         1TZQ9zCcTZbb7J2Ig1VLTzUpxYBdMn+q2bWjJXmDbo1457mOf2B3TRGmuCCiiErHfQ+C
         dQ7hYs7YrPDRKz9h0t0ptE6cIIbW9LusDQ2l5WKc6xmHxACUS77/wdjsCX594Aca9F0A
         xRRIw6+sM5S4QcAtlY29pQj3lKb4NxF6D72NeVFrlPeudQA1V6Oz3gG94REIHh6SC7aq
         8BHGDqJwTHAqUPtuwkAzZR+i0zZodP0QKoaDXXfNzlIKOS3i7lyK4cBkz1hsKe1QC6JW
         ZhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176165; x=1706780965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPMySe0yXPWxWL/iJsUJSLzHKiI9qsvkmijA7/w7YXM=;
        b=mcpqep04DIcsfFgP/r0UkUFUNeBsEvnIuLMd1FQiCgUaE/VNlPFH5E5d+U2h/myiEe
         PLEh0Ny2vxk82/ZtDjfZMRAgGY6/bmVyRaZeZHBTYtj7ANl0ieRIGA+5iusmJ5tzoDXJ
         WBbNOLlnZiT5Nj9MFLeFayR4llYLVHN5Yv/GtxjVMci2KtYHx5kBd1VBqKF7r3HLhYMx
         B4foK6YK+DXYViU544z0YQz9My7SxGbYioMi0tWfubKsBfW9qtKEUzVoM38sgiokBe/U
         B1IsSLGFqrtae1p37tHaXIzueMWPIbcC03SbyL1BGmbfCrmTmNuofA15dl5ey0PxsdQo
         eM8A==
X-Gm-Message-State: AOJu0YzpAi9AMeeyffugN9uLC0dOiHrPGn56SZoXdyfTAlfbCRRpN+GO
	ENVRoNpspzzVwDpR6jTnRwomdrtqQ4eTC1T6qzbVmkGhtv05Wz65DV/OqvWKq5E=
X-Google-Smtp-Source: AGHT+IG+s/733KbkSSZ85ObjfXVAW2/zhE83DZd9BKMuD04ff2X3novkGEI4Owm4MiKjR+acNDE0jg==
X-Received: by 2002:a05:651c:623:b0:2cd:f876:27f with SMTP id k35-20020a05651c062300b002cdf876027fmr198484lje.130.1706176165223;
        Thu, 25 Jan 2024 01:49:25 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x26-20020a05651c105a00b002ccd49fa5a9sm236170ljm.19.2024.01.25.01.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:49:24 -0800 (PST)
Message-ID: <99817149-4a2e-49fc-aedc-fe298964a019@linaro.org>
Date: Thu, 25 Jan 2024 10:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] clk: qcom: sm8[56]50: Drop the Disp AHB clock from
 Display Clock Controller
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-0-0f8d96156156@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240125-dispcc-sm8550-sm8650-drop-disp-ahb-clk-v1-0-0f8d96156156@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/25/24 10:27, Abel Vesa wrote:
> The Disp AHB clock is provided by the GCC but never registered. It is
> instead enabled on probe as it is expected to be always-on. So it should
> be dropped from Disp CC entirely.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Abel, you just raised some concerns over my series doing this and now
you're doing the same, plus breaking backwards compatibility for no
good reason, instead of solving the problem.

The correct solution here is to register the AHB clock with GCC and
pm_clk_add() it from dispcc's .probe (and enable runtime PM on dispcc
if it's already not the case). Then the AHB clock will be gated when
no display hardware (= no dispcc consumer) is in use.

8[56]50 are in a good position for this, as they already have the
required DTS reference. Unfortunately, I still haven't fully dug
into this for platforms without one, but that's on me.

Konrad

