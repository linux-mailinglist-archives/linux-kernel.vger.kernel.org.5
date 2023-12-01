Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11124800DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379292AbjLAPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379270AbjLAPCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:02:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB410F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:02:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DD3C433C9;
        Fri,  1 Dec 2023 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701442950;
        bh=HCKgkvZM3p9a1PhMU+0ZdI63NNj7rU/pKhx/Px4fVKY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZnzIEJkgcQPJ9EhwbA+QMxmLvo7Vb5mFoKAoNXH6yHgW+nms/wyXGXewhlB2+aaMv
         ggRc0WCfAnmF4J1gGXJNsVm00we+Ush4nAHaDY6/aboqP1YpJAeXkD97yaQm8LF8DA
         kcLJiTetD9+tqyUXfvHMuhZjY2ZJFxqDcxvpvNstZflcgXy8ZgkfwU667pQAlZks+n
         JLx/dRpoe81S7cz16xFnm3ay1eGU674lCQdb1zXCGrUTHqAKRJwjbY6ZS9z8d7fK1o
         4iwBWtKKzMnCl2rC99z3RVqUB/XbA4ZBM/7CWSyEJ5gV7SbzjnjMTZ4SljJxZUkoLX
         rN/ROb0OGkmhg==
Message-ID: <5a660c0f-d3ed-47a2-b9be-098a224b8a12@kernel.org>
Date:   Fri, 1 Dec 2023 16:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] net: stmmac: Add txtime support to XDP ZC
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
 <20231201062421.1074768-3-yoong.siang.song@intel.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231201062421.1074768-3-yoong.siang.song@intel.com>
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



On 12/1/23 07:24, Song Yoong Siang wrote:
> This patch enables txtime support to XDP zero copy via XDP Tx
> metadata framework.
> 
> Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
>   2 files changed, 15 insertions(+)

I think we need to see other drivers using this new feature to evaluate
if API is sane.

I suggest implementing this for igc driver (chip i225) and also for igb
(i210 chip) that both support this kind of LaunchTime feature in HW.

The API and stmmac driver takes a u64 as time.
I'm wondering how this applies to i210 that[1] have 25-bit for
LaunchTime (with 32 nanosec granularity) limiting LaunchTime max 0.5
second into the future.
And i225 that [1] have 30-bit max 1 second into the future.


[1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/code01_follow_qdisc_TSN_offload.org

