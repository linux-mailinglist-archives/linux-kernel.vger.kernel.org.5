Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C2F751B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjGMINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjGMILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EA71FD2;
        Thu, 13 Jul 2023 01:09:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D983A1F45E;
        Thu, 13 Jul 2023 08:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689235772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4lzmGg5bFXSh1ovH2sAfn4p+vzl+/Qk0Uk/Y8saxFI=;
        b=gG9p7HtN5tIubv2mnEEYqiqb65HTBQtoXZCxTlDSol3E4ZTp+eieRVtCBW254urji2Ww4J
        L8vQW6OqxtdlyA1g3AbUyQlqypsiX72Y07Pc4rNX4wHIpmuUbobzgiMkIR4jAL6MHm4VB5
        dRCvu21WltflCHrFtapcdul0Yv0Eu8w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6E2C133D6;
        Thu, 13 Jul 2023 08:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n05QKjyxr2SZJAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 13 Jul 2023 08:09:32 +0000
Date:   Thu, 13 Jul 2023 10:09:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] mm/memory_hotplug: document the signal_pending()
 check in offline_pages()
Message-ID: <ZK+xOxQSevxpWoCr@dhcp22.suse.cz>
References: <20230711174050.603820-1-david@redhat.com>
 <ZK2/3Kq8VlDwcCpc@dhcp22.suse.cz>
 <7449914a-1ae3-9ea8-b60b-f0314999b790@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7449914a-1ae3-9ea8-b60b-f0314999b790@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-07-23 21:09:25, David Hildenbrand wrote:
> On 11.07.23 22:47, Michal Hocko wrote:
> > On Tue 11-07-23 19:40:50, David Hildenbrand wrote:
> > > Let's update the documentation that any signal is sufficient, and
> > > add a comment that not only checking for fatal signals is historical
> > > baggage: changing it now could break existing user space. although
> > > unlikely.
> > > 
> > > For example, when an app provides a custom SIGALRM handler and triggers
> > > memory offlining, the timeout cmd would no longer stop memory offlining,
> > > because SIGALRM would no longer be considered a fatal signal.
> > 
> > Yes, and it is likely goot to mention here that this is an antipattern
> > for many other kernel operations like IO (e.g. write) but it is a long
> > term behavior that somebody might depend on and it is safer to reflect
> > the documentation to the realitity rather than other way around (which
> > would be imho better).
> > 
> 
> You mean adding something like
> 
> "Note that using signal_pending() instead of fatal_signal_pending() is an
> anti-pattern, but slowly deprecating that behavior to eventually change it
> in the far future is probably not worth the effort. If this ever becomes
> relevant for user-space, we might want to rethink."

Yes, something like that. Thanks!

-- 
Michal Hocko
SUSE Labs
