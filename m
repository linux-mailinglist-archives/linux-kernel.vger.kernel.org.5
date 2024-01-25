Return-Path: <linux-kernel+bounces-38464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88F83C0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6389B35735
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D136B10;
	Thu, 25 Jan 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0MHBwtd"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924F3309C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180209; cv=none; b=abJ5BwgbrTOWAn/WuVaZFUGtxHREXkvw6kmSpV5yMygvanHte0hwMvKBwrX1UUoSMYDGCJ0Rhz6L2NKj9WijSIg6yfMwISWjLlMD/dCvOF/F1Wf+4qnsCScnndS7YOHnhXo1mTudUfImPbgO2cXW9jgA2qVoGbjZ4Nt4trxP8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180209; c=relaxed/simple;
	bh=9qY2haHLwCCpegYVyW5Gz9pPYqp5yfhyAdGIM8sSa0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prgcciXE4cemX9ExvmPWShueXHIhiz3Al37WbKpVGMOGDwD17TXrAfYATQf32OME529SSOjOlsYqbllDAA0tK39bFkONHlXJdd7uUn3HSjku3qazIGbIoq3iHF+gH3t3KhsxsFigvg5kwf6riUOYJv1h0/PCohFT6aKBqII7x9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0MHBwtd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cddb2c2b54so66716891fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706180205; x=1706785005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCfQ4dB5qtEMvlBkDX6rwlE0l9miPxpcPJ/nwYxSowU=;
        b=S0MHBwtdrk6e5b+WIRtkLHyqTz9OQ8lTbTnpYU+Z+Q789sgGELgmcdd2UgjYuLclQX
         bd712yyF7NMHEf9M5DA/xCGloH+UcYUq9N6KPtrj6VjCSGDv6fBcI8gXVjTKzBxt70QS
         B3/HOntD1SFZ+cyoxOXdZnWKXm6osIVTt7/x2NcCEC+GxJSzdh3HPbNfgh22gytz4RCV
         0YdE/altzt2lhj1qDb6A5Q7NcCKLt11Sq509gybAG8a8vMp5KJFVurR2hu3InVuZzKn/
         EU9OrXA4m7ScWSBxen9aqUijwZ8iwR7IPbyqoJKUw6iIyLma0fJsTC3F4k9qHyMkEIMk
         6GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180205; x=1706785005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCfQ4dB5qtEMvlBkDX6rwlE0l9miPxpcPJ/nwYxSowU=;
        b=hYGtmnBqOrAy0p4CHES5HK4SELqzqIo221A0dgGYg8nIwRCE3bDhUFWd6pqYAU80BC
         sXMHQXm4ezqg2B9Cy8wAJyX9BF6lYzW38Pts2QQI2WzHgYeAfi8eTejSt/Q/A6FTqiGt
         jMPoUWPtDh2ngt9hxZsxS314mnU+eytOJo4r6+u4JE6Y2qpUfNMTwc57+2A2CbrJBBAx
         xcy8GvWs0iAi5wOrcAMjH/OSxQRyIp6lOku2i+4FxQhDfzmYQGz/4Fk1Qrd19tZEY5Rh
         3m6xHeLSdYPpHasykPqgKdBA9UIgvOc1khc8infNn3SWlQvVKJ+y3KU7fxOnVzZPnveX
         QVZw==
X-Gm-Message-State: AOJu0YzxFCYnhA3Q5YlJGRo66v0bvakrv1BS7VP7HEnWZYJIXGbW2sSS
	L/PvpfSnnppdQVjp4MNOtnlGpQy6wgkFjNy7WJWCFu/U5TnS0h9oqasFUQK4COM=
X-Google-Smtp-Source: AGHT+IHRtAZxhGIF/Y+ITlHpQgzW+VI9oR1q2AdFBH42WjiA/tqDSCXgRSch7fRF3PNSewVYjvX/Fg==
X-Received: by 2002:a2e:a786:0:b0:2cf:26d5:1813 with SMTP id c6-20020a2ea786000000b002cf26d51813mr919939ljf.13.1706180205552;
        Thu, 25 Jan 2024 02:56:45 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z18-20020a2e3512000000b002cd5b233861sm234062ljz.60.2024.01.25.02.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:56:45 -0800 (PST)
Message-ID: <49a98836-b4a1-4654-8b39-7cf095a17d1b@linaro.org>
Date: Thu, 25 Jan 2024 11:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] Unregister critical branch clocks + some RPM
Content-Language: en-US
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
 <d4a14fb9-849c-4236-9ec1-538f2944fb02@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d4a14fb9-849c-4236-9ec1-538f2944fb02@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/25/24 11:16, Taniya Das wrote:
> Hi Konrad,
> 
> Thanks for your patch.
> 
> On 1/13/2024 8:20 PM, Konrad Dybcio wrote:
>> On Qualcomm SoCs, certain branch clocks either need to be always-on, or
>> should be if you're interested in touching some part of the hardware.
>>
>> Using CLK_IS_CRITICAL for this purpose sounds like a genius idea,
>> however that messes with the runtime pm handling - if a clock is
>> marked as such, the clock controller device will never enter the
>> "suspended" state, leaving the associated resources online, which in
>> turn breaks SoC-wide suspend.
> 
> I am really curious to know a little more about the SoC-Wide Suspend not happening on these targets. Could you add more details here ?
> 
> The Resource Power Manager (RPM) is the main aggregator on these targets where the active & sleep votes on XO, shared rails (CX/MX) decide the SoC wide suspend. The High Level OS on our internal platforms never had any suspend issues due to clocks(GCC/GPUCC) or shared rails being kept enabled from the consumers.

With the common clock framework, CLK_IS_CRITICAL blocks pm operations, as
clk_disable fails at some point. Since RPM(h)PDs are modeled as pmdomains,
this in turn results in them never getting disabled, leading to outstanding
votes. Then, RPM(h) sees these votes and (among other things which are not
properly described on most SoCs leading to dangling votes) decides that
CXPD/XOSD/AOSD can't be entered because there's a request on a resource.

> 
>>
>> This series aims to solve that on a couple SoCs that I could test the
>> changes on and it sprinkles some runtime pm enablement atop these drivers.
>>
> 
> As CX is a shared resource/rail on these specific targets we definitely do not achieve any power saving with the runtime pm attached to these clock controllers, but I see a little more SW overhead. Though you could please add your observations/comments.

Hm, simply adding a power-domains entry to denote the required
performance state values when voting for downstream GDSCs would
be enough and runtime PM only makes sense if there's an additional
rail, say MMCX or GFX. But see the comment below.

> 
> Removing the CLK_IS_CRITICAL is a good cleanup and moving them to probe is a good way to handle the always-on clocks.

Unless it turns out to be really messy with keeping backwards DTS
compatibilty, the goal is to use the pm_clk APIs to only keep the
interface/xo/sleep clocks for subsystems active when that subsystem
is active (i.e. when SUBSYS_CC is *runtime-active*).

This will result in a treewide patchset.

Konrad

