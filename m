Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234C7A504F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIRRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjIRRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBFE93;
        Mon, 18 Sep 2023 10:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D542C43391;
        Mon, 18 Sep 2023 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695043234;
        bh=ij64horHxqCr6tNsHUKw9q182XiZPq+6TuHedYlAa8A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bJ7yDdHKoHkvsLxRuIHaF8svocpAFG573VOvgpGy2veP6jiXsKZrk6j8En2Agh4Wb
         3FcoC9RO7PUyVPvlKlgmbMho9gEGeW+2tZUaj7Wl5Uk7SKbyaFSDSxjDApZvDRY/O8
         Ctg/DyPa54XDpujgjx1ff/ccB/x69Qn5RCM6R4+ij9qqbkUlPYPHD11xb+zMwQ+daL
         YMpG9u2AtWV7Ks3X95Pr4MAnQOrH6gI96LOnzRC58RZBrhm+tlaGOd2ysygxd8qE88
         BjFdEK9G9xNHZOoJ7jtu+6+6wc5CubsvBdYzsKNaWrFgEs+0g35TgJe+jPSFGfls4N
         IM4UHjRe1trHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230914070227.12028-1-juerg.haefliger@canonical.com>
References: <20230914070227.12028-1-juerg.haefliger@canonical.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     juerg.haefliger@canonical.com, SHA-cyfmac-dev-list@infineon.com,
        aspriel@gmail.com, brcm80211-dev-list.pdl@broadcom.com,
        franky.lin@broadcom.com, gustavoars@kernel.org,
        hante.meuleman@broadcom.com, hdegoede@redhat.com,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        marcan@marcan.st, ryohei.kondo@cypress.com, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504322899.617522.3173548821985178100.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 13:20:30 +0000 (UTC)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> 'element' and 'channel_list' will trigger warnings, so make them proper
> flexible arrays.
> 
> False positive warnings were:
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6984:20
>   index 1 is out of range for type '__le32 [1]'
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1126:27
>   index 1 is out of range for type '__le16 [1]'
> 
> for these lines of code:
> 
>   6884  ch.chspec = (u16)le32_to_cpu(list->element[i]);
> 
>   1126  params_le->channel_list[i] = cpu_to_le16(chanspec);
> 
> Cc: stable@vger.kernel.org # 6.5+
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless.git, thanks.

4fed494abcd4 wifi: brcmfmac: Replace 1-element arrays with flexible arrays

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230914070227.12028-1-juerg.haefliger@canonical.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

