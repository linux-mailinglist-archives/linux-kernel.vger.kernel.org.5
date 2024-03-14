Return-Path: <linux-kernel+bounces-103398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6A87BEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6901F23E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5A1D69C;
	Thu, 14 Mar 2024 14:30:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5861A38F1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426628; cv=none; b=EBEYxbaCqjG/l5v+H+Y02zLBbNswkADMAnmhR/WnxxhQaSk01DcpQoSMwWxFEZJH8ILiSXq07B/kT48mtNI6b5st2IXhz/dneUIFntbs0hfUGGB0MB3Qfp4UdIIJcBWBCSjGvgeUp2vqrl9kXa//DGiKPyUKxla7Cm0uMoLyiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426628; c=relaxed/simple;
	bh=GepO+rRnr8mGIl2frn5Ar2Zz8CTdmmXLPwQtnbQ9OkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hma4ooyYcwvF+IpDMzkywWyMT9CEG/pkaLKNIXuJVDeQmeiJSJjXLzHsgK7nowPAzgOl4kSN2KSvK7ee6Ml+hHA+2gdxucwP+lUiFy7kZPVMdQeW+9nKktNFebkhAGWg43ipPYsIqk/eWDNK1x7M50HyNByXUNrVeZcg6KzTQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95E81007;
	Thu, 14 Mar 2024 07:31:01 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 231BE3F762;
	Thu, 14 Mar 2024 07:30:24 -0700 (PDT)
Date: Thu, 14 Mar 2024 14:30:21 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viacheslav <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 0/4] soc: amlogic: add new meson-gx-socinfo-sm driver
Message-ID: <ZfMJ_Z07QkwFbOuQ@bogus>
References: <20240314070433.4151931-1-adeep@lexina.in>
 <ZfLUMoN_ZU-xLfpA@bogus>
 <62d45d81-1366-440f-81e1-e66395707eb9@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d45d81-1366-440f-81e1-e66395707eb9@lexina.in>

On Thu, Mar 14, 2024 at 03:25:02PM +0300, Viacheslav wrote:
> Hi!
> 
> 14/03/2024 13.40, Sudeep Holla wrote:
> > On Thu, Mar 14, 2024 at 09:59:50AM +0300, Viacheslav Bocharov wrote:
> > > The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
> > > unique SoC ID starting from the GX Family and all new families.
> > > But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
> > > chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.
> > > 
> > 
> > How old or new are these SoCs ? The reason I ask is that it is really
> > sad to see vendors still creating their custom interfaces for such things
> > despite the standard SMCCC interface SOC_ID introduced in SMCCC v1.2 some
> > time in 2020.
> 
> Most of these SoC were created before 2020.
> 

Fair enough then. Hope they use SOC_ID on newer SoCs.

-- 
Regards,
Sudeep

