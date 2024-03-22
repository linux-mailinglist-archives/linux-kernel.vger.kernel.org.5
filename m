Return-Path: <linux-kernel+bounces-112025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52CF88744E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE5A282AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0767FBB4;
	Fri, 22 Mar 2024 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWP1T4ld"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A31E53A;
	Fri, 22 Mar 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141182; cv=none; b=ZxQj6OalhtGjKm+ouGeRPzXLdpgFtlSogsxSo4r4ehaC6eOtoc00O6vD1fu5Wyf5nEcQRGk26uTeOXTHcFbHoPsK6fEqIfQrVqbnCyjKVdjvZAs6TXVRHDFSHF5bWOQByZIXpn3/HvrYjfgnwgRQHF8egroRNugOGjXhpc68Cm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141182; c=relaxed/simple;
	bh=dcPqVPVlekj/1D0yZKd0ytj+AvHgkBPi76h7Ig9Sgo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7l1+msUNGZPtMS3nEVUvVGcJfSP6uLFOgLIBpr1x929ht5zohefSL19gtbkvUCeiMIT4Qy88EKe6GDJVQ5nzcI3Clkg7XHD/dkZ6s6cxKZ3Xwipmgx3lP0/KRFs6ApOZbkf4TwdCr2E0pmO0lQjvPmF93nByJOKzjw7mkXppfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWP1T4ld; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33edbc5932bso1437699f8f.3;
        Fri, 22 Mar 2024 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711141179; x=1711745979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mx5abWniPmMEHe5nRvt33pyFnIPxwPNkAz4naD0v62I=;
        b=hWP1T4ldWGB581fqpNr6fWby4wiR7rM02iCYgyG1cAft7iGlcUBvUoyhTUkowDSLfy
         LNAiOD6pk3hDoY+l/2oG6DH4zPG37huDjsAOzHzHMyhbNV2p6jg1vPvYpHfLYcRBmhAg
         VYjz0QBokVGST1WYtRf+vJpMXXWGBwV06StQ3R0AG3LqrPfXHX9uOlch844kkriITNr7
         YCtryzZyJam4Din1O1gs7Sqjg53h6YUkgUZjZKu4l46cz1rq+xryvcsLcJBsu5E4bUuR
         TftYjOCP967jvsXWYdCox/NLSlgNFpdqJXQGWkHza45qszqPXtwMILot+TmVIonTmqCq
         D5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711141179; x=1711745979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx5abWniPmMEHe5nRvt33pyFnIPxwPNkAz4naD0v62I=;
        b=paXAb0Dx1pf7/vn/8MfnC5SjJakxHPzfEtS+FY0RW5ArgVtg4jhepV8mzHyeK7PWYC
         PWxspHu5nr4u2mv/lzXp9u7npYmVMEmSk9keextEJ/OLWN2k1WORFS+PmUYAvhRsSS/9
         +KXYhumSrNkr9Csid6ueFgTubiWPvFcQRD5EYKz7st+eDyZcoQ4F9fDe4OGWJzaPEzEB
         8Zw/uJuFOgonrj7m7SX0Vz/M+YhurUu/meQ9n4V1On/G+m06CkAVzwtImPCraPoCUdCP
         U4wfsXqv5UPaI5qY8Z2Wg4tYJ9CwOn/Bz8XeIcJQPoBUA4brXuCKUn8hyMm6r+RiU+cm
         pmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkHfmwqyzw5IXfGS6YFCebXujLMhF1KkNkdP5vLWCSrx1nSZOHkya1kyt5zLh8S0Y22XI60Mocs07vAGK7ElYz7CDTQ/9XjNw31/7PF/SbuwhQXKSK4KYi7nmgAOZMTW7jCn/AXlSeg1IteXrySfCjKAszR0jjuKfaa5zMlkwSGdbEppry9Q==
X-Gm-Message-State: AOJu0YwAovMPBQvJJ2Keo96XKWJLddmem+BdoJvDPYQk/Yuw8kUi9mIv
	F+VNQi1q6M170YhxACUUHxPZ4Fdyfp82UIoxAMFRxVsU0IeVti/g+ttoqvf+
X-Google-Smtp-Source: AGHT+IH8qwLFqVcj6lce2Vc30GmobK5Gewe79ELjMRvL+fjE2owhWRpmg0NacD/D8F61nJ0TBHFPhA==
X-Received: by 2002:adf:c004:0:b0:33e:867:b288 with SMTP id z4-20020adfc004000000b0033e0867b288mr281077wre.63.1711141178677;
        Fri, 22 Mar 2024 13:59:38 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d4a09000000b00341bdecdae3sm658086wrq.117.2024.03.22.13.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 13:59:38 -0700 (PDT)
Message-ID: <ca4d85f1-397e-4c43-8548-436b9238e85e@gmail.com>
Date: Fri, 22 Mar 2024 21:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] clk: qcom: apss-ipq-pll: remove 'pll_type' field
 from struct 'apss_pll_data'
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
 <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
 <CAA8EJprr4E1CM4f+eBzdRN41nm33xY-hRPQDn3peR94vLyJsYQ@mail.gmail.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <CAA8EJprr4E1CM4f+eBzdRN41nm33xY-hRPQDn3peR94vLyJsYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 21. 11:37 keltezéssel, Dmitry Baryshkov írta:
> On Thu, 21 Mar 2024 at 09:50, Gabor Juhos <j4g8y7@gmail.com> wrote:
>>
>> The value of the 'pll_type' field of 'struct apps_pll_data'
>> is used only by the probe function to decide which config
>> function should be called for the actual PLL. However this
>> can be derived also from the 'pll' field  which makes the
>> 'pll_type' field redundant.
>>
>> Additionally, the CLK_ALPHA_PLL_TYPE_* enumeration values
>> are meant to be used as indices to the 'clk_alpha_pll_regs'
>> array so using those to define the pll type in this driver
>> is misleading anyway.
>>
>> Change the probe function to use the 'pll' field to determine
>> the configuration function to be used, and remove the
>> 'pll_type' field to simplify the code.
> 
> I can't fully appreciate this idea. There can be cases when different
> PLL types share the set of ops. I think having a type is more
> versatile and makes the code more obvious.

I understand your concerns, but let me explain the reasons about why I have
choosed this implementation in more detail.

The driver declares three distinct clocks for the three different PLL types it
supports. Each one of these clocks are using different register maps and clock
operations which in a whole uniquely identifies the type of the PLL. In contrary
to this, the CLK_ALPHA_PLL_TYPE_* values assigned to 'pll_type' are only
indicating that which register map should be used for the given PLL. However
this is also specified indirectly through the 'regs' member of the clocks so
this is a redundant information.

Additionally, using the CLK_ALPHA_PLL_TYPE_*  for anything other than for
specifying the register map is misleading.  For example, here are some snippets
from the driver before the patch:

static struct clk_alpha_pll ipq_pll_stromer_plus = {
	...
	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
	...

static struct apss_pll_data ipq5332_pll_data = {
	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
	.pll = &ipq_pll_stromer_plus,
	...

Since it is not obvious at a first glance, one could ask that why the two
CLK_ALPHA_PLL_TYPE_* values are different?

Although my opinion that it is redundant still stand, but I'm not against
keeping the pll_type. However if we keep that, then at least we should use
private enums (IPQ_APSS_PLL_TYPE_* or similar) for that in order to make it more
obvious that it means a different thing than the CLK_ALPHA_PLL_TYPE_* values.

This solution would be more acceptable?

Regards,
Gabor


