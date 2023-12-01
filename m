Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F332800F92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379526AbjLAPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379508AbjLAPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:39:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B410D8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:39:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBDDC433C7;
        Fri,  1 Dec 2023 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701445181;
        bh=V7WtW43roNI+kWQ1jgxoaFh9ZbnjwKeONNImrea0QOQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TRASJF6OIlc3u7XXuhbDaK4viFQJH7E7P4b0J4LqnZBm3T4XlnR3wBJcRPM9GJJO4
         4Y3WNVYM4egNGn7EKS+XOf7HsyIWWI1Ehnm+UycZlQSrC7GkVbPj/7oh4rYBe9Ht/3
         Q8rfJDaPym3mbS1oRuUcd7Vy4vu8MUT7Jlq0QsMl1UPCi5URZ2uu+0dCnh7/NJHdvr
         AOgvp6+9g5MBccZC9x5e2TXU8Eg2bC9bCY7IiiWlMjj1jU3MkU2p5RjuMLWiXpjfxN
         KoK0WQEMGg98VWuozPV8zRgNgzyxLI3luIXEVYj89SJnBDR6Vm0nnbrxcaIOf+rl7s
         FVxTlyu/GUKTA==
Message-ID: <179a4581-f7df-4eb1-ab67-8d65f856a2fe@kernel.org>
Date:   Fri, 1 Dec 2023 16:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
Content-Language: en-US
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Topel <bjorn@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Andre Fredette <afredette@redhat.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
 <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
 <PH0PR11MB58306C2E50009A6E22F9DAD3D881A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <6569f71bad00d_138af5294d@willemb.c.googlers.com.notmuch>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <6569f71bad00d_138af5294d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/23 16:09, Willem de Bruijn wrote:
> Song, Yoong Siang wrote:
>> On Friday, December 1, 2023 6:46 PM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>> On 12/1/23 07:24, Song Yoong Siang wrote:
>>>> This series expands XDP TX metadata framework to include ETF HW offload.
>>>>
>>>> Changes since v1:
>>>> - rename Time-Based Scheduling (TBS) to Earliest TxTime First (ETF)
>>>> - rename launch-time to txtime
>>>>
>>>
>>> I strongly disagree with this renaming (sorry to disagree with Willem).
>>>
>>> The i210 and i225 chips call this LaunchTime in their programmers
>>> datasheets, and even in the driver code[1].
>>>
>>> Using this "txtime" name in the code is also confusing, because how can
>>> people reading the code know the difference between:
>>>   - tmo_request_timestamp and tmo_request_txtime
>>>
>>
>> Hi Jesper and Willem,
>>
>> How about using "launch_time" for the flag/variable and
>> "Earliest TxTime First" for the description/comments?
> 

I don't follow why you are calling the feature:
  - "Earliest TxTime First" (ETF).
  - AFAIK this just reference an qdisc name (that most don't know exists)


> I don't particularly care which term we use, as long as we're
> consistent. Especially, don't keep introducing new synonyms.
> 
> The fact that one happens to be one vendor's marketing term does not
> make it preferable, IMHO. On the contrary.
>

These kind of hardware features are defined as part of Time Sensitive
Networking (TSN).
I believe these TSN features are defined as part of IEEE 802.1Qbv (2015)
and according to Wikipedia[2] incorporated into IEEE 802.1Q.

[2] https://en.wikipedia.org/wiki/Time-Sensitive_Networking


> SO_TXTIME is in the ABI, and EDT has been used publicly in kernel
> patches and conference talks, e.g., Van Jacobson's Netdev 0x12
> keynote. Those are vendor agnostic commonly used terms.
> 

I agree that EDT (Earliest Departure Time) have become a thing and term
in our community.
We could associate this feature with this.
I do fear what hardware behavior will be it if I e.g. ask it to send a
packet 2 sec in the future on i225 which max support 1 sec.
Will hardware send it at 1 sec?
Because then I'm violating the *Earliest* Departure Time.


> But as long as Launch Time is not an Intel only trademark, fine to
> select that.

The IEEE 802.1Qbv is sometimes called Time-Aware Shaper (TAS), but I
don't like to for us to name this after this.  This features is simply
taking advantage of exposing one of the hardware building blocks
(controlling/setting packet "launch time") that can be used for
implementing a TAS.

I like the name "launch time" because it doesn't get easily confused
with other timestamps, and intuitively describes packet will be send at
a specific time (likely in future).

--Jesper
