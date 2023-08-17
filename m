Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0629477FA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352997AbjHQPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353025AbjHQPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:14:17 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C673590;
        Thu, 17 Aug 2023 08:14:10 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qWegr-0002Mq-Sh; Thu, 17 Aug 2023 17:13:37 +0200
Date:   Thu, 17 Aug 2023 17:13:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Lu Wei <luwei32@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wsa+renesas@sang-engineering.com,
        tglx@linutronix.de, peterz@infradead.org, maheshb@google.com,
        fw@strlen.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipvlan: Fix a reference count leak warning in
 ipvlan_ns_exit()
Message-ID: <20230817151337.GH4312@breakpoint.cc>
References: <20230817145449.141827-1-luwei32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817145449.141827-1-luwei32@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lu Wei <luwei32@huawei.com> wrote:
> There are two network devices(veth1 and veth3) in ns1, and ipvlan1 with
> L3S mode and ipvlan2 with L2 mode are created based on them as
> figure (1). In this case, ipvlan_register_nf_hook() will be called to
> register nf hook which is needed by ipvlans in L3S mode in ns1 and value
> of ipvl_nf_hook_refcnt is set to 1.

[..]

> register nf_hook in ns2 and unregister nf_hook in ns1. As a result,
> ipvl_nf_hook_refcnt in ns1 is decreased incorrectly and this in ns2
> is increased incorrectly. When the second net namespace is removed, a
> reference count leak warning in ipvlan_ns_exit() will be triggered.
> 
> This patch add a check before ipvlan_migrate_l3s_hook() is called.

Reviewed-by: Florian Westphal <fw@strlen.de>
