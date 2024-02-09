Return-Path: <linux-kernel+bounces-59838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0784FC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E8C1F223A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243E81ACB;
	Fri,  9 Feb 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ua2s416p"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BA50241;
	Fri,  9 Feb 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504960; cv=none; b=MOAu86qaxeLLAH+LhXXFJdbiAKmWa9YVEFH/fdYwIw16tfmPQc0qv7POMK6f69VtS0FRbeliaXNq4Eq5viaY8MW82UmwTecmlKrTWk9uWsTxMRiK0e/ut3Ws7f6pJNVEMQG8Pybj4OCKdTQQxIjgS2nMkyWsWeuZT69eeBa0AFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504960; c=relaxed/simple;
	bh=718c/meOqiOwvZMPuz8c8BgGWyDlkajC+GqTBbpRz44=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u8FPw8wCAuBUNB17ex1FMva3ggzcGToe8yEFu5hFJRoF3P1nnta/po57ef5nD+kC0DNxlwfwJV1Sf/PxAnD9N87P319r3+Y6fSzbwmxuTObS9PNF6kLGADGettm7KF7MHHC0up//1lfdvV6os9L3icAGjZ+pIkbWvmyfNBCHLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ua2s416p; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419ItluH058094;
	Fri, 9 Feb 2024 12:55:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707504947;
	bh=ZizTx1uK/wrfr2SSrP0MYYokmhKwqiFDbgxDTx6rvbY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=ua2s416pqUvhfNJgcHeDqSKGXdJlHeCBxH8X4I/GzSK5H4OT4Av2heBnKWRfBn+hv
	 wP9j2R257WdBmbM8N9uK6mTGv/8kVrcduBR84hvTsOTzS79TE+V8KZVfsnXp5aD1ds
	 zXQ36haYvsSNj3ZzmUZpmEwBSpIlwkPxAOgiWm6c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419Itlw3118636
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 12:55:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 12:55:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 12:55:47 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419Itk1Q122386;
	Fri, 9 Feb 2024 12:55:46 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Nishanth Menon <nm@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <vigneshr@ti.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <20240209172555.fxlxijhhbgrkyibo@agreeing>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240207125410.r2q3jcplvif7dvt2@tumbling>
 <3a7c4a18-5463-414f-82df-39aaed861148@ti.com>
 <20240209172555.fxlxijhhbgrkyibo@agreeing>
Date: Sat, 10 Feb 2024 00:25:45 +0530
Message-ID: <87y1btlb66.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Nishanth Menon <nm@ti.com> writes:

> On 19:53-20240207, Kumar, Udit wrote:
>> Hi=A0Nishanth,
>>=20
>> On 2/7/2024 6:24 PM, Nishanth Menon wrote:
>> > On 14:41-20240207, Udit Kumar wrote:
>> > > Most of clocks and their parents are defined in contiguous range,
>> > > But in few cases, there is gap in clock numbers[0].
>> > > Driver assumes clocks to be in contiguous range, and add their clock
>> > > ids incrementally.
>> > >=20
>> > > New firmware started returning error while calling get_freq and is_on
>> > > API for non-available clock ids.
>> > >=20
>> > > In this fix, driver checks and adds only valid clock ids.
>> > >=20
>> > > Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynami=
cally probing clocks")
>> > >=20
>> > > [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/cloc=
ks.html
>> > > Section Clocks for NAVSS0_CPTS_0 Device,
>> > > clock id 12-15 not present.
>> > >=20
>> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> > > ---
>> > > Changelog
>> > > Changes in v3
>> > > - instead of get_freq, is_auto API is used to check validilty of clo=
ck
>> > > - Address comments of v2, to have preindex increment
>> > > Link to v2 https://lore.kernel.org/all/20240206104357.3803517-1-u-ku=
mar1@ti.com/
>> > >=20
>> > > Changes in v2
>> > > - Updated commit message
>> > > - Simplified logic for valid clock id
>> > > link to v1 https://lore.kernel.org/all/20240205044557.3340848-1-u-ku=
mar1@ti.com/
>> > >=20
>> > >=20
>> > > P.S
>> > > Firmawre returns total num_parents count including non available ids.
>> > > For above device id NAVSS0_CPTS_0, number of parents clocks are 16
>> > > i.e from id 2 to 17. But out of these ids few are not valid.
>> > > So driver adds only valid clock ids out ot total.
>> > >=20
>> > > Original logs
>> > > https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6=
#file-original-logs
>> > > Line 2630 for error
>> > >=20
>> > > Logs with fix v3
>> > > https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9=
#file-v3
>> > > Line 2586
>> > >=20
>> > >=20
>> > >   drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
>> > >   1 file changed, 10 insertions(+), 2 deletions(-)
>> > >=20
>> > > diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/s=
ci-clk.c
>> > > index 35fe197dd303..31b7df05d7bb 100644
>> > > --- a/drivers/clk/keystone/sci-clk.c
>> > > +++ b/drivers/clk/keystone/sci-clk.c
>> > > @@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci=
_clk_provider *provider)
>> > >   	struct sci_clk *sci_clk, *prev;
>> > >   	int num_clks =3D 0;
>> > >   	int num_parents;
>> > > [..]					/* Check if this clock id is valid */
>> > > +					ret =3D provider->ops->is_auto(provider->sci,
>> > > +						sci_clk->dev_id, ++clk_id, &state);
>> > A bit too nice coding ;) =3D> I had been confused momentarily by clk_i=
d =3D args.args[1]
>> > change just above till I saw that you are pre-incrementing
>> > clk_id - Is there a harm in leaving the original clk_id increment logic
>> > alone (it was much simpler to read up)?
>>=20
>> No warm in using original code but want to avoid, two statement for
>> increment in case of failure and success.
>>=20
>> Let me know, if i need to add few comments around this
>>=20
>> or if you think, code is confusing I can move to original one
>
> Yes, please drop the un-necessary changes. In this case, original
> increment code should work just fine.
I wouldn't call it unnecessary, If I have to track increment/addition at
3 different places just to understand the loop, it is hard. On other
hand, pre-increment code is solving the problem by having increment at
only one place(easier to track). On the plus side, every clk_id belonging to
parent is handled completely inside the loop.

For a new person looking at this code, pre-increment code would be
actually easier to undertsand.

Also, Udit feels the same.

Would you please explain why do you think the original increment code
make more sense? It's not simple to understand or track, that's for sure.

Kamlesh
>\
> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D

