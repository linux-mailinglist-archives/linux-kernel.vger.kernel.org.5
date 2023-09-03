Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A0790BD6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjICMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjICMLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:11:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB4E6;
        Sun,  3 Sep 2023 05:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 32DB3CE094F;
        Sun,  3 Sep 2023 12:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06787C433C8;
        Sun,  3 Sep 2023 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693743091;
        bh=yylgNbk4wAwCq3zUIXJ6a2XhrfJxnfgpFQPN7FEtrpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M+Q8CnDk8OETUNne46apwTm+9Exn4raXM3HL1yTatSfzsQmTFHdVsZKwvyEN9aN0O
         A2MieRCK9OugrJU3drdTjN7QJkKx4UP/Kw85EkxrSlRsXKYP15Kdcg+frRsK5nDEDN
         wy1E0K2Ww0jvajsWSE8Q3pWVPJgdaYo/7w6y2HU5UW7KdlPQdPJKTi+VNZsIWketTA
         ryOUHlPm4EeBodxcwK/PHYAscO0OKeC9LEhxUeyQkGI/xnHS/XUFetZPLqEauujSYZ
         tjTxjsm4C0KXMSjxr7MyWAA7xYRLN9j39aBJzz3is6xaj2JlNk0YCm/iUsy/Jh2aex
         bP/W+N59KcETw==
Date:   Sun, 3 Sep 2023 13:11:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Match data improvements for adxl345 driver
Message-ID: <20230903131158.33e0c099@jic23-huawei>
In-Reply-To: <20230903090051.39274-1-biju.das.jz@bp.renesas.com>
References: <20230903090051.39274-1-biju.das.jz@bp.renesas.com>
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

On Sun,  3 Sep 2023 10:00:49 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> This patch series aims to add match data improvements for adxl345 driver.
> 
> This patch series is only compile tested.
> 
> v2->v3:
>  * Replaced struct adxl3x5_chip_info->struct adxl345_chip_info
>  * Simplified adxl345_read_raw()
>  * Dropped enum adxl345_device_type as there is no user
> v1->v2:
>  * Replaced EINVAL->ENODEV for invalid chip type.
>  * Kept leading commas for adxl345_*_info and adxl375_*_info.
>  * Restored switch statement in adxl345_core_probe()
> 
> Biju Das (2):
>   iio: accel: adxl345: Convert enum->pointer for data in match data
>     table
>   iio: accel: adxl345: Simplify adxl345_read_raw()
> 
>  drivers/iio/accel/adxl345.h      | 21 ++++++++++++--
>  drivers/iio/accel/adxl345_core.c | 47 ++++----------------------------
>  drivers/iio/accel/adxl345_i2c.c  | 20 ++++++++++----
>  drivers/iio/accel/adxl345_spi.c  | 20 ++++++++++----
>  4 files changed, 54 insertions(+), 54 deletions(-)
> 

Series applied to the togreg branch of iio.git and pushed out
as testing for 0-day to poke at it.

Thanks,

Jonathan
