Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE87E00CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbjKCK0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjKCKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:25:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9523D4E;
        Fri,  3 Nov 2023 03:25:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qyrN4-00055B-3O; Fri, 03 Nov 2023 11:25:46 +0100
Date:   Fri, 3 Nov 2023 11:25:46 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <20231103102546.GB8035@breakpoint.cc>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
 <20231103091801.GA8035@breakpoint.cc>
 <ZUTBNcA7ApLu5DMA@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUTBNcA7ApLu5DMA@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Nov 03, 2023 at 10:18:01AM +0100, Florian Westphal wrote:
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > The problem is in nft_byteorder_eval() where we are iterating through a
> > > loop and writing to dst[0], dst[1], dst[2] and so on...  On each
> > > iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
> > > element only has space for 4 bytes.  That means that every iteration
> > > overwrites part of the previous element.
> > > 
> > > I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
> > > nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
> > > issue.  I think that the reason we have not detected this bug in testing
> > > is that most of time we only write one element.
> > 
> > LGTM, thanks Dan.  We will route this via nf.git.
> 
> Thanks for your patch.
> 
> One question, is this update really required?

I think so, yes.  Part of this bug here is that this helper-niceness
masks whats really happening in the caller (advancing in strides of
'u32', rather than 'u64').
