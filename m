Return-Path: <linux-kernel+bounces-93597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4387322E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177F8288BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0B60889;
	Wed,  6 Mar 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="ABN90weX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701E5F49A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715945; cv=none; b=DjySRbI0uT/9ewIGiZQifFjuuZSiAP/7YsCVDzRJ2WqM2XBbv4+XdNrFGOo3/M5O3ZjCV0Qhj7DVmmhrTA36owztTpGrRB0W70khMCmQN9Lay43Ec7668HCY8LvgQOanQykrXjgFmFUJm3K+4A/gxD1CmgAYDZ5MszW2N46H+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715945; c=relaxed/simple;
	bh=AixO+OZOBnZxCVOMRZd6pfSLiMPnzDGtYaxvFS70ZA4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKDT3oC9oLYss4vuk/bkut50gB9JfiGzExubQlcgYkvToPrYmkFb+bPgZ/eRzxSSg317Ffizla5Ktn2uAuyYX1w2+GXASV+rLN7HFDysd+0BKZ2NPD+yqg4jWjSVdyJnius+hNhDzp8c0T6uW3+s2h35Vn+UW20tB/G+FpieF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=ABN90weX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412f1ccf8d8so6086405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1709715942; x=1710320742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8ufPezaLKvHMaPm3SqbvV4sbLCYN/FbWjx6XVEqb6s=;
        b=ABN90weX26uPH1XTzCDaSqZqYA/CNr2m+qHhOhbQ9cdQNQteJydK/2WZN3CarvV0rm
         BWQNaLqgrJxgs5vkOhZkEngotbg21YgNY3sjpf4kV5avmlpmh7hV7CHpSyjvN7KgxD16
         TRi8SimqEbugOivkEUqA+78WvWfCC5Ijict9YLdNsVuAxjGfGQS06Xi6AbqKOqc6zJA+
         bGWgn1LhQ5hirpQ64I0wx7l5giw5cbpd9QCIQEOyh5DwVMML9ySrOSolyk529jrdSDzK
         gGdzfOYNLmgsNgBFA7V3iYKkDXD1oygOkklouM29PbVkPLkTqxYK9Ug+AKuJPZZJWkLW
         BwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715942; x=1710320742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8ufPezaLKvHMaPm3SqbvV4sbLCYN/FbWjx6XVEqb6s=;
        b=KdH+hLXi7BS322jZ4Y0GfHdvslcnNRRlmFWbqxBrrxLScPKHqcg+JohQdAU4P/aoxm
         t0rUqu3nab0M4ZFtsM431EM4Vp+jgyw7PQERnxF2gtFabpZImJBz3R57Aof1gK7WBPq7
         nCkCOpJokvS+JZ2csc8tDPPhYJZ0wafMnQhvTvhS/d+kRO89XDBJsDvCMPoztz8hkQfc
         1w3NDxOyzOXxteyLbGBcETDkY3ADzAc8K4HfnwXxwAx6hCOh75bNcxb9Vzo66pWmysZM
         94T1mq/AELRzK/AZUOwzdKUZ9JQs7FOPgT7P6HPvIJu5xQJDnxlbEIAZyEOQ9So0o0qv
         n0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUZCb0Ql8tCideQqPNuQsg+ZvQOcbKm7yOagAaF2vnZBJJ33aYfA198MtJkbqgQqJgdxFFTjVVmDzjR/A8muor+SzOfWLKMpiV7p8zy
X-Gm-Message-State: AOJu0Yx7KYQcgg8129gNcEAPlZRoAef+X9IgPL6vSRbXAtjiKjlB9xec
	5n2RS/tMRS5FC6CqU3l+uR7QqRou5mCO7B/XiTrmEzPXeViYKWH2Ng+lKiRzZUI=
X-Google-Smtp-Source: AGHT+IEkqDsppvh+9EAAVwqQJkQOpNaPLhsIMxBUqOqRReXWyEUG7A+50+IB/vT3/o3giLHc07mvtA==
X-Received: by 2002:a5d:594b:0:b0:33d:f30:5689 with SMTP id e11-20020a5d594b000000b0033d0f305689mr9609409wri.30.1709715941926;
        Wed, 06 Mar 2024 01:05:41 -0800 (PST)
Received: from trax (132.red-81-38-137.dynamicip.rima-tde.net. [81.38.137.132])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d484f000000b0033dec836ea6sm17043454wrs.99.2024.03.06.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:05:41 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Wed, 6 Mar 2024 10:05:40 +0100
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
Message-ID: <Zegx5PCtg6hs8zyp@trax>
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>

On 06/03/24 10:44:38, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
>
> Commit e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB
> partitions.") added a mask check for 'part_type', but the mask used was
> wrong leading to the code intended for rpmb also being executed for GP3.
>
> On some MMCs (but not all) this would make gp3 partition inaccessible:
> armadillo:~# head -c 1 < /dev/mmcblk2gp3
> head: standard input: I/O error
> armadillo:~# dmesg -c
> [  422.976583] mmc2: running CQE recovery
> [  423.058182] mmc2: running CQE recovery
> [  423.137607] mmc2: running CQE recovery
> [  423.137802] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
> [  423.237125] mmc2: running CQE recovery
> [  423.318206] mmc2: running CQE recovery
> [  423.397680] mmc2: running CQE recovery
> [  423.397837] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [  423.408287] Buffer I/O error on dev mmcblk2gp3, logical block 0, async page read
>
> the part_type values of interest here are defined as follow:
> main  0
> boot0 1
> boot1 2
> rpmb  3
> gp0   4
> gp1   5
> gp2   6
> gp3   7

right, the patch I originally sent didn't consider anything after GP0 as per
the definitions below.

#define EXT_CSD_PART_CONFIG_ACC_MASK	(0x7)
#define EXT_CSD_PART_CONFIG_ACC_BOOT0	(0x1)
#define EXT_CSD_PART_CONFIG_ACC_RPMB	(0x3)
#define EXT_CSD_PART_CONFIG_ACC_GP0	(0x4)

That looked strange as there should be support for 4 GP but this code
kind of convinced me of the opposite.

	if (idata->rpmb) {
		/* Support multiple RPMB partitions */
		target_part = idata->rpmb->part_index;
		target_part |= EXT_CSD_PART_CONFIG_ACC_RPMB;
	}

So if we apply the fix that you propose, how are multiple RPMB
partitions (ie, 4) going to be identified as RPMB? Unless there can't be
more than 3?

But sure, your patch makes sense to me.

>
> so mask with EXT_CSD_PART_CONFIG_ACC_MASK (7) to correctly identify rpmb
>
> Fixes: e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB partitions.")
> Cc: stable@vger.kernel.org
> Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> A couple of notes:
> - this doesn't fail on all eMMCs, I can still access gp3 on some models
>   but it seems to fail reliably with micron's "G1M15L"
> - I've encountered this on the 5.10 backport (in 5.10.208), so that'll
>   need to be backported everywhere the fix was taken...
>
> Thanks!
> ---
>  drivers/mmc/core/block.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..86efa6084696 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -874,10 +874,11 @@ static const struct block_device_operations mmc_bdops = {
>  static int mmc_blk_part_switch_pre(struct mmc_card *card,
>  				   unsigned int part_type)
>  {
> -	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
> +	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
> +	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
>  	int ret = 0;
>
> -	if ((part_type & mask) == mask) {
> +	if ((part_type & mask) == rpmb) {
>  		if (card->ext_csd.cmdq_en) {
>  			ret = mmc_cmdq_disable(card);
>  			if (ret)
> @@ -892,10 +893,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>  static int mmc_blk_part_switch_post(struct mmc_card *card,
>  				    unsigned int part_type)
>  {
> -	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
> +	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
> +	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
>  	int ret = 0;
>
> -	if ((part_type & mask) == mask) {
> +	if ((part_type & mask) == rpmb) {
>  		mmc_retune_unpause(card->host);
>  		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
>  			ret = mmc_cmdq_enable(card);
>
> ---
> base-commit: 5847c9777c303a792202c609bd761dceb60f4eed
> change-id: 20240306-mmc-partswitch-c3a50b5084ae
>
> Best regards,
> --
> Dominique Martinet | Asmadeus
>

