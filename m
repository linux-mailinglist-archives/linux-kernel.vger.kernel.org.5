Return-Path: <linux-kernel+bounces-96097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B687570B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15E51C216A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F64136999;
	Thu,  7 Mar 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0IpIy7V"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C01BDDB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839391; cv=none; b=EPee/7NXQA7zkkb1hk6rbwhEaiJFe2cDJ9zi80ooX4OSnSMXIW5E4635KTboqPFBpuL2uRA98nkNjbh86UjzOaA8OG9FJzhT1QYK7DhH4jXm7F7NoYmqG8y1T0/Z+ydbo1BlPbxn04Q/way2iLD1bMpIMflFQ+xt5GFi1YbERew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839391; c=relaxed/simple;
	bh=wJlCqTThPi4/VML6Y1+wwR+KbJN/I/oeJww0OgERadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snLAhtSMsU2wogos0XbpE8FbHpo6VYNW3WlLTCSaOELg9jeXj/3PYjKGWQBeDw5ztWbbHfIga8P0GOKBhLzh5WDHqTT8oMN14QQtaOj8+RFSM54dgpNvHfk+8x2toyOMFyRPymyqkechmS6QjFw0pHOo88qUCHV9gTqJBF9IO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0IpIy7V; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e64997a934so1034963b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709839389; x=1710444189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DduEKj8GFlpzFgT0yb/zzfC+FS9qllTpxNT85F/f4pE=;
        b=G0IpIy7V6yAgO80mW1eN7xl5W1itTjsjzyLIBxFoBa1eIspWIEp+Ou56QRxvgxMuZI
         c7SOohY0fm4JcPMhRdhKD8SWASZd8L7qUaooQeOIRJV53oZHyCkVuouYsyGIXphttgUm
         3dAc5TkKmkAPaG3NasWGoNeIQ7w4b1HxBKRHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839389; x=1710444189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DduEKj8GFlpzFgT0yb/zzfC+FS9qllTpxNT85F/f4pE=;
        b=pl7njhCQtKSyduT9X2J6bXX71yXswaZIT3AVTBQgi/LKEzpJ/2/+NhOsJ5KvzE47/d
         JS1KNNCCCS+w0rDotr9I9IRxO1h0GnAQgz5vBlSe3EB01Qz+S6aULa5PSZR1qTrpP6NO
         Ttt7Z8aBW/Gx3Vo9LZ61+t5+kp85yZ1ty8bjuOza2GUzAIXAF1EZAKVfswYvDJ22RqCN
         ov2SiwaMuC1uVSAwnNUgxoYqnSEvcAaZFKfeNNZjuHyuWNob08g38ds4m1IxNA7uEUgL
         IrNjT+VfTiunHrZCGrp4Tj/kth/DQsTSOeD3wh/YeIALs0kG6BFffyfcAa/xW67g5pkD
         uFZQ==
X-Gm-Message-State: AOJu0Yzr1nARII7veln4b7Q8XedPJ8wc6ueXnOIVI9JBqv7UlnncRsTn
	4GslWhfcwZK/UJevGLth0yTnX4T/R8Fpbv8VfoNDCcG+4xh2WBOTg4wlb4c45M6jcIeJuwRk7dY
	=
X-Google-Smtp-Source: AGHT+IEao0PKXmkrbOlkb65VAQeNWgyrP8klLz9VK3UZOClIF7LkQox4OoOzSsYuc+PGTEsKmDzx9Q==
X-Received: by 2002:a05:6a20:d395:b0:1a0:708a:4f6e with SMTP id iq21-20020a056a20d39500b001a0708a4f6emr9938824pzb.41.1709839388729;
        Thu, 07 Mar 2024 11:23:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f19-20020a656293000000b005dc816b2369sm11419586pgv.28.2024.03.07.11.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:23:08 -0800 (PST)
Date: Thu, 7 Mar 2024 11:23:07 -0800
From: Kees Cook <keescook@chromium.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: linux-next: manual merge of the kspp tree with the net-next tree
Message-ID: <202403071122.F11DAADF50@keescook>
References: <20240307162958.02ec485c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307162958.02ec485c@canb.auug.org.au>

On Thu, Mar 07, 2024 at 04:29:58PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> FIXME: Add owner of second tree to To:
>        Add author(s)/SOB of conflicting commits.
> 
> Today's linux-next merge of the kspp tree got conflicts in:
> 
>   drivers/net/ethernet/intel/ice/ice_lib.c
>   drivers/net/ethernet/intel/ice/ice_xsk.c
> 
> between commits:
> 
>   3e5fb691faee ("ice: make ice_vsi_cfg_rxq() static")
>   a292ba981324 ("ice: make ice_vsi_cfg_txq() static")
> 
> from the net-next tree and commit:
> 
>   014dc22af922 ("overflow: Change DEFINE_FLEX to take __counted_by member")
> 
> from the kspp tree.
> 
> I fixed it up (I used those files from the former and applied the
> following merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 7 Mar 2024 16:26:02 +1100
> Subject: [PATCH] fix up for "overflow: Change DEFINE_FLEX to take __counted_by
>  member"
> 
> comflcting with commits
> 
>   3e5fb691faee ("ice: make ice_vsi_cfg_rxq() static")
>   a292ba981324 ("ice: make ice_vsi_cfg_txq() static")
> 
> from the net-nect tree.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index d2fd315556a3..a545a7917e4f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -956,7 +956,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
>  int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
>  			   u16 q_idx)
>  {
> -	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
> +	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
>  
>  	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
>  		return -EINVAL;
> @@ -978,7 +978,7 @@ int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
>  static int
>  ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
>  {
> -	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
> +	DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
>  	int err = 0;
>  	u16 q_idx;

Thanks! This looks correct to me.

-- 
Kees Cook

