Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3361B758D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGSGPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGSGPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:15:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991C1FCD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:14:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0ADF5218E3;
        Wed, 19 Jul 2023 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689747290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/D08qzEWu/7mB48H1swfh+BecNolwUhkRGJESUZ8JEU=;
        b=iJhoCGIYM7tExD4yQ0N1H01mcecv5NvyEkpcO4WtDNw10MwJPWDHSzPdrTyJQuc0f8JuYl
        rr/fjRA0ZscX947EfYtVqPuGjZw/1MS2HBuUJ5Z3y/fZPsf37LfPDpRGSQHCDZANPxHnBR
        pe9jgEmw9cQ3Y6feJqHqckdgjzMb8k0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF4181361C;
        Wed, 19 Jul 2023 06:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o8B1M1l/t2QMOQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Jul 2023 06:14:49 +0000
Date:   Wed, 19 Jul 2023 08:14:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
References: <20230718220106.GA3117638@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718220106.GA3117638@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
[...]
> I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> allocations, because this issue essentially makes the movablecore= kernel
> command line parameter useless in many cases, as the ZONE_MOVABLE region it
> creates will often actually be unmovable.

movablecore is kinda hack and I would be more inclined to get rid of it
rather than build more into it. Could you be more specific about your
use case?

> Here are the options I currently see for resolution:
> 
> 1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
> the beginning of the NUMA node instead of the end. This should fix my use case,
> but again is prone to breakage in other configurations (# of NUMA nodes, other
> architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
> think that this should be relatively straightforward and low risk, though.
> 
> 2. Make the code which processes the movablecore= command line option aware of
> the memblock allocations, and have it choose a region for ZONE_MOVABLE which
> does not have these allocations. This might be done by checking for
> PageReserved() as we do with offlining memory, though that will take some boot
> time reordering, or we'll have to figure out the overlap in another way. This
> may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
> a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?

Yes, this is no problem. Zones are allowed to be sparse.

> If
> we can get it working, this seems like the most correct solution to me, but
> also the most difficult and risky because it involves significant changes in
> the code for memory setup at early boot.
> 
> Am I missing anything are there other solutions we should consider, or do you
> have an opinion on which solution we should pursue?

If this really needs to be addressed than 2) is certainly a more robust
approach.
-- 
Michal Hocko
SUSE Labs
