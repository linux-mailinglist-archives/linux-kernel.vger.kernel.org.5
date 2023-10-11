Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86F7C4D71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJKIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjJKIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:44:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA99C;
        Wed, 11 Oct 2023 01:44:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EDDC433C7;
        Wed, 11 Oct 2023 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697013845;
        bh=dd+UyXR1Az0fXvBPCAsefm8xWqDo7U7mAoE7+i7ryUE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dIvhcxJLLadwnP7CezapgQe2im9mEM3TP/AijgNT/ZsH9TFSKOcFzdqhAcy1jy8UI
         iM5xhmQ3NyeKbQAbugNyzd7NWp7WC/V7j7dLKQKshgw9VQI/aWWxx+bCmUZF7A9C3u
         /E3J1to57u2h9PetDUpbkFjbdoAGAuwfUHOhb/cqm0wWAHrw6wcJUu5uPrAJhHWYJl
         PAA/4AtfQ3Kc27tZjvO8n7uXIj78NJhUA/6ARVjOajhYx5I+Sr9Kd9XYe8lxWhYsDf
         pNUNi9gAFcWpCSoceUhogcF4HrR5hXvfPJFj9xlDHZR765EeQwURSGc7kTCkVjCrgi
         MGsQibLj2IOMg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-wireless@vger.kernel.org,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Pavel Machek" <pavel@ucw.cz>, "Jakub Kicinski" <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
References: <20231010155444.858483-1-arnd@kernel.org>
        <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
        <d081871c-977c-43e9-afa3-a3c3e5880fea@app.fastmail.com>
Date:   Wed, 11 Oct 2023 11:44:00 +0300
In-Reply-To: <d081871c-977c-43e9-afa3-a3c3e5880fea@app.fastmail.com> (Arnd
        Bergmann's message of "Wed, 11 Oct 2023 09:24:55 +0200")
Message-ID: <87r0m14khb.fsf@kernel.org>
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

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Oct 11, 2023, at 07:40, Kalle Valo wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>
>> We (the wireless folks) have been talking about dropping legacy drivers
>> on and off for several years now. The problem is that we don't know
>> which of them work and which not, for example IIRC someone reported
>> recently that wl3501 still works.
>>
>> Personally I would be extremly happy to remove all the ancient drivers
>> as that reduces the amount of code for us to maintain but is that the
>> right thing to do for the users? I don't have an answer to that,
>> comments very welcome.
>
> I had a look at what openwrt enables, to see if any of the drivers
> in my RFC patch are actually enabled, if anything supports legacy
> embedded devices with these it would be openwrt. The good news here
> is that openwrt intentionally leaves WEXT disabled, and none of them
> are still in use.

I don't think openwrt is a good metric in this case. These drivers are
for 20+ years old hardware, most likely running on really old x86
laptops. So the chances of them running openwrt on those laptops is low
and I would expect them to run more traditional distros like debian or
ubuntu. But of course this is just guessing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
