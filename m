Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B77FB504
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjK1I6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjK1I6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:58:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0919C194
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:58:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A965D21987;
        Tue, 28 Nov 2023 08:58:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A6213763;
        Tue, 28 Nov 2023 08:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id pOlCIM+rZWXNUwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 08:58:55 +0000
Date:   Tue, 28 Nov 2023 09:58:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pingfan Liu <piliu@redhat.com>
Cc:     Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWWrxt0HLC6V4_6X@tiehlicka>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAF+s44QDMzSq3ihzRtaP9ZwF-drfAiQq713d9bastsJFiReJ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44QDMzSq3ihzRtaP9ZwF-drfAiQq713d9bastsJFiReJ4w@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A965D21987
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 10:07:08, Pingfan Liu wrote:
> On Sun, Nov 26, 2023 at 5:24 AM Jiri Bohac <jbohac@suse.cz> wrote:
> >
> > Hi Tao,
> >
> > On Sat, Nov 25, 2023 at 09:51:54AM +0800, Tao Liu wrote:
> > > Thanks for the idea of using CMA as part of memory for the 2nd kernel.
> > > However I have a question:
> > >
> > > What if there is on-going DMA/RDMA access on the CMA range when 1st
> > > kernel crash? There might be data corruption when 2nd kernel and
> > > DMA/RDMA write to the same place, how to address such an issue?
> >
> > The crash kernel CMA area(s) registered via
> > cma_declare_contiguous() are distinct from the
> > dma_contiguous_default_area or device-specific CMA areas that
> > dma_alloc_contiguous() would use to reserve memory for DMA.
> >
> > Kernel pages will not be allocated from the crash kernel CMA
> > area(s), because they are not GFP_MOVABLE. The CMA area will only
> > be used for user pages.
> >
> > User pages for RDMA, should be pinned with FOLL_LONGTERM and that
> > would migrate them away from the CMA area.
> >
> > But you're right that DMA to user pages pinned without
> > FOLL_LONGTERM would still be possible. Would this be a problem in
> > practice? Do you see any way around it?
> >
> 
> I have not a real case in mind. But this problem has kept us from
> using the CMA area in kdump for years.  Most importantly, this method
> will introduce an uneasy tracking bug.

Long term pinning is something that has changed the picture IMHO. The
API had been breweing for a long time but it has been established and
usage spreading. Is it possible that some driver could be doing remote
DMA without the long term pinning? Quite possible but this means such a
driver should be fixed rather than preventing cma use for this usecase
TBH.
 
> For a way around, maybe you can introduce a specific zone, and for any
> GUP, migrate the pages away. I have doubts about whether this approach
> is worthwhile, considering the trade-off between benefits and
> complexity.

No, a zone is definitely not an answer to that because because a)
userspace would need to be able to use that memory and userspace might
pin memory for direct IO and others. So in the end longterm pinning
would need to be used anyway.

-- 
Michal Hocko
SUSE Labs
