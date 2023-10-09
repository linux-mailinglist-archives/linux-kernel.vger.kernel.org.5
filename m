Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2417BD5A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjJIIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbjJIIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:50:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D0B6;
        Mon,  9 Oct 2023 01:50:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C01C433C9;
        Mon,  9 Oct 2023 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696841405;
        bh=v/wmFXeFO8DxY0ma5UxE0sJMP9dgiKFa27sxu++CIu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsFIjY0VLVYQaqLRnSrTz6IwoA0CpE/WsT34CJe9hMZyePmmJm4Eh35/kWXhW6GiJ
         B4mKBygdefdqEK6Tpgrteu7YfB9jKMBN0mpAHrTivi7q5ugHo4NKTUk1xYYXHpa+jN
         QjoOdTpg+Tf/h0rj9ZrhFHLHUDpnnq7lr6vQiMby+f6pZC1xWbAAYu8sPxt5FIAaO+
         Vd1Yji1o7N40FlZtJ0UBfd79LNJ9KKumOYm6uMvWrds04P6rGydA8rB2mffzifBs8w
         eEbk0a/2BZ7yJi1WFjCebFxQkr5bthgJTwtQbZ8JRmoLaucs/R3bU09gfz0wHKnOMN
         1azUB+Nsnbd6w==
Date:   Mon, 9 Oct 2023 11:49:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] ioctl_userfaultfd.2: correct and update UFFDIO_API
 ioctl error codes
Message-ID: <20231009084911.GK3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-8-axelrasmussen@google.com>
 <5ddepg57wqnidtvsio2pse44dot6pvr3rcmhwld6ml3sflwcz3@ijd3h4teqblr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ddepg57wqnidtvsio2pse44dot6pvr3rcmhwld6ml3sflwcz3@ijd3h4teqblr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:52:34AM +0200, Alejandro Colomar wrote:
> Hi Axel,
> 
> On Tue, Sep 19, 2023 at 12:02:03PM -0700, Axel Rasmussen wrote:
> > First, it is not correct that repeated UFFDIO_API calls result in
> > EINVAL. This is true *if both calls enable features*, but in the case
> > where we're doing a two-step feature detection handshake, the kernel
> > explicitly expects 2 calls (one with no features set). So, correct this
> > description.
> > 
> > Then, some new error cases have been added to the kernel recently, and
> > the man page wasn't updated to note these. So, add in descriptions of
> > these new error cases.
> > 
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  man2/ioctl_userfaultfd.2 | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > index 53b1f473f..1aa9654be 100644
> > --- a/man2/ioctl_userfaultfd.2
> > +++ b/man2/ioctl_userfaultfd.2
> > @@ -280,17 +280,31 @@ refers to an address that is outside the calling process's
> >  accessible address space.
> >  .TP
> >  .B EINVAL
> > -The userfaultfd has already been enabled by a previous
> > -.B UFFDIO_API
> > -operation.
> > -.TP
> > -.B EINVAL
> >  The API version requested in the
> >  .I api
> >  field is not supported by this kernel, or the
> >  .I features
> >  field passed to the kernel includes feature bits that are not supported
> >  by the current kernel version.
> > +.TP
> > +.B EPERM
> 
> This EPERM should probably be at the end.  Unless you have a good reason
> to break alphabetic order.

I agree with Alex here, other than that feel free to add

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

 
> Thanks,
> Alex
> 
> > +The
> > +.B UFFD_FEATURE_EVENT_FORK
> > +feature was enabled,
> > +but the calling process doesn't have the
> > +.B CAP_SYS_PTRACE
> > +capability.
> > +.TP
> > +.B EINVAL
> > +A previous
> > +.B UFFDIO_API
> > +call already enabled one or more features for this userfaultfd.
> > +Calling
> > +.B UFFDIO_API
> > +twice,
> > +the first time with no features set,
> > +is explicitly allowed
> > +as per the two-step feature detection handshake.
> >  .\" FIXME In the above error case, the returned 'uffdio_api' structure is
> >  .\" zeroed out. Why is this done? This should be explained in the manual page.
> >  .\"
> > -- 
> > 2.42.0.459.ge4e396fd5e-goog
> > 



-- 
Sincerely yours,
Mike.
