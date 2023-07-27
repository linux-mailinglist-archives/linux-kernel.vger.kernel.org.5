Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C81765828
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjG0QAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjG0QA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB8BC;
        Thu, 27 Jul 2023 09:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DCF61E06;
        Thu, 27 Jul 2023 16:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F90CC433C8;
        Thu, 27 Jul 2023 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690473626;
        bh=f5m8BGhtN6zBxnVwJ+ho2scIqcjIJySmiEoYp/0u46I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Zx+nPrzkjVwYmOzLqBoOHudWiVte0aG41ndPOdr+LiYIMiXAAXXEKSP9pDuEG2y5L
         nmN8Kpd+cv43df4ijqgds7+65i0cNIIyPsv3E8Xo9vPPe1uFXsHSRtGd3wD9t9PwxS
         Q/Ym0Z8LxRYzEe1vvAUsmrl5tqV8dsf+KqVh05H9dFZ2tHUSToEOrh3mI5o9VW6RZx
         2X324IRq6rXWvu5t4cgcR1uLxO+IYzawNauV2VddPtVPq8NATjY20WdsCzogEkewHP
         bvEpJvlQpy7iEQ+VtKQt8RcZLTpbG0YKfcbSjSj30R20IT802X/OWcGrK7HT6sZvT9
         Wic+BgtEgdKYw==
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
Date:   Thu, 27 Jul 2023 19:00:21 +0300
In-Reply-To: <169047317159.2400214.7882697833368890001.b4-ty@chromium.org>
        (Kees Cook's message of "Thu, 27 Jul 2023 08:52:55 -0700")
Message-ID: <87tttpz6ne.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, 03 Jul 2023 18:12:56 +0000, Azeem Shaikh wrote:
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy() here with strscpy().
>> 
>> [...]
>
> Applied, thanks!
>
> [1/1] wifi: mt76: Replace strlcpy with strscpy
>       https://git.kernel.org/kees/c/535c78cbc0c4

Why did you take this? mt76 is in active development so risk of
conflicts is high.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
