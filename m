Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41F7FA4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjK0Pav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjK0PaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:30:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B342117;
        Mon, 27 Nov 2023 07:29:59 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8CB2A21B58;
        Mon, 27 Nov 2023 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701098997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ll683VjO5cgdZEXvfYTUzLYylEdUG/UQv49Lu4Sc7rA=;
        b=OOXAB+DpFUt4iwizIQsg9NdOIv7EkWhpXPvrvm3xSPIkYK01e48JBaP6McNQXVt1W4HMcp
        FzhsJfz4OLu8cI2pA+kFgSSwrdgoVb/idRWXuLd+Fx/rh355mLKnibOH8SOrq1VdRhoTdr
        woqZH0y3y+TGG/qALZCHEensDf8Z/lc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 714C11367B;
        Mon, 27 Nov 2023 15:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id e1MKGvW1ZGVHRQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Mon, 27 Nov 2023 15:29:57 +0000
Date:   Mon, 27 Nov 2023 16:29:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-ID: <ZWS19JFHm_LFSsFd@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
 <ZV5/ilfUoqC2PW0D@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV5/ilfUoqC2PW0D@memverge.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_TWELVE(0.00)[19];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,arndb.de,linutronix.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, didn't have much time to do a proper review. Couple of points
here at least.

On Wed 22-11-23 17:24:10, Gregory Price wrote:
> On Wed, Nov 22, 2023 at 01:33:48PM -0800, Andrew Morton wrote:
> > On Wed, 22 Nov 2023 16:11:49 -0500 Gregory Price <gourry.memverge@gmail.com> wrote:
> > 
> > > The patch set changes task->mempolicy to be modifiable by tasks other
> > > than just current.
> > > 
> > > The ultimate goal is to make mempolicy more flexible and extensible,
> > > such as adding interleave weights (which may need to change at runtime
> > > due to hotplug events).  Making mempolicy externally modifiable allows
> > > for userland daemons to make runtime performance adjustments to running
> > > tasks without that software needing to be made numa-aware.
> > 
> > Please add to this [0/N] a full description of the security aspect: who
> > can modify whose mempolicy, along with a full description of the
> > reasoning behind this decision.
> > 
> 
> Will do. For the sake of v0 for now:
> 
> 1) the task itself (task == current)
>    for obvious reasons: it already can
> 
> 2) from external interfaces: CAP_SYS_NICE

Makes sense.

[...]
> > > 3. Add external interfaces which allow for a task mempolicy to be
> > >    modified by another task.  This is implemented in 4 syscalls
> > >    and a procfs interface:
> > >         sys_set_task_mempolicy
> > >         sys_get_task_mempolicy
> > >         sys_set_task_mempolicy_home_node
> > >         sys_task_mbind
> > >         /proc/[pid]/mempolicy
> > 
> > Why is the procfs interface needed?  Doesn't it simply duplicate the
> > syscall interface?  Please update [0/N] with a description of this
> > decision.
> > 
> 
> Honestly I wrote the procfs interface first, and then came back around
> to just implement the syscalls.  mbind is not friendly to being procfs'd
> so if the preference is to have only one, not both, then it should
> probably be the syscalls.
> 
> That said, when I introduce weighted interleave on top of this, having a
> simple procfs interface to those weights would be valuable, so I
> imagined something like `proc/mempolicy` to determine if interleave was
> being used and something like `proc/mpol_interleave_weights` for a clean
> interface to update weights.
> 
> However, in the same breath, I have a prior RFC with set/get_mempolicy2
> which could probably take all future mempolicy extensions and wrap them
> up into one pair of syscalls, instead of us ending up with 200 more
> sys_mempolicy_whatever as memory attached fabrics become more common.
> 
> So... yeah... the is one area I think the community very much needs to
> comment:  set/get_mempolicy2, many new mempolicy syscalls, procfs? All
> of the above?

I think we should actively avoid using proc interface. The most
reasonable way would be to add get_mempolicy2 interface that would allow
extensions and then create a pidfd counterpart to allow acting on a
remote task. The latter would require some changes to make mempolicy
code less current oriented.
-- 
Michal Hocko
SUSE Labs
