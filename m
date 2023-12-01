Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66A28008D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378451AbjLAKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378423AbjLAKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:46:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8C1726
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:46:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A3C433C7;
        Fri,  1 Dec 2023 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701427589;
        bh=5zjayL88soz+UgJbryPsfFfFuCruLUpe7CIqCl/SLV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SWPKPFHsSk8v67r+wzTQi1CO6hcbjUUpZE3vnilfgHHfZwu4IJFOQ5+rwbUdgPmLc
         yWtMqvr0cxc2sdZrbCSHK568MaEExBRSfpDet74hIw2pKTCMegAO8qkO+wBD57U//9
         730HNIMRIxuWCCJFQNjzcbx58JHzDGYi6owXtMvfOhgcSIwgOpoBgzUhFTnyt4XCDN
         e7Syzbndkz/v/VLblq4L9o8kSEXECELQ08REb4v+RuY+aRar9yp//iKZVGMv256t73
         o71Zp0tFHEerRmrytXpPlbRTZhyt+4VDNMgczQDGar2JHc9H5WbBlArbEMH4DACuda
         pFCJdIzQ48ioA==
Message-ID: <d4f99931-442c-4cd7-b3cf-80d8681a2986@kernel.org>
Date:   Fri, 1 Dec 2023 11:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
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
References: <20231201062421.1074768-1-yoong.siang.song@intel.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231201062421.1074768-1-yoong.siang.song@intel.com>
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



On 12/1/23 07:24, Song Yoong Siang wrote:
> This series expands XDP TX metadata framework to include ETF HW offload.
> 
> Changes since v1:
> - rename Time-Based Scheduling (TBS) to Earliest TxTime First (ETF)
> - rename launch-time to txtime
> 

I strongly disagree with this renaming (sorry to disagree with Willem).

The i210 and i225 chips call this LaunchTime in their programmers 
datasheets, and even in the driver code[1].

Using this "txtime" name in the code is also confusing, because how can 
people reading the code know the difference between:
  - tmo_request_timestamp and tmo_request_txtime


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org

> v1: https://patchwork.kernel.org/project/netdevbpf/cover/20231130162028.852006-1-yoong.siang.song@intel.com/
> 
> Song Yoong Siang (3):
>    xsk: add ETF support to XDP Tx metadata
>    net: stmmac: Add txtime support to XDP ZC
>    selftests/bpf: Add txtime to xdp_hw_metadata
> 
>   Documentation/netlink/specs/netdev.yaml        |  4 ++++
>   Documentation/networking/xsk-tx-metadata.rst   |  5 +++++
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 13 +++++++++++++
>   include/net/xdp_sock.h                         |  9 +++++++++
>   include/net/xdp_sock_drv.h                     |  1 +
>   include/uapi/linux/if_xdp.h                    |  9 +++++++++
>   include/uapi/linux/netdev.h                    |  3 +++
>   net/core/netdev-genl.c                         |  2 ++
>   net/xdp/xsk.c                                  |  3 +++
>   tools/include/uapi/linux/if_xdp.h              |  9 +++++++++
>   tools/include/uapi/linux/netdev.h              |  3 +++
>   tools/net/ynl/generated/netdev-user.c          |  1 +
>   tools/testing/selftests/bpf/xdp_hw_metadata.c  | 18 +++++++++++++++++-
>   14 files changed, 81 insertions(+), 1 deletion(-)
> 
