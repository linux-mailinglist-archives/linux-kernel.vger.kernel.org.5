Return-Path: <linux-kernel+bounces-100771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ABF879D09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869051C21915
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BF143727;
	Tue, 12 Mar 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHeFOoCj"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754051428E4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275964; cv=none; b=Mdbjl5uFTQTnAsMcwEPwAPnPaTMHP6QbdSJcFKCAZ9RKTrfztP5PQCz4seFvRNUF0r1vlW1A1C9f7VypkyNtSw5c06xpDnk3DJjrNRxEYnANHnydqgtPpXIIahjdKs7bEp0PQBXPAGeFyUhP4QaVhcyGp6pGC8wp8qq/TTcUAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275964; c=relaxed/simple;
	bh=5dIIDioEedQVKeslk6sHdJ38vdna0ZniV+9gULNiGkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHGeuSX7sMYnTTLYgnVkjmsK7n5FgOj4kllhgm1tXWgV/QmTlWGuDOdTnrYESZ7ZOzK/5+Bt2ovxFe14TMPhJauIJJz80o1gT2NybOEa37FiCqntszCE5b5fKBpM7Ewuq/rOQKUIPVzHzgBHXyG9CqbgRnoxftV5sM2vfY5ados=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHeFOoCj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51323dfce59so4377935e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710275960; x=1710880760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMa9uy1xjyCYcVnS1D56e26rdhN3qgYq/HM1aZSyxxQ=;
        b=lHeFOoCjGC8/Tfqsq2br2WENzwrLFoVpP22rcFn6rXTxsmK40LPsDjvkbLsqTNLam+
         TA6lBccJGJ3g/sduCla++lLl/WOvYYGNLVU9JECtFFLWai6oo+xRiy5hpweAmz6F/+O7
         EjOgcz5y7Cma8sI8n2quE1MpTlLpH6SLeniwPPgRKi0ij53OYHZgkBo21MKsHSj4NPD9
         o0rBdH9Og0OVu/Ine7ydiTncXpgcZwhfy2/gnZDdFE1DaogQ4S3IHI5oLN549MnXet0T
         rVlAyqU3kzgKSiBwuRMiLMc/OO3un8kFIT9n9wbdvRxu+9KJlxl67IHE+627lYW50G7p
         KFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275960; x=1710880760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMa9uy1xjyCYcVnS1D56e26rdhN3qgYq/HM1aZSyxxQ=;
        b=wQnjAi9ahDLIZ6513dR0hFSqVmzA214dzlX6EZwzMYWQqn+oidOjxv17ZRG3e+kG9U
         5AL9ktg1bHET3ZMnuo20F6bBvVPk/KbykGH482fRjlA4/tZK71rpOx26CBvMLz3B0dbs
         EavshnL9oJm+c0DGRbFvLaEMb+Je9FkCv02uiN+PueQTElRrE42PKaQ84DKgS6TJ2Oxc
         IPjYF8FPdCZvdAV/t8AW6HwRVSVO3nmzFfJrmiW/4EgLoOVyFCP1aZRzH4LmdyxaW1Fu
         jAVJWbxKcPXFj6R7H0CnSyCIMjdag2CCgD6fHDHZGF28SYIetth+aSScBhSkeu5K0HqX
         r61g==
X-Forwarded-Encrypted: i=1; AJvYcCVDlzRdpMggP+WuP0rXK75ccmSBTCmqRRlfkUFlBXDvtDD897ULPnIAbiSbef+BxmSU5+sHCPLr4K7HZ8w1DU0yOSuUL/bOKz4GkOC2
X-Gm-Message-State: AOJu0YzhxmzTsI8Ja/k88obw+bd/FwJtD1bm+cVuUMgNWOtq9u03Tc+n
	eHXem6uBl2a1H4t+GnHZbOel5WYIbdtFvF5Y8Mj6JHhBREvi452iZLwgjwoia1ZMDFWIF5Qzk7K
	m+8E=
X-Google-Smtp-Source: AGHT+IEFqnfYYAqbOkd1uofvkZfrQN9GSRLx/1bjUeXeGqTXRPEUXnzY5ruOC253oQHGieN3PO9JlA==
X-Received: by 2002:a05:6512:2f4:b0:513:2e60:a75b with SMTP id m20-20020a05651202f400b005132e60a75bmr7246874lfq.34.1710275960546;
        Tue, 12 Mar 2024 13:39:20 -0700 (PDT)
Received: from [172.30.204.193] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u14-20020a05651220ce00b00513a238039csm1426317lfr.287.2024.03.12.13.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:39:20 -0700 (PDT)
Message-ID: <a269a263-70fa-46a3-a7d1-31f369db4f05@linaro.org>
Date: Tue, 12 Mar 2024 21:39:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] media: qcom: camss: Add sc8280xp resources
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, hverkuil-cisco@xs4all.nl,
 laurent.pinchart@ideasonboard.com, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
 matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-b4-camss-sc8280xp-v6-0-0e0e6a2f8962@linaro.org>
 <20240222-b4-camss-sc8280xp-v6-4-0e0e6a2f8962@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240222-b4-camss-sc8280xp-v6-4-0e0e6a2f8962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/24 18:17, Bryan O'Donoghue wrote:
> This commit describes the hardware layout for the sc8280xp for the
> following hardware blocks:
> 
> - 4 x VFE, 4 RDI per VFE
> - 4 x VFE Lite, 4 RDI per VFE
> - 4 x CSID
> - 4 x CSID Lite
> - 4 x CSI PHY
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

