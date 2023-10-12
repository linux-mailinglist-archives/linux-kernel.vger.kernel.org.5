Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA77C709A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378304AbjJLOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjJLOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:46:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC80DD;
        Thu, 12 Oct 2023 07:46:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB73C433C7;
        Thu, 12 Oct 2023 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697121978;
        bh=O2x78rOBWTFesFHLGuuhfU/0q39fTXA8lDOZUhM2/mQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q6nL+4M+7KTg9VgVgqbBhoqWdSfrxRveBtZLy+eErYUxSVUgM4+fg/IUKw9vZ5bnf
         IQX9ZsfwvYb3k0iixw4+CYudyE3JD/hMcrvlLuyw2+uRL6DNAR6wkCitcOXK54ozu1
         6n+ui8/e/T2z/5wVJHgRau597vQcWIH/Nfb+CBmf6j00OBUCfp1quLgMh7923EKNg1
         WhkQ+daxcTe77B8ZZFqhn7A9HkLJNCRsBbz03mwnnBYoRLDWQDquCZY7DtMLFZhGjK
         UC2fZf4SjBkwOaYj0XTjKzCgQ5SwoTIYraTnG+EtwC3ZbngUfn1fO2k9c97IysCcHn
         j4nDsCl3g+mSQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Jakub Kicinski" <kuba@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Pavel Machek" <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
References: <20231010155444.858483-1-arnd@kernel.org>
        <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
        <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
        <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
        <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
Date:   Thu, 12 Oct 2023 17:48:47 +0300
In-Reply-To: <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com> (Arnd
        Bergmann's message of "Thu, 12 Oct 2023 16:36:26 +0200")
Message-ID: <87fs2fgals.fsf@kernel.org>
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

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Thu, Oct 12, 2023, at 13:47, Kalle Valo wrote:
>>
>> Is anyone willing to submit patches? Use wireless-next as the baseline
>> for patches and one driver per commit, please. That way it's easy to
>> revert later, if needed (hopefully not).
>
> I can do it, I've already done most of the work for moving the
> drivers, so I just need to split up my existing patch and leave out
> the bits that get added to drivers/staging.

Awesome, thank you!

> I'll also send Greg a patch to remove rtl8192u now that we know
> that this has been broken for 7 years. Similarly, I'd include
> another patch to remove PCMCIA support for libertas, as that
> would otherwise be the only remaining 16-bit PCMCIA wlan card,
> and I could find no indication of this one ever being popular,
> unlike the USB/SDIO/SPI variants of the same device or the
> other PCMCIA drivers.
>
> This would leave only a handful of wext implementations in the
> tree: ipw2x00, ps3-gelic-wireless, staging/rtl8712, staging/rtl8192e
> and staging/ks7010. Since ipw2x00 is apparently still supported
> in theory and was rather popular on Pentium-M based systems 20
> years ago, this may still need to be converted to cfg80211
> before you can remove support for wext style drivers altogether.
> ps3-gelic-wireless and rtl8712 are also still maintained but have
> a much smaller user base I assume.

Actually I would prefer to remove ipw2x00 and ps3-gelic-wireless as
well. I have not seen any evidence that there would be users for those
drivers. If we find out that there really are users I can easily add the
drivers back. The faster we get rid of wext the better, it really needs
to go away.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
