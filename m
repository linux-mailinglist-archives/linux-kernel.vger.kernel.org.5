Return-Path: <linux-kernel+bounces-18901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC598264E0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8CA281E7C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268813ADB;
	Sun,  7 Jan 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMEuaZSP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BE13AC0;
	Sun,  7 Jan 2024 16:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5A9C433C7;
	Sun,  7 Jan 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643358;
	bh=AgdzebLM5cK9tMR3KyEkXQ/+QTHVfgE2gK9SSe5ys1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eMEuaZSPUQm0ZR1Qt5SToxGIMZcNTEbCM+QNSkJLM5gKqwcYDQaqRJos5xHdDJkkS
	 9ByhjhHiuly2X6dS4AnADhP7hlDrfPPn3f70ljNVZSg2RitIcJaDo/01qCFmVvBLhI
	 nieDyKA/DOgrLawIuL2kRR5FIWIjWb0Ear/TVrmqmcSNWqk14mFGOZGDbpKXSOLdon
	 4SnceSGSywhLbqIQNci3QaS5h6w3TogY4Bx89kisbvDPMLrROGmlZekC7UWsz4Baem
	 IAvvm0c9fByABPcmhKstgJe7J8ReQJSdLJNMoZKi9KsxzD/ETL/FzZTaMOfE/411nc
	 iMsucXAkDnB9w==
Date: Sun, 7 Jan 2024 16:02:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: ti-ads7950: remove redundant assignment
 to variable ret
Message-ID: <20240107160232.4cdbae62@jic23-huawei>
In-Reply-To: <e0f58f77-1dd0-4def-84ec-eded4b7d2092@lechnology.com>
References: <20240106152251.54617-1-colin.i.king@gmail.com>
	<e0f58f77-1dd0-4def-84ec-eded4b7d2092@lechnology.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jan 2024 12:14:22 -0600
David Lechner <david@lechnology.com> wrote:

> On 1/6/24 9:22 AM, Colin Ian King wrote:
> > Variable ret is being assigned a value that is never read, the variable
> > is being re-assigned again a few statements later. Remove it.
> > 
> > Cleans up clang scan build warning:
> > warning: Value stored to 'ret' is never read [deadcode.DeadStores]
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >   drivers/iio/adc/ti-ads7950.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > index 263fc3a1b87e..f975de059ba0 100644
> > --- a/drivers/iio/adc/ti-ads7950.c
> > +++ b/drivers/iio/adc/ti-ads7950.c
> > @@ -441,8 +441,6 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
> >   	if (ret)
> >   		goto out;
> >   
> > -	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
> > -
> >   	/* Revert back to original settings */
> >   	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
> >   	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);  
> 
> This does not look like the correct fix. This is the intended return value of the function in the case of no errors. So we probably need to introduce a new variable instead so that it doesn't get written over.

Agreed.  Needs to stash that in another local variable and return that value
if ret == 0.

J


