Return-Path: <linux-kernel+bounces-49978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A564847271
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA32E29513B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E547144636;
	Fri,  2 Feb 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nX2R+xpE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4307E5;
	Fri,  2 Feb 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885965; cv=none; b=qgMmQlyIPZZCJub2IaKJu1oD6cwqEQAp+1xdVTbxesPQO4aFCTB1tBP1YALHlGhXCNgD/YVuV7Xx/r+Tb/YgFJL7gEfGjLHfspKaYidXdg0fLS5ZZNfKv0w+JjAWqw6tMUWe5joBtt9VIm7EFFD1iOlsdYHlrJ+760WvTIEq/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885965; c=relaxed/simple;
	bh=060+cBbOS7QVMY0C6mMjot3skN9ZnKXBLMXmiqpiDok=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZsGsS1JSmmrvkmxsLdjqIOgkvuGX3N+ZKMMrVweV10VLUkcBAmJAe5Ehfc7AC2zaQnMF350e899iIQlICkd/8Ad+Ll+HOQvtNE78tMoewWwc11qkdMTbcZV3JE0RtIHS3FJMnfEJgNjrpnlc5ssguKooQv62hXmpCEYmQEzfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nX2R+xpE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412Ex9hh064767;
	Fri, 2 Feb 2024 08:59:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706885949;
	bh=Yal9nzjrFfbUuNcyrhES9wxwnLywzSU7c1qVhaUmbIE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nX2R+xpEkHm+LS9R4QjiXvhbE4HdJMNSwwVhZHV9j6rmWl0C9ep8uT2vQL6Z/hAe+
	 MFyijljs/VkIvMYg/tiNjL1NMd4ZaLPvCUVJ56XtVrVLJn7pDP5oYU8KD+/cV/chdo
	 xf5+wZ8Qyfy9PySa75zycFd9alNs9tChc+Mx3MK0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412Ex92l003347
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 08:59:09 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 08:59:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 08:59:09 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412Ex9Vj120052;
	Fri, 2 Feb 2024 08:59:09 -0600
Date: Fri, 2 Feb 2024 08:59:09 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley
	<conor@kernel.org>, Bin Liu <b-liu@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240202145909.a5hnglswn5xivxaj@ebook>
References: <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
 <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
 <20240202-unzip-whacky-bb2f151c618b@wendy>
 <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>
 <20240202121828.oo7grngyh2heqdxn@disposal>
 <2dbbcc17-38e9-48b4-a0b1-450350644fb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2dbbcc17-38e9-48b4-a0b1-450350644fb9@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:59-20240202, Roger Quadros wrote:
> 
> 
> On 02/02/2024 14:18, Nishanth Menon wrote:
> > On 12:13-20240202, Roger Quadros wrote:
> > [..]
> >>>>
> >>>> As DTS and driver will be merged by separate maintainers I thought it
> >>>> would be easier for maintainers this way.
> >>>
> >>> dts and driver might be merged by different people, but dt-bindings and
> >>> drivers are merged by the same people. This is a bindings patch, not a
> >>
> >> If we do that then I get a bunch of dtbs_check warnings
> >>
> >> dwc3-usb@f900000: reg: [[0, 261095424, 0, 2048], [0, 261128192, 0, 1024]] is too long
> > 
> > Just my 2 cents: If the binding (and driver) change was truly backward
> > compatible (which it should be - for example: errata can only be
> > applied if the second property is described), then you want to control
> > that reg property to add minItems? - thatm I think will allow the dts
> > change to come in at the next cycle once the binding has been merged.
> > 
> 
> Thanks for the hint.
> Please drop patches 4 and 5 in case you pick this series.
> 
> I'll send patch 4 along with the driver series v2.
> Patch 5, I'll send after the DT binding has been merged.

I suggest to resubmit requisite series (with patches +- or what ever)
specific to appropriate maintainers (I don't typically like folks
sending driver change along with dts change in a single series without
indicating to driver maintainer that dts is something they shouldn't
be picking) and avoid any confusion ;)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

