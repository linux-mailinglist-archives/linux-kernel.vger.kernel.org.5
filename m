Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39078413C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjHVMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHVMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E43196;
        Tue, 22 Aug 2023 05:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C19063A24;
        Tue, 22 Aug 2023 12:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F5CC433C7;
        Tue, 22 Aug 2023 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692708720;
        bh=HHS+KFzKB/4+wRIIYJAuxJ+p0HkEFOmktJAC/AvivQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xc8YmAYolYEKgqlEqu+wlIwELWgvho/gg8YzYuMK8scR8HxiuyKprS6z+0O3OKXdh
         TpU3HfX0nlQxI+U0+1bgMNDHM8iUpm0xNHZUBeaI193tHVKWe7w0nbhxDD3MFrDHdV
         JZ3SZ5dq9bU2x42aHAsz68l0zyXTtI1Tx1SLvsnnIBS7Lu3Sum0t5JWeJbGbBitjH/
         SIQnWmdHoDuyBrkHTB9m1Qj0tavI1yYT3ALtP6Kg+69CfUPt2fxkW8H3gCe2rW7hTn
         whtwhIuxcFRhk8AGDUlNoZzPVjjgkqBM5/wkhAYnQoeWD8VrIwdIkYqfFiIuozO+Zz
         f+NqqcoAjp+tA==
Date:   Tue, 22 Aug 2023 21:51:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-Id: <20230822215157.35002478c5e2d40b6abf5e8e@kernel.org>
In-Reply-To: <20230822045937.3fc0da54@rorschach.local.home>
References: <169262755804.106231.8245792908363050528.stgit@devnote2>
        <20230822045937.3fc0da54@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 04:59:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 21 Aug 2023 23:19:18 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> >  	if (!spd.nr_pages) {
> >  		long wait_index;
> > +		size_t nr_pages;
> > +		size_t full;
> 
> size_t is usually considered "long" (machine word length).
> 
> >  
> >  		if (ret)
> >  			goto out;
> > @@ -8472,7 +8474,15 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
> >  
> >  		wait_index = READ_ONCE(iter->wait_index);
> >  
> > -		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
> > +		/* For splice, we have to ensure at least 1 page is filled */
> > +		nr_pages = ring_buffer_nr_pages(iter->array_buffer->buffer, iter->cpu_file);
> > +		if (nr_pages * iter->tr->buffer_percent < 100) {
> > +			full = nr_pages + 99;
> > +			do_div(full, nr_pages);
> 
> No need for do_div() as full is not 64 bit on 32 bit machines.
> 
> That's why the kernel test robot is complaining.

Thanks for the comment. I decided to set full = 1, maybe we don't need to set
the percent to be the page size because full_hit() checks it by the number
of dirty pages. :)
I'm testing a new one.

Thanks,

> 
> -- Steve
> 
> > +		} else
> > +			full = iter->tr->buffer_percent;
> > +
> > +		ret = wait_on_pipe(iter, full);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
