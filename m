Return-Path: <linux-kernel+bounces-18378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE8825C32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613361F258CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DBD225A6;
	Fri,  5 Jan 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXIW9Cjx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E91364A1;
	Fri,  5 Jan 2024 21:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FD5C433C7;
	Fri,  5 Jan 2024 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704491101;
	bh=S8xwNI2IVLGMzs1d0V3i+KaFfXXiiwzlTAyPMkEB65w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXIW9CjxpEEA78IVJ1b06aYlo7peW1XEcL1cagcL4tc4I8/O/9rDTpXwwuhkFmGOk
	 dTVCgdLFYIcXYm2xsgMW539leVlZ44OsnpTYmNaJqL12msHAQJkzfAq8ZHq7aK/40/
	 qUkxlYOnq5wUfUz2jHUBbCPfqzu+MlM6P5GDGFTsLZdbAqpabOmHDFwqVO9vwGsCsQ
	 9NLNyYKpbLHmMyi1I7Pf3J7WlvAedt7hKI4c6YZjvNCOS6xJsMydT+sGXNK7gNLTLp
	 Ac8+IJOXQiLbhBhMmPRTaSAR+mj5KgiKkCjtfSy8uxjsMBRgV+afSBjrc0RB/fbeK+
	 Bo+h9ppcMiK4Q==
Date: Fri, 5 Jan 2024 21:44:57 +0000
From: Simon Horman <horms@kernel.org>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: [net PATCH] octeontx2-af: CN10KB: Fix FIFO length calculation
 for RPM2
Message-ID: <20240105214457.GD31813@kernel.org>
References: <20240105065423.714-1-naveenm@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105065423.714-1-naveenm@marvell.com>

On Fri, Jan 05, 2024 at 12:24:23PM +0530, Naveen Mamindlapalli wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> RPM0 and RPM1 on the CN10KB SoC have 8 LMACs each, whereas RPM2
> has only 4 LMACs. Similarly, the RPM0 and RPM1 have 256KB FIFO,
> whereas RPM2 has 128KB FIFO. This patch fixes an issue with
> improper TX credit programming for the RPM2 link.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>

If this is a fix for a user-visible bug then it should
have a Fixes tag. Else it should be targeted at net-next.

Also, as a potential follow-up, it looks like this
file (driver?) could benefit from use of GETMASK/FIELD_GET/FIELD_PREP.
But, IMHO, there is no need to do that for this change
which is in a style consistent with the rest of the file.

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> index 4728ba34b0e3..76218f1cb459 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> @@ -506,6 +506,7 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
>  	rpm_t *rpm = rpmd;
>  	u8 num_lmacs;
>  	u32 fifo_len;
> +	u16 max_lmac;
>  
>  	lmac_info = rpm_read(rpm, 0, RPM2_CMRX_RX_LMACS);
>  	/* LMACs are divided into two groups and each group
> @@ -513,7 +514,11 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
>  	 * Group0 lmac_id range {0..3}
>  	 * Group1 lmac_id range {4..7}
>  	 */
> -	fifo_len = rpm->mac_ops->fifo_len / 2;
> +	max_lmac = (rpm_read(rpm, 0, CGX_CONST) >> 24) & 0xFF;
> +	if (max_lmac > 4)
> +		fifo_len = rpm->mac_ops->fifo_len / 2;
> +	else
> +		fifo_len = rpm->mac_ops->fifo_len;
>  
>  	if (lmac_id < 4) {
>  		num_lmacs = hweight8(lmac_info & 0xF);
> -- 
> 2.39.0.198.ga38d39a4c5
> 

