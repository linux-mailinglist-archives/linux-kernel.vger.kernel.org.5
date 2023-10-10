Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F37C014C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjJJQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjJJQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:11:22 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFABCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9FJwAU28iuTv/7nCKDXq9E5+1x1YwYFBxD8benLUCJo=;
  b=t3CQTzLmOiWH7ZebcX0dJMdBkY1Ade1HaaJpBfkXTF9ewtNXh0zYeBy/
   QZsrfKH4AJcJkFheWzNzXG6NTe3OR3Wx3ZrdS59FsjrWjvlmk0cL8v1JJ
   VPUot77JI2GuymEWdKhfDQAt5LGmKz5+TFpt4J8faCUzxS0dzFHWesBe0
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,213,1694728800"; 
   d="scan'208";a="130495417"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:11:16 +0200
Date:   Tue, 10 Oct 2023 18:11:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Anton Eliasson <anton.eliasson@axis.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
In-Reply-To: <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
Message-ID: <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com> <20231003-coccicheck-v1-2-07d2d900a52a@axis.com> <alpine.DEB.2.22.394.2310072140340.36842@hadrien> <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Oct 2023, Anton Eliasson wrote:

> On 07/10/2023 21.41, Julia Lawall wrote:
> >
> > On Tue, 3 Oct 2023, Anton Eliasson wrote:
> >
> > > This helps automating coccicheck runs by discarding stderr and only
> > > looking at the output of stdout. In report mode the only remaining
> > > output on stdout is the initial "Please check for false positives"
> > > message followed by each spatch warning found.
> > What is getting dropped is the spatch command lines indicating the
> > semantic patch.  Is this desirable?
> >
> > julia
> It's not ideal but it's the best compromise that I have found. The problem I'm
> trying to solve is to be able to diff the output of two coccicheck runs and
> notify the developer if any new warnings were introduced. That requires the
> output to be stable. spatch is always invoked for each cocci file in the same
> order. However, the output from each spatch invocation is not stable as it
> examines each source file in an arbitrary order.
>
> My workaround is to sort the output before diffing. The line-by-line sorted
> output only makes sense if the input is one line per warning found and that is
> why I try to discard all output except the single line per spatch warning.
> While the terse output doesn't tell which semantic patch file generated the
> warning, it does usually contain the offending file, line number and a summary
> of the issue.

Why does the command line pose a problem for sorting?

julia

>
>
> Anton
> >
> > > Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
> > > ---
> > >   scripts/coccicheck | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > > index 95a312730e98..7e7c44125f47 100755
> > > --- a/scripts/coccicheck
> > > +++ b/scripts/coccicheck
> > > @@ -146,8 +146,8 @@ run_cmd_parmap() {
> > >                   echo $@>>$DEBUG_FILE
> > >                   $@ 2>>$DEBUG_FILE
> > >           else
> > > -                echo $@
> > > -                $@ 2>&1
> > > +                echo $@ >&2
> > > +                $@
> > >   	fi
> > >
> > >   	err=$?
> > >
> > > --
> > > 2.30.2
> > >
> > >
>
>
