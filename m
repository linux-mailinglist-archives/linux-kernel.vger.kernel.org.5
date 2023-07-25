Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE989760A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjGYGH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjGYGHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBAE10E5;
        Mon, 24 Jul 2023 23:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60FA161549;
        Tue, 25 Jul 2023 06:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17930C433C8;
        Tue, 25 Jul 2023 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690265272;
        bh=g1caD9CrbR3LwJeOeh9fQXcDn7BjKUbUaJjDJVl9M7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlD7W3Wwt32cIbOtX7m31Rqe01XgCM1QR4umfbVEgKtJ8KHz/H9F9XbeKH6Hfta5I
         tVipI5y51fg4rSCaNsTt3DWQPuUmOz5pMrX9NKS8Kh72woVGRyoDdS42QH+6J0QF7k
         HVKBYLI7HUSwZApcG06ComH69NMZuj/ciA0NvbYXIqOZX3m6ZZfpn1gb+3c+oaiz04
         9fMzkRPZM4eu1ov7VGp7oRTlRUrYOdEoll+1lW92CJh8uBQDm7d8LQozNmbX9yLGQg
         IZ35ydjMZqw7/4hOlHqz3dqIBxdRzVPWUS5o512vFArgCKJRaFay/PNVr8ziTm+FH9
         Z4k9PnWe3XPYw==
Date:   Tue, 25 Jul 2023 09:07:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com
Subject: Re: [External] Re: [PATCH] docs: mm: Fix number of base pages for
 1GB HugeTLB
Message-ID: <ZL9msij+DaXiDHbq@kernel.org>
References: <20230207114456.2304801-1-usama.arif@bytedance.com>
 <Y+NwkCsDnOBSCqVu@kernel.org>
 <463c960e-1d3b-edc0-edbb-d5ecbf7fc3b1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463c960e-1d3b-edc0-edbb-d5ecbf7fc3b1@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Jon)

On Mon, Jul 24, 2023 at 03:05:29PM +0100, Usama Arif wrote:
> 
> 
> On 08/02/2023 09:51, Mike Rapoport wrote:
> > On Tue, Feb 07, 2023 at 11:44:56AM +0000, Usama Arif wrote:
> > > 1GB HugeTLB page consists of 262144 base pages.
> > > 
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > 
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > 
> > > ---
> > >   Documentation/mm/vmemmap_dedup.rst | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
> > > index a4b12ff906c4..689a6907c70b 100644
> > > --- a/Documentation/mm/vmemmap_dedup.rst
> > > +++ b/Documentation/mm/vmemmap_dedup.rst
> > > @@ -1,3 +1,4 @@
> > > +
> > >   .. SPDX-License-Identifier: GPL-2.0
> > >   =========================================
> > > @@ -17,7 +18,7 @@ HugeTLB pages consist of multiple base page size pages and is supported by many
> > >   architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
> > >   details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
> > >   currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
> > > -consists of 512 base pages and a 1GB HugeTLB page consists of 4096 base pages.
> > > +consists of 512 base pages and a 1GB HugeTLB page consists of 262144 base pages.
> > >   For each base page, there is a corresponding ``struct page``.
> > >   Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to
> > > -- 
> > > 2.25.1
> > > 
> > 
> 
> Hi,
> 
> Was just reading vmemmap_dedup.rst for something and realized that its still
> 4096 pages for 1G, maybe this patch got missed?
> 
> Thanks,
> Usama

-- 
Sincerely yours,
Mike.
