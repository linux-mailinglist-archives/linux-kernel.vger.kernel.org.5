Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346CF7FC203
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjK1OtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346317AbjK1OtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:49:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F7AA;
        Tue, 28 Nov 2023 06:49:11 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1268E1F7AB;
        Tue, 28 Nov 2023 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701182950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGmTk8emchkRnIZ9vc9YqHrdZi2kThKUDQIAuz1Uolw=;
        b=mBdDZcd9KOpnp6jijp/2TTuNI4abARr+OJznAuryiNL8esNd6d8hxt24jNjY5GxKISRdl4
        rk985MoB8ccxv9jIslmGTbZVFBBHh5PhwdGTcQryuFGa7XVqeLkxCSY0hUJyivkIAZ2HDX
        oi4DuA18ebHpnewyXPXCHNDbM9ia7MM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5158F13763;
        Tue, 28 Nov 2023 14:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id tyvkEOX9ZWUCRQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 14:49:09 +0000
Date:   Tue, 28 Nov 2023 15:49:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tj@kernel.org, ying.huang@intel.com,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 04/11] mm/mempolicy: modify get_mempolicy call stack
 to take a task argument
Message-ID: <ZWX94KO-XYLuikHd@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-5-gregory.price@memverge.com>
 <ZWX0IMfR3S3rRzen@tiehlicka>
 <ZWX1U1gCTXC+lFXn@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWX1U1gCTXC+lFXn@memverge.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-0.999];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-0.992];
         RCPT_COUNT_TWELVE(0.00)[19];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[24.72%]
X-Spam-Score: -0.80
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[restoring the CC list as I believe this was not meant to be a private
response]

On Tue 28-11-23 09:12:35, Gregory Price wrote:
> On Tue, Nov 28, 2023 at 03:07:28PM +0100, Michal Hocko wrote:
> > On Wed 22-11-23 16:11:53, Gregory Price wrote:
> > [...]
> > > @@ -928,7 +929,16 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
> > >  		 * vma/shared policy at addr is NULL.  We
> > >  		 * want to return MPOL_DEFAULT in this case.
> > >  		 */
> > > -		mm = current->mm;
> > > +		if (task == current) {
> > > +			/*
> > > +			 * original behavior allows a kernel task changing its
> > > +			 * own policy to avoid the condition in get_task_mm,
> > > +			 * so we'll directly access
> > > +			 */
> > > +			mm = task->mm;
> > > +			mmget(mm);
> > 
> > Do we actually have any kernel thread that would call this? Does it
> > actually make sense to support?
> > 
> 
> This was changed in the upcoming v2 by using the pidfd interface for
> referencing both the task and the mm, so this code is a bit dead.

OK, that is the right thing to do IMHO. Allowing modifications on memory
policies on borrowed mms sounds rather weird and if we do not have any
actual usecases that would require that support then I would rather not
open that possibility at all.

-- 
Michal Hocko
SUSE Labs
