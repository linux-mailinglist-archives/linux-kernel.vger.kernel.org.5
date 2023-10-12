Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296047C6D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379168AbjJLLtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378847AbjJLLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50B1A5;
        Thu, 12 Oct 2023 04:47:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29692C433C8;
        Thu, 12 Oct 2023 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697111229;
        bh=Os/rNYAUGPL9imcxx13LMUsomb2BE6SwhLERSQGYHhY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fyWT3MLEW1gImBZOebPavwDqi8qE6hF1yUAbAy6IIPxDuxtOBsXzsEYb2jkWWXfgD
         TZ/j4YZwEHDQIN3IaI8MRA6IF+gmYEUck2qy7B6+uUVKkU3iACYVdZrCJRkRwW9Ww4
         yKGN65dkV5mHmyFWmOYoFo+L16YMw+hdk3RfcvWTbDjBzpx3JTzVX92IjXMLqtEj0i
         +R1VOtRwueBgf2L4GcM6VVrsU9ca2DXyzxbbZdix49Aw9ZQpcTwxphQSiFWZ9Z6bou
         eyMMmQ4aRjnJTRIEG7XQU4/HIA3zc4rb8uUawk143bDjCCviRZ4zdrwNFhNBeg/OYQ
         38QyvtFWyTvXQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
References: <20231010155444.858483-1-arnd@kernel.org>
        <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
        <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
        <20231011080955.1beeb010@kernel.org>
Date:   Thu, 12 Oct 2023 14:47:03 +0300
In-Reply-To: <20231011080955.1beeb010@kernel.org> (Jakub Kicinski's message of
        "Wed, 11 Oct 2023 08:09:55 -0700")
Message-ID: <87sf6g2hc8.fsf@kernel.org>
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

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Oct 2023 10:29:58 +0300 Kalle Valo wrote:
>> > No matter what the time frame is, it's never going to line up with all
>> > distros, or catch everyone properly.  
>> 
>> Yeah, that's true.
>> 
>> > I recommend, just delete all the ones you feel are not being used, in a
>> > patch that removes them one-by-one, so that it is trivial to revert if
>> > someone shows up and says "hey, my device stopped working!" a few years
>> > in the future.  
>> 
>> I'm starting to lean towards this as well. We have talked about this for
>> so long now but no practical solution ever found so maybe just bite the
>> bullet finally. What do others think?
>
> FWIW in Ethernet we do what Greg says. Delete it, if someone complains
> we revert back in. The revert did actually happen once, it was pretty
> painless (Greg even took it into stable tree, IIRC).

Thanks, good to know that you have had positive experiences with this
approach. As I didn't hear any concerns from anyone so I'm convinced we
should do this. I'm sure it will make my life a lot easier :)

Is anyone willing to submit patches? Use wireless-next as the baseline
for patches and one driver per commit, please. That way it's easy to
revert later, if needed (hopefully not).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
