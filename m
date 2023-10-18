Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA77B7CD8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjJRKRw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRKRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:17:50 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1514103
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:17:48 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6c6591642f2so1565891a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697624268; x=1698229068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGu6HN6pIBhLjaRU06ecpopD+U32c6R7CbdSepUXSFc=;
        b=gEGFRiBROkMeB3JX49khcXmNKxNpTpalB0O6Dqw0k7yHgTcvDARCT+SccgKGWa+plc
         LkUwfmXcltegueGjmjrjWG5Q+B3QJmN2WtF7M/90271y3rfZvjx0Z7+bjzNin3EVBdpO
         HF3CdUib1kF95rI2njWY9CEvMegy41WzKm8f5nRcCz0sUkGG7VlHsl/4AdACAgHGrlis
         F3dwBhIii+vbMNLTLkSPh3rtzzEjrGAwycfABqppQXchersGuUKr7vRNSDbkGPIuSl5c
         GqwgNcTbv9EzTBRcePJYWXOg6rSscxJulfiT1aNJuRMTrIcj7xQbMeCOJ+bEyYuVOoO5
         pJ9w==
X-Gm-Message-State: AOJu0YwaBLJ5CsMVvGmA3w5LG/VuX+DxREZwNxQt6SkECCDGS1VgzEKR
        p1KhfYTBYB1qHSzZGhFiW2UUx5zdmlWaA2nIjhM=
X-Google-Smtp-Source: AGHT+IHoL67m9mIkAvSmMZBkVkUJFfeW7GQx3J/CCJ4xbLbMuzKBSlYwdmaPaJKzCxI2iiOQjRLfjJFO7q6olVsQgEk=
X-Received: by 2002:a4a:b304:0:b0:581:d5df:9cd2 with SMTP id
 m4-20020a4ab304000000b00581d5df9cd2mr4352079ooo.0.1697624268204; Wed, 18 Oct
 2023 03:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231018013851.3303928-1-saravanak@google.com>
In-Reply-To: <20231018013851.3303928-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 12:17:37 +0200
Message-ID: <CAJZ5v0iJ+dy0u+ob72KfGMEmvqT25dr+05O5wkEryFH6zQhnMg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Release all resources during unbind
 before updating device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 3:38 AM Saravana Kannan <saravanak@google.com> wrote:
>
> This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
> dependencies tracking support") where the device link status was
> incorrectly updated in the driver unbind path before all the device's
> resources were released.
>
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Reported-by: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengutronix.de/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: James Clark <james.clark@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a528cec24264..0c3725c3eefa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1274,8 +1274,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>                 if (dev->bus && dev->bus->dma_cleanup)
>                         dev->bus->dma_cleanup(dev);
>
> -               device_links_driver_cleanup(dev);
>                 device_unbind_cleanup(dev);
> +               device_links_driver_cleanup(dev);
>
>                 klist_remove(&dev->p->knode_driver);
>                 device_pm_check_callbacks(dev);
> --
> 2.42.0.655.g421f12c284-goog
>
