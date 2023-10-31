Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA67DC90D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343744AbjJaJIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjJaJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:08:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE6191;
        Tue, 31 Oct 2023 02:08:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EEBC433C8;
        Tue, 31 Oct 2023 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698743286;
        bh=feIBOznLOh65axwYyiiYpq9McN8nBddJCuTkou94EY8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VblEe006dkOhHKFV8lXYkjBoV+/BKggu8KsI5kMIAb2Q1426nw4dRAAVoYwb69UEw
         G4GLrarHQQVvZuXCYCZpQm3MzyKeWeBmJjvlgQ6PMCq7xr4I4hB0HHfGshV2oZUG15
         X6DMTAU3M/qqtSGFor+HnXWdZfMMByBst6bHmnUyfk/boW/rAygCoryItoD82ouGdQ
         F5rgczw5G1IKtPxgez4yKfn8OvhBZ5q4umOXcv+za1DnTK33HU98GoVwOWr045jrBq
         m/rH+Oca3fkh8qYaRN6iMziupF3suM3KgYmJZfX4wsLpF+TVmwMsBaFclHecefyoKM
         WMmuIxn5gT6Nw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
References: <20231023131953.2876682-1-arnd@kernel.org>
Date:   Tue, 31 Oct 2023 11:08:00 +0200
In-Reply-To: <20231023131953.2876682-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 23 Oct 2023 15:19:42 +0200")
Message-ID: <874ji7w45r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> As discussed previously, a lot of the older wifi drivers are likely
> entirely unused, Though we can't know for sure.
>
> As suggested by both Greg and Jakub, let's remove the ones that look
> are most likely to have no users left and also get in the way of the
> wext cleanup. If anyone is still using any of these, we can revert the
> driver removal individually.
>
> I would suggest merging these for net-next after 6.7-rc1 is out, to give
> them the maximum amount of time for users to speak up before a release
> comes out.
>
> This kills off all pcmcia wifi drivers, and all wext users in
> drivers/net/wireless, but not the ps3-gelic-wireless driver in
> drivers/net/ethernet, or the staging drivers.
>
> In staging, rtl8192u was already removed in the meantime, while rtl8712
> and rtl8192e are apparently still used.  I have not been able to find
> out whether ks7010 is still in use.
>
> 	Arnd
>
> Link: https://lore.kernel.org/lkml/20231011080955.1beeb010@kernel.org/
>
>
> Arnd Bergmann (10):
>   wifi: libertas: drop 16-bit PCMCIA support
>   wifi: atmel: remove wext style at76c50x drivers
>   wifi: remove orphaned cisco/aironet driver
>   wifi: remove obsolete hostap driver
>   wifi: remove orphaned zd1201 driver
>   wifi: remove orphaned orinoco driver
>   wifi: remove orphaned ray_cs driver
>   wifi: remove orphaned wl3501 driver
>   wifi: remove orphaned rndis_wlan driver
>   [RFC] wifi: remove ipw2100/ipw2200 drivers

I manually applied these 9 to wireless-next:

4b478bf6bdd8 wifi: libertas: drop 16-bit PCMCIA support
77e49bec6414 wifi: atmel: remove wext style at76c50x drivers
6853c70ba5ed wifi: remove orphaned cisco/aironet driver
d0172d5f7576 wifi: remove obsolete hostap driver
757a46c2a7a9 wifi: remove orphaned zd1201 driver
1535d5962d79 wifi: remove orphaned orinoco driver
6b9dbaff83d6 wifi: remove orphaned ray_cs driver
238349207cd3 wifi: remove orphaned wl3501 driver
bec95598b24a wifi: remove orphaned rndis_wlan driver

I dropped this patch as we got several reports about people using the
driver:

[RFC] wifi: remove ipw2100/ipw2200 drivers

The patches are queued for v6.8. Arnd, thanks a lot for cleaning this
up!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
