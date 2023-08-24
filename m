Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04CA786E24
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjHXLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbjHXLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795861987;
        Thu, 24 Aug 2023 04:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF1C76451E;
        Thu, 24 Aug 2023 11:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE8BC433C8;
        Thu, 24 Aug 2023 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692877238;
        bh=Hc4V3VNJYc6/BXVoldkNqz2vHuG+cGO8fUbta2UGr8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GB4gnzuUmF/ACHrJcy/9WckgBVFxls3bxrOyEhu33uz6EZSrBYmOKwBGBBf/aqcLL
         rDifer/+1bO8ULHmjNQCJXcXJxzOMF2xYRGA4iZoaIKQUIXwWNQV5a3Woh72EYztip
         3ln6E7RMLtGlCNGGfauyGnszI6Y9r6psiBnR9xiI=
Date:   Thu, 24 Aug 2023 13:40:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCHv5 2/4] wiegand: add Wiegand bus driver
Message-ID: <2023082420-quaking-barley-47b4@gregkh>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824111015.57765-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:10:13PM +0200, Martin Zaťovič wrote:
> +static inline void wiegand_controller_put(void *ptr)

Why is this a void *?  It should be "struct wiegand_controller *"

Please never use void * if at all possible.

> +static inline void wiegand_unregister_driver(struct wiegand_driver *wdrv)
> +{
> +	if (wdrv)

How could this ever be true?

> +		driver_unregister(&wdrv->driver);
> +}
> +
> +static inline struct wiegand_driver *to_wiegand_driver(struct device_driver *drv)
> +{
> +	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;

How could drv be NULL?

And you should make this a const *, right?

thanks,

greg k-h
