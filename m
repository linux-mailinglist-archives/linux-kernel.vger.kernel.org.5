Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C078763D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGZRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGZRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD7E42
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B7A61BF4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E8DC433C7;
        Wed, 26 Jul 2023 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690390897;
        bh=41IH+STJ6bMJLu2X89vfytzyvTOWg9NjdLg+SOjMTGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+TkpMHi+OOJTwfkr0gBDx+A3BVXrx0R6aEWRg3SRabDjbOkuNa9sdegsHvosOzy6
         DF7TXXyuia2j2Z3CuCT/JRf9AfVpDfva8YvriMaGm3ADPFYQITJzGAaHDMco/hVajT
         q1zjZjru4gDZY1q+MxIMcfuXX4jp0jAga5kjt2WgyH8h2/fMwD98QxUcX60rOThekF
         09eSuHYpNK++akPLHgNQvuzg3WmuZNQElUoKpCDwdaenb1RY090YmSCILultRYCniL
         uUdaD5ZCwscr6PWTAJKk+habMTDl8S/ncVcjNijnXbkDUGsZBF6YNqkIzur3duDtwj
         dxrkEGrdE2f3Q==
Date:   Wed, 26 Jul 2023 20:01:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        Gal Pressman <gal@nvidia.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Message-ID: <20230726170133.GX11388@unreal>
References: <000000000000ee69e80600ec7cc7@google.com>
 <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
 <20230726071254.GA1380402@unreal>
 <20230726082312.1600053e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726082312.1600053e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:23:12AM -0700, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
> > > Thanks, I'll take a look this evening.  
> > 
> > Did anybody post a fix for that?
> > 
> > We are experiencing the following kernel panic in netdev commit
> > b57e0d48b300 (net-next/main) Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
> 
> Not that I know, looks like this is with Daniel's previous fix already
> present, and syzbot is hitting it, too :(

My naive workaround which restored our regression runs is:

diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 69a272712b29..10c9ab830702 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -111,6 +111,7 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
                        bpf_prog_put(tuple.prog);
                tcx_skeys_dec(ingress);
        }
-       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
+       tcx_miniq_set_active(entry, false);
        tcx_entry_free(entry);
 }

