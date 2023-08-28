Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4478B51C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjH1QJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjH1QJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979BE11A;
        Mon, 28 Aug 2023 09:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 283D763B11;
        Mon, 28 Aug 2023 16:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FDAC433C7;
        Mon, 28 Aug 2023 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693238949;
        bh=Ch9OCItNGNpyFFwd6yIpYv29s6Rlh61ARfaG6iVrQMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RsH1O+AKVpKZ+uN6rJbrDIdHW4PIlmHQ8aj4BOVs8u0AQfz09fbCIHkafEbtBkueT
         RNcjR+kjuKUgor760AHdetxDD4nNiOy+MmAVIeMgGBmcgIf/LBhDSgrSjcXmYQrU5R
         s8dhpGqR43Y9hC4UGverFncjtWsPMHj4Sp0oVupGvAAoSooOcjwyc18mCaoMLGIwh6
         ZQoiL6EGqcVjfCbbF8vlmJA72dMj/2FDZCPWTuyJ0oSFDVNQ9EbprJwmU48hWNldJg
         vZPFUME6AuK7xXYHDWQt4M0JOix0Qsri7zSItM4ItzIh9KjWO4z2Hj+rOE+WUMsAn0
         neHHpLogaH0Fw==
Date:   Mon, 28 Aug 2023 17:09:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/3] iio: hid-sensor: Use aligned data type for
 timestamp
Message-ID: <20230828170928.5264dadf@jic23-huawei>
In-Reply-To: <20230815154027.12468-3-andriy.shevchenko@linux.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
        <20230815154027.12468-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 18:40:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use aligned_s64 for the timestamp field.
> 
> Note, the actual data is signed, hence with this we also amend that.
> While at it, drop redundant __alignment directive.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c              | 3 +--
>  drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
>  drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
>  drivers/iio/light/hid-sensor-als.c                   | 2 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c        | 4 ++--
>  drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
>  drivers/iio/pressure/hid-sensor-press.c              | 2 +-
>  drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
>  9 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 5eac7ea19993..f739589564c5 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -25,10 +25,9 @@ struct accel_3d_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info accel[ACCEL_3D_CHANNEL_MAX];
> -	/* Ensure timestamp is naturally aligned */

Comment is still true and no more or less obvious than it was with the old code
I think so I don't really see why it should be removed with this change.

>  	struct {
>  		u32 accel_val[3];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
...


> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index a033699910e8..864ecbcad26e 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -19,8 +19,8 @@ struct dev_rot_state {
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info quaternion;
>  	struct {
> -		s32 sampled_vals[4] __aligned(16);
> -		u64 timestamp __aligned(8);
> +		s32 sampled_vals[4];

Hmm. I can't immediately recall why that aligned(16) is therebut
it's not related to the rest of this change so I'm not sure we should touch it.
I don't think we ever required quaternions to be aligned as a whole so this does feel odd but
in the category of something we should be careful touching or at very least do it in
a different patch where it stands out.


> +		aligned_s64 timestamp;
>  	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> index 07c30d217255..48005b568dd9 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -39,7 +39,7 @@ struct hinge_state {
>  	const char *labels[CHANNEL_SCAN_INDEX_MAX];
>  	struct {
>  		u32 hinge_val[3];
> -		u64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  
>  	int scale_pre_decml;
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index a9215eb32d70..a964c7b65402 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -24,7 +24,7 @@ struct press_state {
>  	struct hid_sensor_hub_attribute_info press_attr;
>  	struct {
>  		u32 press_data;
> -		u64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
> index d40f235af1d4..32f4b13fd554 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -18,7 +18,7 @@ struct temperature_state {
>  	struct hid_sensor_hub_attribute_info temperature_attr;
>  	struct {
>  		s32 temperature_data;
> -		u64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
>  	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;

