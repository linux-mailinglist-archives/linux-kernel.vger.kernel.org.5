Return-Path: <linux-kernel+bounces-98457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42092877A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E1C1C20D53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51397489;
	Mon, 11 Mar 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jvc38W8i"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD47462;
	Mon, 11 Mar 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131982; cv=none; b=SzLcznAIYXRdmq4lwmTCXsvEp4AOW8URpBXCrxtaCEuUb2sRtPF2Xh4BlZ+GPzTPllLBxaea5iNbF/hgiFhKt60Zr3hM1gccPXETFSwkQLsgEgOUUKHgTR+mACA/tI65LiOmolm9ZkPMJph1UF4hOIQaBJf69GF/nNbaUMynX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131982; c=relaxed/simple;
	bh=4Ibi4H07VxgPlyDobBtS4MyrMdnJ8VwUnqQ3QlPghtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfwhqT/xUFn4RpUJlJndqiWqbPuO0y/Dssh5nYQZBKj2VBrrlfKk09xciAAdZFRSViyJIAuzgqpWhELZfP2i5ET29we8CB/HqmxcDp6MudiZ3FuFo/MfKcYpOSFvyrR+xwIWp1wm/xNpy+zundx2J5Cc9ieNUNpydA2Jz9CWDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jvc38W8i; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42B4dTCr003622;
	Sun, 10 Mar 2024 23:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710131969;
	bh=a6RuBo2ZSc5PPvT8dADMxZcpKorsZU59gBI/y+TA4+M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Jvc38W8iNSFtaGZZVkpQfyUl2Ni14H9BeFDO5Pnwn3/01QHDeA0v9f3b/hhlx69kh
	 FLYkRX/hAWOR6yN9pnPdCpoRHoc8k9J7Zjs+XebvcTS3kBWFsL6BvveG9SlvQj20xT
	 Jikedaf68KYIdcwgP+SRQQrh1tLJ4OleRYMG7HMY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42B4dT80056249
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Mar 2024 23:39:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Mar 2024 23:39:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Mar 2024 23:39:29 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42B4dSX3024733;
	Sun, 10 Mar 2024 23:39:28 -0500
Date: Mon, 11 Mar 2024 10:09:27 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Saravana Kannan <saravanak@google.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <kernel-team@android.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: power: Fix typo in suspend and interrupts
 doc
Message-ID: <20240311043927.il77znubaymo3rhd@dhruva>
References: <20240308224450.2327415-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308224450.2327415-1-saravanak@google.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 08, 2024 at 14:44:50 -0800, Saravana Kannan wrote:
> Typos are bad. Fix them.

Maybe a little more description that you s/by/but would've also made
things more clear?

> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/power/suspend-and-interrupts.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/suspend-and-interrupts.rst b/Documentation/power/suspend-and-interrupts.rst
> index dfbace2f4600..f588feeecad0 100644
> --- a/Documentation/power/suspend-and-interrupts.rst
> +++ b/Documentation/power/suspend-and-interrupts.rst
> @@ -78,7 +78,7 @@ handling the given IRQ as a system wakeup interrupt line and disable_irq_wake()
>  turns that logic off.
>  
>  Calling enable_irq_wake() causes suspend_device_irqs() to treat the given IRQ
> -in a special way.  Namely, the IRQ remains enabled, by on the first interrupt
> +in a special way.  Namely, the IRQ remains enabled, but on the first interrupt
>  it will be disabled, marked as pending and "suspended" so that it will be
>  re-enabled by resume_device_irqs() during the subsequent system resume.  Also
>  the PM core is notified about the event which causes the system suspend in
> -- 

Anyway, changes LGTM!

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

