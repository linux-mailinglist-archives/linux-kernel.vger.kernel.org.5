Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01A7ACAF9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjIXRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIXRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:19:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF6F1;
        Sun, 24 Sep 2023 10:19:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1573DC433C7;
        Sun, 24 Sep 2023 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695575955;
        bh=eNYErXcCAerxNr/tunujy0UP4OcdGqejs1ZBEPEyDMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6jwZoEvg88nOG/6vAaDT1gHvto+qzkzJPTfXHSMtM09zOLSFQRdocyW6LKG29qdg
         jRVjTDXtC2LCqDYBIZEWrsjedPtNJQalp3vYey2Ll+/6Osx/8ujT+zMBoLZKNbCe6Y
         8fNXLxDX/5q/dXc3yM+TWNBXA5JRrqfjuF2wCZtYr0eIQlmNLFqyw/s07z1dGgYE7P
         +s3RypvDfIlrSLxg6Vhip1LBaWYaXVK+KAAgPToV+kWHOOkKAEzRPw2Uz5xdrDbyLs
         IYvR6IdXJVQEpQpD8jrk+avTcepHDH75yp++pOnwkZoS+N95UmYYDK38eDXwm1PLBB
         QXbMFnNDiHmSg==
Date:   Sun, 24 Sep 2023 18:19:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 04/19] staging: iio: resolver: ad2s1210: fix not
 restoring sample gpio in channel read
Message-ID: <20230924181906.16797c9b@jic23-huawei>
In-Reply-To: <20230921144400.62380-5-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-5-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> In theory, this code path should not be reachable because of the
> previous switch statement. But just in case we should make sure we
> are restoring the SAMPLE gpio to its original state before returning
> in addition to releasing the mutex lock.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 84743e31261a..0bdd5a30d45d 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -510,8 +510,8 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	default:
> -		mutex_unlock(&st->lock);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		break;
>  	}
>  
>  error_ret:

