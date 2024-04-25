Return-Path: <linux-kernel+bounces-158507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610538B216E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019801F21094
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC412BF14;
	Thu, 25 Apr 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iAaz8KO3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576F12AAD5;
	Thu, 25 Apr 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047052; cv=none; b=FdeMfqkL9RomReMVHnzP3nK5pN4qcR/if00ZpklaJjljPrUfMfl+evS+nHOEWCHbS1doJnsPxmRsmKx+GyIMesats9rLT2Fyu7KcaeAF3w/C/7eal8dJpIAvkeaYtOyqKUQeB1lgD+qxAtreWiM1AcVlifAYF3XEa4M8NKU5pE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047052; c=relaxed/simple;
	bh=HdZ2QnA7U2oMaAFrgywXWMXD05CJWf4ARPk2tQv0ZA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/kJhKzP9TwG8EfiPaJt0c1YoVK6cCcviU0bUeweZok+y2jAZlY5Z4VDEt20y31IvmhT76XaAL+h1KQ7XtNxE8QzcryJgqsrItOGctzDMjiYpmY144Q0xzHqJNh/UnE76s/hs6MDZ43rvbynE17et/hA3rJ94xY4jTJlpJS5D8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iAaz8KO3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PCAeRk024096;
	Thu, 25 Apr 2024 07:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714047040;
	bh=20RMvqPeKimzlfIcpbZ/jDK1eyJlbn4Lto3iHRS0I+c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=iAaz8KO3mq1BoTNcTCvQizGESg7K6BExwxKzQBq53xfQPx2aXsbLx5b6YfHxRVxP/
	 yBEh3mOHgceFWW4OqXp15nScHCP+sqVAuoPNjpL8mGQZU692UPEKi/TRtrfj/vz4ZP
	 yrxGu6qtYYZvN5tGOorMVfUjOwmp4bW2Z7AafSIA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PCAe5k013375
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 07:10:40 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:10:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:10:40 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PCAdV1065347;
	Thu, 25 Apr 2024 07:10:39 -0500
Date: Thu, 25 Apr 2024 17:40:38 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <8a64294a-df1e-4331-aca5-0b23b637b9e1@ti.com>
References: <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
 <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
 <af61424e-7006-49f5-b614-3caa3674685a@ti.com>
 <083e50de-1c99-4a58-8b55-4dec26d97c1b@kernel.org>
 <9bca7d94-142e-4717-aea7-437805717a00@ti.com>
 <a895ddc8-5c18-49d7-86c4-b995bb946914@ti.com>
 <94bae793-ba4f-467f-917d-213fa3cd6faa@ti.com>
 <20489a1e-51d1-42b3-9014-fc1c00b087db@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20489a1e-51d1-42b3-9014-fc1c00b087db@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Apr 05, 2024 at 08:55:18AM +0200, Krzysztof Kozlowski wrote:
> On 05/04/2024 07:21, Siddharth Vadapalli wrote:
> >>>> bindings in the changelog or cover letter.
> >>>
> >>> Thank you for clarifying. I will post the DTS patches corresponding to
> >>> this patch and reference this patch in the DTS patch series.
> >>
> >> I have posted the DTS patch at:
> >> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404081845.622707-1-s-vadapalli@ti.com/
> >> indicating the dependency on this bindings patch.
> > 
> > Hello Krzysztof,
> > 
> > Do I have to post a v2 for this patch? You had Acked it initially but I
> 
> No, I acked it. All this unnecessary talk was because you did not post a
> user, but it is not a requirement, at least when we expect such user.

Lee,

Could you please merge this patch? It applies cleanly on the latest
linux-next tagged next-20240424.

Regards,
Siddharth.

