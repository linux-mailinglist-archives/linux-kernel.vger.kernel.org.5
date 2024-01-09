Return-Path: <linux-kernel+bounces-20495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA49827FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5EBB21DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DF13FE7;
	Tue,  9 Jan 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqNAYoRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F82134C3;
	Tue,  9 Jan 2024 07:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B939C43390;
	Tue,  9 Jan 2024 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704786576;
	bh=8bsC+3GiQ/JyD4ov1VIrPnB8eSSmJQCsfVT2D7rax+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqNAYoRHb/uGuAsEuPgrEmlu7R70ql65q9qoizETbxKOprUTHYACy6yQNqF8N409v
	 /eJwmuHvRuqbGx4oMgMzhS43HTL4Roceni71noR1FPU0rbX9cHlqUx2FhEmF313bJt
	 xKttH/+iUgStKHQ7uDjgZ3AkZiNXL4NuRqMydTq8=
Date: Tue, 9 Jan 2024 08:49:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: SilverPlate3 <arielsilver77@gmail.com>
Cc: forest@alittletooquiet.net, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6655: Fix sparse warning. Restricted cast.
Message-ID: <2024010937-rental-filled-5ae6@gregkh>
References: <20240109072704.44582-1-arielsilver77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109072704.44582-1-arielsilver77@gmail.com>

On Tue, Jan 09, 2024 at 09:27:04AM +0200, SilverPlate3 wrote:
> Running 'make M=drivers/staging/vt6655 C=2'
> causes sparse to generate few warnings.
> This patch fixes the following warnings by ensuring le64_to_cpu
> handles only __le64 values, thus dismissing chances of bad endianness.
> * drivers/staging/vt6655/card.c:302:45: warning: cast to restricted __le64
> * drivers/staging/vt6655/card.c:336:23: warning: cast to restricted __le64
> * drivers/staging/vt6655/card.c:804:23: warning: cast to restricted __le64
> * drivers/staging/vt6655/card.c:831:18: warning: cast to restricted __le64
> 
> Signed-off-by: Ariel Silver <arielsilver77@gmail.com>

 From: line doesn't match the signed-off-by line :(

> ---
>  drivers/staging/vt6655/card.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 350ab8f3778a..5dc2200466b7 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -292,6 +292,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
>  {
>  	u64 local_tsf;
>  	u64 qwTSFOffset = 0;
> +	__le64 le_qwTSFOffset = 0;
>  
>  	local_tsf = vt6655_get_current_tsf(priv);
>  
> @@ -299,7 +300,8 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
>  		qwTSFOffset = CARDqGetTSFOffset(rx_rate, qwBSSTimestamp,
>  						local_tsf);
>  		/* adjust TSF, HW's TSF add TSF Offset reg */
> -		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
> +		le_qwTSFOffset = cpu_to_le64(qwTSFOffset);
> +		qwTSFOffset = le64_to_cpu(le_qwTSFOffset);

Are you sure about this?  Please verify just what you are doing here
please...

thanks,

greg k-h

