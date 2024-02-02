Return-Path: <linux-kernel+bounces-50063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB1F8473DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1751F2A105
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931B1487F0;
	Fri,  2 Feb 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BNSjVBBx"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C881474B9;
	Fri,  2 Feb 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889515; cv=none; b=tkC1LjrNs6zMOj5SC9DFIvD/MPM1qiSyZDCX/fHt3TNYDsoEb/SQj04BoiL42eTou23cpxUlLgFdJJphDggVx46Ye/pHb5CjdRI9halWF5FaSCn9RqWY5VtNOPoyhylwd5vXGZDIslHmtZJaP3Z35p6qaU/+VX85l9yFbV3pJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889515; c=relaxed/simple;
	bh=dp75bwXX7tIHfUVH1f4OXG1r3cVmLUBPJ3pB0Cvd8pM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Z8O+BiwuVc0qViESdXE43Y+Zhq7BrZbJXQpDzdQ4ZVCBr9uo4rGE+O8k7Zm513JX6UX+0VTLkurrROFLO1OYSGOOlol1gJxuKC0YcALDeZkBWwal+w68Wv1JAszK1P5peyJuYjQQILRKBm0/cQLMNXjeW7R+4LDsqfuw60g4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BNSjVBBx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412FwEnk129851;
	Fri, 2 Feb 2024 09:58:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706889494;
	bh=CFtDJ049GnMFYlEV6vLRg/Zh5NxrePWpNQeg1PHu2Po=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BNSjVBBx41adwlfNt13ZMwaQFcTFADAHI5TwE48SiiIxYK+CxbtERMb/fPx3jZJyQ
	 xAFIYsrk5A6gPs1jF+duNEYl1TUhmu2/CcqQ1o2d9PScKP2Wut7I+w/FiEKY2IcPxN
	 p0eL0z11/W9IfBncRZWAdKkLQTbyV99BB1EL6Y2k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412FwE3M086792
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 09:58:14 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 09:58:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 09:58:13 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412FwDum074625;
	Fri, 2 Feb 2024 09:58:13 -0600
Date: Fri, 2 Feb 2024 09:58:13 -0600
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Brandon Brnich <b-brnich@ti.com>, Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Darren
 Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Message-ID: <20240202155813.szxvi7bfp5xh7rvw@babble>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
 <20240202125257.p4astjuxpzr5ltjs@dragster>
 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:56-20240202, Krzysztof Kozlowski wrote:
> On 02/02/2024 13:52, Nishanth Menon wrote:
> > On 11:47-20240202, Krzysztof Kozlowski wrote:
> >> On 01/02/2024 19:42, Brandon Brnich wrote:
> >>> Wave521c has capability to use SRAM carveout to store reference data with
> >>> purpose of reducing memory bandwidth. To properly use this pool, the driver
> >>> expects to have an sram and sram-size node. Without sram-size node, driver
> >>> will default value to zero, making sram node irrelevant.
> >>
> >> I am sorry, but what driver expects should not be rationale for new
> >> property. This justification suggests clearly it is not a property for DT.
> >>
> > 
> > Yup, the argumentation in the commit message is from the wrong
> > perspective. bindings are OS agnostic hardware description, and what
> > driver does with the description is driver's problem.
> > 
> > I will at least paraphrase my understanding:
> > In this case, however, the hardware block will limp along with
> > the usage of DDR (as is the current description), due to the
> > latencies involved for DDR accesses. However, the hardware block
> > has capability to use a substantially lower latency SRAM to provide
> > proper performance and hence for example, deal with higher resolution
> > data streams. This SRAM is instantiated at SoC level rather than
> > embedded within the hardware block itself.
> 
> That sounds like OS policy. Why would different boards with the same
> component have this set differently? Based on amount of available
> memory? This, I believe, is runtime configuration because it might
> depend on user-space you run. Based on purpose (e.g. optimize for
> decoding or general usage)? Again, run-time because same hardware board
> can be used for different purposes.
> 

Why is this OS policy? It is a hardware capability. Traditionally
many similar hardware blocks would have allocated local SRAM for
worst case inside the hardware block itself and don't need to use
DDR in the first place. However, for this hardware block, it has
capability to use some part of one of the many SRAM blocks in the SoC,
not be shared for some part of the system - so from a hardware
description perspective, we will need to call that out as to which
SRAM is available for the hardware block.

Why would different boards need this differently? simply because
different cameras have different resolution and framerates - and you
dont want to pay the worst case sram penalty for all product
configuration.

Further, Linux is not the only thing that runs on these SoCs.. these are
mixed systems with autonomous operations of uC cores who may or maynot
(typically not) even need to communicate with MPU to state which part of
resource they are hogging (hence the board level definition).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

