Return-Path: <linux-kernel+bounces-55282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32884BA2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EBF286B30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BB134CC0;
	Tue,  6 Feb 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S/AOz21X"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0712E1E9;
	Tue,  6 Feb 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234854; cv=none; b=P4Hq4C7nwws/sJgFLeKLuTojDI0IF/wEeRbv1ayzjTEnO/4bXiKSRVs4vcPsOaAYs1q9ZHPd453skKiYB3bv3qA3e5kTbVLHUCXq/FxaR1yBElZJMAZY1QP55w/nupL3DO9v4U+00gV8N3Fk1ax5Giipwd2/8PQHcCisPrzq7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234854; c=relaxed/simple;
	bh=kQhsrTRwdHJ9NWwS8cGdFIDk12FxEBq7Mik2i9lD4q0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0Hhr4h7doir+XZzHICAV8evV2PPQALl6EuuKVq6HfjZARDu0XXhmTcXMABvwUt7sTrIlPbrmKVh5bCu1wvneel29se2WSbgiF12J+nQ7+cvh45ZvPPE6MBNHWTmimNCAudiDRxi9qVyZV10X01gVwowOfxKCqxPM4pjRytxfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S/AOz21X; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416Fs3tQ123333;
	Tue, 6 Feb 2024 09:54:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707234843;
	bh=ZCan28bMKu4/QLOXWI8DFZSRkG92ndMcg10Of7DyJDw=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=S/AOz21XpWPP7fWql4RI0GltgVvT5o32mikL8S7M30PdvWuKvguh3InIR18EiTB6U
	 6H/+s4rH0Ao3gUoB1Sb8DbV6lSw0y/LZpmcukq9bJYgaE/xMSP1TP/XPq0o4+Fr1jn
	 ef3AR/yxXJIjsJDeVCp0JvhXJWwhs0ownSEbqMi0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416Fs3o7063174
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 09:54:03 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 09:54:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 09:54:03 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416Fs23g018189;
	Tue, 6 Feb 2024 09:54:02 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, CHANDRU DHAVAMANI <chandru@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <a4fdbcfe-e0e0-4280-8638-e39b6b46778e@ti.com>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
 <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <c5b6bd1d-dbb4-4bfb-8b3e-9b0733e2ba5d@ti.com>
 <c2b7f22d-f07d-4cac-8a01-af7b014e7ff4@ti.com>
 <a4fdbcfe-e0e0-4280-8638-e39b6b46778e@ti.com>
Date: Tue, 6 Feb 2024 21:24:01 +0530
Message-ID: <87ttmly4fa.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

"Kumar, Udit" <u-kumar1@ti.com> writes:

>>>>> get_freq is a bit expensive as it has to walk the clock tree to find
>>>>> the clock frequency (at least the first time?). just wondering if
>>>>> there is lighter alternative here?
>>>>>
>>>> How about get_clock? Doesn't read the registers at least.
>>>
>>> Said API needs, some flags to be passed,
>>>
>>> Can those flag be set to zero, Chandru ?
>>
>>
>> get_clock doesn't require any flags to be passed.
>
>
> May be firmware does not need it but=A0 I was referring to
>
> https://elixir.bootlin.com/linux/latest/source/drivers/clk/keystone/sci-c=
lk.c#L78
Just took a look,

I now understand the reason for confusion,

#define TI_SCI_MSG_SET_CLOCK_STATE	0x0100
#define TI_SCI_MSG_GET_CLOCK_STATE	0x0101

cops->get_clock =3D ti_sci_cmd_get_clock;  --> refers to
TI_SCI_MSG_SET_CLOCK_STATE
That's why we are passing the flag from linux for get_clock

Linux is using terminology of get/put.

As Chandru pointed, we don't have to pass flags, cause he is refering
to TI_SCI_MSG_GET_CLOCK_STATE

Below functions passes TI_SCI_MSG_GET_CLOCK_STATE to DM, which is what
we actually want.
cops->is_auto =3D ti_sci_cmd_clk_is_auto;
cops->is_on =3D ti_sci_cmd_clk_is_on;
cops->is_off =3D ti_sci_cmd_clk_is_off;

Which should be safe to call, Chandru can confirm.

Regards,
Kamlesh
>
>
>
>>
>>
>>>
>>>
>>>> Regards,
>>>> Kamlesh

