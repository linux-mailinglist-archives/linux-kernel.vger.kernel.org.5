Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF5F79E2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjIMI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjIMI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F548196;
        Wed, 13 Sep 2023 01:56:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653BCC433C8;
        Wed, 13 Sep 2023 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694595392;
        bh=Y1yF1JdFEipuLJy5XAg3taX2OJcsThXzbTWKAi9GM7A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BYKmIMGtAducsE7GoVP9h6mT5cBvkFzI7Bnc3M+pD3ZA082kYg+PiYKPAdKrLhqEg
         YgHE7RGP9ZWXEKsPcte9uykWkElvhA5bHgCgCQPQRgTKJIEFzBtjhjfgtGBsdwnXNs
         MwsazLQyneXwK0j1if2CQ/0b+o3npFT+n8Y5pwAF1/TA/I7Npd+LjLmJm+V5HpnRYh
         ujl7zLsemZOYAbDdH664hTXOh8TlbiSSYkZMxj6t6eLSDXpYWFE/whcL9fhF7ewjqZ
         2NikhTrhkLD4bwY3B1SI3G2wZ01onhBfG1TY/gxgRiimA7tH8otpoOTY0Ct7guif+k
         zqt5cZxk3Cpmw==
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
Date:   Wed, 13 Sep 2023 11:58:07 +0300
In-Reply-To: <20230913065421.12615-1-juerg.haefliger@canonical.com> (Juerg
        Haefliger's message of "Wed, 13 Sep 2023 08:54:21 +0200")
Message-ID: <87msxqlaao.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Haefliger <juerg.haefliger@canonical.com> writes:

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
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Should this be queued for v6.6?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
