Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A236378B50E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjH1QDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjH1QD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2695F124;
        Mon, 28 Aug 2023 09:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96C964B6D;
        Mon, 28 Aug 2023 16:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4629C433C8;
        Mon, 28 Aug 2023 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693238604;
        bh=ctRT4WEIZ5sfZeT55lglKA+zOsUyJr8r6V2/fNP6mAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YhDmKkGKIcPJqaspJOrAda61fwOgP5xcJcnIj6nBtG7gdtsE1zd4w50Y92FIZe+2X
         zc7jZYYHDT7iOWQwir42hBnUXSVP642gRz2kSbd9vUNY3S3N2NsOmM3IlFxFXxTlDh
         MBrz9ACEKEGrZpIH8cVDnFnH+3FRTOJMTDjzFOcTjvndvpvvvP286tvsQIA53hs7vw
         F+FcCReZNrOr5uMNUooSTbfeCcdwBsS5rtim4sJZ0lumTovF/vo9jqrswz6ccisoGQ
         BQMWHlggL4IIlcv1/kgCom6Tw0N1J6Jlz9cR3/tkZbwKuWjJQpJokTAb7fAzUMG+2l
         h4JY99YT392UQ==
Date:   Mon, 28 Aug 2023 17:03:41 +0100
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
Subject: Re: [PATCH v1 2/3] iio: imu: st_lsm6dsx: Use aligned data type for
 timestamp
Message-ID: <20230828170341.3a9641f0@jic23-huawei>
In-Reply-To: <20230815154027.12468-2-andriy.shevchenko@linux.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
        <20230815154027.12468-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 18:40:26 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use __aligned_s64 for the timestamp field.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index c19237717e81..d3d4b3281aa6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -442,10 +442,9 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
>  
>  	struct iio_mount_matrix orientation;
> -	/* Ensure natural alignment of buffer elements */
>  	struct {
>  		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		__aligned_s64 ts;

aligned_s64 as it's internal to the kernel?

>  	} scan[ST_LSM6DSX_ID_MAX];
>  };
>  

