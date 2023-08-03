Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110C076E28C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjHCILS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjHCIK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:10:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279A187;
        Thu,  3 Aug 2023 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691049752; x=1691654552; i=deller@gmx.de;
 bh=jVIaHqd0C5FRVw9ggeD+N36uhb3oQPjzcd7X7a5NTpU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=G02+OCbgK/62oGqmTqBpMMQG8jJbkwWovhFBHDojNGwfuK/YhBNze8g8A7NDEkYnYnlLR0O
 Rcts9jaZjiodWKw6HmGrhGb0WIKZ2cokSS3UTjSz6oks2O3nTOn3oMHaKj2LfW1QxKr+TxumU
 4IRf3pTvTZYwBhlA6Y8awQwyCMVC/rKkCBjr7ctkqcj9CtmC8EHbaFflohU4aM0hzpS3xgHLv
 51mHROS+NknNpsBViZ9NciCHL2tLbIdmDLx2WdbrMp44Hg4T/CkqOI5tmR4kBiK2RQNHBDUlR
 ylM16DuXsNcg2niF1iN2qY7zeTrioMrOrHl+cJYLSJsHWmqtENlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1qOR1I3dQx-0032zM; Thu, 03
 Aug 2023 10:02:31 +0200
Message-ID: <5859e93c-23b3-f1f7-9a7c-d2e4c92047eb@gmx.de>
Date:   Thu, 3 Aug 2023 10:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] parisc/mm: preallocate fixmap page tables at init
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803062404.2373480-1-rppt@kernel.org>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230803062404.2373480-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rKpu2Cl0rRssSWl8tLv4kGQF+QIefluskhC1Yw2+jMtpR4zPN57
 0Bkd6wHeBYGzx+mgsdt3vMt/AfjXsKWjN+h0myFpMYSOncVT14tgOqXZmtLMgFnQVXpT9OH
 RqhkLWZNPo5HzsOYz1r2D5F2sVPP7M4t3okiGhR5dKHC60xeB3qKLMlF+OJ+JhtuB+42Asn
 XLK4o1Cmkqo9hSA9v/AGg==
UI-OutboundReport: notjunk:1;M01:P0:cCv/Zue/FhA=;/MUeLeefkbfQvFZTFWjfmbMOO1G
 p2CbgvIztWey6UagEGeWmdDi8ocipXC6oxG54/YLVeEabXaftcFxI9sYqBl+VNpEuzazxFOnU
 xOMooJ8fnz1cyjYIEcP4Pem5amu4nfh5DzWHe9/GkyHDLMA56VB4AWR9h5NC8KNsXK06NGRGb
 ZRItT4iRBCAnQigZiOt9X/CNHwmufMbb4l+5zrB4cmoNcmae4XM2tsvGQFJdtIA5UXAP+RuvL
 VWyR+Hw7Pp6cGyvo8Bg6mq2YvojHMXcJyMq6b0M8Dbx6Wgr/F2TwyJUefvYMv9PZb9RaEAplh
 dWgAOrkoDT1I5J/u9X2dHmJPNVEI4RF59oqZqk/4MXCQtvjkYmMy6R6M3ImUloQsD7vIlz9gO
 dR1zWdhefGNlGBWL4Q3EOILDcc1lDNm+SumVnf825CIlame8E5AIQ59vD1BYLuotUBf7FwisX
 9rYYp0LwvQ5iZVoV0ZJcyulDHRP+avMKFqRjuia6h8rSFQF4eMk9UQavyzjvM+QXbojrHcHes
 zznovfHv/RnY6BLopJrhQ0VwhzKNHz8a+ZEmFzjH+dwr+iK7hKkzmzP7LvGSl/LYsBqoAkiii
 WKa3nmwWMNOvQf8ml+wFta5fRKKq411KWkCFrLUFZLUBSQzQsNUguHInHV2RPghObjT5In6BH
 /H6BA5SzcNmSQ6YUpQROt+KZtFFYclbKLSm+YaiG6IGB/96Yhjwv30m7pUN6zDkrl60+ZmdY2
 5UW0Lqyj5ER2pC7E685X9sNrxO0ceWLJRgZFPWx+++h6DB168IhEtx37hdkzZHgC7cROlhcgX
 qPD2cWU+LmQJmj0kgeNoyd8WOOE72Gy1ItqaxACp1m4noh0XnZwykhp6KpnGhSxCf9hDRKNsl
 U9alRSPEi72/LbP8JDtQ5U6zc7hgNvsKn/xLGmIx4GTHq4JXWMErDgigx/CnFvOzhV/0706oD
 2x0zy6VkAXYyRyvVBpTgNpaEi1E=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 08:24, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Christoph Biedl reported early OOM on recent kernels:
>
>      swapper: page allocation failure: order:0, mode:0x100(__GFP_ZERO),
> nodemask=3D(null)
>      CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc4+ #16
>      Hardware name: 9000/785/C3600
>      Backtrace:
>       [<10408594>] show_stack+0x48/0x5c
>       [<10e152d8>] dump_stack_lvl+0x48/0x64
>       [<10e15318>] dump_stack+0x24/0x34
>       [<105cf7f8>] warn_alloc+0x10c/0x1c8
>       [<105d068c>] __alloc_pages+0xbbc/0xcf8
>       [<105d0e4c>] __get_free_pages+0x28/0x78
>       [<105ad10c>] __pte_alloc_kernel+0x30/0x98
>       [<10406934>] set_fixmap+0xec/0xf4
>       [<10411ad4>] patch_map.constprop.0+0xa8/0xdc
>       [<10411bb0>] __patch_text_multiple+0xa8/0x208
>       [<10411d78>] patch_text+0x30/0x48
>       [<1041246c>] arch_jump_label_transform+0x90/0xcc
>       [<1056f734>] jump_label_update+0xd4/0x184
>       [<1056fc9c>] static_key_enable_cpuslocked+0xc0/0x110
>       [<1056fd08>] static_key_enable+0x1c/0x2c
>       [<1011362c>] init_mem_debugging_and_hardening+0xdc/0xf8
>       [<1010141c>] start_kernel+0x5f0/0xa98
>       [<10105da8>] start_parisc+0xb8/0xe4
> ...
>      Kernel Fault: Code=3D15 (Data TLB miss fault) at addr 0f7fe3c0
>      CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc4+ #16
>      Hardware name: 9000/785/C3600
>
> This happens because patching static key code temporarily maps it via
> fixmap and if it happens before page allocator is initialized set_fixmap=
()
> cannot allocate memory using pte_alloc_kernel().
>
> Make sure that fixmap page tables are preallocated early so that
> pte_offset_kernel() in set_fixmap() never resorts to pte allocation.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Now queued up in parisc for-next tree.

Thanks to Christoph for bisecting and Mike for coming up with this patch!
Helge
