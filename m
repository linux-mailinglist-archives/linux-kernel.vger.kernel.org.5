Return-Path: <linux-kernel+bounces-68665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6272857E09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E61F2173E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8277B12BF11;
	Fri, 16 Feb 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vD9yhFqJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451612C522
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091369; cv=none; b=uQ/M16porTOA6AbhK0zApXTZRSSH01nkwZBfHGkGwHiiKl0R54lI936nEgW++E2gJHX7lrnff5Ej9y3WinG2GXgcVSI3BVQgpkVLeB9XjvZhy7DOjaJYSduJjF00D/a0BEaZVLt2zYPsbvER4t2CWyWbmx68ES7PMR5VDXtAREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091369; c=relaxed/simple;
	bh=9kLgFo3LkOE/31wGty0YH5P7LInCNnttJL4VqlmV8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEn2oxbtFv0LZVs8GqGe5qQvLjFdtQ42ZWgjmNHlkHBvFOQqfOTLiin9InNwvmRfp8nIzhIR5qsPpLJGD5wYrBCr4jThTTol0JX8lbJxzbcBMcZmenWlF9BnqwoXKILoQISAO6hXFO4hC8XSKy25E+arA4A6UckXg3QdU274qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vD9yhFqJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso1712284b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708091367; x=1708696167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrwIR8b1kDEUZvsSWjQUx/isqJeNcHHG7T0kO10bJRg=;
        b=vD9yhFqJHRFt3etyuMYXsydWEG/mmYqPELIrFa/O2RCYBnJLU2a/pkJoPygdtNhOtk
         L+VSaGo0lwgu8jGGoebhTdbz5qyMZ3xQBhOJZmX26kQI9/Uf3V7m6QevANLKsVjwfS8c
         LXLDyNCaPu5SB3L8VbVVAZKj6m+X82nxbu9RAlsTOWpFAzX3rvyrnlW4vGPdUhg7/LXG
         fF2DYyf2SxFDgCvwMi/i+kxhTz7YBiAfhH+z4iek+0BrAuwhBU41OK+JeJbU+Jo1y7g+
         anS+VcfGO92JzAFNHTsI392qtEda7H1FLBz8JaQYwrP1gHgBk3qGysp/SiKvgrB6n/5s
         ULCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091367; x=1708696167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrwIR8b1kDEUZvsSWjQUx/isqJeNcHHG7T0kO10bJRg=;
        b=CnL4KJlFWO9ZEMndnj1mXaWNahJHxS7JznHT12edCRya6fCZBW5dsPaZaESKz75LoA
         1yTZaF+k4hAjtpon2LNjTnL4ay/I02p1HeQv3wZCqUfd3Oix9CKnCGnGraFodJIg7wew
         dZL46/QaM1bXLhqq/auHKZSuEmybyXUlPEzuyS//pKoAoJzGpOnCVN7/yWHoJ9Iv7A7G
         nPDWFlgJoxtwGd+NCaVLQlNmRQTuduhMA9ujACbwtiq4c8wUZJkSnyB5e7tjZlaGButq
         nzsujFVYZtooOdrR8yhaHl0mrLr3rfqyXNFL/xFTQjmKpENRelonavCuOKr6EIFFfVS/
         7CFg==
X-Forwarded-Encrypted: i=1; AJvYcCUxupp0RO+5M1CVCPZedwq0B+08TSpLwMlqGqEQhVnIYRcn9hvZju0nD7NcYZQryeN2j0nJTKqIHwuZs+Q7drpp6eCOdJsn0HQg/LRm
X-Gm-Message-State: AOJu0Yyi7QSNPiijT7DrJ3upBAv6M/dnFWeA26g32sg+wx4k85Pvx1OV
	RG/seX6lUfb07oQLLmji/4ELcxIKyMBWEcqiQ+Uf/kXh9ez8u2E7mDE4aEdrCw==
X-Google-Smtp-Source: AGHT+IEEbU+1ADdQDuvVbndmm/EodG2xGil0iXo6JADPsUeC3QjB0e52iItjpm7MRlaMW839PV6uTQ==
X-Received: by 2002:a05:6a00:2daa:b0:6e0:4030:ef77 with SMTP id fb42-20020a056a002daa00b006e04030ef77mr11166464pfb.16.1708091367308;
        Fri, 16 Feb 2024 05:49:27 -0800 (PST)
Received: from thinkpad ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id lb14-20020a056a004f0e00b006e0436e08edsm3204053pfb.11.2024.02.16.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:49:26 -0800 (PST)
Date: Fri, 16 Feb 2024 19:19:21 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com,
	pankaj.dubey@samsung.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vidyas@nvidia.com, gost.dev@samsung.com
Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Message-ID: <20240216134921.GH2559@thinkpad>
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
 <20231130115044.53512-1-shradha.t@samsung.com>
 <20231130165514.GW3043@thinkpad>
 <000601da3e07$c39e5e00$4adb1a00$@samsung.com>
 <20240104055030.GA3031@thinkpad>
 <0df701da5ff0$df1165a0$9d3430e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0df701da5ff0$df1165a0$9d3430e0$@samsung.com>

On Thu, Feb 15, 2024 at 02:55:06PM +0530, Shradha Todi wrote:
> 
> 

[...]

> > For the error injection and counters, we already have the EDAC framework. So
> > adding them in the DWC driver doesn't make sense to me.
> > 
> 
> Sorry for late response, was going through the EDAC framework to understand better how we can fit RAS DES support in it. Below are some technical challenges found so far:
> 1: This debugfs framework proposed [1] can run on both side of the link i.e. RC and EP as it will be a part of the link controller platform driver. Here for the EP side the assumption is that it has Linux running, which is primarily a use case for chip-to-chip communication.  After your suggestion to migrate to EDAC framework we studied and here are the findings:
> - If we move to EDAC framework, we need to have RAS DES as a pci_driver which will be binded based on vendor_id and device_id. Our observation is that on EP side system we are unable to bind two function driver (pci_driver), as pci_endpoint_test function driver or some other chip-to-chip function driver will already be bound. On the other hand, on RC side we observed that if we have portdrv enabled in Linux running on RC system, it gets bound to RC controller and then it does not allow EDAC pci_driver to bind. So basically we see a problem here, that we can't have two pci_driver binding to same PCI device
> 2: Another point is even though we use EDAC driver framework, we may not be able to use any of EDAC framework APIs as they are mostly suitable for memory controller devices sitting on PCI BUS. We will end up using debugfs entries just via a pci_driver placed inside EDAC framework.

Please wrap your replies to 80 characters.

There is no need to bind the edac driver to VID:PID of the device. The edac
driver can be a platform driver and you can instantiate the platform device
from the DWC driver. This way, the PCI device can be assocaited with whatever
driver, but still there can be a separate edac driver for handling errors.

Regarding API limitation, you should ask the maintainer about the possibility of
extending them.

> 
> Please let me know if my understanding is wrong.
> 
> > But first check with the perf driver author if they have any plans on adding the
> > proposed functionality. If they do not have any plan or not working on it, then
> > look into EDAC.
> > 
> > - Mani
> > 
> 
> Since we already worked and posted patches [1], [2], we will continue to work on this and based on consent from community we will adopt to most suitable framework.
> We see many subsystems like ethernet, usb, gpu, cxl having debugfs files that give information about the current status of the running system and as of now based on our findings, we still feel there is no harm in having debugfs entry based support in DesignWare controller driver itself. 

There is no issue in exposing the debug information through debugfs, that's the
sole purpose of the interface. But here, you are trying to add support for DWC
RAS feature for which a dedicated framework already exists.

And there will be more similar requests coming for vendor specific error
protocols as well. So your investigation could benefit everyone.

From your above investigation, looks like there are some shortcomings of the
EDAC framework. So let's get that clarified by writing to the EDAC maintainers
(keep us in CC). If the EDAC maintainer suggests you to add support for this
feature in DWC driver itself citing some reasons, then no issues with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

