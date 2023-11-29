Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549E37FDA3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjK2Orh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjK2Orf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:47:35 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159219A;
        Wed, 29 Nov 2023 06:47:41 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r8Lqi-0006yM-ON; Wed, 29 Nov 2023 15:47:36 +0100
Date:   Wed, 29 Nov 2023 15:47:36 +0100
From:   Florian Westphal <fw@strlen.de>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        kadlec@netfilter.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org
Subject: Re: [PATCH net] net/netfilter: bpf: avoid leakage of skb
Message-ID: <20231129144736.GB24754@breakpoint.cc>
References: <1701252962-63418-1-git-send-email-alibuda@linux.alibaba.com>
 <20231129131846.GC27744@breakpoint.cc>
 <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D. Wythe <alibuda@linux.alibaba.com> wrote:
> And my origin intention was to allow ebpf progs to return NF_STOLEN, we are
> trying to modify some netfilter modules via ebpf,
> and some scenarios require the use of NF_STOLEN, but from your description,

NF_STOLEN can only be supported via a trusted helper, as least as far as
I understand.

Otherwise verifier would have to guarantee that any branch that returns
NF_STOLEN has released the skb, or passed it to a function that will
release the skb in the near future.
