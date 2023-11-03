Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72567E0158
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347304AbjKCJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347166AbjKCJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:45:36 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE11BD;
        Fri,  3 Nov 2023 02:45:31 -0700 (PDT)
Received: from [78.30.35.151] (port=34830 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qyqk1-00EAjx-Tf; Fri, 03 Nov 2023 10:45:27 +0100
Date:   Fri, 3 Nov 2023 10:45:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
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
Message-ID: <ZUTBNcA7ApLu5DMA@calendula>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
 <20231103091801.GA8035@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103091801.GA8035@breakpoint.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 10:18:01AM +0100, Florian Westphal wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > The problem is in nft_byteorder_eval() where we are iterating through a
> > loop and writing to dst[0], dst[1], dst[2] and so on...  On each
> > iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
> > element only has space for 4 bytes.  That means that every iteration
> > overwrites part of the previous element.
> > 
> > I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
> > nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
> > issue.  I think that the reason we have not detected this bug in testing
> > is that most of time we only write one element.
> 
> LGTM, thanks Dan.  We will route this via nf.git.

Thanks for your patch.

One question, is this update really required?

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3bbd13ab1ecf..b157c5cafd14 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -178,9 +178,9 @@ static inline __be32 nft_reg_load_be32(const u32 *sreg)
        return *(__force __be32 *)sreg;
 }

-static inline void nft_reg_store64(u32 *dreg, u64 val)
+static inline void nft_reg_store64(u64 *dreg, u64 val)
 {
-       put_unaligned(val, (u64 *)dreg);
+       put_unaligned(val, dreg);
 }

 static inline u64 nft_reg_load64(const u32 *sreg)

because one of the goals of nft_reg_store64() is to avoid that caller
casts the register to 64-bits.
