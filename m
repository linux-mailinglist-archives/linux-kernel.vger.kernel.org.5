Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40E7FD21B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjK2JPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjK2JO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6B1BC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:14:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 961D02193C;
        Wed, 29 Nov 2023 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701249295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iTXJagBqPSeQGBe2NgzqRCNM+zJBCNxL2TWAPwVsXTg=;
        b=Bl4txgUygG7bkfTIElrAJ6DaFeVzy+4+L8B8gIZchfUabewwT84jCcO8gXDHEtRfmC0oQ2
        2MQeS3K46DU4I5LId3NJmx8+fleWDFX1jibnGKRaiZMw+8CyiGU6UTDJebLfh8dqtOGx9h
        dwvPiaFqY102kl6Jv8eG6H6CMrX+FHA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7729D13637;
        Wed, 29 Nov 2023 09:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id mzkPGg8BZ2WgcQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 09:14:55 +0000
Date:   Wed, 29 Nov 2023 10:14:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZWcBDglmDKUJdwMv@tiehlicka>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.80
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 16:34:35, Roman Gushchin wrote:
> On Tue, Nov 28, 2023 at 02:23:36PM +0800, Qi Zheng wrote:
[...]
> > Now I think adding this method might not be a good idea. If we allow
> > shrinkers to report thier own private information, OOM logs may become
> > cluttered. Most people only care about some general information when
> > troubleshooting OOM problem, but not the private information of a
> > shrinker.
> 
> I agree with that.
> 
> It seems that the feature is mostly useful for kernel developers and it's easily
> achievable by attaching a bpf program to the oom handler. If it requires a bit
> of work on the bpf side, we can do that instead, but probably not. And this
> solution can potentially provide way more information in a more flexible way.
> 
> So I'm not convinced it's a good idea to make the generic oom handling code
> more complicated and fragile for everybody, as well as making oom reports differ
> more between kernel versions and configurations.

Completely agreed! From my many years of experience of oom reports
analysing from production systems I would conclude the following categories
	- clear runaways (and/or memory leaks)
		- userspace consumers - either shmem or anonymous memory
		  predominantly consumes the memory, swap is either depleted
		  or not configured.
		  OOM report is usually useful to pinpoint those as we
		  have required counters available
		- kernel memory consumers - if we are lucky they are
		  using slab allocator and unreclaimable slab is a huge
		  part of the memory consumption. If this is a page
		  allocator user the oom repport only helps to deduce
		  the fact by looking at how much user + slab + page
		  table etc. form. But identifying the root cause is
		  close to impossible without something like page_owner
		  or a crash dump.
	- misbehaving memory reclaim
		- minority of issues and the oom report is usually
		  insufficient to drill down to the root cause. If the
		  problem is reproducible then collecting vmstat data
		  can give a much better clue.
		- high number of slab reclaimable objects or free swap
		  are good indicators. Shrinkers data could be
		  potentially helpful in the slab case but I really have
		  hard time to remember any such situation.
On non-production systems the situation is quite different. I can see
how it could be very beneficial to add a very specific debugging data
for subsystem/shrinker which is developed and could cause the OOM. For
that purpose the proposed scheme is rather inflexible AFAICS.

-- 
Michal Hocko
SUSE Labs
