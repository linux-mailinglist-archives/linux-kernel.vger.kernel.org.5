Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE807F94BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKZSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:02:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD9E6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 10:02:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84472C433C7;
        Sun, 26 Nov 2023 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701021763;
        bh=GrzOSbw6X34tTV7cToVm3nPcglrShd1HMJtSVI8K+7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a0hGpUYPpa3B4+9XVnw0i72bIpFlF7C52SHu7BHrG9CmZpv2FiAVWPfcfLbx+xcar
         Q+AMk3MrOE/HeOIWefDvukX5H7WW1EFHpGL8fk9Ejiw3WmhY6sGD4t5dNjj9qZ8JYk
         8NsSOv/+TiN1lvxSxLAg9BBOrzOiMIa88Bo60yoKBtrl1uDtcu8SOx/B+pfIiX7hll
         VoXnk3Uyek/3Hm/g6jQaH2FD0WUzRalEsu7vS6NxTM5UUPaUr3OtzPKfKtvVEOmJ/C
         OIiTNB19VdOv7UPSsuEEEROi7tXct4y6FrrRmSTQrstaf0x7viZRBPMRGk2/83r/a8
         wGIjrNB70/alA==
Date:   Sun, 26 Nov 2023 18:02:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH] iio: light: ltrf216a: Return floating point values
Message-ID: <20231126180236.4af26387@jic23-huawei>
In-Reply-To: <06d3c2f7-50b4-b44d-fa75-8ca6a1a26d89@collabora.com>
References: <20231107192005.285534-1-shreeya.patel@collabora.com>
        <06d3c2f7-50b4-b44d-fa75-8ca6a1a26d89@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 01:05:41 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> On 08/11/23 00:50, Shreeya Patel wrote:
> > For better precision of input light intesity, return floating point
> > values through sysfs instead of an integer value  
> 
> Hi Jonathan,
> 
> Gentle ping for this patch. I am not sure if you got time to look at the 
> patches
> after LPC but just making sure it doesn't get lost between bunch of 
> others :)
Hi Shreeya,

Getting there on catching up - for some reason this one didn't reach my inbox, but thankfully
patchwork had it.

Anyhow, applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> 
> 
> Thanks,
> Shreeya Patel
> 
> >
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > ---
> >   drivers/iio/light/ltrf216a.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> > index 8de4dd849936..68dc48420a88 100644
> > --- a/drivers/iio/light/ltrf216a.c
> > +++ b/drivers/iio/light/ltrf216a.c
> > @@ -234,7 +234,7 @@ static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> >   static int ltrf216a_get_lux(struct ltrf216a_data *data)
> >   {
> >   	int ret, greendata;
> > -	u64 lux, div;
> > +	u64 lux;
> >   
> >   	ret = ltrf216a_set_power_state(data, true);
> >   	if (ret)
> > @@ -246,10 +246,9 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
> >   
> >   	ltrf216a_set_power_state(data, false);
> >   
> > -	lux = greendata * 45 * LTRF216A_WIN_FAC * 100;
> > -	div = data->als_gain_fac * data->int_time_fac * 100;
> > +	lux = greendata * 45 * LTRF216A_WIN_FAC;
> >   
> > -	return div_u64(lux, div);
> > +	return lux;
> >   }
> >   
> >   static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> > @@ -279,7 +278,8 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> >   		if (ret < 0)
> >   			return ret;
> >   		*val = ret;
> > -		return IIO_VAL_INT;
> > +		*val2 = data->als_gain_fac * data->int_time_fac;
> > +		return IIO_VAL_FRACTIONAL;
> >   	case IIO_CHAN_INFO_INT_TIME:
> >   		mutex_lock(&data->lock);
> >   		ret = ltrf216a_get_int_time(data, val, val2);  
> 

