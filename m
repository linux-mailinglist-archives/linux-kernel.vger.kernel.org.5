Return-Path: <linux-kernel+bounces-162742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DE8B5FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF481C22082
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D486651;
	Mon, 29 Apr 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Urs14xf6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB88614C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411218; cv=none; b=aBp5v+oTTp0+qxu6x/wgiH87C7x+I1o+CKfv8tinB9rE1j58yTxSy1dlu/GAbvRL71xJphEr4hL/w6JrNCGkkxI+YX7fcwV9AL7uvnzDtlVJGUgGPpqEA/Ocpx0/X4iK60h975mgsNNDYC+3jgMGBgNlvMevkCK1jc6ycPWzn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411218; c=relaxed/simple;
	bh=PerO1u8TUFFLtW9JThabyUwyutH/yFT8/JHbZmdp7pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/IfdTqtGuho3D2gVhxhyXyVdqg6igHBiWg3soaYpScd6f4cuXjj/FbtO22aluC2CdWA21xoBmq8IkLqigiyaMs1XcMzgtchNoOF7G9uGV4nc+VC5NRi33wcm8l/ojezRpyTaIPp7k5bfVmOyA52xXVfpdBsFR5nMQp2N0WSw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Urs14xf6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eab16c8d83so37591925ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714411217; x=1715016017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CS/SHezQ6Pdhl4ygxfsawlJI+46WSdClgCk8/mnu0OM=;
        b=Urs14xf60+xvQlm5oNz+3ISS6+zc0/AF7w3iBoiy19iAD5JBmFZdyrcTwEY9SrY++P
         qw6K4Qt9CnbLwPsD+dk0uRjFT5rP2TSAFKoywG7QjeDNJc+rd6sI72/hELyNxkDZMoc1
         rq4r19XDWuvJQO8zuecGr/6aM5cjn0iLvevTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411217; x=1715016017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS/SHezQ6Pdhl4ygxfsawlJI+46WSdClgCk8/mnu0OM=;
        b=tHzok6fbSqyNu4xLP1w4V7b/p8JSGr+wGf6yHaE1N8pZ3K3G+qCtKjO0aj5ecp/VZU
         I0XywiSiMaMyt6/xZ5V5W9OPwMNhWnDNyLJ0vED8B/ug0LNBYxgdAj4jbCDVfnV/Li/T
         oHXdeRenRSqUdIVBsOhBwLMsNPuB4SPUtjz2iEI98BsVDjR3ni1KN5vNszx8mED6PwEK
         g/7DG5wZVteGgW3Hn5DOmRjBoa5s5n0wMz0frnN7BE5+sf9PNrkWq21A5G9GSERhyqO8
         RuZP50pgT+NCvNcWOWSPH3hud9JzPsa+d8lHMVudniD37iUgzNETn4BvpIX88nU9xExR
         iFjw==
X-Forwarded-Encrypted: i=1; AJvYcCU0UTrKZajPXgmLv2lhftjWM9UqyJ7IA/6DpVrZDXTTxk+0BqIhcJ2iwRZMNkrzZC7mKTzwldBzdk9nwIgNPG2h3sbjR+ZPyUKndJ+k
X-Gm-Message-State: AOJu0YwIPTLDykr14UfevKDEtAjVwYPPbHX6TuxKLlFzhGrqMxIULbFl
	7Ybv7IOIIxv/G9HQaG4OEkhzHYHrtyp23GoBU3Rul9N5zgL9N1pkLLmRcD4LTw==
X-Google-Smtp-Source: AGHT+IGL/FwAu2x7/qu+PFVMP/cUBvweF6HoXwCVlcpRa0qZiTVDSAwktllDvjj9Gdir3XxgdpFiBA==
X-Received: by 2002:a17:902:ecc4:b0:1e5:9da5:a799 with SMTP id a4-20020a170902ecc400b001e59da5a799mr14449796plh.6.1714411216882;
        Mon, 29 Apr 2024 10:20:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm21002042pln.154.2024.04.29.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:20:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:20:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
Message-ID: <202404291019.5AC903A@keescook>
References: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Mar 30, 2024 at 05:17:53PM +0100, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Also, it is preferred to use sizeof(*pointer) instead of
> sizeof(type) due to the type of the variable can change and
> one needs not change the former (unlike the latter).
> 
> Link: https://github.com/KSPP/linux/issues/162
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v2:
> - Update the changelog text describing the sizeof()
>   changes (Gustavo A. R. Silva)
> 
> Changes in v3:
> - Add the "Reviewed-by:" tag.
> - Rebase against linux-next.
> 
> Version 1:
> Link: https://lore.kernel.org/linux-hardening/20240112182603.11048-1-erick.archer@gmx.com/
> 
> Version 2:
> Link: https://lore.kernel.org/linux-hardening/20240114102400.3816-1-erick.archer@gmx.com/
> 
> Hi everyone,
> 
> This patch seems to be lost. Gustavo reviewed it on January 15, 2024
> but the patch has not been applied since.

This looks correct to me. I can pick this up if no one else snags it?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Thanks,
> Erick
> ---
>  drivers/scsi/csiostor/csio_init.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
> index d649b7a2a879..d72892e44fd1 100644
> --- a/drivers/scsi/csiostor/csio_init.c
> +++ b/drivers/scsi/csiostor/csio_init.c
> @@ -698,8 +698,7 @@ csio_lnodes_block_request(struct csio_hw *hw)
>  	struct csio_lnode **lnode_list;
>  	int cur_cnt = 0, ii;
>  
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>  	if (!lnode_list) {
>  		csio_err(hw, "Failed to allocate lnodes_list");
>  		return;
> @@ -737,8 +736,7 @@ csio_lnodes_unblock_request(struct csio_hw *hw)
>  	struct csio_lnode **lnode_list;
>  	int cur_cnt = 0, ii;
>  
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>  	if (!lnode_list) {
>  		csio_err(hw, "Failed to allocate lnodes_list");
>  		return;
> @@ -775,8 +773,7 @@ csio_lnodes_block_by_port(struct csio_hw *hw, uint8_t portid)
>  	struct csio_lnode **lnode_list;
>  	int cur_cnt = 0, ii;
>  
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>  	if (!lnode_list) {
>  		csio_err(hw, "Failed to allocate lnodes_list");
>  		return;
> @@ -816,8 +813,7 @@ csio_lnodes_unblock_by_port(struct csio_hw *hw, uint8_t portid)
>  	struct csio_lnode **lnode_list;
>  	int cur_cnt = 0, ii;
>  
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>  	if (!lnode_list) {
>  		csio_err(hw, "Failed to allocate lnodes_list");
>  		return;
> @@ -855,8 +851,7 @@ csio_lnodes_exit(struct csio_hw *hw, bool npiv)
>  	struct csio_lnode **lnode_list;
>  	int cur_cnt = 0, ii;
>  
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
>  	if (!lnode_list) {
>  		csio_err(hw, "lnodes_exit: Failed to allocate lnodes_list.\n");
>  		return;
> -- 
> 2.25.1
> 

-- 
Kees Cook

