Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8FD7D1E11
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjJUPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjJUPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:55:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D61A4;
        Sat, 21 Oct 2023 08:55:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD7FC433C7;
        Sat, 21 Oct 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697903742;
        bh=hwuLjwamauGBX49+ZMEyvP+u0WgatDfDReunLsuxivY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LQ56t8Gyrec0S5bFF2ewoXMPh25xVNQ1SmvlkIqX34Z1/2BtczQkEa9Y9TlKNm9iN
         YY6QhRK/6vDJF9Ic3FUdcEWfIlkJXZIH5/B8sx63M3EZ2Xz6ovqHu+Sw5GPfpzL/0R
         Pn83s+adJAuWQ/kkHWT3KEwscIoVC72AmVw0rDSURZ3t2BH+Tux2etXdYcpbzPLr48
         ru3CD/Hbryl1++oqedwq2g9xXCfQprOPk7DgdW4KQtdGBOOFOsFtrQsvtYQuZBJooQ
         tua2FKpDbgiotYrJsGQenYGVMp3nLzsqY3G/W1vfyA48Q3juySSCmIYDUWeuMOR8Au
         2k9hqccy4Gv2Q==
Date:   Sat, 21 Oct 2023 16:55:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Sanity-check available_scan_masks array
Message-ID: <20231021165535.34dcb94b@jic23-huawei>
In-Reply-To: <cover.1697452986.git.mazziesaccount@gmail.com>
References: <cover.1697452986.git.mazziesaccount@gmail.com>
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

On Mon, 16 Oct 2023 14:04:11 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Sanity-check available_scan_masks array
> 
> The available_scan_masks is an array of bitmasks representing the
> channels which can be simultaneously(*) scanned by a driver from the
> device. Following special characteristics apply:
> 
> - When IIO is scanning through the array it will use the first mask
>   which can be used to scan all enabled channels. This means drivers
>   should order the array in the order of the preference. This does also
>   mean that a mask which is a subset of a mask located earler in array
>   will never be used because the earlier one will be picked by the core.
> - Masks wider than size of long are supported only to some extent. The
>   code scanning through the array will interpret the first mask with
>   first long zeroed as end-of-array terminator. Changing this behaviour
>   would make mask-arrays for multi-long masks to be terminated by more
>   than one zero long. Failure to do so would result kernel to read
>   beyond the array generating a potentially hazardous bug.
> 
> Add a sanity-check to IIO-device registration emitting a warning if
> available_scan_mask array is misordered or if mask width is larger than
> a long while available_scan_mask-array is populated. Currently there
> should be no in-tree drivers with available_scan_mask populated and mask
> wider than a long.
> 
> Revision history:
> v1 => v2:
> 	- Add patch 2/2 documenting why iio_scan_mask_match() checks only
> 	  a long worth of bits while searching for the end of the
> 	  available_scan_mask-array.
> 	- Styling of patch 1/2 as per comments from Jonathan
> 	v1 and related discussion here:
> 	https://lore.kernel.org/lkml/ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
> 
> Matti Vaittinen (2):
>   iio: sanity check available_scan_masks array
>   iio: buffer: document known issue
> 
>  drivers/iio/industrialio-buffer.c | 16 ++++++++
>  drivers/iio/industrialio-core.c   | 63 +++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
> 

Hi Matti,

Just a quick note to say this looks fine to me, but I don't want to queue it up
just yet given proximity to merge window etc.  I'll aim to pick it up early
in next cycle. Give me a poke if I still haven't by rc3 or so.

Thanks,

Jonathan
