Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928175EA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGXDqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXDqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:46:34 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25965DB;
        Sun, 23 Jul 2023 20:46:32 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 96B3820A09;
        Mon, 24 Jul 2023 06:46:29 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 6F8DF20A08;
        Mon, 24 Jul 2023 06:46:29 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 0E9533C0439;
        Mon, 24 Jul 2023 06:46:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1690170387; bh=9wDE65OlhnCUzRgqjw2Uyz//+EJm/dZ/6yNBMKhGs7c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=jZbF6lDEEGLK8dDaKiIjrEHyeSVKDWp0FjPwuug8PY2u0ahlIGq1qgH3f1FdN83Sg
         UdClFXYbzxTKTv/HapNN3Wd0XNN5KIv7eHIJgscm/UZa0jazrcujDL3sV3ZwCXECD1
         EEjtsN/Op9XdAjbz5de2deCqlPg5F47twdiRDJ4Y=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 36O3kMqn006749;
        Mon, 24 Jul 2023 06:46:24 +0300
Date:   Mon, 24 Jul 2023 06:46:22 +0300 (EEST)
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
In-Reply-To: <20230724013101.GI6751@linux.alibaba.com>
Message-ID: <3decf8be-ee64-b3c3-2e6d-4f3f392f6faf@ssi.bg>
References: <20230723154426.81242-1-dust.li@linux.alibaba.com> <ff4612e3-bb5a-7acc-1607-5761e5d052c4@ssi.bg> <20230724013101.GI6751@linux.alibaba.com>
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

On Mon, 24 Jul 2023, Dust Li wrote:

> On Sun, Jul 23, 2023 at 08:19:54PM +0300, Julian Anastasov wrote:
> >
> >	Changes look good to me, thanks! But checkpatch is reporting
> >for some cosmetic changes that you have to do in v3:
> >
> >scripts/checkpatch.pl --strict /tmp/file.patch
> 
> Oh, sorry for that! I ignored the CHECKs checkpatch reported, my checkpatch
> shows:
> 
> 
>    $./scripts/checkpatch.pl --strict 0001-ipvs-make-ip_vs_svc_table-and-ip_vs_svc_fwm_table-pe.patch
>    CHECK: Prefer using the BIT macro
>    #69: FILE: include/net/ip_vs.h:40:
>    +#define IP_VS_SVC_TAB_SIZE (1 << IP_VS_SVC_TAB_BITS)
> 
> We just moved this line from ip_vs_ctl.c to ip_vs.h, so we ignored the
> BIT macro. Do you think we should change it using BIT macro ?

	Yes, lets fix all these complains.

>    CHECK: struct mutex definition without comment
>    #79: FILE: include/net/ip_vs.h:1051:
>    +       struct mutex service_mutex;
> 
> I think we can add comment for it.
> But rethinking a bit on the service_mutex in ip_vs_est.c, I'm a
> wondering why we are using the service_mutex in estimation ? Is est_mutex
> enough for the protecting in ip_vs_est.c ?

	Yes, the estimation kthreads are synchronized only
with reconfiguration: ip_vs_start_estimator() and ip_vs_stop_estimator()
are called under service_mutex. And the estimation data is already 
per-net, there is no global data.

>    CHECK: Logical continuations should be on the previous line
>    #161: FILE: net/netfilter/ipvs/ip_vs_ctl.c:410:
>                        && (svc->port == vport)
>    +                   && (svc->protocol == protocol)) {
> 
> This is just the removal of '(svc->ipvs == ipvs)' and kept it as it is.
> So haven't change according to checkpatch. If you prefer, I can modify
> it to make checkpatch happy.

	Yes, lets move all '&&' in this 'if' block and also remove the 
parens:

	if (svc->af == af && ip_vs_addr_equal(af, &svc->addr, vaddr) &&
	    svc->port == vport && svc->protocol == protocol) {

Regards

--
Julian Anastasov <ja@ssi.bg>

