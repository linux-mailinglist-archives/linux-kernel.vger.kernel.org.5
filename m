Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D680306E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjLDKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjLDKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:36:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09002CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:36:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B651CC433C7;
        Mon,  4 Dec 2023 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701686198;
        bh=+ErQN2WS12/khFYfpQDZFxvXogAuk59InCRmaNowfS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TYuJbBEOWc7KkHydu2jfldkno0up5yHsG0uUho4wBtYHENJrIhEzopw828B8nYR2y
         /Bq7E40/MYPd1WbSuMXOvrTR5LHNu4Nyf/Kw+gB/7gkQzftmk1CpVYV9eJwBzY35J7
         xEUZGCUu5mNhYCftzglLku0Qv8rqkxUO3hFH3lqEzc07PY3VLfg/jHqko9fsaF3gZi
         n60G9Q65Bc1Acq6pmo9DI1XvzmOdhIgAhp4s7D3JCsTjOCRoMf5DFu4Adbt8rs1jkb
         JUYwE//FlD7965G/pbx4+GWSA9D9XyXOvGaEDUVAyM3lQkuP2ld5EEhAtkvcn/6u8N
         p2QNPiNTkbN1g==
Message-ID: <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
Date:   Mon, 4 Dec 2023 11:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch Time support to
 XDP ZC
Content-Language: en-US
To:     Song Yoong Siang <yoong.siang.song@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        xdp-hints@xdp-project.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231203165129.1740512-3-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/23 17:51, Song Yoong Siang wrote:
> This patch enables Launch Time (Time-Based Scheduling) support to XDP zero
> copy via XDP Tx metadata framework.
> 
> Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++

As requested before, I think we need to see another driver implementing 
this.

I propose driver igc and chip i225.

The interesting thing for me is to see how the LaunchTime max 1 second
into the future[1] is handled code wise. One suggestion is to add a 
section to Documentation/networking/xsk-tx-metadata.rst per driver that 
mentions/documents these different hardware limitations.  It is natural 
that different types of hardware have limitations.  This is a close-to 
hardware-level abstraction/API, and IMHO as long as we document the 
limitations we can expose this API without too many limitations for more 
capable hardware.

  [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org#setup-code-driver-igb

This stmmac driver and Intel Tiger Lake CPU must also have some limit on 
how long into the future it will/can schedule packets?


People from xdp-hints list must make their voice hear if they want i210 
and igb driver support, because it have even-more hardware limitations, 
see [1] (E.g. only TX queue 0 and 1 supports LaunchTime). BUT I know 
some have this hardware in production and might be motivated to get a 
functioning driver with this feature?

--Jesper
