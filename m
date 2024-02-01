Return-Path: <linux-kernel+bounces-48710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92E84600D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8D1C2A087
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB47E113;
	Thu,  1 Feb 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YPTD4j/+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB84176B;
	Thu,  1 Feb 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812533; cv=none; b=uxR9t/rJJpjUALZ2POzQQoIlBLsyI+hkMSqebAkKI0MEbLWs2pt5qhVwTBobxYAkCDAScdNqlojs4qPjTUe4bXovk9f4wUvFzOHWjxiClDHMwOTWUe4s+XldZd+9O2EkbeMlU8Kv9tMWiPd5MyLvUO6LISgorq0afDJiflr5T8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812533; c=relaxed/simple;
	bh=TVZH7oFOhgDsgkjujmCgChVYjn0cg4/4Fn9o5Rulks0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHwd7JbwxtJTn0zGezKdIuH0lzh1k8twPj1B9HWDmBrsmn1N/lCto0z6yj7PelOJ76v+RNnll+BPcdnZyf+OrPhAk4v+lg+gcBHAmB+d67UmV+YnkynBNtoF5JRjY3y3+++RI/HXuVyQExXlDUgg0Bh6B1dBqbxnTUUDIjeNmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YPTD4j/+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411IZMsW079208;
	Thu, 1 Feb 2024 12:35:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706812522;
	bh=rGyK0t8FjhIkG4Ozo6jyOaqYGyp+BnLZYVxHBLTGdgg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YPTD4j/+4U6wC022MX60ny9ih+0NKv5dh99zxCWvAZCg3fcf3ywlhzGIWAwOk0cDF
	 3iv9e3A7OHdH5NvYNuWdPTwB6BnKBt9+acBKXa0aZo+KsARyD52l8K4g2rZd+E0F3s
	 xDZzH713gOB3jG4X5O3CbGEMlnQFMgGeHt5ml8gY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411IZMQ4089686
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:35:22 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:35:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:35:22 -0600
Received: from localhost ([10.249.33.168])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411IZM7Z032688;
	Thu, 1 Feb 2024 12:35:22 -0600
Date: Thu, 1 Feb 2024 12:35:22 -0600
From: Bin Liu <b-liu@ti.com>
To: Conor Dooley <conor@kernel.org>
CC: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240201183522.ssj553rwefr2wuqi@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Conor Dooley <conor@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, nm@ti.com, vigneshr@ti.com,
	afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
	r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240201-violet-chalice-51a73f113e7b@spud>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Feb 01, 2024 at 06:18:05PM +0000, Conor Dooley wrote:
> On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
> > On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
> > > So far this was not required but due to the newly identified
> > > Errata i2409 [1] we need to poke this register space.
> > > 
> > > [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> > > 
> > > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Actually, where is the user for this that actually pokes the register
> space?
> You're adding another register region, so I went to check how you were
> handling that in drivers, but there's no driver patch.

See Roger's another patch set 'Add workaround for Errata i2409' posted
on 16th.

-Bin.

> 
> 
> > 
> > > ---
> > > 
> > > Notes:
> > >     Changelog:
> > >     
> > >     v3 - new patch
> > > 
> > >  Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> > > index fec5651f5602..c02d9d467d9c 100644
> > > --- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> > > @@ -14,7 +14,9 @@ properties:
> > >      const: ti,am62-usb
> > >  
> > >    reg:
> > > -    maxItems: 1
> > > +    items:
> > > +      - description: USB CFG register space
> > > +      - description: USB PHY2 register space
> > >  
> > >    ranges: true
> > >  
> > > @@ -82,7 +84,8 @@ examples:
> > >  
> > >        usbss1: usb@f910000 {
> > >          compatible = "ti,am62-usb";
> > > -        reg = <0x00 0x0f910000 0x00 0x800>;
> > > +        reg = <0x00 0x0f910000 0x00 0x800>,
> > > +              <0x00 0x0f918000 0x00 0x400>;
> > 
> > Why the double zeros btw?
> > 
> > Cheers,
> > Conor.
> > 
> > >          clocks = <&k3_clks 162 3>;
> > >          clock-names = "ref";
> > >          ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> > > -- 
> > > 2.34.1
> > > 
> 
> 



