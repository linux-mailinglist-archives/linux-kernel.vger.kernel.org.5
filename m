Return-Path: <linux-kernel+bounces-76315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09485F58C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA41F22707
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CE3A1B2;
	Thu, 22 Feb 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fLZDdS6F"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9857F51B;
	Thu, 22 Feb 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597350; cv=none; b=Bw8m4pPvq1NuHkbn1xmg4xW92gqifiB7Ur/yWex6EsKNFQwOsjpq5EYDCaPL564ZFTQqNupikkuJWiLhzEy7ws+XCffLyKoSScYNsCkhDh+ExrRYY5kxGktyHLMVkwNriIwIjj2ZNyrQZ/RyHORT8JjNUJUZECehyaGCgwLMSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597350; c=relaxed/simple;
	bh=5u/5ihWUR+PL3goonlKbJDj1aaRfJ+VBubXkq4gGc34=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqjJFMj0QXwID16iQReeWbZ540TXNIjVrQI6SqzFb2e7WQOt0chPICDTxx7UEx8m/RYUF83naoes/zYITIHNMJxT7rnFTiFc8FthNzrNKa6OyUGvERDASjI1eo+vNr+77MfjCUG5wrnRhVQ/jMLs3j7WkXBCqRIXUmhRc+zV2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fLZDdS6F; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MAMLtP004722;
	Thu, 22 Feb 2024 04:22:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708597341;
	bh=ixHXj7OdIRV4zJ2FsJmNcakskY+4z5DDjV41JAZk8SE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fLZDdS6FGw9uLcoy3A53a7LTx3O7nUEOVpBln0HK6pXSIIexKFnFiFSqL+dy6h8h3
	 r8NLePenxmRU66TKTZLf0OJcPDVGW4GmEugYTy1V7UuCKMGpz0pHLSqnXbFdGZnuRq
	 eypw/eZPfeUERw4Hj3q3GklIERbJ8f6vCRBZo4EE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MAMLLq113308
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 04:22:21 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 04:22:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 04:22:20 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MAMJgf039156;
	Thu, 22 Feb 2024 04:22:20 -0600
Date: Thu, 22 Feb 2024 15:52:19 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v4 3/4] spi: cadence-qspi: put runtime in runtime PM
 hooks names
Message-ID: <20240222102219.gwpgxlbxpodavxr2@dhruva>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <20240222-cdns-qspi-pm-fix-v4-3-6b6af8bcbf59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222-cdns-qspi-pm-fix-v4-3-6b6af8bcbf59@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 22, 2024 at 11:12:31 +0100, Théo Lebrun wrote:
> Follow kernel naming convention with regards to power-management
> callback function names.
> 
> The convention in the kernel is:
>  - prefix_suspend means the system-wide suspend callback;
>  - prefix_runtime_suspend means the runtime PM suspend callback.
> The same applies to resume callbacks.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

LGTM!

Reviewed-by: Dhruva Gole <d-gole@ti.com>



-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

