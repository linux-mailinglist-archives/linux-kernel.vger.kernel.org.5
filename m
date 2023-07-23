Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBE75E401
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGWRUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGWRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 13:20:12 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE41DF;
        Sun, 23 Jul 2023 10:20:09 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id E03031EF7A;
        Sun, 23 Jul 2023 20:20:05 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id C5FA91EF79;
        Sun, 23 Jul 2023 20:20:05 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id DEBC93C0439;
        Sun, 23 Jul 2023 20:20:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1690132803; bh=YrVeEtTivAdP2fxw9gd4b9AW6XhLSsJtD12xMtYk0Ko=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=vvWvHfFCa+NSSrT/PIHNLWy+7Kj0snPJa0hUdEfXgNrMayTvUtxktkFIa6awNoW3m
         dlz0zO40oQMA50f+HkwSiExYDhZEJSwsDDVsjtsyOZ27tYkfLbxSmg99vgxMxfi3+p
         x8K+sUZ/LngP1QD9keNQXTZzMsszBpR+gyO7tMjY=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 36NHJskN090004;
        Sun, 23 Jul 2023 20:19:55 +0300
Date:   Sun, 23 Jul 2023 20:19:54 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Dust Li <dust.li@linux.alibaba.com>
cc:     Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jiejian Wu <jiejian@linux.alibaba.com>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH v2 net-next] ipvs: make ip_vs_svc_table and ip_vs_svc_fwm_table
 per netns
In-Reply-To: <20230723154426.81242-1-dust.li@linux.alibaba.com>
Message-ID: <ff4612e3-bb5a-7acc-1607-5761e5d052c4@ssi.bg>
References: <20230723154426.81242-1-dust.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sun, 23 Jul 2023, Dust Li wrote:

> From: Jiejian Wu <jiejian@linux.alibaba.com>
> 
> Current ipvs uses one global mutex "__ip_vs_mutex" to keep the global
> "ip_vs_svc_table" and "ip_vs_svc_fwm_table" safe. But when there are
> tens of thousands of services from different netns in the table, it
> takes a long time to look up the table, for example, using "ipvsadm
> -ln" from different netns simultaneously.
> 
> We make "ip_vs_svc_table" and "ip_vs_svc_fwm_table" per netns, and we
> add "service_mutex" per netns to keep these two tables safe instead of
> the global "__ip_vs_mutex" in current version. To this end, looking up
> services from different netns simultaneously will not get stuck,
> shortening the time consumption in large-scale deployment. It can be
> reproduced using the simple scripts below.
> 
> init.sh: #!/bin/bash
> for((i=1;i<=4;i++));do
>         ip netns add ns$i
>         ip netns exec ns$i ip link set dev lo up
>         ip netns exec ns$i sh add-services.sh
> done
> 
> add-services.sh: #!/bin/bash
> for((i=0;i<30000;i++)); do
>         ipvsadm -A  -t 10.10.10.10:$((80+$i)) -s rr
> done
> 
> runtest.sh: #!/bin/bash
> for((i=1;i<4;i++));do
>         ip netns exec ns$i ipvsadm -ln > /dev/null &
> done
> ip netns exec ns4 ipvsadm -ln > /dev/null
> 
> Run "sh init.sh" to initiate the network environment. Then run "time
> ./runtest.sh" to evaluate the time consumption. Our testbed is a 4-core
> Intel Xeon ECS. The result of the original version is around 8 seconds,
> while the result of the modified version is only 0.8 seconds.
> 
> Signed-off-by: Jiejian Wu <jiejian@linux.alibaba.com>
> Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

	Changes look good to me, thanks! But checkpatch is reporting
for some cosmetic changes that you have to do in v3:

scripts/checkpatch.pl --strict /tmp/file.patch

Regards

--
Julian Anastasov <ja@ssi.bg>

