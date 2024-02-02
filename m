Return-Path: <linux-kernel+bounces-49867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0668470AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C9C1F26456
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6340BF2;
	Fri,  2 Feb 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FaSRF19T"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462C187F;
	Fri,  2 Feb 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878388; cv=none; b=m4VVdhRaK6vf31vYPYVW0ci/iKiPSWFOUBoTo94kPie4jBCt6CaWpoBZhIdACvvfYUf85peYYX1DE562ZrqdDRpyA53mNsmX/xJzoyF7pwN4mzwX+fnGl3KCXfm0ZhGHtVicYQezMFu4F45IBEUUsen0z/WVTgfICfgxjt129mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878388; c=relaxed/simple;
	bh=aI6tdoMPLKlxeu03PJwY+6PTUmy8/t1n/2qpRcDuYbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhs8lQzpvaDoQzYfdiyOohHZaTeO9/yg7/0x+nNoo8kBA4utz1SMvpIwRDUclUx39pXnW6LOLkBs2AGWB+5H/UF9wpHtLeOKp6t8yVmiGOI2eOnD3Pu+RJhnCFZ8r3CSA0rLqf0khQPNuevHmHq8bI6pG7XPWq26lj5DsaW3h4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FaSRF19T; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412CqwUO085110;
	Fri, 2 Feb 2024 06:52:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706878378;
	bh=NT2KkZYcchRC7YCcmd8jd30rJ0gLMf93hNnBIQa0it4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FaSRF19TRdwnHT6XWwPncK4IBMLtU3SNUZk4gAsvTl576KBa25FrQGIFT7ebY5uaS
	 vgD2gZ34pfBZcU+GAxht+hdAACl/6FBVDP5gzoOHOfXpLNl9UWaJlYAjhDVN7BOtaw
	 00MbkdNGc1MeMUdKq1nFElywhz5h8UFgfA7nHJk4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412CqwvE047001
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 06:52:58 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 06:52:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 06:52:57 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412CqvPA009693;
	Fri, 2 Feb 2024 06:52:57 -0600
Date: Fri, 2 Feb 2024 06:52:57 -0600
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
Message-ID: <20240202125257.p4astjuxpzr5ltjs@dragster>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:47-20240202, Krzysztof Kozlowski wrote:
> On 01/02/2024 19:42, Brandon Brnich wrote:
> > Wave521c has capability to use SRAM carveout to store reference data with
> > purpose of reducing memory bandwidth. To properly use this pool, the driver
> > expects to have an sram and sram-size node. Without sram-size node, driver
> > will default value to zero, making sram node irrelevant.
> 
> I am sorry, but what driver expects should not be rationale for new
> property. This justification suggests clearly it is not a property for DT.
> 

Yup, the argumentation in the commit message is from the wrong
perspective. bindings are OS agnostic hardware description, and what
driver does with the description is driver's problem.

I will at least paraphrase my understanding:
In this case, however, the hardware block will limp along with
the usage of DDR (as is the current description), due to the
latencies involved for DDR accesses. However, the hardware block
has capability to use a substantially lower latency SRAM to provide
proper performance and hence for example, deal with higher resolution
data streams. This SRAM is instantiated at SoC level rather than
embedded within the hardware block itself.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

