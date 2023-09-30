Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC037B4268
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjI3QyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjI3QyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:54:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC2DA;
        Sat, 30 Sep 2023 09:54:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128B0C433C8;
        Sat, 30 Sep 2023 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696092846;
        bh=3FWZ2qW2Ezn08XF7jE/SiC+XcEI8boNjlLaX2s5XXj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kBH/u9QrsdIL0Bc2HrdOfgtLT/lqXpGNTnTlP69fi8Ump94+jFCr03KYTSTcgwWqz
         D7aqfgDQ5XlSm9YyBQO2awR/goy7ZwHYh4JZRnmADYJo1L6yICx1oPxsnBpn8w3J5O
         ULJSYJQ3nAEHb8UklF1lAGbT+3l28/JWZwx2gcbUXX4RqPZ6Cx8MeoKo4Ra7aEjYy8
         jChr7f1OByeRMIhuUiLftT2zRpa8m5IvY+x2/ncjIwT/q8ESLOLQlJCLKq9oILfSCc
         JP45pFa7h62dXuBF/uK2KGjFk/XdmAYdvoMTwagoHsaxuvQU7f+YgS9Z/6OuEqTYy4
         mzqktP+JjH8Qw==
Date:   Sat, 30 Sep 2023 17:54:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: improve doc for available_scan_mask
Message-ID: <20230930175404.033da19e@jic23-huawei>
In-Reply-To: <4e43bf0186df5c8a56b470318b4827605f9cad6c.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
        <4e43bf0186df5c8a56b470318b4827605f9cad6c.1695727471.git.mazziesaccount@gmail.com>
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

On Wed, 27 Sep 2023 11:27:41 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The available_scan_mask is an array of bitmaps representing the channels
> which can be simultaneously enabled by the driver. In many cases, the
> hardware can offer more channels than what the user is interested in
> obtaining. In such cases, it may be preferred that only a subset of
> channels are enabled, and the driver reads only a subset of the channels
> from the hardware.
> 
> Some devices can't support all channel combinations. For example, the
> BM1390 pressure sensor must always read the pressure data in order to
> acknowledge the watermark IRQ, while reading temperature can be omitted.
> So, the available scan masks would be 'pressure and temperature' and
> 'pressure only'.
> 
> When IIO searches for the scan mask it asks the driver to use, it will
> pick the first suitable one from the 'available_scan_mask' array. Hence,
> ordering the masks in the array makes a difference. We should 'prefer'
> reading just the pressure from the hardware (as it is a cheaper operation
> than reading both pressure and temperature) over reading both pressure
> and temperature. Hence, we should set the 'only pressure' as the first
> scan mask in available_scan_mask array. If we set the 'pressure and
> temperature' as first in the array, then the 'only temperature' will never
> get used as 'pressure and temperature' can always serve the user's
> needs.
> 
> Add (minimal) kerneldoc to the 'available_scan_mask' to hint the user
> that the ordering of masks matters.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Applied this patch to the togreg branch of iio.git
If you fancy turning the patch description into some more formal
documentation under Documentation/... that might be a good thing in the
long run. I always mean to spend some time working on that, but too manyt
things to do :(

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 202e55b0a28b..7bfa1b9bc8a2 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -556,7 +556,9 @@ struct iio_buffer_setup_ops {
>   *			and owner
>   * @buffer:		[DRIVER] any buffer present
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
> - * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
> + * @available_scan_masks: [DRIVER] optional array of allowed bitmasks. Sort the
> + *			   array in order of preference, the most preferred
> + *			   masks first.
>   * @masklength:		[INTERN] the length of the mask established from
>   *			channels
>   * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers

