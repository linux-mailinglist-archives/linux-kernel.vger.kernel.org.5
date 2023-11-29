Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E657FD7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjK2NSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjK2NS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:18:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466885
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:18:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCCC433C7;
        Wed, 29 Nov 2023 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701263915;
        bh=CH4bkKpxHIWHSdFzklA5WiWWU65t0PzVjUEFdnbKQgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ri0kKaOP/wr7YbGajgN2fILimAXlnGJSp4VVVU3zg0NXB5O5EWDJNUWsB3hOY9dSg
         xcr+MsEeeCNlzPCd9YTlnCVs3ATRz+FStcpvccI+Gxy9F9rj9ZU9wa7f+k719NHOLm
         1bjSvrSC5k7lSwBkZBa1HHmIlTpZ3+/pm1f5sjguyi5PYyUNOPW4iuwOKcgzYPSYcz
         8+MdhdAJZ9DBt72pMGKfBSZP3J7KNK+3xhMkWrzMr3YdkeOlwu7RsBy3knsuyJ13RS
         1+tvBg15Ey/g761GLH7MlaFSwIIm/Y6WLZVQJQJHXbgBzUS4AhFuVOWQkTPtert4yz
         Edm7cTjiy7oTQ==
Date:   Wed, 29 Nov 2023 22:18:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        suleiman@google.com, briannorris@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp
 in sysfs
Message-Id: <20231129221830.05ee995bfd0f5337dd0fb4d1@kernel.org>
In-Reply-To: <6e664be1-dc6b-461e-b75d-2be49641402c@infradead.org>
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
        <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
        <6e664be1-dc6b-461e-b75d-2be49641402c@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, 27 Nov 2023 15:47:01 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi--
> 
> 
> On 11/27/23 02:38, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> 
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index f6425ae3e8b0..2ab23fd3daac 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> 
> > @@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
> >  			suspend_step_name(
> >  				suspend_stats.failed_steps[index]));
> >  	}
> > +	seq_printf(s,	"last_success_resume_time:\t%-llu.%llu\n",
> 
> The <TAB> after "s," is a bit odd IMO, but I don't see a need to resend it
> just for that.

Yeah, this might be a cosmetic tab. You can see the other seq_prints()
in the same function also have the same <TAB>. I don't want to break it.

Thank you,

> 
> > +		   (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> > +		   (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
> >  
> >  	return 0;
> >  }
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
