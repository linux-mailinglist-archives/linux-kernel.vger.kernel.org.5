Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C667DA7D7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJ1PfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1PfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:35:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137FCF;
        Sat, 28 Oct 2023 08:35:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA43C433C7;
        Sat, 28 Oct 2023 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698507303;
        bh=qZnyFgLTqkYYWA+lM+ITN7Oli/7TuoF3B+RoNn5As90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kou2MhaOa2fZQVtIYAc3lLl0VADeS/ZrHI90OHbfUzbOpCkdlNNpozjEF/Cn07XQU
         hJ9h88GZ1NgpfJUi1wm2qmvOgWd8bWXhJIq7KHd4+XOgjDg8Jd/CH3X8VuzZjNYQ6U
         cVxk4ZEVRmrGW4CwZzRXUiT8SxqRNx+uKgjfEqNkqre2mtmQenbxSEOS2KXaqLSTQs
         YWqO8XxJQfFY8Wco5BgExcOcfU4k91T17ZTjN65AKF6BEC7t1mbNDlmBMKWtgE31J5
         hvAJ8pHIkFkaZy94A37GEmMAvJhpjcGN+SvWOzUtL1k7ZJHLmnyXbrWO8U8lNS2wJB
         lHPZFK7PR78Og==
Date:   Sat, 28 Oct 2023 16:34:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: ms_sensors: ms_sensors_i2c: fix humidity
 conversion time table
Message-ID: <20231028163442.2b803993@jic23-huawei>
In-Reply-To: <20231026-topic-htu21_conversion_time-v1-1-bd257dc44209@gmail.com>
References: <20231026-topic-htu21_conversion_time-v1-1-bd257dc44209@gmail.com>
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

On Thu, 26 Oct 2023 17:44:49 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The HTU21 offers 4 sampling frequencies: 20, 40, 70 and 120, which are
> associated to an index that is used to select the right measurement
> resolution and its corresponding measurement time. The current
> implementation selects the measurement resolution and the temperature
> measurement time properly, but it does not select the right humidity
> measurement time in all cases.
> 
> In summary, the 40 and 70 humidity measurement times are swapped.
> 
> The reason for that is probably the unusual coding for the measurement
> resolution. According to the datasheet, the bits [7,0] of the "user
> register" are used as follows to select the bit resolution:
> 
> --------------------------------------------------
> | Bit 7 | Bit 0 | RH | Temp | Trh (us) | Tt (us) |
> --------------------------------------------------
> |   0   |   0   | 12 |  14  |  16000   |  50000  |
> --------------------------------------------------
> |   0   |   1   | 8  |  12  |  3000    |  13000  |
> --------------------------------------------------
> |   1   |   0   | 10 |  13  |  5000    |  25000  |
> --------------------------------------------------
> |   1   |   1   | 11 |  11  |  8000    |  7000   |
> --------------------------------------------------
> *This table is available in the official datasheet, page 13/21. I have
> just appended the times provided in the humidity/temperature tables,
> pages 3/21, 5/21. Note that always a pair of resolutions is selected.
> 
> The sampling frequencies [20, 40, 70, 120] are assigned to a linear
> index [0..3] which is then coded as follows [1]:
> 
> Index    [7,0]
> --------------
> idx 0     0,0
> idx 1     1,0
> idx 2     0,1
> idx 3     1,1
> 
> That is done that way because the temperature measurements are being
> used as the reference for the sampling frequency (the frequencies and
> the temperature measurement times are correlated), so increasing the
> index always reduces the temperature measurement time and its
> resolution. Therefore, the temperature measurement time array is as
> simple as [50000, 25000, 13000, 7000]
> 
> On the other hand, the humidity resolution cannot follow the same
> pattern because of the way it is coded in the "user register", where
> both resolutions are selected at the same time. The humidity measurement
> time array is the following: [16000, 3000, 5000, 8000], which defines
> the following assignments:
> 
> Index    [7,0]    Trh
> -----------------------
> idx 0     0,0     16000  -> right, [0,0] selects 12 bits (Trh = 16000)
> idx 1     1,0     3000   -> wrong! [1,0] selects 10 bits (Trh = 5000)
> idx 2     0,1     5000   -> wrong! [0,1] selects 8 bits (Trh = 3000)
> idx 3     1,1     8000   -> right, [1,1] selects 11 bits (Trh = 8000)
> 
> The times have been ordered as if idx = 1 -> [0,1] and idx = 2 -> [1,0],
> which is not the case for the reason explained above.
> 
> So a simple modification is required to obtain the right humidity
> measurement time array, swapping the values in the positions 1 and 2.
> 
> The right table should be the following: [16000, 5000, 3000, 8000]
> 
> Fix the humidity measurement time array with the right idex/value
> coding.
> 
> [1] The actual code that makes this coding and assigns it to the current
> value of the "user register" is the following:
> config_reg &= 0x7E;
> config_reg |= ((i & 1) << 7) + ((i & 2) >> 1);
> 
> Fixes: d574a87cc311 ("Add meas-spec sensors common part")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Good description.  That's horrible :(

Applied to the fixes-togreg branch of iio.git and marked for stable.
Note however that I probably won't send a fixes pull request until after rc1
is out in about 3 weeks time.

Thanks,

Jonathan
> ---
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 6633b35a94e6..9c9bc77003c7 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -15,8 +15,8 @@
>  /* Conversion times in us */
>  static const u16 ms_sensors_ht_t_conversion_time[] = { 50000, 25000,
>  						       13000, 7000 };
> -static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 3000,
> -						       5000, 8000 };
> +static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 5000,
> +						       3000, 8000 };
>  static const u16 ms_sensors_tp_conversion_time[] = { 500, 1100, 2100,
>  						     4100, 8220, 16440 };
>  
> 
> ---
> base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
> change-id: 20231026-topic-htu21_conversion_time-9ea81e86703f
> 
> Best regards,

