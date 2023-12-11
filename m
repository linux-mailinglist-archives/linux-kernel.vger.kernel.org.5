Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337F680DB01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjLKTjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:39:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF1ECE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:39:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E18C433C7;
        Mon, 11 Dec 2023 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702323596;
        bh=PB/1LjMlbOLdYSx6h/CttvsBAJYkMBl4EgLNAVM+0NM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMRThIHWlCgpM9f5d/EToo3kDlgm/TRAm4Kc++HtMUN4yCodfPUlqvvpawj+vDlJr
         82mB8KzshRqPW4exaT/1ChCHxSeVhigCp5rYW5wZB5hGxdBqLnjFA29f9twijH1h0m
         6r2tKnLm3hIwO3SX6QyvLY/wmcKV3FAvcaJjAeWjB6nz8KxXgj9TXzl09qa8roGPNY
         4KCNvqTrkQQ6vcjDnecMvxg9DcsWletKgegX9ju0oTb5ZTToCURmKF3s/TctqG/SAM
         ZxPgJJaa3VHGKF6tkzHMiCV7VJO7sg0XYts+grju8YnI6CVsGTWZzpSSKQbx84L49D
         vsqkUujRsKF4A==
Date:   Mon, 11 Dec 2023 19:39:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20231211193950.7d4d012f@jic23-huawei>
In-Reply-To: <20231211122201.9598-1-579lpy@gmail.com>
References: <20231211122201.9598-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 20:22:01 +0800
Li peiyu <579lpy@gmail.com> wrote:

> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>
Series applied to the togreg branch of iio.git but initially
that's just pushed out as testing to let 0-day see if it can find
anything we missed.

Thanks!

Jonathan

> ---
> changes in v6:
> 	sensor driver:
> 	  - Drop offset for humidity channel.
> 	  - Use put_unaligned_be16 to assign the 14-bit heater value.
> 	  - Remove error message if devm_action_or_reset() fails.
> 	  - Add eror message if devm_iio_device_register() fails.
> 	dt-bindings:
> 	  - remove items before "- const: ti,hdc3020".
> 	  - add vdd-supply to required.
> changes in v5:
> 	iio ABI:
> 	  - Document _TROUGH as an info element.
> 	sensor driver:
> 	  - Correct heater enable/disable commands
> 	  - Rearrang header files in alphabetical order.
> 	  - Change .info_mask_separate to BIT(IIO_CHAN_INFO_RAW). 
> 	  - Add details to mutex comment.
> 	  - Add error handling for chan->type in read_raw call.
> 	  - Remove error message for devm_iio_device_register.
> changes in v4:
> 	iio core:
> 	  - Add an IIO_CHAN_INFO_TROUGH modifier for minimum values.
> 	iio ABI:
> 	  - Document the new _TROUGH modifier.
> 	sensor driver:
> 	  - Add MAINTAINERS.
> 	  - Use new IIO_CHAN_INFO_TROUGH modifier.
> 	  - Support the complete heater range.
> 	  - Remove measurement values from the data structure.
> 	  - Use guard(mutex)(...), make the code simpler
> 	  - Removed buffer mode and direct mode conversion code
> 	  - Minor coding-style fixes.
> 	dt-bindings:
> 	  - removed unnecessary example
> 	  - add vdd-supply to the example
> changes in v3:
> 	sensor driver:
> 	  - Removed the custom ABI
> 	  - Give up calculating values in the driver
> 	  - Use read_avail callback to get available parameters
> 	  - Changed the scope of the lock to make the code more concise
> 	  - Fixed the code format issue
> 	dt-bindings:
> 	  - Use a fallback compatible
> changes in v2:
> 	sensor driver:
> 	  - Added static modification to global variables
> 	  - change the methord to read peak value
> 	dt-bindings:
> 	  - change the maintainers to me.
> 	  - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
> 	  - change the node name to humidity-sensor.
> 
> ---
> Javier Carrasco (2):
>       iio: core: introduce trough modifier for minimum values
>       iio: ABI: document temperature and humidity peak/trough raw attributes
> 
> Li peiyu (2):
>       dt-bindings: iio: humidity: Add TI HDC302x support
>       iio: humidity: Add driver for TI HDC302x humidity sensors
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
>  .../bindings/iio/humidity/ti,hdc3020.yaml          |  55 +++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/humidity/Kconfig                       |  12 +
>  drivers/iio/humidity/Makefile                      |   1 +
>  drivers/iio/humidity/hdc3020.c                     | 473 +++++++++++++++++++++
>  drivers/iio/industrialio-core.c                    |   1 +
>  include/linux/iio/types.h                          |   1 +
>  8 files changed, 563 insertions(+), 1 deletion(-)
>  ---
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
> 
> Best regards,

