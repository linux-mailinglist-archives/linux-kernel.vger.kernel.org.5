Return-Path: <linux-kernel+bounces-35861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1D839787
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965FA1F2AED7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253881ABA;
	Tue, 23 Jan 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhR/gBIh"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0281AA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034046; cv=none; b=Pd0/nlz08/5+KjCCZRe+iTy2TPPuFbIVkRnnJtNjCEJiUlJnG3jaA5raRY/Z8RbKuXSSWPCA/SQnRNgbPuwAL9GYXPKOPxcmj89PABKxiSPqOAX9BoxZIg7IsDURIUIg/My2iLb/ZK2hwKk5bp3b9ODgmb3c79KsZ2v4STG80JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034046; c=relaxed/simple;
	bh=USIEsJ/MK/XnJIFgdS/GdFEdoheNScUhLt3v98sSC10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTPWL/+y+KsKDc+FwlMmW1j9xd/Ui9VNW/RzXTtJz2QNHsbU89KJg4dNRNgDGCAbcrZmNNKiq57vzqId2p5n/F83CfMXyfTqxroNdU54goNK68FB+HMc6X0tOtUbpa/wk3OAD7Dm6o6en/HBfv8VTQWdGa/Bt1otnnUQX8mIh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IhR/gBIh; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-467ed334c40so1024897137.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706034043; x=1706638843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB7jjC2EZYwUeHhQPxwFxVrh4egi4HfWvlhEcHneyE0=;
        b=IhR/gBIh3TjzC3+xOWdGu4KvCTYY3B8NvbIIbjmhanuAhLTNMTgRnLdbaciRb08hJr
         mSozoj/lDQaMqu1VQ7luQ5fH6uYLOD7hG+7pLi5FgRhUzVBrtni1DmrdQyPprDzqXJ20
         /Oyv+qTLVCb3mrE9oM+MXuddt4G6dqH+eRvVlYI3Xesq+yu7g3zRl89+pd7Ua+aQNmiR
         yn00c7K7QbJ2OqUs4gE1QC6VXCIslLD86FY02K+E6oSqPzc4QUnZKxjhjAn5uArUEas4
         0mSKuNx1+YPraQj1QxIFixISnHBT6nUsVGegQV/obUODnB5kYb1Xd7v/wV0V+2d6/MHt
         jPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034043; x=1706638843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB7jjC2EZYwUeHhQPxwFxVrh4egi4HfWvlhEcHneyE0=;
        b=PLe0fxoI09Ww0Dy7Y2qACVO/VfELTpH04Ed6sFx4S1Y25TyxhFt5vJkRfMNJvtB885
         aWutvWZ7xPYK1GSrrdDHve0od+wF6iDEMIfRR6as5JhfXXfXY67CvA6/8bV3jq0cX+mG
         j4U6vBkUvkD7YBjsfE776Us2bCtx6evzMXpLPoopHBqAozMcd/AofJnFn274+DJs3vuf
         d3k+cVt7vGWl+uuJxnKV6T/oNt2JlTF3e0eXU62JO8HWOzjCcJnG9wsB33ldU/CeoiPH
         WBtgxenn2vgdx3FS24/L77wBeIdE/Ix9Nr8jiMoNh47/qrl2fWA/+b4AC44TbrfD7Ntq
         9tLA==
X-Gm-Message-State: AOJu0YwhmcwwZAdTaJM+EsL9Slz7zeCDNSjGOuVoudF6BQyrGVVabqiR
	bZx/AsHzmWaxK4jrBYToBAaKR/3BXRKd4iFuubXtI8Ed5S2SjQQloZgmEsRJNXI=
X-Google-Smtp-Source: AGHT+IFCVWWTCP0nN5IbtxjseLprIcS4GMBKsW24BjxmhjMZW0fOgS3rDMCu9S0nZMRuNl+zWKp4CQ==
X-Received: by 2002:a05:6102:30a1:b0:468:151d:13a4 with SMTP id y1-20020a05610230a100b00468151d13a4mr3187736vsd.27.1706034043696;
        Tue, 23 Jan 2024 10:20:43 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 36-20020a9f22a7000000b007ce1febd008sm1658773uan.34.2024.01.23.10.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:20:43 -0800 (PST)
Message-ID: <3d029d7c-7efb-42bb-a16d-30cf965f410b@linaro.org>
Date: Tue, 23 Jan 2024 19:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] arm64: dts: qcom: x1e80100: Add PCIe nodes
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-7-072dc2f5c153@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-7-072dc2f5c153@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 12:01, Abel Vesa wrote:
> Add nodes for PCIe 4 and 6 controllers and their PHYs for X1E80100 platform.
> 
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]

> +
> +			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";

You may want to add ITS MSIs too

[...]

> +
> +			resets = <&gcc GCC_PCIE_6A_BCR>,
> +				<&gcc GCC_PCIE_6A_LINK_DOWN_BCR>;

The second entry is misaligned

Konrad

