Return-Path: <linux-kernel+bounces-109335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1B8817C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08E61C20FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865408563C;
	Wed, 20 Mar 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZX98izj6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F18562D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962354; cv=none; b=Wyy8I5lBFfz9RdUkiJYzQMlwgilYH6WiuHrPTU2wpgS33HKts3Hm1Hv0jVxhU7Qkr5w7G7kqO/JJGjt0Rq+naugHFdt7UVZ88UOXuMksi7cT+dSKZopykNnEMIJ+nIFgD2gtzR55h7AWo6VjDuizpjb0Rvr+2a605WTWf7VVAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962354; c=relaxed/simple;
	bh=iPJRmEumxajKjnt+YaiVZbpw05yONRfFEwzdYYywKw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnTHWU41zj99/pyR8FgOzzg5QuD8FjXRg7b5AUgHmrEirBygQAwCeBtFicJ5j4n2Qv1SaIf85YNzSSA+o6ip9fJLH5cryY3I7VOPwTkbVT3h2EJHr+WIkHvRozaRz4zaHPZTJnW9TCzwg0kIdcJXPlNYkZgY/egrOTEqi7dic8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZX98izj6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710962354; x=1742498354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPJRmEumxajKjnt+YaiVZbpw05yONRfFEwzdYYywKw0=;
  b=ZX98izj6k+AQXa8WhtnWZHprXx88it2YHw9hv3Xn+u+MTUeuySzIJplS
   ++PsaaKX1k9RDsbWktRhjJltodw2c0RNF4pK34K3OABJ2LJwwCc/LyxxG
   8tnP/LR18aki6g2H7yG+R8k5a/hfqgsBLagIgLfHiTbGc5L17Dq8bCtPE
   0k7FCrfnB+prHBGE1ufpI0fuJT+sR7Tt+NHbLYwQisrfjVyCUeIDlHFhA
   tQXG8KBHnsnHrEDThkCd6aDfHfV8wKYWb04AjuNChMOWYfzmyMUHJLSzI
   3Hbk/dDa2H6qH0TvaqQBUjht3TkEUHi4gjvcdN4Wh4NazVkccc5x2Fm3J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17051002"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17051002"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14322938"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.127])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:19:10 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: Change type of local variable
Date: Wed, 20 Mar 2024 20:19:06 +0100
Message-ID: <3629769.BEx9A2HvPv@fdefranc-mobl3>
Organization: intel
In-Reply-To: <Zfnt4pIljgM21/BA@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <Zfnt4pIljgM21/BA@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 20 March 2024 19:53:50 CET Ayush Tiwari wrote:
> Change data type of local variable blnPending from u8 to bool since it
> only assumes 0 or 1 values.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c
> b/drivers/staging/rtl8712/rtl8712_cmd.c index bb7db96ed821..32d9927981aa
> 100644
> --- a/drivers/staging/rtl8712/rtl8712_cmd.c
> +++ b/drivers/staging/rtl8712/rtl8712_cmd.c
> @@ -284,7 +284,7 @@ int r8712_cmd_thread(void *context)
>  		pcmd = cmd_hdl_filter(padapter, pcmd);
>  		if (pcmd) { /* if pcmd != NULL, cmd will be handled by 
f/w */
>  			struct dvobj_priv *pdvobj = &padapter-
>dvobjpriv;
> -			u8 blnPending = 0;
> +			bool blnPending = 0;

bool types should take only 'true' and 'false' values. Therefore, if you 
change a type to 'bool' you should also convert the values it is assigned 
throughout its lifetime.

Fabio

P.S.: I just recalled that Dan has asked you to drop that 'b' prefix and do 
exactly what I wrote above. Are you going to ignore his comments?

>  			u16 cmdcode = pcmd->cmdcode;
> 
>  			pcmdpriv->cmd_issued_cnt++;





