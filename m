Return-Path: <linux-kernel+bounces-59855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE784FC96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A8B2BA91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4280BF2;
	Fri,  9 Feb 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oOcBYN0d"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05E43148;
	Fri,  9 Feb 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505364; cv=none; b=YGoKOm7BH8CO3f4Q041/E+v4PKWj7QPGAujfKxIYaW+i7tPc2Ay/DYzur2v0cVZCt+KNUPA+Soo3u8JgFwpC9Gqh7ix/xifjpU7QL9q+Dl8H3XoDrPMQOM4GBv5Q3pyKZni9BthP4bcqKSKrZwtiKBzl+8aUGP8/c5K/isyUliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505364; c=relaxed/simple;
	bh=x8uQYqZI+N7og1QpHJ/1uyIDzmqPOkXGHzphPLm8/X0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv6E/XVLS+fYsMSET+iN0Gtb3RV5OyXDHxchOK82ANLXo3bvalEyJrf3Semm/z5SlaT7yJGJ2X6ulbsTXGz8X28C2Fj4QtQObe6AkuzjH8Nwe2NFw3mEAiK4erWWA23b3Qs3T8+beB2Qy7m092LNjdLEqWgPbZSjl5W9tLCgKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oOcBYN0d; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419J2SYe103057;
	Fri, 9 Feb 2024 13:02:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707505348;
	bh=tZ4wb1vqLQzLJ/2I94UyZzE0C21f3pHsPwQpBOLxMMM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oOcBYN0dhrskMXoQ3859F78yI7ShYNnYtlXpADGgcsVNj1oCKzMFU08aAt5Y37YmD
	 CceXDGPkMqs33NhBmw6yn1ac5iLLLg1aQnn540LDQWouH9DOptdsizXttsqKSwOTu+
	 2EWM2bjgX8ISnhUzqk65Z5ShpPNUus86kYRQ4O/g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419J2SfS114492
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 13:02:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 13:02:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 13:02:27 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419J2Rr5002005;
	Fri, 9 Feb 2024 13:02:27 -0600
Date: Fri, 9 Feb 2024 13:02:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <chandru@ti.com>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240209190227.lboi6n5s2oy7kxgc@pristine>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240207125410.r2q3jcplvif7dvt2@tumbling>
 <3a7c4a18-5463-414f-82df-39aaed861148@ti.com>
 <20240209172555.fxlxijhhbgrkyibo@agreeing>
 <87y1btlb66.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y1btlb66.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 00:25-20240210, Kamlesh Gurudasani wrote:
> >> > > 
> >> > > diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> >> > > index 35fe197dd303..31b7df05d7bb 100644
> >> > > --- a/drivers/clk/keystone/sci-clk.c
> >> > > +++ b/drivers/clk/keystone/sci-clk.c
> >> > > @@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
> >> > >   	struct sci_clk *sci_clk, *prev;
> >> > >   	int num_clks = 0;
> >> > >   	int num_parents;
> >> > > [..]					/* Check if this clock id is valid */
> >> > > +					ret = provider->ops->is_auto(provider->sci,
> >> > > +						sci_clk->dev_id, ++clk_id, &state);
> >> > A bit too nice coding ;) => I had been confused momentarily by clk_id = args.args[1]
> >> > change just above till I saw that you are pre-incrementing
> >> > clk_id - Is there a harm in leaving the original clk_id increment logic
> >> > alone (it was much simpler to read up)?
> >> 
> >> No warm in using original code but want to avoid, two statement for
> >> increment in case of failure and success.
> >> 
> >> Let me know, if i need to add few comments around this
> >> 
> >> or if you think, code is confusing I can move to original one
> >
> > Yes, please drop the un-necessary changes. In this case, original
> > increment code should work just fine.
> I wouldn't call it unnecessary, If I have to track increment/addition at
> 3 different places just to understand the loop, it is hard. On other
> hand, pre-increment code is solving the problem by having increment at
> only one place(easier to track). On the plus side, every clk_id belonging to
> parent is handled completely inside the loop.
> 
> For a new person looking at this code, pre-increment code would be
> actually easier to undertsand.
> 
> Also, Udit feels the same.
> 
> Would you please explain why do you think the original increment code
> make more sense? It's not simple to understand or track, that's for sure.

the context of the fix is the is_auto call to know what parent options
are valid or not. Do the absolutely what is necessary in the change. if
you want to beautify etc, move it to some other patch and debate about
it. So, this is un-necessary change in this patch.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

