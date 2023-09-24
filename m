Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591387ACA18
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjIXOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIXOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D828FB;
        Sun, 24 Sep 2023 07:47:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533C1C433C7;
        Sun, 24 Sep 2023 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695566848;
        bh=RmbrxrU9l9CyB5p5ygtaBTP0+0uEydNb9Aqm2XCNw2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eeVBWqolcPI0jwuYPbPlaCKV1FQc+H9E+UnESvco0REOVWsGCoONRdUTx3jH9sI1d
         R8Gxygt6/fnHWz7QXOhRHrljIY0W47IR+vzDzymentGv8jenNzGeP0U1mOhGbIU1B6
         34ru9r10JahGFbFyZMRp82CoTKHsr5Yzz6vsHwh+yARsQtwWL6y28mpYDyYSKXZddO
         NCkM8OAfCB9oWWXDpbdG5HKxDaBJQ6/w6l6tWFNhttMi0JiqX2dgp30kkCwiIM7G0Y
         1fJrzr/5bUBvcd2VcguC35fWEP+hWlfQ3uu3vMdWkDLhDF2lqze4WBD2MUljzY2mc+
         aOoT2AU9ZI/ww==
Date:   Sun, 24 Sep 2023 15:47:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: ad7192: Add fast settling support
Message-ID: <20230924154722.14ea28ef@jic23-huawei>
In-Reply-To: <20230920003342.118813-4-alisadariana@gmail.com>
References: <20230920003342.118813-1-alisadariana@gmail.com>
        <20230920003342.118813-4-alisadariana@gmail.com>
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

On Wed, 20 Sep 2023 03:33:42 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisadariana@gmail.com>
> 
> Add fast settling mode support for AD7193.
> 
> Add fast_settling_average_factor attribute. Expose to user the current
> value of the fast settling average factor. User can change the value by
> writing a new one.
> 
> Add fast_settling_average_factor_available attribute. Expose to user
> possible values for the fast settling average factor.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad7192      |  18 +++
>  drivers/iio/adc/ad7192.c                      | 128 ++++++++++++++++--
>  2 files changed, 134 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index f8315202c8f0..5790adbb1cc1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -19,6 +19,24 @@ Description:
>  		the bridge can be disconnected (when it is not being used
>  		using the bridge_switch_en attribute.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, is used to activate or deactivate
> +		fast settling mode and set the value of the average factor to
> +		1, 2, 8 or 16. If the average factor is set to 1, the fast
> +		settling mode is disabled. The data from the sinc filter is
> +		averaged by chosen value. The averaging reduces the output data
> +		rate for a given FS word, however, the rms noise improves.

Trivial but RMS as it's an acronym.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible values for the fast
> +		settling average factor: 1, 2, 8, 16.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
>  KernelVersion:
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index eed3de02c26d..8987b78865f3 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -60,6 +60,8 @@
>  #define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
>  #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
>  #define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
> +#define AD7192_MODE_AVG_MASK	GENMASK(17, 16)
> +		  /* Fast Settling Filter Average Select Mask (AD7193 only) */
>  #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
>  #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
>  #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
> @@ -182,6 +184,7 @@ struct ad7192_state {
>  	u32				mode;
>  	u32				conf;
>  	u32				scale_avail[8][2];
> +	u8				avg_avail[4];
>  	u8				gpocon;
>  	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
> @@ -459,6 +462,13 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  		st->scale_avail[i][0] = scale_uv;
>  	}
>  
> +	if (st->chip_info->chip_id == CHIPID_AD7193) {

Hmm. This does match with local style, but I'd have preferred if the driver
put all this information in the chip_info structure rather than scattered in code
thoughout the driver.  That would be a bigger and mostly unrelated cleanup however
and this doesn't make the situation any worse really so I'm fine with this
patch as it stands.

Jonathan


> +		st->avg_avail[0] = 1;
> +		st->avg_avail[1] = 2;
> +		st->avg_avail[2] = 8;
> +		st->avg_avail[3] = 16;
> +	}
> +
>  	return 0;
>  }
>  
