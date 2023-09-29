Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379C7B2D78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjI2IGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjI2IGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:06:10 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5051A5;
        Fri, 29 Sep 2023 01:06:07 -0700 (PDT)
Received: from [78.30.34.192] (port=36492 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qm8Vc-007w9u-C9; Fri, 29 Sep 2023 10:06:02 +0200
Date:   Fri, 29 Sep 2023 10:05:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH v3 1/2] Make loop indexes unsigned
Message-ID: <ZRaFZ4K3ZHTManT7@calendula>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
 <20230927164715.76744-2-joao@overdrivepizza.com>
 <ZRWCPTVd7b6+a7N5@calendula>
 <77df92a5627411471f1f374d41ae500c@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77df92a5627411471f1f374d41ae500c@overdrivepizza.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:53:14PM -0700, Joao Moreira wrote:
> On 2023-09-28 06:40, Pablo Neira Ayuso wrote:
> > On Wed, Sep 27, 2023 at 09:47:14AM -0700, joao@overdrivepizza.com wrote:
> > > From: Joao Moreira <joao.moreira@intel.com>
> > > 
> > > Both flow_rule_alloc and offload_action_alloc functions received an
> > > unsigned num_actions parameters which are then operated within a loop.
> > > The index of this loop is declared as a signed int. If it was possible
> > > to pass a large enough num_actions to these functions, it would lead
> > > to
> > > an out of bounds write.
> > > 
> > > After checking with maintainers, it was mentioned that front-end will
> > > cap the num_actions value and that it is not possible to reach this
> > > function with such a large number. Yet, for correctness, it is still
> > > better to fix this.
> > > 
> > > This issue was observed by the commit author while reviewing a
> > > write-up
> > > regarding a CVE within the same subsystem [1].
> > > 
> > > 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/
> > > 
> > > Signed-off-by: Joao Moreira <joao.moreira@intel.com>
> > > ---
> > >  net/core/flow_offload.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
> > > index bc5169482710..bc3f53a09d8f 100644
> > > --- a/net/core/flow_offload.c
> > > +++ b/net/core/flow_offload.c
> > > @@ -10,7 +10,7 @@
> > >  struct flow_rule *flow_rule_alloc(unsigned int num_actions)
> > >  {
> > >  	struct flow_rule *rule;
> > > -	int i;
> > > +	unsigned int i;
> > 
> > With the 2^8 cap, I don't think this patch is required anymore.
> 
> Hm. While I understand that there is not a significant menace haunting
> this... would it be good for (1) type correctness and (2) prevent that
> things blow up if something changes and someone misses this spot?

Nothing is going to change, please remove unnecesary updates. Capping
to 2^8 for all hardware offload subsystems is sufficient by now. If
someone needs more than that, it will have to justify it.
