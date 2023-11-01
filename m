Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E27DDF51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjKAKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjKAKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:24:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8E10A;
        Wed,  1 Nov 2023 03:24:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92531C433C7;
        Wed,  1 Nov 2023 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698834276;
        bh=RwpwGnocw6uZNsKYyHZSk+qs8oRJkl1AiuuR52/+UbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bzVf4mZK3OhUrBy3tKrxdZXEjVnrMKW8Uf0jHVhmd1ibzGKf006kFgN/Ydm9GaEAY
         yRo54G9eMZ0s5BpI5L8Z0vGSvDhOtCFQtEIlEm9vO7igrdjas9ivN/UkfCBl5DIoxq
         agDEdFID51CjV8ByCHfQzxvW39zr2MnLmNNRjefhWI20sLn2o7cxQuwYnzjcHhg7K0
         dO7T3UCwjyqnGxCH3wjwwpagt/tBVzfXPFcJykroMtxhxq+VY9z+EHgAlyQWo+XmLQ
         8wksKDwZLnFht6sV4eNMzqCsgPnRzBUYNmHNoRYGEiulRzV/u/xmAo7uI8HE7qed4s
         gHg2GEwe9JIjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25BDBCE0B77; Wed,  1 Nov 2023 03:24:36 -0700 (PDT)
Date:   Wed, 1 Nov 2023 03:24:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, rcu@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] refscale: Optimize process_durations()
Message-ID: <014c446a-23c4-40f9-9512-6869a9b02117@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr>
 <ozbrmbywamyfkv3amsf2dfdacwmi25serwhc75h6fpsahklsmo@rm43srgxumef>
 <bcd6bfe1-9891-4f22-86ad-361330e47e9d@paulmck-laptop>
 <a6943003-da31-4ac7-8944-c7dc06381148@paulmck-laptop>
 <37ab9219-a049-4a43-b555-83b1629e5a48@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37ab9219-a049-4a43-b555-83b1629e5a48@wanadoo.fr>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 08:41:39AM +0100, Christophe JAILLET wrote:
> Le 31/10/2023 à 23:47, Paul E. McKenney a écrit :
> > On Tue, Oct 31, 2023 at 11:21:14AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 30, 2023 at 09:55:16AM -0700, Davidlohr Bueso wrote:
> > > > On Sat, 28 Oct 2023, Christophe JAILLET wrote:
> > > > 
> > > > > process_durations() is not a hot path, but there is no good reason to
> > > > > iterate over and over the data already in 'buf'.
> > > > > 
> > > > > Using a seq_buf saves some useless strcat() and the need of a temp buffer.
> > > > > Data is written directly at the correct place.
> > > > 
> > > > Makes sense.
> > > > 
> > > > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > Queued and pushed, thank you all!
> > 
> > But an allmodconfig build complains about seq_buf_putc() being undefined,
> > that is, not exported.  I suspect that other seq_buf_*() functions in
> > this patch might also be complained about.
> > 
> > I am dropping this for the moment.  Please make it pass an allmodconfig
> > build so that I can pull it in again.  Please see below for the commit.
> 
> Ouch!

Believe me, I know that feeling!  ;-)

> seq_buf_init(), seq_buf_terminate(), seq_buf_clear() are inlined functions
> in a .h file, so shouldn't be a problem.
> 
> seq_buf_printf() is exported, but seq_buf_putc() is not!
> Really odd to me.
> 
> Kees Cook (added in cc) suggests to use this API (see [1]) to avoid some
> potential issues and ease the management of NULL terminated strings in
> buffers. (#LinuxHardening).
> 
> I'll propose to add the missing EXPORT_SYMBOL_GPL.

Very good, looking forward to seeing the result.

							Thanx, Paul

> CJ
> 
> [1]: https://lore.kernel.org/all/202310241629.0A4206316F@keescook/
> 
