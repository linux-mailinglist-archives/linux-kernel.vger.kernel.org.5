Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9943376E881
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjHCMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHCMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:40:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3022359A;
        Thu,  3 Aug 2023 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691066403; x=1691671203; i=deller@gmx.de;
 bh=VfGFsvhM3NXEWVTS/Pqo/Rf2INpNTw7Zff1M2lzdqGU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iHrSV9dlW3MHmKaIX49CNlAJFpHXV05EltWQ3KAQ3GPHp1q64GqgEX8zHXYSPgaRnDO+TGH
 0rWrwIzRtgl/Iui2hXSyULGFFW7DJ48+kO6wzE/OYKejtWZ2WDDL4oRHj6vaxAEdv67oR2iBb
 /7YXju/WWjKkNS+Qr3a109wMj9sY8p2Mp06VI4SyAV9NslxBDdo24QJrQbYZ2GqxNHQnb9nyU
 d93oiFCc+GyCO6sxAoxLGqCs+vfvHpmTSnD43qPi76ZeChrM0vgqSmhrgWYKu/ikt3W9+0Eas
 AyVARg8Wgpfj0mqe58hr4EUKPTVRqEpZRsuUyWcRTTbL87R2gepw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1pfeMu49v4-00x3nX; Thu, 03
 Aug 2023 14:40:03 +0200
Message-ID: <81dea998-a8b1-cac4-5e70-1bf65945af09@gmx.de>
Date:   Thu, 3 Aug 2023 14:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] parisc/mm: preallocate fixmap page tables at init
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>
Cc:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230803062404.2373480-1-rppt@kernel.org>
 <d0b555a4-ed2e-3100-ae12-1b05f3035824@suse.cz>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <d0b555a4-ed2e-3100-ae12-1b05f3035824@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mSWNI6hXW5Y7DRz3ttyGhJTyDIigRAiJsobVe2vANRJxAzdc390
 krqbN8aZFB4H5VPSQiisnHFYXi/5UVeQjx82J++LkwV62SSA8kcV3CscCNMwwnMCPH7OCS/
 VZycnnboGStgALSCc8VrCchCbK/grl5CE6Ph88UwVnO0I8mAzEeTVjo5jaF6QLzBe33PvDE
 l6GA+yS0/XxOBAXkeGxEw==
UI-OutboundReport: notjunk:1;M01:P0:lbCHyjF73gk=;Mnc8dosV1aSKZRN5kbluC1OeWsh
 ovIh6bc3TEe4j42GIbvr4md3Z6DKK6sZQIszEvoxCqTU/IjDNY952+r2ipluRtvLTvtt5Cjqf
 VP/QQUrClwKLmr99uG7STitBtfV8n6fXfzs1fToxLFGj/cPNIy9DxBcqup1yIBB7gxzz2f3dK
 jdjcJwi4ZF2Hs57jYQWRzS1MAtunQKx8l0K4jk8j2s0+Kk714sY0/Okm7D23V37zwfmvHAjX8
 Pr8RgcaIcDXIPt+/iZGviiz5hJHx8RcDiLe9MzhCMTD/smMVv6Qf0car8aABzyK/KBqxE/R9L
 yD/KeG4a4lGf8C0hvh7vA6lJ/aqB2cJ/eZBFhzC7luZ1aDHaZ5ulz0Su5EQblSWdnHjW90N+f
 dcm1u3yloe8WxaAnCTTJuxdwfviUQ5ZpL2XYNs9GkztDw7w6C9v/JYgCTlenNyqvmKJjHtkUc
 XTxFysX4IFWOhtwLwPib8tN74z7wt+5tOGRPapviU0veHX2s7/b2ZBBGUpkaFJQvJsZEj/96T
 J6FrDtANy9R2LlCzjGjJT3ddpAMOjt4cJvbFo5G57t/BMBirfKEX9wkWVlVUXH5nt1x+OoaAu
 sjL83feseVxu3micZZDmIEa4aT2reflR348DUch48xt3wqOWhtF5IIpNKaSgo60EMFa+8C+P5
 /dIUUSCPglMv4PmD7fgiVaW0KOq5KVRj5QX7I2ZyT4tz16ay36Vog38REoBUSB9N5WcfAUTtM
 bfiW+LoJJipWgvbjxVH8rvAPQ7OSc0HZvITzT/uCBxrG9K+DDbu5BKiqSjxz6YJ0eG54EmkUU
 QEnaEma1e4Ttay1RvwElJ3eDegZWnpc9M04KjhmJaOKBBVqdUavigCXFUNBacgzzddGGKyCel
 XuDSycaD3HliHsRxb3joSxMVz+K+e+Anh8sZKQOYWGR1629S1MZ3XlGf0jwPByTa8utA2bFpX
 u8c6ONJxO3We4UaNwjTgQRyb31k=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 10:48, Vlastimil Babka wrote:
> On 8/3/23 08:24, Mike Rapoport wrote:
>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>
>> Christoph Biedl reported early OOM on recent kernels:
>>
>>      swapper: page allocation failure: order:0, mode:0x100(__GFP_ZERO),
>> nodemask=3D(null)
>>      CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc4+ #16
>>      Hardware name: 9000/785/C3600
>>      Backtrace:
>>       [<10408594>] show_stack+0x48/0x5c
>>       [<10e152d8>] dump_stack_lvl+0x48/0x64
>>       [<10e15318>] dump_stack+0x24/0x34
>>       [<105cf7f8>] warn_alloc+0x10c/0x1c8
>>       [<105d068c>] __alloc_pages+0xbbc/0xcf8
>>       [<105d0e4c>] __get_free_pages+0x28/0x78
>>       [<105ad10c>] __pte_alloc_kernel+0x30/0x98
>>       [<10406934>] set_fixmap+0xec/0xf4
>>       [<10411ad4>] patch_map.constprop.0+0xa8/0xdc
>>       [<10411bb0>] __patch_text_multiple+0xa8/0x208
>>       [<10411d78>] patch_text+0x30/0x48
>>       [<1041246c>] arch_jump_label_transform+0x90/0xcc
>>       [<1056f734>] jump_label_update+0xd4/0x184
>>       [<1056fc9c>] static_key_enable_cpuslocked+0xc0/0x110
>>       [<1056fd08>] static_key_enable+0x1c/0x2c
>>       [<1011362c>] init_mem_debugging_and_hardening+0xdc/0xf8
>>       [<1010141c>] start_kernel+0x5f0/0xa98
>>       [<10105da8>] start_parisc+0xb8/0xe4
>>
>>      Mem-Info:
>>      active_anon:0 inactive_anon:0 isolated_anon:0
>>       active_file:0 inactive_file:0 isolated_file:0
>>       unevictable:0 dirty:0 writeback:0
>>       slab_reclaimable:0 slab_unreclaimable:0
>>       mapped:0 shmem:0 pagetables:0
>>       sec_pagetables:0 bounce:0
>>       kernel_misc_reclaimable:0
>>       free:0 free_pcp:0 free_cma:0
>>      Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
>> inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
>> mapped:0kB dirty:0kB writeback:0kB shmem:0kB
>> +writeback_tmp:0kB kernel_stack:0kB pagetables:0kB sec_pagetables:0kB
>> all_unreclaimable? no
>>      Normal free:0kB boost:0kB min:0kB low:0kB high:0kB
>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0=
kB
>> inactive_file:0kB unevictable:0kB writepending:0kB
>> +present:1048576kB managed:1039360kB mlocked:0kB bounce:0kB free_pcp:0k=
B
>> local_pcp:0kB free_cma:0kB
>>      lowmem_reserve[]: 0 0
>>      Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
>> 0*1024kB 0*2048kB 0*4096kB =3D 0kB
>>      0 total pagecache pages
>>      0 pages in swap cache
>>      Free swap  =3D 0kB
>>      Total swap =3D 0kB
>>      262144 pages RAM
>>      0 pages HighMem/MovableOnly
>>      2304 pages reserved
>>      Backtrace:
>>       [<10411d78>] patch_text+0x30/0x48
>>       [<1041246c>] arch_jump_label_transform+0x90/0xcc
>>       [<1056f734>] jump_label_update+0xd4/0x184
>>       [<1056fc9c>] static_key_enable_cpuslocked+0xc0/0x110
>>       [<1056fd08>] static_key_enable+0x1c/0x2c
>>       [<1011362c>] init_mem_debugging_and_hardening+0xdc/0xf8
>>       [<1010141c>] start_kernel+0x5f0/0xa98
>>       [<10105da8>] start_parisc+0xb8/0xe4
>>
>>      Kernel Fault: Code=3D15 (Data TLB miss fault) at addr 0f7fe3c0
>>      CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc4+ #16
>>      Hardware name: 9000/785/C3600
>>
>> This happens because patching static key code temporarily maps it via
>> fixmap and if it happens before page allocator is initialized set_fixma=
p()
>> cannot allocate memory using pte_alloc_kernel().
>>
>> Make sure that fixmap page tables are preallocated early so that
>> pte_offset_kernel() in set_fixmap() never resorts to pte allocation.
>>
>> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> ..
> But if it's manifesting for whatever reason since 6.4 then a "Cc: stable=
 #
> 6.4+" would be in order.

Thanks Vlastimil!
I've added your Acked-by and the Cc...

Helge
