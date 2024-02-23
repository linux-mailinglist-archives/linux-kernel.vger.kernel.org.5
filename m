Return-Path: <linux-kernel+bounces-77968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB63860D78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0301C23159
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFA1B59C;
	Fri, 23 Feb 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FMWnDQCI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7C1864C;
	Fri, 23 Feb 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679081; cv=none; b=lIZtNhxinl+Zb636K1MFAXDgrDJ4nu2Xh9wS2ETaf/4atwH935d732/1MN29hlVNxcrw+hcGsD1WLD/PGD+z1rvJ6GJzSPmLaAS5dGYWsNgp86lGhgD+PrckmJMPB+k09oo8knB1jdCpL7wV7SsHl45hruQkSpHN6Ek6nHGhAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679081; c=relaxed/simple;
	bh=TQspUFQIuS/lSdvzU4xISypGBS54MESafBqD3EWI+Tw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxBjvNP7I9jwaGDp8xSed8Ak5p7vB405XlcvVXS7ntE/2y9eMySzyYAeYe6k74jk+xeezL7A0sfewlFYSw5JkD+zM6l2cW3qx+6eWGljsniHYMX0eFMAQeh62Ko8zQJcHpf+jUjc9sDeQuRif9S4VSy6PX/Z7Fi4E1yqLC45M6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FMWnDQCI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N94CTN079911;
	Fri, 23 Feb 2024 03:04:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708679052;
	bh=MV0WiK50sWpN/D2ImeC0rSquTMqXvPnv7oAy3Kp3On8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FMWnDQCIfisZAGk69C4E8+umZIj282DKybEUJATKNTRPywDjTxwlUV4TFvhNbrOAt
	 yLBzWAyA2r9pSy/MuO6zFoz3xAe5lSTBusQeL2x2MhvnpUZHW7v7s4uydcHFpSvEO8
	 KPRWyBLNs9F1oIwV05gMSU6ipLVNEqCDrGZsubkc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N94CQE013247
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 03:04:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 03:04:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 03:04:11 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N94Bs1027980;
	Fri, 23 Feb 2024 03:04:11 -0600
Date: Fri, 23 Feb 2024 14:34:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland
	<mark.rutland@arm.com>, <andersson@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] firmware/psci: Move psci_init_system_suspend() to
 late_initcall()
Message-ID: <20240223090410.mgsu47wqinw33wep@dhruva>
References: <20240219-suspend_ops_late_init-v1-1-6330ca9597fa@quicinc.com>
 <ZdOP5oAwZvEhNAsn@lpieralisi>
 <dc16acc1-6ad1-4a81-8eeb-aadaf837ff2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc16acc1-6ad1-4a81-8eeb-aadaf837ff2c@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 20, 2024 at 11:18:39 +0530, Maulik Shah (mkshah) wrote:
> 
> 
> On 2/19/2024 10:59 PM, Lorenzo Pieralisi wrote:
> > On Mon, Feb 19, 2024 at 03:02:04PM +0530, Maulik Shah wrote:
> > > psci_init_system_suspend() invokes suspend_set_ops() very early during
> > > bootup even before kernel command line for mem_sleep_default is setup.
> > > This leads to kernel command line mem_sleep_default=s2idle not working
> > > as mem_sleep_current gets changed to deep via suspend_set_ops() and never
> > > changes back to s2idle.
> > > 
> > > Move psci_init_system_suspend() to late_initcall() to make sure kernel
> > > command line mem_sleep_default=s2idle sets up s2idle as default suspend
> > > mode.
> > 
> > Why can't we fix it the other way around, namely enforce
> > mem_sleep_current according to the mem_sleep_default command line
> > even if suspend_set_ops() was already called ?
> 
> yes, this may be fixed other way also and i did not implement other way
> since mem_sleep_default_setup() only update mem_sleep_default and to avoid
> this race, it needs to also need to update mem_sleep_current along
> with it. Below change also resolves the issue.
> 
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -192,6 +192,7 @@ static int __init mem_sleep_default_setup(char *str)
>                 if (mem_sleep_labels[state] &&
>                     !strcmp(str, mem_sleep_labels[state])) {
>                         mem_sleep_default = state;
> +                       mem_sleep_current = state;
>                         break;
>                 }
> 
> however it may be erasing thin line between mem_sleep_default v/s
> mem_sleep_current as both gets updated while set up of mem_sleep_default.
> 
> if this change looks Ok, i can send v2 with it.

Honestly, I don't see too much of a problem with this, it only makes
sense that we're starting off with a default sleep state which means
that it will be considered as "current" sleep state.

For the issue that you described originally, I think this is a fine
solution.

> 
> > 
> > Just asking, I am not super keen on using initcalls ordering, it
> > looks fragile to me.
> 
> i agree with above.

Same.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

