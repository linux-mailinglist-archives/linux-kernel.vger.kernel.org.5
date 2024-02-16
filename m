Return-Path: <linux-kernel+bounces-68078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3488575B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FA4287192
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94703134A0;
	Fri, 16 Feb 2024 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dmyb79wm"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3C1426F;
	Fri, 16 Feb 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062165; cv=none; b=J0UbFnqP1y1UBW8OppeSip1gHGoCh1DlCKH8Dr5b7oFJ3t9fy2Gin+1fivkR6fA6A8bAUNP3B/Ezi4ywpjQpdjXnXxA8OK338K9A43O2wbgGEqT96h9f4uJctgKikWBsmlgk3/cBAVIMhgKNyoSABIm6D7cNIUAja7JnyCun838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062165; c=relaxed/simple;
	bh=HnWCOkMadNhJGbb1VJOm3PJbn/DjNUj34mzlBEQl6Ug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIRh2kltt6j90UjLX+Q7uQwdRg/3f1WUaIAX9AAkzy83ekWH9/UFA4cBIzwzbvvR4GmPwtlZ8uRUk6WEIVeM3Cw9PU6TATgcmSFofIlqXIFFHZjsJLTuY4wiL7BvaFVOxNvEeRmL8MwAWZZBdvL6bOFC/VT5OZG0/7Wdt+5qyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dmyb79wm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G5gb7O111727;
	Thu, 15 Feb 2024 23:42:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708062157;
	bh=7sD7T8y2sbe1Dbnwwio5IHPM4pTPa3PariSat8bPlHA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Dmyb79wmUqXTxgu631FQ4/DWfy/6KhFJJXrGkqA0FFG0NnhVBqeHG2vOSlTJa6qcD
	 uNm9ANKRdCUh0DL5dPKiglzrdKY9FdaPCaGg8KniJpTmTsEjCUnVFQh4jrjTN0UP/d
	 on9WLl2q5rFu6Oj7IkgxBkq7q6nx1zIb/YqGsgF8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G5gbki027275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 23:42:37 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 23:42:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 23:42:37 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G5gahC040179;
	Thu, 15 Feb 2024 23:42:36 -0600
Date: Fri, 16 Feb 2024 11:12:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH -next] spi: spi-summary.rst: fix underline length
Message-ID: <20240216054235.bkfyi5mbdz2yyhan@dhruva>
References: <20240216051637.10920-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216051637.10920-1-rdunlap@infradead.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 15, 2024 at 21:16:37 -0800, Randy Dunlap wrote:
> The change to use "target" requires an underline to be extended by
> one more character to fix a documentation build warning:
> 
>   Documentation/spi/spi-summary.rst:274: WARNING: Title underline too short.
>   Declare target Devices
>   ^^^^^^^^^^^^^^^^^^^^^

Oops, looks like I missed it.

> 
> Fixes: hash ("spi: Update the "master/slave" terminology in documentation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> ---
>  Documentation/spi/spi-summary.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
> --- a/Documentation/spi/spi-summary.rst
> +++ b/Documentation/spi/spi-summary.rst
> @@ -271,7 +271,7 @@ an external clock, where another derives
>  settings of some master clock.
>  
>  Declare target Devices
> -^^^^^^^^^^^^^^^^^^^^^
> +^^^^^^^^^^^^^^^^^^^^^^

Good catch,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

Mark,
Will you be just squashing the commits since they're still in next
or will this be a separate commit? Just curious how fixes work while
they're still not in any mainline linux tree

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

