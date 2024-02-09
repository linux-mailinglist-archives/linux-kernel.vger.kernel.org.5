Return-Path: <linux-kernel+bounces-59912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249EE84FD46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9E71F22624
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA78564E;
	Fri,  9 Feb 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wZncPceV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474E8287F;
	Fri,  9 Feb 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508880; cv=none; b=sAk65YsO7dzRoR+lqSX3halzb2/kcCidKZobrZji9nrnotoLDFX1Eh+6gsBWULzDXKJoMNLkzBMvCrVFwDMZaZNTp/R3/JFIXv0zqAB7hAZ+7Wz2idz33o4JjwdoTPzbATa2s930N7bbfvIc0x1ayIoDcSYZxeW+iaQf5DTAJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508880; c=relaxed/simple;
	bh=o/8wndvIYXCDVyptq7fP01DqP1w9rrvG4uBd7m7U/L8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERyRGBG4UOvUls0qshlkYWcDCxd2cnkLeFu8NHSsUJUEv7byhoDZywrj579mPZQDEn7+flQkEPp1ce+Yb8CIu85JNwyB0sylFPRK9Aw++jNzs573kxWo4A73LYxVT8FrL2BODEhFKnwgEW2CTk6EMTL9NF5qLClIJMD+2Sku448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wZncPceV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419K1BPA115191;
	Fri, 9 Feb 2024 14:01:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707508871;
	bh=SVASYROGxveF2vwE6Vi8wJxsEEn0nCoTyOo/LpiBJmI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=wZncPceVNlpS3o/yQVaWIttf3hJWUdzMgqX4+OC+Aft8+zd5pb6dv6oiFEn7GpoNc
	 je6dJwwkj0juPx7G+8JeOjjJR4DXg0E4+LXAkDNA06JSxwrCYLCbSETk4gnuBkLLg9
	 t/M4Scwv/OJ7jmWpV8sIW2IpAoMf0LVKy6Tsq7vs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419K1Bnf041601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 14:01:11 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 14:01:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 14:01:10 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419K1AJx003931;
	Fri, 9 Feb 2024 14:01:10 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <chandru@ti.com>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <20240209190227.lboi6n5s2oy7kxgc@pristine>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240207125410.r2q3jcplvif7dvt2@tumbling>
 <3a7c4a18-5463-414f-82df-39aaed861148@ti.com>
 <20240209172555.fxlxijhhbgrkyibo@agreeing>
 <87y1btlb66.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20240209190227.lboi6n5s2oy7kxgc@pristine>
Date: Sat, 10 Feb 2024 01:31:09 +0530
Message-ID: <87v86xl856.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Nishanth Menon <nm@ti.com> writes:

> On 00:25-20240210, Kamlesh Gurudasani wrote:
>> >> > > 
>> >> > > diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>> >> > > index 35fe197dd303..31b7df05d7bb 100644
>> >> > > --- a/drivers/clk/keystone/sci-clk.c
>> >> > > +++ b/drivers/clk/keystone/sci-clk.c
>> >> > > @@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>> >> > >   	struct sci_clk *sci_clk, *prev;
>> >> > >   	int num_clks = 0;
>> >> > >   	int num_parents;
>> >> > > [..]					/* Check if this clock id is valid */
>> >> > > +					ret = provider->ops->is_auto(provider->sci,
>> >> > > +						sci_clk->dev_id, ++clk_id, &state);
>> >> > A bit too nice coding ;) => I had been confused momentarily by clk_id = args.args[1]
>> >> > change just above till I saw that you are pre-incrementing
>> >> > clk_id - Is there a harm in leaving the original clk_id increment logic
>> >> > alone (it was much simpler to read up)?
>> >> 
>> >> No warm in using original code but want to avoid, two statement for
>> >> increment in case of failure and success.
>> >> 
>> >> Let me know, if i need to add few comments around this
>> >> 
>> >> or if you think, code is confusing I can move to original one
>> >
>> > Yes, please drop the un-necessary changes. In this case, original
>> > increment code should work just fine.
>> I wouldn't call it unnecessary, If I have to track increment/addition at
>> 3 different places just to understand the loop, it is hard. On other
>> hand, pre-increment code is solving the problem by having increment at
>> only one place(easier to track). On the plus side, every clk_id belonging to
>> parent is handled completely inside the loop.
>> 
>> For a new person looking at this code, pre-increment code would be
>> actually easier to undertsand.
>> 
>> Also, Udit feels the same.
>> 
>> Would you please explain why do you think the original increment code
>> make more sense? It's not simple to understand or track, that's for sure.
>
> the context of the fix is the is_auto call to know what parent options
> are valid or not. Do the absolutely what is necessary in the change. if
> you want to beautify etc, move it to some other patch and debate about
> it. So, this is un-necessary change in this patch.
The context of the fix i.e. handling non contiguous parents is making
the loop logic complex. Before this patch, i.e. contiguous clock
handling was simple.

In this fix, we are solving the problem as well as keeping the loop
simple. clk_id is basically the part of the same loop and it's affecting
nothing but the loop count. 

This is not just beautification, this is also simplifying the logic and
improving the readibility. 

If the patch can provide the solution and avoid the complexity, then I don't
understand why we need a patch that introduce the complexity and another
patch to solve the complexity.

My original question below is still not answered so I guess there is no
debate here actually.
"Would you please explain why do you think the original increment code
 make more sense? It's not simple to understand or track, that's for
 sure."

Kamlesh
>
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

