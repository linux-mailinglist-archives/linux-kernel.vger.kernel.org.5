Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E367F63FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjKWQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjKWQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:33:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7B10C7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:33:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60A2C433CA;
        Thu, 23 Nov 2023 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700757195;
        bh=SG11iwaP+p3koKgEoIVWXgRVVhH7qW0Y0/2cmw+cMpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRHhRKo69OXirFp+Rt89lJzssRTbqTsohTNQcXFTUxdRnQHui3q8TSYSPO8SKrQC/
         apsxzb02JH6F8E2/A8Y+mQWA9CSforGzyx14GmG7KtRdXJ7Fwo5ozuYo+xctTezX+6
         e4Z/UJVWbDFeJ+rPhV9+qTdkb0dQIV4kJSt7WVlBa/pi5TVSzIOXE77wAvq/ekeZ7Y
         fR0IriTFRegUMQnRs0pPjjJJoK6QZUFgQN2caRms+YlTkpkK8Xcqkvp6z5rxLi9DZg
         yQ5mBweHcpFEcaw+ukuWs7hps2RwbRsdWJWFym5IL855bTKNlgyA7iJNkrhXvxnXMP
         jiPPfmnIZs8Hw==
Date:   Thu, 23 Nov 2023 17:33:05 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 2/5] fork: Add shadow stack support to clone3()
Message-ID: <20231123-ausziehen-harpune-d020d47f964c@brauner>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>
 <20231123-derivate-freikarte-6de8984caf85@brauner>
 <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:17:19PM +0000, Mark Brown wrote:
> On Thu, Nov 23, 2023 at 11:28:47AM +0100, Christian Brauner wrote:
> > On Mon, Nov 20, 2023 at 11:54:30PM +0000, Mark Brown wrote:
> 
> > Any reasonably maximum that should be assumed here? IOW, what happens if
> > userspace starts specifying 4G shadow_stack_size with each clone3() call
> > for lolz?
> 
> I guess we could impose RLIMIT_STACK?

Yeah, that also seems to be what acct_stack_growth() is using.

> 
> > > +	} else {
> > > +		/*
> > > +		 * For CLONE_VFORK the child will share the parents
> > > +		 * shadow stack.  Make sure to clear the internal
> > > +		 * tracking of the thread shadow stack so the freeing
> > > +		 * logic run for child knows to leave it alone.
> > > +		 */
> > > +		if (clone_flags & CLONE_VFORK) {
> > > +			shstk->base = 0;
> > > +			shstk->size = 0;
> > > +			return 0;
> > > +		}
> 
> > Why is the CLONE_VFORK handling only necessary if shadow_stack_size is
> > unset? In general, a comment or explanation on the interaction between
> > CLONE_VFORK and shadow_stack_size would be helpful.
> 
> This is the existing implicit behaviour that clone() has, it's current
> ABI for x86.  The intent is that if the user has explicitly configured a
> shadow stack then we just do whatever they asked us to do, if they

So what I'm asking is: if the calling process is suspended until the
child exits or exec's does it make sense for the child to even get a
shadow stack? I don't know the answer which is why I'm asking.
