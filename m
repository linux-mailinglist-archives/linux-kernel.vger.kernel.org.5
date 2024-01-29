Return-Path: <linux-kernel+bounces-42160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D983FD46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80DC2854CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CF3C680;
	Mon, 29 Jan 2024 04:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zKaIKPJm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E04594F;
	Mon, 29 Jan 2024 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706503494; cv=none; b=TbRg2iH86LnqSxqKm+La4mZQA2289CMmzC8mi9gTUj29G1wyQWe/pt3QbXZEFkRhWoWhk4nWr95YOg5ZUhnp/KOAeoU98BCW2ABnc8K/RJCThVv0u7YuQwpC+0qqEUnC1AiR5X9wi/4W3PPU9tyr4yfCZj44apKkQP52VqvZPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706503494; c=relaxed/simple;
	bh=1G2xXOzQnRqJTvV0bngAqZr6EnGOPLZBeWWsv4R9G9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJukV6pR6HFszEpa9YImyZApMxSSW8VO0JDa9m08piLzk91UzJp9wViBpTdRMhRbH+witrUyfWMtleEIJAiYAHA3gSlDhPidsZ3OUotyfOfbF3HqIIY5HPFR0fccA/++NytScCSbhJ1H9Kq8NznhP8HcmMln7XzoY9RjMahs/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zKaIKPJm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40T4hV6s126265;
	Sun, 28 Jan 2024 22:43:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706503411;
	bh=Gkj/u6ClapY9kjjAsgxj3sF7rHtkAMhcSbNvQH3rZ6w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=zKaIKPJm1fiRTIzjxnrpDB26J1ykW8/irxgtQQQb3qA0LK5DRfGcjZcN0+tqoBu54
	 IEMXqtdtW2Go/In9YPqy3GGI5tj9oYBxL4hGS6upDi2Kj1Z/VIYhYbBNFB3nIX8QSi
	 n3QvuTMDR9hnaOyWge2UZNuQRjYbqDcrBAG4pq9M=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40T4hVd2079021
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 28 Jan 2024 22:43:31 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 28
 Jan 2024 22:43:30 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Sun, 28 Jan 2024 22:43:30 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>, "Xu,
 Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "P O, Vijeth" <v-po@ti.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "Chawla, Mohit" <mohit.chawla@ti.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "soyer@irl.hu"
	<soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
        "tiwai@suse.de"
	<tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
        "McPherson, Jeff"
	<j-mcpherson@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        Mark Brown
	<broonie@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Topic: [EXTERNAL] Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Index: AQHaUAwUI8E/PZj0r0in3/wm+owNo7DsJ5KAgABZ9gCAA7KFIA==
Date: Mon, 29 Jan 2024 04:43:30 +0000
Message-ID: <015abf2c43a44c478726c270bfa17fc0@ti.com>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
 <20240126035855.1785-4-shenghao-ding@ti.com>
 <f7a2de19-55c5-4aa9-b0a8-632f22b6c147@linaro.org>
 <f5357751-ed4d-49ad-9d65-199c49f4cbdf@sirena.org.uk>
In-Reply-To: <f5357751-ed4d-49ad-9d65-199c49f4cbdf@sirena.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, January 26, 2024 9:50 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Ding, Shenghao <shenghao-ding@ti.com>; conor+dt@kernel.org;
> robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; Lu, Kevin <kevin-
> lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>; devicetree@vger.kernel.org; P
> O, Vijeth <v-po@ti.com>; lgirdwood@gmail.com; perex@perex.cz; pierre-
> louis.bossart@linux.intel.com; 13916275206@139.com; Chawla, Mohit
> <mohit.chawla@ti.com>; linux-sound@vger.kernel.org; linux-
> kernel@vger.kernel.org; liam.r.girdwood@intel.com; soyer@irl.hu; Huang,
> Jonathan <jkhuang3@ti.com>; tiwai@suse.de; Djuandi, Peter
> <pdjuandi@ti.com>; McPherson, Jeff <j-mcpherson@ti.com>; Navada
> Kanyana, Mukund <navada@ti.com>
> Subject: [EXTERNAL] Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add
> initial DT binding
>=20
> On Fri, Jan 26, 2024 at 09:27:47AM +0100, Krzysztof Kozlowski wrote:
> > On 26/01/2024 04:58, Shenghao Ding wrote:
>=20
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - ti,pcm1690
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          items:
> > > +            minimum: 0x4c
> > > +            maximum: 0x4f
>=20
> > Nothing improved.
>=20
> Shenghao explained what what this is doing - I'm not sure what the actual
> problem is here?  It's an actual restriction on the values that are valid=
.

Hi, Krzysztof. May I have the privilege to petition on behalf of my custome=
rs? They=20
want to keep these if branches and the i2c address in yaml file. As you kno=
w, most=20
of my customers used to make mistakes and confuse with the i2c address. Lis=
ting=20
them here can help them to get the information easily.

