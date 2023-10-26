Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DF7D7FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbjJZJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJZJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:41:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08684194;
        Thu, 26 Oct 2023 02:41:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F74C433C9;
        Thu, 26 Oct 2023 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698313293;
        bh=QxFYe5c/XElEhgs94iEddJdQGcgkPEwi4At0UDjpW3s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D8Qcd0yw0e1bKprF3WY9/beM4PynUZcxc7qiLy+kDXAU5l3hcsS4Mim+vfWdBMmcg
         evRtytNOqMHSiWa86KjruNGFbTypqfGfc+JfNGBGoNhFKQvjmRDY4AzLwRT9MN/GwT
         MwQDD6YhBGEWONQP1eD2V9cCPxApJbE9GovocKzlG2NMZhal6BTZUxu+2rOYaRvdQy
         gE3f6cCidYwxkdLUiMEN1FQhTnvj+rVnE2d8mkEW913UcUFccA4uK7VWOW4XVYOhMz
         AqoKItcYNTa6KEU2tohytxe7qzEzklXKV6lMbvS/RCSr7plb6zYL9x2ZjNsk+hKiYL
         tNstCpZgMxf8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Witold Baryluk <witold.baryluk@gmail.com>
Cc:     arnd@kernel.org, Larry.Finger@lwfinger.net,
        alexandre.belloni@bootlin.com, arnd@arndb.de,
        claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        ilw@linux.intel.com, johannes@sipsolutions.net, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicolas.ferre@microchip.com,
        pavel@ucw.cz, quic_jjohnson@quicinc.com, stas.yakovlev@gmail.com,
        stf_xl@wp.pl
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
References: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
Date:   Thu, 26 Oct 2023 12:41:27 +0300
In-Reply-To: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
        (Witold Baryluk's message of "Wed, 25 Oct 2023 22:27:20 +0000")
Message-ID: <87o7gld8l4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Witold Baryluk <witold.baryluk@gmail.com> writes:

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
> I still use ipw2200 on Intel PRO/Wireless 2915ABG [Calexico2] Network
> Connection card, in my IBM Thinkpad X41 (Pentium-M 1.73GHz, Centrino
> platform). The laptop is rock solid, and I use it as a backup for my
> other Thinkpad. In fact is sometimes preferable to more modern machines
> (IMHO X41 itself is the best laptop ever made in terms of a design).
>
> Never had really issues with WiFi on it. In terms of speed it is neither
> far or slow, but does the job anyway.
>
> Now, I do not use this laptop frequently, maybe once or twice a month.
> But that is more because in I use laptops less in general these days. Not
> because the machine is not usable. I have modern SSD in it, second hard
> drive, two USB 3.0 ports via ExpressCard, high res 4:3 (1440x1050)
> display, full disk encryption, etc.
>
> I would really like for this driver to stay in the mainline for another 5-10
> years.

Thanks for the thorough report. By my calculations that's the third user
report about ipw2x00 so clearly there are users still and we shouldn't
remove the driver. I'm dropping this patch 10 from my queue now.

> I might be interested in modernizing the driver, but I have no idea how
> much effort it would be (in terms of changed fraction of code). 20k LOC is
> neither small or big, and not obvious (a lot of it would be unchanged),
> if it is a week of work, or months of work.
>
> I would not have an issue with removing it, and readding back if somebody
> (or me) ports it, if not for re-review from scratch concerns. If I port
> it, I would not be able to do re-review, 1) out of date coding standards,
> 2) different reviewers, 3) I would only port needed parts, and keep rest
> of the driver intact, so I would not be able to really provide much
> insight. So, readding after porting might be harder than keeping and
> porting.

It would be great if you could cleanup the driver and convert it to use
mac80211. In the wiki link below there is more info how to contribute
patches to the wireless subsystem. I always recommend starting with
something small and going towards more complex patches with baby steps.
Avoid patchbombing as much as possible!

For example, I see lots of dead code under '#ifdef NOT_YET' and '#if 0',
removing those is a good a start. Also converting the ugly debug_level
procfs file to something more modern would be nice, maybe using just
dev_dbg() throught the driver is a good option? Or maybe use a module
parameter instead?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
