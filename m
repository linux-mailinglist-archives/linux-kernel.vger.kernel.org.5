Return-Path: <linux-kernel+bounces-145238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59628A514E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB7E1F22595
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAE484A50;
	Mon, 15 Apr 2024 13:21:10 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D283CB4;
	Mon, 15 Apr 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187269; cv=none; b=rgoEidmJmNThm6PELDOhombkW9UlmXBSvksl/N1ySEkoz0qP0Wt8G6FtzyQJCMwh+7VEMw9V34YLP81tlTpCdEfk4RgLe+BqLbWrKqK2PeLDRVn9luSACgmRZpzpIYBxEnh6bEDH6jCecZ24TgKHfVbZzPnwSI3bicxw9gTz+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187269; c=relaxed/simple;
	bh=YX7hllbyiJmA8n7JHQzkLlbiw1r46OIwRrV5JFT8Yk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm675OQA8jXg52dwYij1UKzurkwKl7KX0jaEI6+pSQSzP3S3lAikIMxpzg2KiaxHK03jKuqWklB8GTxyIVC9YHu9mg01MNSOKAdRm5sOs7km1lja5UXXx6RLwTa0Wjon1KCX9Jn+GObD5rs7tB294M7Ksph+Q9YrbaPm+OpGA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 14966A0356;
	Mon, 15 Apr 2024 15:12:27 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ePUsKKeAeGk; Mon, 15 Apr 2024 15:12:27 +0200 (CEST)
Received: from begin (unknown [61.199.131.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 4D97EA0326;
	Mon, 15 Apr 2024 15:12:25 +0200 (CEST)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rwM89-00000007bTI-0YTQ;
	Mon, 15 Apr 2024 15:12:17 +0200
Date: Mon, 15 Apr 2024 15:12:17 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix sizeof() vs ARRAY_SIZE() bug
Message-ID: <20240415131217.t3zfjucclauc3rkz@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <d16f67d2-fd0a-4d45-adac-75ddd11001aa@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16f67d2-fd0a-4d45-adac-75ddd11001aa@moroto.mountain>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Dan Carpenter, le lun. 15 avril 2024 14:02:23 +0300, a ecrit:
> The "buf" pointer is an array of u16 values.  This code should be
> using ARRAY_SIZE() (which is 256) instead of sizeof() (which is 512),
> otherwise it can the still got out of bounds.
> 
> Fixes: c8d2f34ea96e ("speakup: Avoid crash on very long word")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org

Thanks!

> ---
>  drivers/accessibility/speakup/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
> index 736c2eb8c0f3..f677ad2177c2 100644
> --- a/drivers/accessibility/speakup/main.c
> +++ b/drivers/accessibility/speakup/main.c
> @@ -574,7 +574,7 @@ static u_long get_word(struct vc_data *vc)
>  	}
>  	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
>  	buf[cnt++] = attr_ch;
> -	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
> +	while (tmpx < vc->vc_cols - 1 && cnt < ARRAY_SIZE(buf) - 1) {
>  		tmp_pos += 2;
>  		tmpx++;
>  		ch = get_char(vc, (u_short *)tmp_pos, &temp);
> -- 
> 2.43.0
> 

