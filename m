Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A914879123D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjIDHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjIDHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:32:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34050CD1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:32:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 384C12185A;
        Mon,  4 Sep 2023 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693812712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHZGlbeVP+pLU0GMySUVFyA82bTMjYMnmGf86Ii+HHk=;
        b=IMFV2St3ejsBXZjOsyQ9k4vHq3nPMdg7a6jJdpoe1U5fBOlyqh0HoOsTdCZyyXh8Xvo1w6
        qT60bx+dFOckH/J8NaQa+Mz93WPiQ3brlDOR+rSKyqp7VeDO9OTqaxDLRDUH7cQi/0rb/y
        j3nkVEJ+v00A3enwx08dwYi5cHJd098=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17DD513425;
        Mon,  4 Sep 2023 07:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nx7rAuiH9WSCPgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 07:31:52 +0000
Date:   Mon, 4 Sep 2023 09:31:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, glider@google.com,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Message-ID: <ZPWH53NUqTIoDcMV@dhcp22.suse.cz>
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org>
 <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-09-23 18:29:07, Zhaoyang Huang wrote:
> loop alex
> 
> On Thu, Aug 31, 2023 at 8:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Aug 31, 2023 at 06:52:52PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > There is no explicit gfp flags to let the allocation skip zero
> > > operation when CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y. I would like to make
> > > __GFP_SKIP_ZERO be visible even if kasan is not configured.
> >
> > This bypasses a security feature so you're going to have to do a little
> > better than "I want it".
> Thanks for pointing this out. What I want to do is to give the user a
> way to exempt some types of pages from being zeroed, which could help
> on performance issues.

Could you be more explicit about those users? Your patch doesn't add
any.

> Could we have the most safety concern admin
> use INIT_ON_FREE while the less concerned use INIT_ON_ALLOC &
> __GFP_SKIP_ZERO as a light version method?

Are you suggesting the __GFP_SKIP_ZERO would be ignored in any setups
except for init_on_alloc?

-- 
Michal Hocko
SUSE Labs
