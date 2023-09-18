Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0857A4EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIRQZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjIRQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:25:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15882547D;
        Mon, 18 Sep 2023 09:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDFEC3278F;
        Mon, 18 Sep 2023 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695048960;
        bh=5g74zms0pxYMdecZQ6PAg8uOblUWneJINnwTnBCL5rc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Z7kNBKDa8YOfxRdV2WlXnpbGMI7XWjSdQF38l1v7ARdt8lxcnz2FySG3T//N7fGhq
         nis7qDZLH7hL6/MnhuDP06S7yZwEiukQYjrmZd2p/SjUIu/821QUts4SjxVY1jinVS
         CKGoZITkcDvyW6aa4uzhlP9ud0VOpc0kjs33P5DUobPEhAS2Y0x/0FjFNgUpFFwCrq
         EsDawe56B6E9dKqegayeheJdTmcPCwC/VzIgmclTlxyJeLUnjkb+oQpjoaYwNnwnsq
         BbeHk4LA+FeUamNPmlpW25Y4HodFs4DkpCDyPUc2Pv9pU3xrgOEa9POh8XjnOVGSYn
         Fq6UllRskbcyw==
Date:   Mon, 18 Sep 2023 16:55:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: nvidia-shield: add LEDS_CLASS dependency
In-Reply-To: <20230914000517.16252-1-rdunlap@infradead.org>
Message-ID: <nycvar.YFH.7.76.2309181655490.14216@cbobk.fhfr.pm>
References: <20230914000517.16252-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Randy Dunlap wrote:

> The hid-nvidia-shield driver uses functions that are built
> only when LEDS_CLASS is set, so make the driver depend on that
> symbol to prevent build errors.
> 
> riscv32-linux-ld: drivers/hid/hid-nvidia-shield.o: in function `.L11':
> hid-nvidia-shield.c:(.text+0x192): undefined reference to `led_classdev_unregister'
> riscv32-linux-ld: drivers/hid/hid-nvidia-shield.o: in function `.L113':
> hid-nvidia-shield.c:(.text+0xfa4): undefined reference to `led_classdev_register_ext'
> 
> Fixes: 09308562d4af ("HID: nvidia-shield: Initial driver implementation with Thunderstrike support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/hid/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -799,6 +799,7 @@ config HID_NVIDIA_SHIELD
>  	tristate "NVIDIA SHIELD devices"
>  	depends on USB_HID
>  	depends on BT_HIDP
> +	depends on LEDS_CLASS

Aplied, thanks.

-- 
Jiri Kosina
SUSE Labs

