Return-Path: <linux-kernel+bounces-101424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C262D87A6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637ADB211E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D03EA71;
	Wed, 13 Mar 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPF6mMXW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC98F3D3BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328416; cv=none; b=a/zvev0MTIScDMcSvZTJGTvjwEjrY+8trE1Zx4vTd+asMSzutHlclkoWlO7nQ78MbmzNJZw1TOCJxh8vd7cV5TxBjk+CkTEVMwEOLIKx3wUdVFtvatOMas4+AIrlds/VeeGWpz0SsZFoeWoePR/vagOeVirwszfCvzbE+Pcpq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328416; c=relaxed/simple;
	bh=zvVPD2rEjMvKEqzOWqTbTlroAk1Gq55sIdwBumC37O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqvWZjS9fYBRjVHdhLZ7Op9TEWcs5/jbO2afC+1S8AOomQQuojsTGRjkPZWreHWPVDPffQB//qCfpx3p0SkNiSFfNtXiWax9tPOz4MvrzFjc1fEm6L9y2v0lnQTimp6pa7ojhZqNRmQJoYlptht3kBX8Fg/ZIJ5RFkW67BCeNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPF6mMXW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710328415; x=1741864415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zvVPD2rEjMvKEqzOWqTbTlroAk1Gq55sIdwBumC37O0=;
  b=FPF6mMXW795Fhu3NlyXyx8TKISdODho0d2U2Uuoxn25rVKNrJhuYZC/h
   Ju9WlVg0UTrndWVy1oH7nC2c6QBbdmwAP/h3Jf7InPF+Wf/f4CoJkOeI6
   MHIFRj5WvT+9+KFBVEeE6w46O0kyz8ViaWSXH0IOmxi9qLa7tz1kW5EkY
   R0UOi7Ks1sxbntziwLfEbqNliSjvxClkWe8R2xHQSxl0qbZ9ssR7P5kxk
   wkn26ZVanwyQqfkSHWNRzCGrnxduXSFAWtxio/j/KEd7oeQ397tFbfgsA
   6Fl4566fABxppL3aDFmoT3NMhpb82kCY/+99pdVQTAVPiqGROKQm4e7ni
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16229056"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16229056"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11968542"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.6.143])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:13:31 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v6] staging: rtl8712: rename tmpVal to avg_val
Date: Wed, 13 Mar 2024 12:13:28 +0100
Message-ID: <3798987.kQq0lBPeGt@fdefranc-mobl3>
Organization: intel
In-Reply-To: <ZfF+qu+CGHlpHrtY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZfF+qu+CGHlpHrtY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 13 March 2024 11:23:38 CET Ayush Tiwari wrote:
> Rename tmpVal to avg_val in process_link_qual() to reflect the intended use
> of the variable and conform to the kernel coding style.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>

Reviewed-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Thanks,

Fabio

> 
> Changes in v6: changed variable name tmpVal to avg_val against a clean
> staging tree
> Changes in v5: changed variable name pct_val back to avg_val, as agreed by
> Julia and Dan
> Changes in v4: changed variable name avg_val to pct_val, as suggested by
> Dan
> Changes in v3: changed variable name tmpVal to avg_val
> Changes in v2: added a period in message
> 
>  drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c
> b/drivers/staging/rtl8712/rtl8712_recv.c index a3c4713c59b3..1fabc5137a4c
> 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter
> *padapter, static void process_link_qual(struct _adapter *padapter,
>  			      union recv_frame *prframe)
>  {
> -	u32	last_evm = 0, tmpVal;
> +	u32	last_evm = 0, avg_val;
>  	struct rx_pkt_attrib *pattrib;
>  	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
> 
> @@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
> sqd->index = 0;
> 
>  		/* <1> Showed on UI for user, in percentage. */
> -		tmpVal = sqd->total_val / sqd->total_num;
> -		padapter->recvpriv.signal = (u8)tmpVal;
> +		avg_val = sqd->total_val / sqd->total_num;
> +		padapter->recvpriv.signal = (u8)avg_val;
>  	}
>  }





