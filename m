Return-Path: <linux-kernel+bounces-144685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADD8A4935
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB62E1F219AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E442575F;
	Mon, 15 Apr 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YLat/mj9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432772C182;
	Mon, 15 Apr 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166726; cv=none; b=EH8G0cr9a76oamTXHE3x1lcowNEwRZxPwB8p9VBySfcIeQKryvlBxafx/z/eR/b3GFsf0f+AMem6r3MlTRxFkgc5L2A5BWjfhZ67xJYMvQWlGel134VcSbL+za+HO6cmUzabTCs5LFiO612MrPOGrvFnPm43yb1lM7o071ciAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166726; c=relaxed/simple;
	bh=XoJ3BgAXfG7Ztw2+4zm9qLyn6Q1JuojtZSQ/7v1yDpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ra7f0Jb0ym/9gRoPAb65F1xHXZqSJcgBxaR6o4rk5pV4D/AZdINqQbwm6Et9c/z8N0GO/2VITgayg/dh0j1O0RrEPMq4mJb5YQadSfdt3EsaIYP6D6QIO3fcY6VNg66fkgm08I+v3sqQQAjGcF7eDts6y/iNml85W4O0Fa9tK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YLat/mj9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F7cT64089323;
	Mon, 15 Apr 2024 02:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713166709;
	bh=eLzl+Oxkyw8OllKXOTLNpqMrQYlGfw6Giwejo+77bG4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YLat/mj9u+MSXl2podi8tSNUJmjYi81V5K5izbjxUsgTtHdUlBJV0ctQ2vyEmZyv5
	 QBNOugOhBu8cGnEsYI8VwE1PlNnEWpiR3dZC02bGcT4+FocjG5degAk1bvZUksu+3n
	 JC5uncPxBld7yccFniFR6sNSbhV+jFa5LCRGt61Q=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F7cT6v126888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 02:38:29 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 02:38:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 02:38:28 -0500
Received: from [172.24.31.60] (lt5cd2489kgj.dhcp.ti.com [172.24.31.60])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F7cPFE053968;
	Mon, 15 Apr 2024 02:38:25 -0500
Message-ID: <72f89991-70bc-465a-af69-2d4683541793@ti.com>
Date: Mon, 15 Apr 2024 13:08:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j784s4-evm: Arranging mux and
 macro update
To: Francesco Dolcini <francesco@dolcini.it>
CC: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240415063329.3286600-1-u-kumar1@ti.com>
 <20240415063329.3286600-2-u-kumar1@ti.com>
 <20240415073110.GA7360@francesco-nb>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240415073110.GA7360@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 4/15/2024 1:01 PM, Francesco Dolcini wrote:
> Hello,
>
> On Mon, Apr 15, 2024 at 12:03:26PM +0530, Udit Kumar wrote:
>> Updating J784S4 macro for pin mux instead of J721S2.
>>
>> Also arranging pin mux in order of main_pmx0/1, wkup_pmx0/1/2/3
>> along with fixing pin type for TX as output of wkup_uart.
> Are you doing a refactoring + fixes in the same commit or I
> misunderstood your commit message?
>
> If this is the case I would suggest to have separate commit for the fix
> and the refactoring, with the fix being first in the series and with a
> fixes tag.
>
>  From a quick look, this comment may apply to other commits in the
> series.

will split into two series Fixes and refactor .


> Thanks,
> Francesco
>

