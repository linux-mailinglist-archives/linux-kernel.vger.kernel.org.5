Return-Path: <linux-kernel+bounces-59730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9F784FAFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4B28936E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CA7C0A9;
	Fri,  9 Feb 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qbxvAUFK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9576414;
	Fri,  9 Feb 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499577; cv=none; b=dA/W8ERL7yP72PrxO2SMereiQJSq5ExWjXB1wuEjUSxQgL83y9DXDWitAfSUynLYJcQpT+v26NeC1fOiIVn4T71k2U6mB1Xd06aWFhGOOHfnTzkF+dHmBeTRq3eKs8ERlrW9siLcE8qaJdccudNgIPvPvvqFDbp1iVlKTGhEhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499577; c=relaxed/simple;
	bh=ie5ldj9yiN5heSZ1zRAjnTvccO7uZDnrTmVr98yTE04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3/YeU7K4TuqhAkhw8i05Y3sM7VBYUfWD92X2BJnaE5luNu4qQI29UOwLFjSV/u3SNcbW7amt3bMm6SvYqNAjDTJpZbF47h8zSfmC1J3AhrFlR1+IB5yvH4m3/k8i0e1BWj4Syle4qyYsKcfe8yJ3Sx+Wx5dBVhdqn05LBzd28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qbxvAUFK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419HPtq9027981;
	Fri, 9 Feb 2024 11:25:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707499555;
	bh=o/yHIEvgh2LRKD3q5Z1jqyyrArHXgL1I3+o2CJJSOiI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qbxvAUFK3+CMJemxeZkMJm7kaneX+IrQQ6sdbs/KBn32b83WOYrcPq/Gtlhs66rJ5
	 baPk94KBCfjzmlyZZcayIUSP1B64qYjooypHx10NKEKbjkHfdRSCn8XQ5TQhZWx8NH
	 HWY6gsa23a5FTrbWjvtMGoGZfycPy5l5EafmNxhY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419HPtNo002091
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 11:25:55 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 11:25:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 11:25:55 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419HPt5I126337;
	Fri, 9 Feb 2024 11:25:55 -0600
Date: Fri, 9 Feb 2024 11:25:55 -0600
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240209172555.fxlxijhhbgrkyibo@agreeing>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240207125410.r2q3jcplvif7dvt2@tumbling>
 <3a7c4a18-5463-414f-82df-39aaed861148@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7c4a18-5463-414f-82df-39aaed861148@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 19:53-20240207, Kumar, Udit wrote:
> Hi Nishanth,
> 
> On 2/7/2024 6:24 PM, Nishanth Menon wrote:
> > On 14:41-20240207, Udit Kumar wrote:
> > > Most of clocks and their parents are defined in contiguous range,
> > > But in few cases, there is gap in clock numbers[0].
> > > Driver assumes clocks to be in contiguous range, and add their clock
> > > ids incrementally.
> > > 
> > > New firmware started returning error while calling get_freq and is_on
> > > API for non-available clock ids.
> > > 
> > > In this fix, driver checks and adds only valid clock ids.
> > > 
> > > Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
> > > 
> > > [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> > > Section Clocks for NAVSS0_CPTS_0 Device,
> > > clock id 12-15 not present.
> > > 
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > > ---
> > > Changelog
> > > Changes in v3
> > > - instead of get_freq, is_auto API is used to check validilty of clock
> > > - Address comments of v2, to have preindex increment
> > > Link to v2 https://lore.kernel.org/all/20240206104357.3803517-1-u-kumar1@ti.com/
> > > 
> > > Changes in v2
> > > - Updated commit message
> > > - Simplified logic for valid clock id
> > > link to v1 https://lore.kernel.org/all/20240205044557.3340848-1-u-kumar1@ti.com/
> > > 
> > > 
> > > P.S
> > > Firmawre returns total num_parents count including non available ids.
> > > For above device id NAVSS0_CPTS_0, number of parents clocks are 16
> > > i.e from id 2 to 17. But out of these ids few are not valid.
> > > So driver adds only valid clock ids out ot total.
> > > 
> > > Original logs
> > > https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
> > > Line 2630 for error
> > > 
> > > Logs with fix v3
> > > https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9#file-v3
> > > Line 2586
> > > 
> > > 
> > >   drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> > > index 35fe197dd303..31b7df05d7bb 100644
> > > --- a/drivers/clk/keystone/sci-clk.c
> > > +++ b/drivers/clk/keystone/sci-clk.c
> > > @@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
> > >   	struct sci_clk *sci_clk, *prev;
> > >   	int num_clks = 0;
> > >   	int num_parents;
> > > [..]					/* Check if this clock id is valid */
> > > +					ret = provider->ops->is_auto(provider->sci,
> > > +						sci_clk->dev_id, ++clk_id, &state);
> > A bit too nice coding ;) => I had been confused momentarily by clk_id = args.args[1]
> > change just above till I saw that you are pre-incrementing
> > clk_id - Is there a harm in leaving the original clk_id increment logic
> > alone (it was much simpler to read up)?
> 
> No warm in using original code but want to avoid, two statement for
> increment in case of failure and success.
> 
> Let me know, if i need to add few comments around this
> 
> or if you think, code is confusing I can move to original one

Yes, please drop the un-necessary changes. In this case, original
increment code should work just fine.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

