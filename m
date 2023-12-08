Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783B809E37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573323AbjLHIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjLHIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:35:13 -0500
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA621729;
        Fri,  8 Dec 2023 00:35:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 6427B20868;
        Fri,  8 Dec 2023 09:35:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vb8e2srhxs4k; Fri,  8 Dec 2023 09:35:15 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id C9E1F206D2;
        Fri,  8 Dec 2023 09:35:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C9E1F206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
        s=202301; t=1702024515;
        bh=85i0GXjB5ZwUcg8pev6rLBbmnP+O9f3YCQzGI4JsW/Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=djDuRS8xoK/daO1oLJphawnOZabnvGyTuKZfx+1nlXadN9DPrBqRdn4a5VgJRuCiN
         xTczTWVmmnx9UIOMWX7YTuRUVYyicA7He60dtUsraXLyJlARwBY2PT9k9HXIxatE/4
         jmwIBIZML+uOkIf4XlT89oRKlSIvMJxl8HoWk8XuuxMrcnsnMAWMh7Np6lDRASKbmo
         ENCBmfOYDnLFEkbT/7EAei9A+P9+aF4A7mzyPUlhLbmQ/zswgD1pBeFpWV7ov9U38o
         kPccZL3/wWp/wLYDgwSo3utG5toF8fDSfGooa+7TbE3oQ9RfwOuL8vDGj9JuL9AEpq
         hMY1oUQf3KlGQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout2.secunet.com (Postfix) with ESMTP id C4F3780004A;
        Fri,  8 Dec 2023 09:35:15 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 8 Dec 2023 09:35:15 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 09:35:15 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 0918D318299E; Fri,  8 Dec 2023 09:35:15 +0100 (CET)
Date:   Fri, 8 Dec 2023 09:35:14 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Eyal Birger <eyal.birger@gmail.com>
CC:     Daniel Xu <dxu@dxuuu.xyz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexei.starovoitov@gmail.com>, <devel@linux-ipsec.org>,
        <eddyz87@gmail.com>, <edumazet@google.com>,
        Eyal Birger <eyal@metanetworks.com>, <yonghong.song@linux.dev>,
        <kuba@kernel.org>, <bpf@vger.kernel.org>, <pabeni@redhat.com>,
        <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH bpf-next v4 01/10] xfrm: bpf: Move
 xfrm_interface_bpf.c to xfrm_bpf.c
Message-ID: <ZXLVQuqSG7TSjQxD@gauss3.secunet.de>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
 <ZXGx7H/Spv634xgX@gauss3.secunet.de>
 <CAHsH6GtmhP=hZcf2Qv=21dAOSb5dD4GDa+QYdLFz9_FsCZq6tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GtmhP=hZcf2Qv=21dAOSb5dD4GDa+QYdLFz9_FsCZq6tA@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:08:08PM -0800, Eyal Birger wrote:
> Hi Daniel,
> 
> On Thu, Dec 7, 2023 at 3:52 AM Steffen Klassert via Devel
> <devel@linux-ipsec.org> wrote:
> >
> > On Mon, Dec 04, 2023 at 01:56:21PM -0700, Daniel Xu wrote:
> > > This commit moves the contents of xfrm_interface_bpf.c into a new file,
> > > xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd like
> > > to keep all the bpf integrations in a single file.
> 
> This takes away the nice ability to reload the xfrm interface
> related kfuncs when reloading the xfrm interface.
> 
> I also find it a little strange that the kfuncs would be available
> when the xfrm interface isn't loaded.
> 
> So imho it makes sense that these kfuncs would be built
> as part of the module and not as part of the core.

I proposed to merge all the bpf extensions into one file.
With that I wanted to avoid to have 'many' files under
/net/xfrm that fall basically under bpf maintainance
scope. But if there are practical reasons to have these
spilted, I'm OK with that too.
