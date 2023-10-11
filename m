Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036377C4BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbjJKH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:27:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F948F;
        Wed, 11 Oct 2023 00:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCA8C433C8;
        Wed, 11 Oct 2023 07:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697009251;
        bh=03aSR9vRMyR6WZ4IDbMq/8rQA70nwzn1OKbYDhAxn34=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AHixd93NgnbD0YCJeZq2fcEy2ebK/TS8VICXgDNmLSzi5dRPe8UA8+cWwHCtnMaHW
         vMJBZjhZYK1KqZpV3P9DUn1ZnKUtuBokHyk1imkMlPPDwY655vi50wGWoiaHVFwluC
         55PCrbs7BT+kk6x7LSnkN3PGlPA7pcGHi3qETw3TDTnlPo1ojFdlh30pInNNP5fPGq
         6udcrSx+IGBvGZX7i6JiSFr02rTol2qEu4MLbcKvis8LH+H4oqwiKqyk+7z+/FG+5v
         rJ3/twlRbCQNR4KwAzvAEYJLsV3gZczzKCPn/MM8yvlSy+rIb4BrGR4DnzmuGgzm20
         vOpSrMbBTc3yw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
References: <20231010155444.858483-1-arnd@kernel.org>
        <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
        <2023101139-pyromania-game-2237@gregkh>
Date:   Wed, 11 Oct 2023 10:29:58 +0300
In-Reply-To: <2023101139-pyromania-game-2237@gregkh> (Greg Kroah-Hartman's
        message of "Wed, 11 Oct 2023 08:16:38 +0200")
Message-ID: <87r0m1fwg9.fsf@kernel.org>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Oct 11, 2023 at 08:40:00AM +0300, Kalle Valo wrote:
>
>> We (the wireless folks) have been talking about dropping legacy drivers
>> on and off for several years now. The problem is that we don't know
>> which of them work and which not, for example IIRC someone reported
>> recently that wl3501 still works.
>> 
>> Personally I would be extremly happy to remove all the ancient drivers
>> as that reduces the amount of code for us to maintain but is that the
>> right thing to do for the users? I don't have an answer to that,
>> comments very welcome.
>> 
>> I have been also wondering if I should add warnings like this to every
>> ancient driver to see if there are any users left:
>> 
>> "wl3501 wireless driver will be removed in 2024. If the driver still
>> works and you are using it send a report NOW to
>> linux-wireless@vger.kernel.org to avoid the removal."
>> 
>> But with the long release cycles the kernel and distros have I doubt
>> waiting for a year is enough, it should be more like three years.
>
> No matter what the time frame is, it's never going to line up with all
> distros, or catch everyone properly.

Yeah, that's true.

> I recommend, just delete all the ones you feel are not being used, in a
> patch that removes them one-by-one, so that it is trivial to revert if
> someone shows up and says "hey, my device stopped working!" a few years
> in the future.

I'm starting to lean towards this as well. We have talked about this for
so long now but no practical solution ever found so maybe just bite the
bullet finally. What do others think?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
