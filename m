Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1079E59C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjIMLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjIMLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:01:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E719A6;
        Wed, 13 Sep 2023 04:01:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81941C433C7;
        Wed, 13 Sep 2023 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694602883;
        bh=njWoZyjVfNLBeTuRkPaCYOoH5IOVyF7UqVGkU/ZLhaE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lOGGc71M3PzJIruz0pNtMlJmyc2d/NBhzOpmekVSfvro4RoXb9hZgM35vFymdEdmp
         kP0heobKPtubsoEjs7oEsWD2bKYGIXYICuQ9HU/Ndsi2Xhvr8VrjxSYoPDd5FwAVMy
         8Fck0MHX5bH8yUzLRNWk4CXyCksH5MvrLuDMp6pdlGQkZh7RnJUVtjgWuqkMheRjfu
         kJ15mFkdiqsxKbpSdBb6zn6krVeLebsOd6F15O4or49gr1xO2nJ7ER31ZVTTxI/lPv
         X1aiJ0g6PK/v2RjlfUfGVm61uH14dWHAEq7eqaRsv/GkTjTY0JX4+matdkLVe8eckE
         tdtcKw4dNfUkw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, marcan@marcan.st, keescook@chromium.org,
        gustavoars@kernel.org, hdegoede@redhat.com,
        ryohei.kondo@cypress.com
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
        <87msxqlaao.fsf@kernel.org> <20230913111747.35839fd8@gollum>
Date:   Wed, 13 Sep 2023 14:01:18 +0300
In-Reply-To: <20230913111747.35839fd8@gollum> (Juerg Haefliger's message of
        "Wed, 13 Sep 2023 11:17:47 +0200")
Message-ID: <87jzsucp6p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Haefliger <juerg.haefliger@canonical.com> writes:

> On Wed, 13 Sep 2023 11:58:07 +0300
> Kalle Valo <kvalo@kernel.org> wrote:
>
>> Juerg Haefliger <juerg.haefliger@canonical.com> writes:
>> 
>> > Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
>> > UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
>> > 'element' and 'channel_list' will trigger warnings, so make them proper
>> > flexible arrays.
>> >
>> > False positive warnings were:
>> >
>> >   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6984:20
>> >   index 1 is out of range for type '__le32 [1]'
>> >
>> >   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1126:27
>> >   index 1 is out of range for type '__le16 [1]'
>> >
>> > for these lines of code:
>> >
>> >   6884  ch.chspec = (u16)le32_to_cpu(list->element[i]);
>> >
>> >   1126  params_le->channel_list[i] = cpu_to_le16(chanspec);
>> >
>> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>  
>> 
>> Should this be queued for v6.6?
>
> I would think so. It's a problem since 6.5. Which reminds me that I should
> have added:
>
> Cc: stable@vger.kernel.org # 6.5+

I can add that during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
