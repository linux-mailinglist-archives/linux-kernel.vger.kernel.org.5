Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83023802E07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbjLDIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:37:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4117CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:37:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5BEC433C7;
        Mon,  4 Dec 2023 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701679075;
        bh=ftmmbjUPFPYaMVVTsCh1SAKi4plLZBTdcQEkERtxlG4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Tg/7WLEZoOcMn2nDBFBn/UG3NI6uXNyiSPClpRfA1cBfPtSx2pDbdWD/H4k56mwoE
         +QNupT1g1geF2oa+jqBmH44890zbr8wjRors3E3pX4A+bGdtIUR4qmCh0y81LPaSBy
         +BIWDBqCTOHTsNmlUSXqYIFOOAwZJ6mVZwrWVTVNNtKb9/dg+eXmln9zoPb4txG4aW
         o9JR6NOaTn2PWaU6xhPjs8Wx+XIXN3nAtWN4jHRUxOygjlDjfLyuQQbmjmQUOgbZJw
         AnPgrYkuxx6xeeym9KAEhHXELSvGAUhEYG8zeLPUJu1RIZMTmh/20qaUmeHT+ggNBC
         E3sI7GQMAL8eQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix -Warray-bounds warnings
References: <ZVaCNAohuieMmdq9@work> <202312021326.D3504C1@keescook>
Date:   Mon, 04 Dec 2023 10:37:50 +0200
In-Reply-To: <202312021326.D3504C1@keescook> (Kees Cook's message of "Sat, 2
        Dec 2023 13:27:54 -0800")
Message-ID: <87zfyqqs69.fsf@kernel.org>
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

> On Thu, Nov 16, 2023 at 02:57:24PM -0600, Gustavo A. R. Silva wrote:
>
>> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
>> flexible-array members in anonymous union in `struct
>> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
>> helper; and fix multiple -Warray-bounds warnings:
>> 
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> 
>> This results in no differences in binary output, helps with the ongoing
>> efforts to globally enable -Warray-bounds.
>> 
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> *thread ping*
>
> Can wireless folks please pick this patch up?

Ok, I assigned this to me on patchwork now. Felix, please let me know if
you prefer to take this to your tree instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
