Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17CC7D4CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjJXJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjJXJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09030F4;
        Tue, 24 Oct 2023 02:30:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EABCC433C8;
        Tue, 24 Oct 2023 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698139836;
        bh=CB0uZasGotH3WSQ2XD6CQGludeAGY3f8w17TrzekeQU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dby9AI0p83lKR7U5CCjg2W7DpqRQqyb59zNfumlkY8ts8VHFwcff/XFzqbRKMY55Q
         RPEGb17YmlSQo+XND8ZEqC7yXRo+6kDE9s3zllgDm+XX6xUwEB5Z4wXMl+4sx4O02e
         HlDNnlnAG9UftAcKGoZHxSGp4zKOqPsYGiLTNoVQbiaXrsshmAYMv0FyYHYIOOaS0K
         FNXQGox4XxUgAWUtTfAGwv5zHAnOri9VwXtnN3WXrk66gXQ6NM2RfYSYo+eyHFUIRd
         CbCvNJqEy1WbUgxeM336II3ysCBIN6XpQjlNUkpd2/EQUjF31mxQmi6Kk7gjMRduMv
         TE0I45NGqEfNA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geoff Levand <geoff@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pavel Machek <pavel@ucw.cz>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Linux Wireless <ilw@linux.intel.com>
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
References: <20231023131953.2876682-1-arnd@kernel.org>
        <20231023131953.2876682-11-arnd@kernel.org>
        <20231024014302.0a0b79b0@mir>
Date:   Tue, 24 Oct 2023 12:30:29 +0300
In-Reply-To: <20231024014302.0a0b79b0@mir> (Stefan Lippers-Hollmann's message
        of "Tue, 24 Oct 2023 01:43:02 +0200")
Message-ID: <875y2wz7t6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Lippers-Hollmann <s.l-h@gmx.de> writes:

> On 2023-10-23, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> These two drivers were used for the earliest "Centrino" branded Intel
>> laptops during the late 32-bit Pentium-M era, roughly 2003 to 2005, which
>> probably makes it the most modern platform that still uses the wireless
>> extension interface instead of cfg80211. Unlike the other drivers that
>> are suggested for removal, this one is still officially maintained.
>>
>> According to Johannes Berg, there was an effort to finish the move away
>> from wext in the past, but the last evidence of this that I could find
>> is from commit a3caa99e6c68f ("libipw: initiate cfg80211 API conversion
>> (v2)") in 2009.
>>
>> Link: https://lore.kernel.org/all/87fs2fgals.fsf@kernel.org/
>> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
>> Cc: Linux Wireless <ilw@linux.intel.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> I'm not convinced this should be in the same set of drivers as the
>> rest, since this is clearly less obsolete than the other hardware
>> that I would remove support for.
>
> These have indeed been very common back in the day, I'm still using
> a 2003-vintage 1.5 GHz Pentium-M 'Banias' Acer Travelmate 292LMi
> notebook using ipw2200 (and have two spare ipw2200 mini-PCI cards).
> Works still fine using v6.5.8-rc1 and WPA2PSK/ CCMP (sadly it does
> not do WPA3) and I do use it semi-regularly (running the latest
> stable- or stable-rc kernel of the day).
>
> While it would be nice to replace it with an ath5k based card (to
> get WPA3 support), the card isn't that easy to reach in the notebook,
> so it would be sad to see this go.

Wow, I'm very surprised that ipw2200 still works after 20 years. Thanks
for the report, I think it's best that we still keep the ipw2x00 driver
in the kernel.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
