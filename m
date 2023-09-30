Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4177B428F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjI3RNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjI3RNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:13:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F80E5;
        Sat, 30 Sep 2023 10:13:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C675C433C7;
        Sat, 30 Sep 2023 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696093997;
        bh=AEuIV4qOo/frZ3vn0QZSXE4WVdAdUG2y/1bCK1B7DHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ejnxgRRKw4ZOITyvC8kMxGy+1hmEEDuRcU0sWqWj3snDeK764WWDvNTfTTT238bf0
         wL7FaAxipoujLGpBmQ0ZpBLhSwBMj6kj1hAJbzoP9pKWehQeudKaP9QIzRe+HHl5Co
         0y4MAuXP1rPspMMUEJKG3qH2ihQ3XopT0Kw3HhDllxiGZZlT2kyGhRF9Y5egrB3/oE
         qdCU8b6q6qL2UDMf9e+7HzgSS1tU+IZG0bXLS1nC9i9TdIDQ2n/fj3S2Jx8/PYsC3t
         u6799cK2PzgJLVFRQzp2h18YRAhgLJp3rsoX+euAcDlqq6jSzv9GajcHWgqwsSw6YK
         aJQf0/crpvf9A==
Date:   Sat, 30 Sep 2023 18:13:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: ad7192: Use bitfield access macros
Message-ID: <20230930181317.2cff5d00@jic23-huawei>
In-Reply-To: <20230924215148.102491-2-alisadariana@gmail.com>
References: <20230924215148.102491-1-alisadariana@gmail.com>
        <20230924215148.102491-2-alisadariana@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 00:51:46 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Include bitfield.h and update driver to use bitfield access macros
> GENMASK, FIELD_PREP and FIELD_GET.
> 
> Remove old macros in favor of using FIELD_PREP and masks.
> 
> Change %d to %ld to match the type of FIELD_GET().
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi Alisa-Dariana,

One more !! in here. I'll get rid of that whilst applying.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan


> @@ -682,7 +682,8 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> -	bool unipolar = !!(st->conf & AD7192_CONF_UNIPOLAR);
> +	bool unipolar = !!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf);

This !! not needed.

> +	u8 gain = FIELD_GET(AD7192_CONF_GAIN_MASK, st->conf);
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
