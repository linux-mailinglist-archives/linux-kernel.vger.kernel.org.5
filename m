Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2432783D58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHVJv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjHVJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:51:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD171A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:51:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31F7F22C47;
        Tue, 22 Aug 2023 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692697915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdCgYWOgTsCE9k8ZFgfn4CkkXIjrshXgCbrrriZQv2s=;
        b=zmjOqbPm4+CA5+kFgDuCVrsguxPDcRrBtAl8FpIExJ/x05ZfmzSQZTPrTlP788a4nUmgnJ
        dhXTGu3bTzO1Yi4UPEQd6WmU8gJZ+GD4w8E9guj2Vn7Bv2JKjZvrj4uwW9n6lXC/7T+ShY
        nttzTPSLb6YyHIQvit4/VagiJxvXEBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692697915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdCgYWOgTsCE9k8ZFgfn4CkkXIjrshXgCbrrriZQv2s=;
        b=r4btaUS+/3tCM7grMQ9BA+6fvA3h9G9aDSvHfszRfTRNnqZYg2thwi+Y0LudtLtPMLy5Ol
        HOnqQi92nuNlpBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22DBA13919;
        Tue, 22 Aug 2023 09:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0zBzCDuF5GTGEgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Aug 2023 09:51:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A32F6A0774; Tue, 22 Aug 2023 11:51:54 +0200 (CEST)
Date:   Tue, 22 Aug 2023 11:51:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        shakeelb@google.com, linux-mm@kvack.org, jack@suse.cz
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <20230822095154.7cr5ofogw552z3jk@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f>
 <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-08-23 00:29:49, Mateusz Guzik wrote:
> On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > True Fix(tm) is a longer story.
> >
> > Maybe let's sort out this patchset first, whichever way. :)
> >
> 
> So I found the discussion around the original patch with a perf
> regression report.
> 
> https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3/
> 
> The reporter suggests dodging the problem by only allocating per-cpu
> counters when the process is going multithreaded. Given that there is
> still plenty of forever single-threaded procs out there I think that's
> does sound like a great plan regardless of what happens with this
> patchset.
> 
> Almost all access is already done using dedicated routines, so this
> should be an afternoon churn to sort out, unless I missed a
> showstopper. (maybe there is no good place to stuff a flag/whatever
> other indicator about the state of counters?)
> 
> That said I'll look into it some time this or next week.

Good, just let me know how it went, I also wanted to start looking into
this to come up with some concrete patches :). What I had in mind was that
we could use 'counters == NULL' as an indication that the counter is still
in 'single counter mode'.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
