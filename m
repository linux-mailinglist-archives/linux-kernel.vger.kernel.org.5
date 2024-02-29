Return-Path: <linux-kernel+bounces-86336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087D86C40A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D20E1C21128
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B0535B4;
	Thu, 29 Feb 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IfH4fgTH"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865E535AF;
	Thu, 29 Feb 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196407; cv=none; b=rydlZVmZvFhRRhAS/lHPZXcSd0CGIa3CCj/1qNmLfQhe/fvJfZyc1Q0uJ8Nz1xpwDn6SJ24s6SM6ZPD6w2Z8NB5nSNQvwXeLcBuGyUwLT8H+G8fTgDMJpOyygZqwbv0DSf0vVXkqitQ3GXdgtMfofwk8FHJa/U6YfWfvw+atfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196407; c=relaxed/simple;
	bh=qwCh4HkETlXqvXQiDnkTAVSKoofLJRfU5jEJr6Y2t1E=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAsbI5SuAl6SG2S/MKKRPP7TKpz8J8tuL31mvJf4EkN1ruXylYtSArdPuy6oLyQx2sKggudMabFz3Sl3KevgyHyuVpdz+zp9NZlX6nUJvMsuHoOY9rjrMzW3o/zp3JuRascHrKgedVLxev4GzVK7tCnYUmLnH3L02j57HDT4Bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IfH4fgTH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41T8jSoB094393;
	Thu, 29 Feb 2024 02:45:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709196328;
	bh=Ulcrfge3dIu9txF9ZPWk1YqG9TlLAnjzw2E2aDqON2c=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=IfH4fgTHaE4W04yHnZz6V9XlunSfeUzgZ3pdOsDqyvv+MW7GaKzyXSez2HnXFO7Hx
	 mamka70Odc/h0m6xvZVc1tHjC15u3MZEmGY45aqsmA85HoZEAe1JyrDoJrsFO/Pvys
	 AIH3JMDB54TXFWFbuGzjNu+Jdic7xRkc7mMqi/7w=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41T8jRZb035729
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 02:45:27 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 02:45:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Feb 2024 02:45:27 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41T8jQQj078498;
	Thu, 29 Feb 2024 02:45:27 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Eric Biggers
	<ebiggers@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller"
	<davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: RE:  Re: [PATCH v2 2/6] crypto: crc64 - add crc64-iso framework
In-Reply-To: <MW5PR84MB18424EC8DDB4863777D302E2AB562@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
 <20230812025520.GE971@sol.localdomain>
 <87jztserrf.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <MW5PR84MB18424EC8DDB4863777D302E2AB562@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Date: Thu, 29 Feb 2024 14:15:25 +0530
Message-ID: <87plwfk6ai.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

"Elliott, Robert (Servers)" <elliott@hpe.com> writes:

>> -----Original Message-----
>> From: Kamlesh Gurudasani <kamlesh@ti.com>
>> Sent: Friday, August 18, 2023 2:26 AM
>> Subject: Re: [EXTERNAL] Re: [PATCH v2 2/6] crypto: crc64 - add crc64-iso
>> framework
>> 
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > Is "crc64-iso" clear enough, or should it be "crc64-iso3309"?  There are
>> > thousands of ISO standards.  Different CRC variants are specified by
>> different
>> > ISO standards.  Is this particular variant indeed commonly referred to
>> as simply
>> > the "ISO" CRC-64?  Even if it's currently the case that all other CRCs
>> in ISO
>> > standards are different widths than 64 bits (which may be unlikely?),
>> I'm not
>> > sure we should count on no CRC-64 variant ever being standardized by
>> ISO.
>> >
>> > - Eric
>> https://en.wikipedia.org/wiki/Cyclic_redundancy_check
>> 
>> Last entry CRC-64-ISO in the table.
>> It is mentioned as crc64-iso and that's the
>> only 64-bit CRC standardized by ISO. 
>
> ECMA-182 (DLT-1 tapes) was contributed to become ISO/IEC 13421 in 1993, so
> that was another "64-bit CRC standardized by ISO." Plus, ISO could publish new
> standards with new CRCs at any time.
>
>> But I do agree that crc64-iso3309 would be more specific, will change it
>> to crc64-iso3309 in next revision. Thanks.
>> 
>> Regards,
>> Kamlesh
>
> ISO-3309:1991 was withdrawn and revised by
> ISO/IEC 3309:1993, which was withdrawn and revised by
> ISO/IEC 13239:2002, which was confirmed in 2007 and is still current.
>
> Apparently only the 1991 version defined a CRC-64; later versions dropped
> that.
>
> Is there really a demand for adding a 23 year old deprecated algorithm to
> the kernel?
I understand your concern but a lot of TI's K3 based J7* and AM6* SOCs
have MCRC and MCRC64(Mostly on AM6* SOCs)
Where MCRC64 only supports above mentioned CRC64 algorithm and few
customers wants to use the hardware based CRC to ensure FFI, so we
actually need it.
If it is available in upstream and can be used easily, a lot of
customers would want to use it.

I'll look into the naming and will provide something specific to that
particular algo.

Kamlesh

