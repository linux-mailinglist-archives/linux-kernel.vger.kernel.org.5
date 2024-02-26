Return-Path: <linux-kernel+bounces-81532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310C586772C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BD51F2469C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A712AAD6;
	Mon, 26 Feb 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJ2By5Ka"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509EA12883D;
	Mon, 26 Feb 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955285; cv=none; b=eHhH1p+yABy2/7zRS1qO55GuPO4R4iXKy6Hla+R/PzBnx2/2PgINbV8yZie/Xo7+G9GnFnwQauXcCKUQ8OU+EF3lbIvB8KwNmCbIvy/sQqrxczivVIopaYYMrMind5r3NAGtwI+SyioJddNAoOGspNo3Af2NoUCaZNj1gP5e8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955285; c=relaxed/simple;
	bh=haMUGAK+PJjKaqeqp8C9tQacXFq+vv7X9U/zyUTnK08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eMGTrWKYX3yXXxq+MgzWr3qwIgd0qErf/3tQ+yHTYagtkOyuPbckjPY4McA/VeDA5mrFido5P6BJSsvs0F/QgUas7N9FuMN2eSy5vcWCBPY3M/SXMaIjmYo12NFgtKi8XSjN4j3R/4XPYkC+QkccoeQ9u99isn74b7Q/BxAWgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WJ2By5Ka; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QDlcFC125492;
	Mon, 26 Feb 2024 07:47:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708955258;
	bh=haMUGAK+PJjKaqeqp8C9tQacXFq+vv7X9U/zyUTnK08=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WJ2By5Ka6LaFKMX0UNbNxGskmu1pVNcKEJGDM2v2AvfvslSwzNpHX94PO0J66Ury7
	 SGv7575ZrgBkv6mRtTOzpmodJvC5JnuN22Zcy4VmtZbLW6EbSFS6TeRI3RtK+vGXFj
	 gFgsKj3nAbDgkob6pjJqxrGQcufkMpaXDvu8pCKk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QDlclv077861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 07:47:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 07:47:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 07:47:38 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QDlWPm074190;
	Mon, 26 Feb 2024 07:47:33 -0600
Message-ID: <aa180f33-9c42-4435-aff2-f23c42bcadea@ti.com>
Date: Mon, 26 Feb 2024 19:17:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240213082640.457316-1-u-kumar1@ti.com>
 <20240226105435.GA11908@francesco-nb>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240226105435.GA11908@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/26/2024 4:24 PM, Francesco Dolcini wrote:
> On Tue, Feb 13, 2024 at 01:56:40PM +0530, Udit Kumar wrote:
>> Most of clocks and their parents are defined in contiguous range,
>> But in few cases, there is gap in clock numbers[0].
>> Driver assumes clocks to be in contiguous range, and add their clock
>> ids incrementally.
>>
>> New firmware started returning error while calling get_freq and is_on
>> API for non-available clock ids.
> Is this the kind of errors I should expect in such situation?
>
> ti-sci-clk 44043000.system-controller:clock-controller: recalc-rate failed for dev=13, clk=7, ret=-19
>
> If this is the case, I feel like this patch should be back-ported to
> stable kernels.

Sure will send to stable@vger.kernel.org


> Any malfunction because of these errors or just some noise in the logs?

Error is noise in logs, no impact on function as these reserved clocks

are not used by drivers.


>
> Francesco
>

