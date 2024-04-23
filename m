Return-Path: <linux-kernel+bounces-155831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD58AF7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C94284014
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99C1422DD;
	Tue, 23 Apr 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KhVPfI7u"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1813DDB4;
	Tue, 23 Apr 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902475; cv=none; b=Y9Og1y6iKnZrr/aWXbGssGpNKELPPsdE8pPI4KSWG44j0/WWG6OaQqWkd15E1hBdsMYhBxToV+QHI7kOdOEo/beeMvWfnyk+cw4Tf39TiCAxArP6In2jbVZlGjwYQNxE8jJo7Qvk77lNXs6JQR9/vfQ6dyGkhdnneCkV8/gLFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902475; c=relaxed/simple;
	bh=gO5lInamXWvVwcjXwapFzG1P6LElJDaUQgLFUsX3OeM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP1auYT/GTe5dq04be15TVNCkrxkdgqYgSfTbfQKg6epCCPw81M5PGNbV8F7QDI3R9zFOMzjUZBU+UC1Qt8XIGTsLOB54GO4KGbnjjP+/ibp6MYObiONzaglkn8Tthr7XMCmyEaneF1FjYYBtRo5lMTGOrR9SBSihZHxO8CDaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KhVPfI7u; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NK0qRq029453;
	Tue, 23 Apr 2024 15:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713902453;
	bh=RhWga2NMvhF/Z3yJFrEOYdpiLpVUvGsPvXj1UVjFcxI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KhVPfI7uktlq4ZJ2LQ70R+N7H1jvE7fZZdF7pd/o07tjpDkiUr6ptY1JP8FBrKDZl
	 64O/wMl03Yv7q8ws/YUVOSSRP1+ecPECUeyMmGAmlhPHKsYkz4q4avXr9IB7nJNX4l
	 FrylrwIW1WF3jPVXxfpGzmfTE3VNjVafSFAhTo7k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NK0qSa096891
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 15:00:52 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 15:00:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 15:00:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NK0qTX004163;
	Tue, 23 Apr 2024 15:00:52 -0500
Date: Tue, 23 Apr 2024 15:00:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: Andrew Davis <afd@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring
	<robh@kernel.org>, Jared McArthur <j-mcarthur@ti.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Message-ID: <20240423200052.fmias3xcapm3t57r@bring>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
 <1a5e719f-efa0-4c60-8add-ef7c0464d1ce@ti.com>
 <CAOCHtYjHhH2M_+7md-e2vh_d_3H2r66OhXEp2acd0D+6O+uwcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYjHhH2M_+7md-e2vh_d_3H2r66OhXEp2acd0D+6O+uwcg@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:48-20240423, Robert Nelson wrote:
> On Mon, Apr 22, 2024 at 3:57 PM Andrew Davis <afd@ti.com> wrote:
> >
> > On 3/28/24 2:12 PM, Robert Nelson wrote:
> > > This board is based on ti,j722s
> > >
> > > https://beagley-ai.org/
> > > https://openbeagle.org/beagley-ai/beagley-ai
> > >
> > > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > > CC: Rob Herring <robh@kernel.org>
> > > CC: Nishanth Menon <nm@ti.com>
> > > CC: Jared McArthur <j-mcarthur@ti.com>
> > > CC: Jason Kridner <jkridner@beagleboard.org>
> > > CC: Deepak Khatri <lorforlinux@beagleboard.org>
> > > ---
> > >   Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > index 52b51fd7044e..ca23b7e6a35e 100644
> > > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > @@ -134,6 +134,7 @@ properties:
> > >         - description: K3 J722S SoC and Boards
> > >           items:
> > >             - enum:
> > > +              - beagle,j722s-beagley-ai
> >
> > Recommend "beagle,am67-beagley-ai". The "J722s" is the family
> > name, the part used on this board is the AM67. We do the same
> > for the SK boards, for example, the SK-AM69 uses the AM69
> > part from the J784s4 family, so it is called k3-am69-sk.dts
> > with compatible = "ti,am69-sk", "ti,j784s4";
> >
> > This would otherwise be the first board with a specific part
> > attached but uses the SoC family name instead of that specific
> > part name in the DT file/name. Only the EVMs should have the
> > family name since we sell versions of those with all the different
> > parts swapped onto it. I don't imagine you will be selling
> > BeagleY's with TDA4VEN, TDA4AEN, DRA82x, etc.. All your
> > docs and other collateral use "AM67", using the same here
> > would help avoid confusion.
> >
> > Andrew
> 
> Andrew, would you like us to model this just like the AM69-SK? and
> also rename the device tree? or just the bindings..
> 
> k3-j722s-beagley-ai.dtb -> k3-am67-beagley-ai.dtb or even the am67a
> k3-am67a-beagley-ai.dtb ?
> 

Will drop these patches off the queue for now. please respin as needed.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

