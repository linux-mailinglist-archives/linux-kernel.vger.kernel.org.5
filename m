Return-Path: <linux-kernel+bounces-94371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D205A873E36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1891C20B67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715114038A;
	Wed,  6 Mar 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdXdAWtb"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6A13B2BC;
	Wed,  6 Mar 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748192; cv=none; b=Ffo9k44LPbNQOjZywzHw/MaIAzAII2TuPVFi2G5TG9osL47HxwfF/sigxgtYiaOKtgBoksHwMjJLTKQt3Jy1Uzt110TpmEO8JcLpacMc7cCoIVOVSI3GUSSengYR4SOcmF54k8JAG1eJb6HalKxRaEje0/4yn62mDsAhCoHV+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748192; c=relaxed/simple;
	bh=MslP/GgC8iwDTAnt8RyubtvFyZFUlfOY+NPdmCr9Me4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fIG3Iho6RfwybOCpc/fOY5K8PDfS0tkAY7ffkVhOtEfmx0QJiKaRUprAfqJZ4SsWFfrZLbKU6KtD1UxXGmKkQo3iR/ECnhkVMj2LhZZqdAnN9xJsNEPygBJSM0XkV2KEPFt5lln0C+8wdKG5F60dvJBHp5KZknES6Nm4X+NVOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdXdAWtb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so9605a12.0;
        Wed, 06 Mar 2024 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709748189; x=1710352989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2npUY4eeDDvoekzBCU0xKhb2LdvwtEzu1Ljw3wVUCC0=;
        b=gdXdAWtbc5e9Sn1uLVGZpus0TSEJYItJ2kmTOsI0rErIzBkOcO716tXZZpjOZz0hLN
         Fl6omOBjRTkKoH+U73TK+DVHYurnZT1YQMjjPAhjHq4d6vjiRLNJQxCpG0YTEXb57UMy
         HggAL5ggBrIfHcuceec8mskhLlsVD02KHhV4ED1g4ySzl94/KriFU8XYYR4zpjuZttHa
         TJ44n//klsCOHntxuvYvszRWuv2Wo8N+i9YY0OctjsLGiXPMBaaurlR8W26IMkjgXpNF
         u9/redG0OkaaHZEwSIS3Qewimxea8pFOETTpfp3balOTaeJMY0onA4iJg1io2PLFvMGr
         bnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709748189; x=1710352989;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2npUY4eeDDvoekzBCU0xKhb2LdvwtEzu1Ljw3wVUCC0=;
        b=oBSUXeajZKvsWAnOilMjkFguXkf6BAhTWz4EYeWQXH1N4e6Hwia0OqncrdUd5V3VVI
         g4u0TctVPItDiihsHSYXJ8//quAXSutBr3cqsa2oLTFWJx0yf7F1lKK5SURKUdzi3WZ4
         3KAis7utNEB1YtDdnIiF9CLPESzSEd2uBLZSZXeQg7h7Nd0rfFI8+4SH6+2ARcmEG8Kk
         t5rwj+imYCQQHXMSIAXhdpOFwcQ8bUa33u+zhE3GVJojaOFJlqGozDGVsaOVpavu1p0l
         spran/eJdMWFHzd6j4TNW+ZNRv59cvZPss+0D1n6LtilAzKAU8Q7OQ7EW3vdR4vt7ABF
         +5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUl8rG/eyBM4YkCefRVsYEct0HIX3qHAOSuOikMTPTau5l4zgFPea7MXTXbQVPS/EkOZlo8///Jj51atJd46tm9bE1GXOcSLB2Wy4YpzbG/B6rQaBia5Zy6ypknf521/3RNpL3qoqFaSvyeAZDhK7YqX7V/au21EqyooAA/j1G24pFS6Q==
X-Gm-Message-State: AOJu0YyjxStFCM0lHyGIDq9RZIr6r5SZGYoG5QDZfuBJNIKLYB2O9JPp
	I19Jr2foeGhF2rUkTe9MyeIqfPZPARNUCHVwm1BBbV/jYEsnooOw
X-Google-Smtp-Source: AGHT+IFM/XXRTaSemXFiIcyA3yuOycYUFJwAQNMOBZTb3n2Xc4QR6NRDStodxTdg9XOV6FjMxBsf8A==
X-Received: by 2002:a17:906:f898:b0:a44:17da:424 with SMTP id lg24-20020a170906f89800b00a4417da0424mr10646147ejb.56.1709748188522;
        Wed, 06 Mar 2024 10:03:08 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170906adca00b00a45380dfd09sm3898898ejb.105.2024.03.06.10.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 10:03:08 -0800 (PST)
Message-ID: <f28633b9-cad8-4e1f-807c-830ba9368eb5@gmail.com>
Date: Wed, 6 Mar 2024 19:03:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
 <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
 <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
 <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 06. 17:02 keltezéssel, Konrad Dybcio írta:
> 
> 
> On 3/6/24 05:10, Elliot Berman wrote:
>> On Tue, Mar 05, 2024 at 10:15:19PM +0100, Konrad Dybcio wrote:
>>>
>>>
>>> On 3/4/24 14:14, Gabor Juhos wrote:
>>>> There are several functions which are calling qcom_scm_bw_enable()
>>>> then returns immediately if the call fails and leaves the clocks
>>>> enabled.
>>>>
>>>> Change the code of these functions to disable clocks when the
>>>> qcom_scm_bw_enable() call fails. This also fixes a possible dma
>>>> buffer leak in the qcom_scm_pas_init_image() function.
>>>>
>>>> Compile tested only due to lack of hardware with interconnect
>>>> support.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM
>>>> interface")
>>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>>> ---
>>>
>>> Taking a closer look, is there any argument against simply
>>> putting the clk/bw en/dis calls in qcom_scm_call()?
>>
>> We shouldn't do this because the clk/bw en/dis calls are only needed in
>> few SCM calls.
> 
> Then the argument list could be expanded with `bool require_resources`,
> or so still saving us a lot of boilerplate

That would mean that we have to modify each callers of qcom_scm_call() to pass a
new parameter. Additionally, there are cases, when the bw enable part is not
needed so we should add separate parameters, one for clk and one for bw or we
should use a bitmask.

Would not it be simpler to use a helper function like the following instead?

static int qcom_scm_call_clk_bw(struct device *dev,
				const struct qcom_scm_desc *desc,
				struct qcom_scm_res *res)
{
	int ret;

	ret = qcom_scm_clk_enable();
	if (ret)
		return ret;

	ret = qcom_scm_bw_enable();
	if (ret)
		goto disable_clk;

	ret = qcom_scm_call(dev, desc, res);
	qcom_scm_bw_disable();

disable_clk:
	qcom_scm_clk_disable();

	return ret;
}


