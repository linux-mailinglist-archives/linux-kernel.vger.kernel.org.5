Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB7802FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjLDKQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjLDKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:16:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E6B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:16:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9B7C433C7;
        Mon,  4 Dec 2023 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701685017;
        bh=NvabCPUoEeNgkHlQOh++f/IpiYrFxijeYof5NfRPONE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gj60O4w3gXfZMoRfR6TVuuBMVNHiyEh6nUNydfFfRtKH2vJhhhVuUfP9Y4+rhdY5B
         zjCUTsbEh5i2w9D6MgQWx68op4BJuUViJcr9vihhIQ8pM0QJhsxRJLcvyPKCr6mmvh
         2fi5L0nxX4kFshYlSuzPTS0BbZwOLeu6gZ3GQp0LhzILev3EvwzL6CIBTA/cDwOP5S
         DE1a4L0ovYgsibC0R82gwV80GU4EzfF3khZdF8IufKrqTVx7GteEKxJT8Lh7qC0oMP
         fXKPG9TSggDDEaNpqmO1xTH+Yafxw1vMknRluaszrrr6d4GsKEX1oH+EnHBEKjkV1g
         wSPOvEgh46O1A==
Message-ID: <8e20031c-83cb-4927-ab6a-e6b4840e1e42@kernel.org>
Date:   Mon, 4 Dec 2023 11:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add Launch Time request to
 xdp_hw_metadata
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
 <20231203165129.1740512-4-yoong.siang.song@intel.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231203165129.1740512-4-yoong.siang.song@intel.com>
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
> This patch is tested with stmmac on Intel Tiger Lake platform. Refer to
> result below, the delta between pre-determined launch time and actual HW
> transmit complete time is around 24 us.

Is there any NIC setup (e.g. ethtool/qdisc) requirements to enable HW 
for this feature?

--Jesper
