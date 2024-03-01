Return-Path: <linux-kernel+bounces-88394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA186E101
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB16B21BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA746E60E;
	Fri,  1 Mar 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFZyELV8"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A576E60B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295856; cv=none; b=qa+0zUlkFxVoUcmXHfghpSU2jHA0TG8boylZZg2Y2YGwEzED0DKOiqM/aOYe7u1AsFaqn2phSk836285qmv6HMAgBWbLpzr6cSZuIhVShLm7lJqdZ1lnw6BZDuLh4ll4bB3OKnGpEOYu11CFnYNBSYNyRUFtpHTir7498C+bf58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295856; c=relaxed/simple;
	bh=GeK7NXU8+bwfBSHzsZlUNBLhTVjfM+PRqah5iO9UP7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CavHTVz4TeBSYae/AqQyZcGKH4wo6sn67r2w9OI9RK/ACONtOjPj7sSTRLV4HOGHHBu+fbPorDWJURwv1eLHBJM3+DkItGrOkSMDOzXEP/40MX1IBj9E299pxVvJLvJ3LW5QLTSCdwIIcC/FMC9jdhxIvEKLWZlXGIezGhYJZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFZyELV8; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c7b8fb8ba6so119981039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709295854; x=1709900654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/b5kEb7iwEP3csgzWIGJ8JouHXy+H/cUYJXmmRjhdKE=;
        b=aFZyELV89/ojTEZjsaa6LrmkxmcsyGsIIv4IfcnBC5zUmeTiOTe1EYaHtJGWP+goDe
         Myy9og1eWl+voL2fSpJDp3FdKtK+Q6UCQJM+1emF9oWo9dEY4bzPkEjzqet65QFHramv
         yBkfpJtsmcQXtdkkYQNSmpHcNuZiJ1t9EmUXufby7xGTbjxhOzBvfdwJ9wqBByLE1wbU
         olz4U+GHwJcMwtvmJpTYK2Gc+DOjVCv6w1O/D/F5fmwa9KIXVMZNMVT0sC41C5pnLmV1
         TTBAfMXM+mpMFxdidYD0X2PNLoOOVJq316pphS2+59mWcAPW6+Z5t2X2ajcoKQPPE9lp
         ARMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709295854; x=1709900654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/b5kEb7iwEP3csgzWIGJ8JouHXy+H/cUYJXmmRjhdKE=;
        b=X2VYmygB/Cdg/WGIHPeAaiamsPKJpUESHiGhDUh9ZuCrhi7nxXBxWVIYKVVRl8aX4X
         AHiJJqOq2pMK2bOgxcvXFIdUmJz73oadSn6EQEybJMUfXIrs3nQY9GRiWf9arc3q69c7
         SUwZuqQ/5EYWtlTugrGd6hI5zj9yrqswV/dxSg7HeZPwWLeY15+yhKFeo+cZ8mYJ1dDu
         BQnPc1+0DafRTvnvZ8hwy6RA0xE/Q25ZBJN6qDI1tR/c2qcPcf6xcmSJleG2/e4gotIo
         LXv4f2Q/grLHhu10arqn8hz9faeaaAxnm4cUXpcZtqssXWMqYxSNzXvh4/X5x3ZdODSw
         g9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUHuz+bSpnVnv+E37A2Puv2OAWQ/XIbXAScmwKMcrvPNNtzhtAtvmhztpYc8FSbwRasBeu/fFBsRbzhReNxt8AWUrhBfWvLZ783l+IW
X-Gm-Message-State: AOJu0Yxac6YV4wp6blO69LAd0qlRjHw/MbM/mhSh4Szgbpd19Ie0mQFG
	fulGw3q64W7YkXAnNBPkrDpmRS9/60sYNWjfohbqq1dVF6xY+i8qMBIbO4PjZA==
X-Google-Smtp-Source: AGHT+IGjonEgf53n7CtJrGJKoHCICELzX7ssAuT3mNd1cdbBKw/KgfiA65RmCI0QdqSvYfVXPwiQRg==
X-Received: by 2002:a6b:ef13:0:b0:7c4:9c09:218c with SMTP id k19-20020a6bef13000000b007c49c09218cmr1513631ioh.7.1709295854030;
        Fri, 01 Mar 2024 04:24:14 -0800 (PST)
Received: from thinkpad ([2409:40f4:13:3cbc:2484:3780:dcff:ebcf])
        by smtp.gmail.com with ESMTPSA id l20-20020a63da54000000b005cd8044c6fesm2934212pgj.23.2024.03.01.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:24:13 -0800 (PST)
Date: Fri, 1 Mar 2024 17:54:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240301122406.GA2401@thinkpad>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229135407.GE2999@thinkpad>
 <ZeCktwcEFAfCEVkV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeCktwcEFAfCEVkV@hovoldconsulting.com>

On Thu, Feb 29, 2024 at 04:37:27PM +0100, Johan Hovold wrote:
> On Thu, Feb 29, 2024 at 07:24:07PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:
> 
> > > I think that based on the available data it's reasonable to go ahead and
> > > merge these patches. In the event that this turns out to be a
> > > configuration issue, we can just drop the 'aspm-no-l0s' properties
> > > again.
> > 
> > Well the problem is, if you are not sure, then adding the DT properties is
> > certainly not correct. As that implies a hardware defect, but it may not be.
> > So let's wait for some time to find out the actual issue.
> 
> Our devicetrees are always going to be a tentative description of the
> hardware, and this especially true for Qualcomm that don't publish any
> documentation so that people are forced to rely on informed guesses
> based on downstream devicetrees and drivers and reverse engineering.
> 
> As far as I can tell, after having spent a lot of time on this and
> checking with sources inside Qualcomm, the hardware is to blame here. If
> this turns out not to be true, we can always revise later. We do this
> all the time, as you know.
> 
> I'm all for digging further into this issue with the help of Qualcomm,
> but I don't think that should block this series as that would leave the
> link errors that we hit since 6.7 in place and effectively prevent us
> from enabling the ITS in 6.9.
> 

Sounds fair. I will report back, perhaps with a fix based on what I get to know.

But I think it is better to disable L0s in the SoC dtsi itself. That's not only
because there are patches to essentially disable L0s in 2 of the available
platforms making use of this Soc, but also you are enabling GIC ITS in the SoC
dtsi and that may affect sa8540p which is making use of this dtsi.

The users of that SoC may have not noticed the errors as you did before, but
enabling GIC ITS will certainly make the issue visible to them (more likely).

Also, if it turns out to be a hardware IP issue, then we can leave the patches
as it is, otherwise we can revert them easily.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

