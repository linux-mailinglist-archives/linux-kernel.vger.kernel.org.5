Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706B7B54EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjJBOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbjJBOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:22:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FDA4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:22:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62136C433C7;
        Mon,  2 Oct 2023 14:22:20 +0000 (UTC)
Date:   Mon, 2 Oct 2023 10:23:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Lowell <nicholas.lowell@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
Subject: Re: [PATCH] trace: tracing_event_filter: fast path when no
 subsystem filters
Message-ID: <20231002102323.2fc0e4bc@gandalf.local.home>
In-Reply-To: <CAFEqNJ0SEjP4BvEHtZjyudo97uAMCv9P5jjCJ=Z7OxT3sdh67w@mail.gmail.com>
References: <20230926142058.1370-1-Nicholas.Lowell@gmail.com>
        <20230930040357.14fcbdf4@rorschach.local.home>
        <CAFEqNJ0SEjP4BvEHtZjyudo97uAMCv9P5jjCJ=Z7OxT3sdh67w@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 09:57:34 -0400
Nick Lowell <nicholas.lowell@gmail.com> wrote:
> >
> > The above looks awkward. What about:
> >
> >         if (!file->filter)
> >                 return 0;
> >
> >         remove_filter_string(file->filter);
> >         return 1;
> >
> > ?
> >
> > Or better yet:
> >
> >         if (!file->filter)
> >                 return false;
> >
> >         remove_filter_string(file->filter);
> >         return true;
> >
> >  
> Is it safe to assume you would like the function's return type to change
> from int to bool if I go with option 2?

Yes.

> 
> 
> > and ...
> >  
> > >  }
> > >
> > > -static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
> > > +static int filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
> > >                                       struct trace_array *tr)
> > >  {
> > >       struct trace_event_file *file;
> > > +     int i = 0;  
> >
> > We don't really need a counter. It's either do the synchronization or
> > we don't.
> >
> >         bool do_sync = false;
> >  
> > >
> > >       list_for_each_entry(file, &tr->events, list) {
> > >               if (file->system != dir)
> > >                       continue;
> > > -             __remove_filter(file);
> > > +             i += __remove_filter(file);  
> >
> >                 if (remove_filter(file))
> >                         do_sync = true;
> >  
> > >       }  
> >
> >         return do_sync;
> >
> >  
> Going to assume the same here--that return type should change from int to
> bool.
> 

Correct.

> 
> > > +     return i;
> > >  }
> > >
> > >  static inline void __free_subsystem_filter(struct trace_event_file  
> > *file)  
> > > @@ -2411,7 +2418,9 @@ int apply_subsystem_event_filter(struct  
> > trace_subsystem_dir *dir,  
> > >       }
> > >
> > >       if (!strcmp(strstrip(filter_string), "0")) {
> > > -             filter_free_subsystem_preds(dir, tr);
> > > +             if (filter_free_subsystem_preds(dir, tr) == 0)
> > > +                     goto out_unlock;
> > > +  
> >
> >                 /* If nothing was freed, we do not need to sync */
> >                 if (!filter_free_subsystem_preds(dir, tr))
> >                         goto out_unlock;
> >
> > And yes, add the comment.
> >
> > And actually, in that block with the goto out_unlock, we should have:
> >
> >                 if (!filter_free_subsystem_preds(dir, tr)) {
> >                         if (!(WARN_ON_ONCE(system->filter))
> >                                 goto out_unlock;
> >                 }
> >
> >  
> Can you explain why the WARN_ON_ONCE should be in a conditional.
> 
> Don't we still want the original conditional to cause the goto regardless?
> 

Because if it exists, we still want to free it and do the synchronization,
and set it to NULL. In other words, it means we missed something and need
to revert back to the original behavior.

The WARN_ON_ONCE() documents that we never expect that to happen, and if it
does, it means we have a bug.

-- Steve


> 
> 
>                 if (!filter_free_subsystem_preds(dir, tr)) {
>                         WARN_ON_ONCE(system->filter);
>                         goto out_unlock;
>                 }
> 
