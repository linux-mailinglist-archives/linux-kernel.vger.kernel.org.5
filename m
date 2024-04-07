Return-Path: <linux-kernel+bounces-134525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171B89B287
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BFEB21214
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4C39AFE;
	Sun,  7 Apr 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NttMJzzQ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E21241E7
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712500957; cv=none; b=FELcVxnv33SntrW9haoPb+Iodie1+S5cOikchF2Y9RG7838w/Arvoaa78iTg0uYtGbAjvRb1D620JhUE6b01umufcE9tQtfRP5wZPwMR4WF8oN+GMOGa3zdlgLf4NaX/8feT4IsZcwOzmrrByFXdrR19zBlHbgIjDFKcGBlV/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712500957; c=relaxed/simple;
	bh=RYI0Q/PC18L0A2DgMpRvDcCdhn+9FzK9o8KOqINLVdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZQJMx2bPTNAljpXEvsj3KqJM1BPmO9aGbtWYmYqCpGmndbA+FgIiSG5IGl29BETQDOLurY3EPNVs8uNlfzmgOXU6WELAD4jpNhKLOj63MN8qQkywhvtB6JgWgpnlihpNw04SMDtbWJJC4BiV7S8fENj26Fk3q1KnjlqY/lDlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NttMJzzQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso281380b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712500955; x=1713105755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AGXoqXfAlX5nC8yKXkv2xcky5j0caWjCJ7czfp/ZnY=;
        b=NttMJzzQAt1bE+6N0PHbCkbhzqg/6c+zQNqpuJJM6Ff5VpixgVnv8mVXav/VlvnKQ2
         e6cl1OZsqqpvuE8RuO3H+g93AFo8HP8/8CJy3RFGx+F5jT4aMGh4L3/FCFXWd/IA0i9L
         IVljT8fqHua/IZyxDOJu0rlvHLHqHHaJ0oCCoRV7E+at34GGWn8ANC/we0ONlrFm0g+l
         kfERNMzx8JkHEezeg2P9dg5G8HK/VgdiYqu+Pywxa+lzT0gIkUK4y9vFZ1Qtwc4qAEF6
         /rG/9GNEXAiSOu0NZEWoen/ZM1DEOcqgVDHElNuXPvGnTKqbGzz+kmJQKKsLC4mfiup/
         UJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712500955; x=1713105755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AGXoqXfAlX5nC8yKXkv2xcky5j0caWjCJ7czfp/ZnY=;
        b=v6Dx3KB3PAZryzT3ar+it6zIQccqBy4RWfB3eMmTtmzmo6IunPuKGmuDsrvrZ4Q3jY
         aUvWYTrmkmh9J52Z6cG8r4cesF6WjuY532PdYCumzRPwdCrvsJA4abm3ojHcanYpnscy
         Zp4oMwqgarui/ooetl8RbUlEdbg93HOEI4TrSbJshhCEd2H8EysBnzH/+z7+TwGfEcBF
         q7qOl+Cz7m4UeaaESLkyE2+rDVAFEOKMLXA9tRn3wkSQcon+3h698nJRTdKtagRcn2TJ
         t2MnVX+3vEpQ5XbLdNSWXkND2oKOS+hyBjvdHzRobfs+dTAbR7u3urgFOtMakenaY12u
         /V9g==
X-Forwarded-Encrypted: i=1; AJvYcCUv6Yi6xz/A2phsBQyydaEZL/rC8x/Bymecqeg183qo56tI67v4ZLyqZOO2DkWtSmjbUdp3EXbXWKQ4lTfZzfh6cbwFB7ww9mBsDsF3
X-Gm-Message-State: AOJu0YyJbMP3yt+wZn8Kvx+d5eJzKT7zqBqtep2lIhvo5VhNvSkwea/9
	x2plbFSHmJ1Y6fXltxbZLPGWUPBOppaSMPwnQfqwXVtkbws2kDPrasbdTfFhpw==
X-Google-Smtp-Source: AGHT+IH91S1Z/KeP8j1qCyAsCVGA3WNwVPBN6gvhYhKdgqEwwdwQYimMDHu7d2YE/xvhwIILfPFCUA==
X-Received: by 2002:a05:6a21:33a7:b0:1a7:23d1:c30d with SMTP id yy39-20020a056a2133a700b001a723d1c30dmr7748366pzb.8.1712500955282;
        Sun, 07 Apr 2024 07:42:35 -0700 (PDT)
Received: from thinkpad ([120.56.192.184])
        by smtp.gmail.com with ESMTPSA id p23-20020aa78617000000b006eab7ca005esm4877624pfn.18.2024.04.07.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 07:42:34 -0700 (PDT)
Date: Sun, 7 Apr 2024 20:12:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v9 3/6] dt-bindings: pci: qcom: Add opp table
Message-ID: <20240407144227.GC2679@thinkpad>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-3-496184dc45d7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407-opp_support-v9-3-496184dc45d7@quicinc.com>

On Sun, Apr 07, 2024 at 10:07:36AM +0530, Krishna chaitanya chundru wrote:

s/opp/OPP

> PCIe needs to choose the appropriate performance state of RPMH power

s/RPMH/RPMh

> domain based upon the PCIe gen speed.
> 

s/upon/on

> Adding the Operating Performance Points table allows to adjust power
> domain performance state and icc peak bw, depending on the PCIe gen

s/icc/ICC

s/PCIe gen speed/PCIe data rate

> speed and width.
> 

s/width/link width

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

With above changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> index 1496d6993ab4..d8c0afaa4b19 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> @@ -69,6 +69,10 @@ properties:
>        - const: msi6
>        - const: msi7
>  
> +  operating-points-v2: true
> +  opp-table:
> +    type: object
> +
>    resets:
>      maxItems: 1
>  
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

