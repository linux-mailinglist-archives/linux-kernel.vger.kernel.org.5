Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8FE76AC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjHAJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjHAJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:12:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B31F659F;
        Tue,  1 Aug 2023 02:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1367B614DC;
        Tue,  1 Aug 2023 09:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D507C433CB;
        Tue,  1 Aug 2023 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690880875;
        bh=JXpCu7p/CWKp6jZPKSaMbWukxpZFXpkVBsqC2SBekyA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mCPPWfmGfXdKrezEfgf+KOFfVTcNZx0K/TebxxhKsXMzcwSfJxxCb2eJvgc9jx2dh
         dLZqYaBonuGMqrlq+8DChi8+bStP7esX3VEHg1jTRvK4807qAiMV0MLkczC5FAOrIH
         +RvIexjcALqhHlm/05+s6E2xowislWYJ7QN+iLKCtARlf0B6ntuQWj9X/otVtMIAVB
         oBdkXvYMcvFEwAVPdKGVm0pERWFzHLni9h45fkrUdXlBs/Wc2psG98zEEEuew0yywf
         0En+3hmm6ydDGSWBegsOyUE69SQGYz+vE7Yk7Aj5glDuoxbkbWeG1lOR33oNkretGz
         hXKpAN9fiN3SQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
        <169047317159.2400214.7882697833368890001.b4-ty@chromium.org>
        <87tttpz6ne.fsf@kernel.org> <202307270959.900E3A345E@keescook>
Date:   Tue, 01 Aug 2023 12:07:50 +0300
In-Reply-To: <202307270959.900E3A345E@keescook> (Kees Cook's message of "Thu,
        27 Jul 2023 10:01:37 -0700")
Message-ID: <87zg3bxh95.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Jul 27, 2023 at 07:00:21PM +0300, Kalle Valo wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Mon, 03 Jul 2023 18:12:56 +0000, Azeem Shaikh wrote:
>> >> strlcpy() reads the entire source buffer first.
>> >> This read may exceed the destination size limit.
>> >> This is both inefficient and can lead to linear read
>> >> overflows if a source string is not NUL-terminated [1].
>> >> In an effort to remove strlcpy() completely [2], replace
>> >> strlcpy() here with strscpy().
>> >> 
>> >> [...]
>> >
>> > Applied, thanks!
>> >
>> > [1/1] wifi: mt76: Replace strlcpy with strscpy
>> >       https://git.kernel.org/kees/c/535c78cbc0c4
>> 
>> Why did you take this? mt76 is in active development so risk of
>> conflicts is high.
>
> There didn't seem to be any further activity for 3 weeks, and it was a
> relatively mechanical change.

That's because the wireless trees were on a summer break:

https://lore.kernel.org/all/87y1kncuh4.fsf@kernel.org/

> I can drop it from my tree.

Yes, please drop this. And in the future don't take any wireless patches
unless acked by Johannes or me, I want to minimize the risk of conflicts
between the trees. If a patch is missed for whatever reason please let
me know, do not take it to your tree.

> What's needed for it to be picked up through wireless?

I don't know why Felix didn't take this patch but now I assigned it to
me on patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/20230703181256.3712079-1-azeemshaikh38@gmail.com/

It should be in wireless-next this week.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
