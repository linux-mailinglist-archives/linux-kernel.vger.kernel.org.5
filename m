Return-Path: <linux-kernel+bounces-104065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FC87C878
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A31C22054
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FA8FC0E;
	Fri, 15 Mar 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h2VzbmDF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79482DF51;
	Fri, 15 Mar 2024 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710479922; cv=none; b=oSXATy/6UzeA206fQvu2PPd8bD7aoAjGEKR6G/FWOU2GjuuX2dwFPvCzALDKj23gEXG6VhFzBXhC4TBOL0KmCZ+QdWBoZ+zl4gh1qABJdbVLdgIDcFreQebBWSH10d/bqk2VoWKxyOBaSpJgEYR43zsAcs4PKDiR+LYrml0KyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710479922; c=relaxed/simple;
	bh=TSz4q8e/Myls9muHOuA/XK18sKxVwAOYsfHI0Wa8g9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBmHfz2N4DxICpPvWNrPSs5IkeIfLcx0fspFP6LuGg6VQ6E8I9WpPrcgX7OGfiGF34nnNtDQdz6JujeHWP96FvHq+gAr0FPGxaBUFlT99BlaFWHOmhDrg28R4HuqQoGZSXoGjd7z9mTPalkXMjEFw8jI2kAF6um0mnzcWdL3xVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h2VzbmDF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42F5IUGs031512;
	Fri, 15 Mar 2024 00:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710479910;
	bh=+uRwraEU6FERBoY5E3KjHdKwfwbFVLOB11FlY+czH7M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=h2VzbmDFdeo4YjlCcUw8WYTfIPMjHiD6TvUxSbwYDOuJri8z2swlRu0UtctzS33h1
	 IUx6t2cg/Yn777Ze0yC9qVcpLLk729zDRlKAKeR7KwTVNHw3dXrgpxbPEfUNPsMnCV
	 v0KJbsvIEyXZxo+xEd14UfS/q1xD7pEbS2xLhlOU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42F5IUju117317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Mar 2024 00:18:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Mar 2024 00:18:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Mar 2024 00:18:30 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42F5ITLx025481;
	Fri, 15 Mar 2024 00:18:29 -0500
Date: Fri, 15 Mar 2024 10:48:28 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, <theo.lebrun@bootlin.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: wakeup: Add a missing return case in init_wakeup
Message-ID: <20240315051828.su2qx57ecyhv3up3@dhruva>
References: <20240314075429.1164810-1-d-gole@ti.com>
 <CAJZ5v0iUt+tudMV-rJ80GR6iNQVv06+054h0UyNgpEOUF6QLRQ@mail.gmail.com>
 <20240314151846.u3r3eaklrl3hf7pi@dhruva>
 <CAJZ5v0gwkKa+AYgOwydzsKjo=_M56t88PwVo7R+fe-53abAdVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gwkKa+AYgOwydzsKjo=_M56t88PwVo7R+fe-53abAdVw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 14, 2024 at 16:29:36 +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2024 at 4:18 PM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > Hi,
> >
> > On Mar 14, 2024 at 15:01:36 +0100, Rafael J. Wysocki wrote:
> > > On Thu, Mar 14, 2024 at 8:55 AM Dhruva Gole <d-gole@ti.com> wrote:
> > > >
> > > > The device_wakeup_disable call can return an error if no dev exists
> > > > however this was being ignored. Catch this return value and propagate it
> > > > onward in device_init_wakeup.
> > >
> > > Why does this matter to the callers of device_init_wakeup()?
> >
> > If atall !dev->power.can_wakeup then the caller should know something is
> > funny right?
> 
> What would the caller do with this information?
> 
> They attempted to disable wakeup on a device that doesn't exist or is
> not wake-capable, and so what?

Using drivers/char/hw_random/xgene-rng.c as an example, we can atleast
print a warning or something to make the user aware of an unclean state.

Is the argument here that if the caller can't do anything meaningful
then what's the point of returning any error?

If so, then my preference would be just to propagate as much information
upward from the stack whether the caller can make use of that error and
in what way is upto the caller, if nothing else then even a warn or
error print is still useful piece of information.

However if it's useless to return anything from device_wakeup_disable
then we might as well make that function a void or something and avoid
any confusion as to if there's any point in returning error at that
point.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

