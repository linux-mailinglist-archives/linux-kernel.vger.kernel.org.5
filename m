Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087827C7C87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJMEVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:21:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE893B8;
        Thu, 12 Oct 2023 21:21:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFD8C433C7;
        Fri, 13 Oct 2023 04:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697170863;
        bh=eF3uwEMunt9TVhu7tojnLiF5ASnkzXEcPB/OGE9CrCc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=X8QMaHw5+VAOpcKTk5shLloNae1MDJ8/J4Wstt0y4EboG6sznMG7Q/nJt1r9Cpht4
         LGUt44k3oRSBV58xFjE9pa1cXrwW86nwKqyp/9ggv/oRzLSY0/P1LuVby3f4zK9iS1
         Yvl8iiXy3HiDKR6ZRvjQD4IUTR+m+k5/41P2AP+z27aqYRrR4NYnlvrIHSx+J6Bd/q
         JT+xBjQbqgAP2PJBzgBRqSw5bzACnMhlC/v680RsdeaXu0Iv3qnfTIvbcy23HQqRrP
         nrGCZezXjxBMmRdAabK0fZSzGQmFZ4eM/7VOrvbW6MShhdFiVVuITDcRfdeauu2o6P
         REShTeYoxjLaA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     pkshih@realtek.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write
 RF mode table fail
References: <6991a517301a46159085a0b06d43f319@realtek.com>
        <20231013023848.10444-1-amadeus@jmu.edu.cn>
Date:   Fri, 13 Oct 2023 07:23:36 +0300
In-Reply-To: <20231013023848.10444-1-amadeus@jmu.edu.cn> (Chukun Pan's message
        of "Fri, 13 Oct 2023 10:38:48 +0800")
Message-ID: <8734yff8vr.fsf@kernel.org>
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

Chukun Pan <amadeus@jmu.edu.cn> writes:

> Hi, Ping-Ke
>
>> Why do you think this trace is useless? As I see, there is more than one callers.
>> Did you meet a real case it throws this trace? If yes, how about the frequency?
>
> [  217.651858] ------------[ cut here ]------------
> [  217.654813] write RF mode table fail
> [  217.657434] WARNING: CPU: 2 PID: 3705 at 0xffffffffa03df3cb [rtw88_8822b@00000000bf0fde9e+0x35000]
> [  217.662078] Modules linked in: rtw88_8822ce rtw88_8822c rtw88_8822be rtw88_8822b rtw88_8723de ...
> [  217.704412] RIP: 0010:0xffffffffa03df3cb [rtw88_8822b@00000000bf0fde9e+0x35000]
> ...
> [  217.737232] Call Trace:
> [  217.738683]  0xffffffffa03df943 [rtw88_8822b@00000000bf0fde9e+0x35000]
> [  217.740865]  0xffffffffa0385ab9 [rtw88_core@00000000a8d26f0d+0x1a000]
> [  217.742993]  0xffffffffa0279111 [mac80211@000000003cb4b3bd+0x7b000]
> [  217.745028]  0xffffffffa0239092 [cfg80211@00000000a951c4b5+0x46000]
> [  217.751368]  ? 0xffffffffa0238de0 [cfg80211@00000000a951c4b5+0x46000]
> [  217.773278] RIP: 0033:0x7ff0cdf8836c
> ...
> [  217.789457] ---[ end trace 177712424e9eab4a ]---
>
> As you can see this trace above, I don't think it's useful. This
> trace throws up a lot of register values but doesn't point out why.
> As long as I plug in the rtl8812bu or rtl8822be wifi modules, this
> trace will be thrown every time when the rtw88 driver is loaded.

_Why_ is that warning printed? Are your devices uncalibrated or are they
somehow else special?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
