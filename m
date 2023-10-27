Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6667F7D9AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjJ0OA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbjJ0OA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E103CA;
        Fri, 27 Oct 2023 07:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C8DC433C8;
        Fri, 27 Oct 2023 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698415223;
        bh=GqUoq/JnTOGA/NUBYPlElzP2R5B+dPinIucjNVQO58Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ADOKI5eRQ/uDfirD5R4HAl777pjX1RPv5Jo/nnIGwlYynfqbxIi4nzmHrHnj2PNj+
         h6XDezDrxVS/0yfog78g82NpzP4W9lxhQUPWph+rvb1MROQEt8GhMfqq/SVwIHNeNM
         oLNwXM+JaC6vhyAV2IH5bCJOUgxwnSAsPn2/Y3LnQNpf+HxsoT6Nz6oivWcr+TtYkZ
         k9/Cs2Aq71ksZbXLlD6gSzSHx5fxHYuWd2En+QDWwZX8D4loMvV9ncXBvuFFvTPk3i
         pT5a+BGHCPOT2bU5ssZFS2MVzP9027QiZqbhB9Wlyli9UuBIkCHYdiEg8FfSGsoY6L
         d4HLe1TLE4ieQ==
Date:   Fri, 27 Oct 2023 14:59:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Jonathan.Cameron@Huawei.com, lars@metafoo.de,
        jean-baptiste.maneyrol@tdk.com, andy.shevchenko@gmail.com,
        chenhuiz@axis.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Message-ID: <20231027145949.243f03f2@jic23-huawei>
In-Reply-To: <20231023040551.68902-1-suhui@nfschina.com>
References: <20231023040551.68902-1-suhui@nfschina.com>
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

On Mon, 23 Oct 2023 12:05:52 +0800
Su Hui <suhui@nfschina.com> wrote:

> inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
> true value rather than only return IIO_VAL_INT.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

If you can figure out a fixes tag that would be great.  Just reply to this thread
with it and I'll pick it up from here.
> ---
> v2:
>  - fix the error of commit title.
> v1: 
>  - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 29f906c884bd..a9a5fb266ef1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			return ret;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			return ret;
>  
>  		default:
>  			return -EINVAL;

