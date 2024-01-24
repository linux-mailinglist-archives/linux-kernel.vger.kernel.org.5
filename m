Return-Path: <linux-kernel+bounces-37483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF583B0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939221C22A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BD129A83;
	Wed, 24 Jan 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yyy7si/E"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA703128366
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119506; cv=none; b=RqQ9I2kujyuXFlXwIEw08y6cH0qTP3hLXrVRaQiLqPgcGw/hMtWgDKPhU+aHf1MNv9mYthOEo77eZpk51fERNvkPUVTyj1honosjMgmZovqpQwx6ek81ViwkpeJym76aLOwbDkWVULZVQtQIstuhrlyMNx/u95kQSzL/DfPDhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119506; c=relaxed/simple;
	bh=EHFytkA9/AUK/9/fyphVcZ9FCOe+Qx74C8fWBE+TGR4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG5kVnxLI1GLhV5L4VJzwB2vIhwXf1q1eNvuPauw+OvET0gjnlBhPwf15BIXRTfpQ/iXtn0dqsK7QkQ7y9dQkhxoEFKwNZfO/2InfGUrvyvFHgtSQtBKVKDvMuJh4gjzjDWYGVs8Ulte0SwiJNeQHPW6BhZAe5wS/DuE1jheMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yyy7si/E; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OI4pfR065404;
	Wed, 24 Jan 2024 12:04:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706119491;
	bh=8Y47hwA1gWaE4gN7rYHwLzLwXq44cFa44BxBygpadzU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yyy7si/E4Jelo6E7MAXuxGF7P9qGZRFzHghZhMsyittNDxSIs0Wq8cHRkieUf6yDp
	 RPw8ZGg/x36OELl0GdyaQ2fSj0ZwV8hGnBYT5FSMbblxSJbXYO0tjJEbQ/YJLRABRy
	 GnSEbnxztm02F9vI1Qtpw3DV323yb8PoSN71L3HQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OI4pVk007466
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:04:51 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:04:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:04:51 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OI4ppm104258;
	Wed, 24 Jan 2024 12:04:51 -0600
Date: Wed, 24 Jan 2024 12:04:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: configs: keystone: Remove this defconfig
Message-ID: <20240124180451.bptuhldi44leulr3@pectin>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124162857.111915-2-afd@ti.com>
 <20240124164116.k5ah56xvuclfkxdr@despise>
 <0ab47165-3ba3-4d34-aea0-9bc12fd5ff31@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ab47165-3ba3-4d34-aea0-9bc12fd5ff31@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:31-20240124, Andrew Davis wrote:
> On 1/24/24 10:41 AM, Nishanth Menon wrote:
> > On 10:28-20240124, Andrew Davis wrote:
> > > TI Keystone devices can and should use the common multi-v7 defconfig.
> > > Currently it is not clear which defconfig should be used and so config
> > > options for Keystone boards are added to either both defconfigs, or only
> > > one or the other. As nice as it is to have a config just for this platform
> > > it is a maintenance burden. As it is not used by generic distros it is not
> > > very useful to continue to maintain. Remove this defconfig.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >   arch/arm/configs/keystone_defconfig | 238 ----------------------------
> > >   1 file changed, 238 deletions(-)
> > >   delete mode 100644 arch/arm/configs/keystone_defconfig
> > > 
> > 
> > There are a bunch of downstream folks who will have recipe fails etc if
> > we do that. I am not sure we need to go down that route.
> > 
> 
> That is the point of this patch, we want to stop any remaining downstream
> folks from using this defconfig. It is not maintained nor updated like
> the multi_v7_defconfig, any new or needed options will only be added to
> multi-v7 defconfig.
> 

I am going to have to defer to ARM maintainers what they think..
enabling LPAE etc in common multi_v7_config.

--
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

