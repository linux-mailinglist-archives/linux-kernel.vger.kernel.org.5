Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CF7BD68A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbjJIJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbjJIJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:13:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B25B6;
        Mon,  9 Oct 2023 02:13:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D231C433C7;
        Mon,  9 Oct 2023 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696842830;
        bh=jhipQjsWiEs+Ekubf342gQBtzevOfGi2BJ5QvrVCXa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoVD/LVv8aVw/fiyc7REZB4iBGjkQiMDiIXjJ1NUvGS912djNzCzSccBrjVnA+B8p
         QuINxv9JhjARUPo061A4lil0hWTiXPcrh+ZqqouR3fDxSnMnSajcFWBvPm9d1WPLe4
         PuSmHoiF9ObcPxlL4eujAkAUsCkEMj7YZzWL8VuvPqtwuWm0mVpu3Xt8eQji7zPR81
         sgg9LhNcKSushKV2A2D1/k+twz+uWzbWBdJdkiYqcVT8K38J6uUy0T0SrCfYddWkBu
         YiS+jP7rYMqxhA3i9wjwmIAtIgC+zMWjw1BsCeQescVFaEsFNdRaPIrYH0nZnzX28w
         IVrbomr9ZLrRA==
Date:   Mon, 9 Oct 2023 12:12:56 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
Message-ID: <20231009091256.GN3303@kernel.org>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-4-axelrasmussen@google.com>
 <ZSMkuf3g5hGk1Kjk@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSMkuf3g5hGk1Kjk@debian>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 11:52:56PM +0200, Alejandro Colomar wrote:
> Hi Axel,
> 
> On Tue, Oct 03, 2023 at 12:45:45PM -0700, Axel Rasmussen wrote:
> > The old FIXME noted that the zeroing was done to differentiate the two
> > EINVAL cases. It's possible something like this was true historically,
> > but in current Linux we zero it in *both* EINVAL cases, so this is at
> > least no longer true.
> > 
> > After reading the code, I can't determine any clear reason why we zero
> > it in some cases but not in others. So, some simple advice we can give
> > userspace is: if an error occurs, treat the contents of the structure as
> > unspecified. Just re-initialize it before retrying UFFDIO_API again.
> > 
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  man2/ioctl_userfaultfd.2 | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > index 28dd2fcdd..2ee6a0532 100644
> > --- a/man2/ioctl_userfaultfd.2
> > +++ b/man2/ioctl_userfaultfd.2
> > @@ -248,6 +248,14 @@ operation returns 0 on success.
> >  On error, \-1 is returned and
> >  .I errno
> >  is set to indicate the error.
> > +If an error occurs,
> > +the kernel may zero the provided
> > +.I uffdio_api
> > +structure.
> > +The caller should treat its contents as unspecified,
> > +and reinitialize it before re-attempting another
> > +.B UFFDIO_API
> > +call.
> >  Possible errors include:
> >  .TP
> >  .B EFAULT
> > @@ -281,14 +289,6 @@ feature was enabled,
> >  but the calling process doesn't have the
> >  .B CAP_SYS_PTRACE
> >  capability.
> > -.\" FIXME In the above error case, the returned 'uffdio_api' structure is
> > -.\" zeroed out. Why is this done? This should be explained in the manual page.
> > -.\"
> > -.\" Mike Rapoport:
> > -.\"     In my understanding the uffdio_api
> > -.\"     structure is zeroed to allow the caller
> > -.\"     to distinguish the reasons for -EINVAL.
> > -.\"
> 
> I've added Mike to the thread in case he wants to comment.

Thanks, Alex!

It looks like I reviewed v1 of the patchset though :)
 
> Thanks,
> Alex
> 
> >  .SS UFFDIO_REGISTER
> >  (Since Linux 4.3.)
> >  Register a memory address range with the userfaultfd object.
> > -- 
> > 2.42.0.609.gbb76f46606-goog
> > 
> 
> -- 
> <https://www.alejandro-colomar.es/>



-- 
Sincerely yours,
Mike.
