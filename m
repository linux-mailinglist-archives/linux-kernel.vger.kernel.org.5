Return-Path: <linux-kernel+bounces-103604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B244587C1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E335C1C2095D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087374436;
	Thu, 14 Mar 2024 17:06:32 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 561A67351C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435992; cv=none; b=fXA18OD1wH/w7PRuJHek950qyTjoQvoli969o0drSLJp9M1cutWOJdMugO58IfXH9DNymXXolS65OWeuxoCvwBcn5quY8NHMA94HZgkV5rYq1Eqk5kfHTQB5QhyE3WMrnWXFSbTNci4SFd9SjOB15CxaihiNSWCw7u1pgPyoVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435992; c=relaxed/simple;
	bh=CGkln+OmSkzR1fL8B64pytuSGwIBUDXizmxgaTNMi1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNox6LI+9Jv+/r2OsWJMbdeYb7/Mf7ANKpBydZ54oaRGLPjMS3MBvQ4BONwUuKu2Db7+o3XAEdOELU5o7UNuOIzvwEARWZHEFIxnXwQH0mph+xx+tC4XY42oHAcILMOfsQj3xNI5eit6TDlX94CQPmNm7gE2AlSmrK6A8BMDD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 457369 invoked by uid 1000); 14 Mar 2024 13:06:29 -0400
Date: Thu, 14 Mar 2024 13:06:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
  linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
  Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] usb: storage: isd200: fix error checks in
 isd200_{read,write}_config()
Message-ID: <8819c3a3-fbf1-4df5-9e40-3509ef383b4a@rowland.harvard.edu>
References: <20240314093136.16386-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314093136.16386-1-r.smirnov@omp.ru>

On Thu, Mar 14, 2024 at 12:31:36PM +0300, Roman Smirnov wrote:
> The expression result >= 0 will be true even if usb_stor_ctrl_transfer()
> returns an error code. It is necessary to compare result with
> USB_STOR_XFER_GOOD.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Cc: stable@vger.kernel.org
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/isd200.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
> index 300aeef160e7..2a1531793820 100644
> --- a/drivers/usb/storage/isd200.c
> +++ b/drivers/usb/storage/isd200.c
> @@ -774,7 +774,7 @@ static int isd200_write_config( struct us_data *us )
>  		(void *) &info->ConfigData, 
>  		sizeof(info->ConfigData));
>  
> -	if (result >= 0) {
> +	if (result == USB_STOR_XFER_GOOD) {
>  		usb_stor_dbg(us, "   ISD200 Config Data was written successfully\n");
>  	} else {
>  		usb_stor_dbg(us, "   Request to write ISD200 Config Data failed!\n");
> @@ -816,7 +816,7 @@ static int isd200_read_config( struct us_data *us )
>  		sizeof(info->ConfigData));
>  
>  
> -	if (result >= 0) {
> +	if (result == USB_STOR_XFER_GOOD) {
>  		usb_stor_dbg(us, "   Retrieved the following ISD200 Config Data:\n");
>  #ifdef CONFIG_USB_STORAGE_DEBUG
>  		isd200_log_config(us, info);
> -- 
> 2.34.1
> 
> 

