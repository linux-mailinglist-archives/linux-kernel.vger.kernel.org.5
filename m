Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4561802E31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjLDIkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:39:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268985
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:40:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE88AC433C7;
        Mon,  4 Dec 2023 08:40:01 +0000 (UTC)
Message-ID: <40783b7c-4353-4366-ad49-95ac87c5f8be@xs4all.nl>
Date:   Mon, 4 Dec 2023 09:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/35] media: em28xx: cx231xx: fix opencoded
 find_and_set_bit()
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-26-yury.norov@gmail.com>
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 xsFNBFQ84W0BEAC7EF1iL4s3tY8cRTVkJT/297h0Hz0ypA+ByVM4CdU9sN6ua/YoFlr9k0K4
 BFUlg7JzJoUuRbKxkYb8mmqOe722j7N3HO8+ofnio5cAP5W0WwDpM0kM84BeHU0aPSTsWiGR
 yw55SOK2JBSq7hueotWLfJLobMWhQii0Zd83hGT9SIt9uHaHjgwmtTH7MSTIiaY6N14nw2Ud
 C6Uykc1va0Wqqc2ov5ihgk/2k2SKa02ookQI3e79laOrbZl5BOXNKR9LguuOZdX4XYR3Zi6/
 BsJ7pVCK9xkiVf8svlEl94IHb+sa1KrlgGv3fn5xgzDw8Z222TfFceDL/2EzUyTdWc4GaPMC
 E/c1B4UOle6ZHg02+I8tZicjzj5+yffv1lB5A1btG+AmoZrgf0X2O1B96fqgHx8w9PIpVERN
 YsmkfxvhfP3MO3oHh8UY1OLKdlKamMneCLk2up1Zlli347KMjHAVjBAiy8qOguKF9k7HOjif
 JCLYTkggrRiEiE1xg4tblBNj8WGyKH+u/hwwwBqCd/Px2HvhAsJQ7DwuuB3vBAp845BJYUU3
 06kRihFqbO0vEt4QmcQDcbWINeZ2zX5TK7QQ91ldHdqJn6MhXulPKcM8tCkdD8YNXXKyKqNl
 UVqXnarz8m2JCbHgjEkUlAJCNd6m3pfESLZwSWsLYL49R5yxIwARAQABzSFIYW5zIFZlcmt1
 aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD7CwZUEEwECACgFAlQ84W0CGwMFCRLMAwAGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAACEJEL0tYUhmFDtMFiEEBSzee8IVBTtonxvKvS1hSGYUO0wT
 7w//frEmPBAwu3OdvAk9VDkH7X+7RcFpiuUcJxs3Xl6jpaA+SdwtZra6W1uMrs2RW8eXXiq/
 80HXJtYnal1Y8MKUBoUVhT/+5+KcMyfVQK3VFRHnNxCmC9HZV+qdyxAGwIscUd4hSlweuU6L
 6tI7Dls6NzKRSTFbbGNZCRgl8OrF01TBH+CZrcFIoDgpcJA5Pw84mxo+wd2BZjPA4TNyq1od
 +slSRbDqFug1EqQaMVtUOdgaUgdlmjV0+GfBHoyCGedDE0knv+tRb8v5gNgv7M3hJO3Nrl+O
 OJVoiW0G6OWVyq92NNCKJeDy8XCB1yHCKpBd4evO2bkJNV9xcgHtLrVqozqxZAiCRKN1elWF
 1fyG8KNquqItYedUr+wZZacqW+uzpVr9pZmUqpVCk9s92fzTzDZcGAxnyqkaO2QTgdhPJT2m
 wpG2UwIKzzi13tmwakY7OAbXm76bGWVZCO3QTHVnNV8ku9wgeMc/ZGSLUT8hMDZlwEsW7u/D
 qt+NlTKiOIQsSW7u7h3SFm7sMQo03X/taK9PJhS2BhhgnXg8mOa6U+yNaJy+eU0Lf5hEUiDC
 vDOI5x++LD3pdrJVr/6ZB0Qg3/YzZ0dk+phQ+KlP6HyeO4LG662toMbFbeLcBjcC/ceEclII
 90QNEFSZKM6NVloM+NaZRYVO3ApxWkFu+1mrVTXOwU0EVDzhbQEQANzLiI6gHkIhBQKeQaYs
 p2SSqF9c++9LOy5x6nbQ4s0X3oTKaMGfBZuiKkkU6NnHCSa0Az5ScRWLaRGu1PzjgcVwzl5O
 sDawR1BtOG/XoPRNB2351PRp++W8TWo2viYYY0uJHKFHML+ku9q0P+NkdTzFGJLP+hn7x0RT
 DMbhKTHO3H2xJz5TXNE9zTJuIfGAz3ShDpijvzYieY330BzZYfpgvCllDVM5E4XgfF4F/N90
 wWKu50fMA01ufwu+99GEwTFVG2az5T9SXd7vfSgRSkzXy7hcnxj4IhOfM6Ts85/BjMeIpeqy
 TDdsuetBgX9DMMWxMWl7BLeiMzMGrfkJ4tvlof0sVjurXibTibZyfyGR2ricg8iTbHyFaAzX
 2uFVoZaPxrp7udDfQ96sfz0hesF9Zi8d7NnNnMYbUmUtaS083L/l2EDKvCIkhSjd48XF+aO8
 VhrCfbXWpGRaLcY/gxi2TXRYG9xCa7PINgz9SyO34sL6TeFPSZn4bPQV5O1j85Dj4jBecB1k
 z2arzwlWWKMZUbR04HTeAuuvYvCKEMnfW3ABzdonh70QdqJbpQGfAF2p4/iCETKWuqefiOYn
 pR8PqoQA1DYv3t7y9DIN5Jw/8Oj5wOeEybw6vTMB0rrnx+JaXvxeHSlFzHiD6il/ChDDkJ9J
 /ejCHUQIl40wLSDRABEBAAHCwXwEGAECAA8FAlQ84W0CGwwFCRLMAwAAIQkQvS1hSGYUO0wW
 IQQFLN57whUFO2ifG8q9LWFIZhQ7TA1WD/9yxJvQrpf6LcNrr8uMlQWCg2iz2q1LGt1Itkuu
 KaavEF9nqHmoqhSfZeAIKAPn6xuYbGxXDrpN7dXCOH92fscLodZqZtK5FtbLvO572EPfxneY
 UT7JzDc/5LT9cFFugTMOhq1BG62vUm/F6V91+unyp4dRlyryAeqEuISykhvjZCVHk/woaMZv
 c1Dm4Uvkv0Ilelt3Pb9J7zhcx6sm5T7v16VceF96jG61bnJ2GFS+QZerZp3PY27XgtPxRxYj
 AmFUeF486PHx/2Yi4u1rQpIpC5inPxIgR1+ZFvQrAV36SvLFfuMhyCAxV6WBlQc85ArOiQZB
 Wm7L0repwr7zEJFEkdy8C81WRhMdPvHkAIh3RoY1SGcdB7rB3wCzfYkAuCBqaF7Zgfw8xkad
 KEiQTexRbM1sc/I8ACpla3N26SfQwrfg6V7TIoweP0RwDrcf5PVvwSWsRQp2LxFCkwnCXOra
 gYmkrmv0duG1FStpY+IIQn1TOkuXrciTVfZY1cZD0aVxwlxXBnUNZZNslldvXFtndxR0SFat
 sflovhDxKyhFwXOP0Rv8H378/+14TaykknRBIKEc0+lcr+EMOSUR5eg4aURb8Gc3Uc7fgQ6q
 UssTXzHPyj1hAyDpfu8DzAwlh4kKFTodxSsKAjI45SLjadSc94/5Gy8645Y1KgBzBPTH7Q==
In-Reply-To: <20231203193307.542794-26-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2023 20:32, Yury Norov wrote:
> Functions in the media/usb drivers opencode find_and_set_bit() by
> polling on a found bit in a while-loop.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Feel free to take this yourself through the bitmap tree.

It's a nice improvement.

Regards,

	Hans

> ---
>  drivers/media/usb/cx231xx/cx231xx-cards.c | 16 ++++------
>  drivers/media/usb/em28xx/em28xx-cards.c   | 37 +++++++++--------------
>  2 files changed, 21 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c b/drivers/media/usb/cx231xx/cx231xx-cards.c
> index 92efe6c1f47b..b314603932d7 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-cards.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
> @@ -1708,16 +1708,12 @@ static int cx231xx_usb_probe(struct usb_interface *interface,
>  		return -ENODEV;
>  
>  	/* Check to see next free device and mark as used */
> -	do {
> -		nr = find_first_zero_bit(&cx231xx_devused, CX231XX_MAXBOARDS);
> -		if (nr >= CX231XX_MAXBOARDS) {
> -			/* No free device slots */
> -			dev_err(d,
> -				"Supports only %i devices.\n",
> -				CX231XX_MAXBOARDS);
> -			return -ENOMEM;
> -		}
> -	} while (test_and_set_bit(nr, &cx231xx_devused));
> +	nr = find_and_set_bit(&cx231xx_devused, CX231XX_MAXBOARDS);
> +	if (nr >= CX231XX_MAXBOARDS) {
> +		/* No free device slots */
> +		dev_err(d, "Supports only %i devices.\n", CX231XX_MAXBOARDS);
> +		return -ENOMEM;
> +	}
>  
>  	udev = usb_get_dev(interface_to_usbdev(interface));
>  
> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
> index 4d037c92af7c..af4809fe74a8 100644
> --- a/drivers/media/usb/em28xx/em28xx-cards.c
> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> @@ -3684,17 +3684,14 @@ static int em28xx_duplicate_dev(struct em28xx *dev)
>  		return -ENOMEM;
>  	}
>  	/* Check to see next free device and mark as used */
> -	do {
> -		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
> -		if (nr >= EM28XX_MAXBOARDS) {
> -			/* No free device slots */
> -			dev_warn(&dev->intf->dev, ": Supports only %i em28xx boards.\n",
> -				 EM28XX_MAXBOARDS);
> -			kfree(sec_dev);
> -			dev->dev_next = NULL;
> -			return -ENOMEM;
> -		}
> -	} while (test_and_set_bit(nr, em28xx_devused));
> +	nr = find_and_set_bit(em28xx_devused, EM28XX_MAXBOARDS);
> +	if (nr >= EM28XX_MAXBOARDS) {
> +		/* No free device slots */
> +		dev_warn(&dev->intf->dev, ": Supports only %i em28xx boards.\n", EM28XX_MAXBOARDS);
> +		kfree(sec_dev);
> +		dev->dev_next = NULL;
> +		return -ENOMEM;
> +	}
>  	sec_dev->devno = nr;
>  	snprintf(sec_dev->name, 28, "em28xx #%d", nr);
>  	sec_dev->dev_next = NULL;
> @@ -3827,17 +3824,13 @@ static int em28xx_usb_probe(struct usb_interface *intf,
>  	udev = usb_get_dev(interface_to_usbdev(intf));
>  
>  	/* Check to see next free device and mark as used */
> -	do {
> -		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
> -		if (nr >= EM28XX_MAXBOARDS) {
> -			/* No free device slots */
> -			dev_err(&intf->dev,
> -				"Driver supports up to %i em28xx boards.\n",
> -			       EM28XX_MAXBOARDS);
> -			retval = -ENOMEM;
> -			goto err_no_slot;
> -		}
> -	} while (test_and_set_bit(nr, em28xx_devused));
> +	nr = find_and_set_bit(em28xx_devused, EM28XX_MAXBOARDS);
> +	if (nr >= EM28XX_MAXBOARDS) {
> +		/* No free device slots */
> +		dev_err(&intf->dev, "Driver supports up to %i em28xx boards.\n", EM28XX_MAXBOARDS);
> +		retval = -ENOMEM;
> +		goto err_no_slot;
> +	}
>  
>  	/* Don't register audio interfaces */
>  	if (intf->altsetting[0].desc.bInterfaceClass == USB_CLASS_AUDIO) {

