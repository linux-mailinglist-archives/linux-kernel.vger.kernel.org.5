Return-Path: <linux-kernel+bounces-72849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836E85B97B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18499B21725
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59B657B7;
	Tue, 20 Feb 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DW0DRmnm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0009634FE;
	Tue, 20 Feb 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426085; cv=none; b=eE3zPXtRlb2SnKQhJMROGISSF6gxk2mKxcNmaED3TYpSyVxXmNTnEUaeDp2xzriwG4kdBHxASH9uX98evBMs0BpOC04zVW4qPLx0dQ+alakPLOLHHPQF3PR3a7yJCXfsjXRVO1nEMh9RmtR79tjG9M/+Ef4hHu4FL1f5F5GZB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426085; c=relaxed/simple;
	bh=Cn5Q0tE0K7epzyr3Pzg2/BDRDT9qsqOrm6Fbx0RQL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYwCOvaj2SjJgxXcx4vLd0SL/Fxu8TSWOH5fhQo9n8bhMs+akKqOnQPy5PZOu6AuGl/UGa1VdaW5CTJFAFDd0epG4J5i4WDjyNpoi8d24CzlKMnYxObCaaJIDoPhOnyEyvnw1KcT+QnYT+QyEhoOcC/0PQKC5YrlwHfYupniwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DW0DRmnm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708426084; x=1739962084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cn5Q0tE0K7epzyr3Pzg2/BDRDT9qsqOrm6Fbx0RQL2I=;
  b=DW0DRmnmzg1Bn5nPwiB01gydHbEL40aGWd+wRCAY+LOD1qo44sU9TACy
   OJY1QRIr0n29BkXrlvCJaffZ0PYqWnKvY8/y6YnxNC2PLgCcZf7qqmmvL
   9AnusV7czN1C2PcubcP9uFEslyEqARzrFV9tyIuT15HqinK2y0npqnoPY
   atacGauJ8NudSrZYEJI2sTrC5ScjGUYifL/T+JY/5ACru+9p+mAW/p91F
   oO6JwoQe1NIS+44mGvBGl0bQSQ2JdAbUPfzbVTr7BqCDX+A9Y/EIAz2z4
   lPddWqrXpQ2SNKMaRCbWXJ6xYs6vYmkQEhSHOSpebj1ttykaDRdjgltrb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="24980676"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="24980676"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913053326"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913053326"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:47:59 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3782A11F7E1;
	Tue, 20 Feb 2024 12:47:57 +0200 (EET)
Date: Tue, 20 Feb 2024 10:47:57 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add galaxycore,gc2145 DVP
 bus support
Message-ID: <ZdSDXQg2UDPvvSh6@kekkonen.localdomain>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
 <20240217220308.594883-2-andrej.skvortzov@gmail.com>
 <ZdSC_xulFQ84TtLT@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdSC_xulFQ84TtLT@kekkonen.localdomain>

On Tue, Feb 20, 2024 at 10:46:23AM +0000, Sakari Ailus wrote:
> Hi Andrey,
> 
> Thanks for the patchset.
> 
> On Sun, Feb 18, 2024 at 01:03:07AM +0300, Andrey Skvortsov wrote:
> > Don't require link-frequencies like it's done for ov5640, that
> > supports both CSI-2 and DVP. And v4l2_fwnode_endpoint_alloc_parse
> > ignores link-frequencies property for DVP endpoint. It's used only for
> > CSI-2 endpoints
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  .../bindings/media/i2c/galaxycore,gc2145.yaml | 33 +++++++++++++++++--
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > index 1726ecca4c77..fb376b9d0f2a 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > @@ -61,9 +61,6 @@ properties:
> >          properties:
> >            link-frequencies: true
> >  
> > -        required:
> > -          - link-frequencies
> 
> That seems like a bad idea to me.
> 
> While for parallel interface it may not be often important, for CSI-2 it
> should stay.

You're also missing the bus-type property which should default to CSI-2
D-PHY.

-- 
Sakari Ailus

