Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9D752620
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGMPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjGMPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71A2D41;
        Thu, 13 Jul 2023 08:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD05617DE;
        Thu, 13 Jul 2023 15:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E9C433C8;
        Thu, 13 Jul 2023 15:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689260785;
        bh=BrCUMVcm59ip3FSmvaFKeun1VvhqNZrzrk4aUt0/9Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFBjaugwDoPkC2zgwS6Wm+VJbI5MixQEPfHBTO6gxycFEf2JVAYzAjWhScNrxB+du
         PCsaChe5OoOPQLr0CFNhILR0+O2SKt3Fu5NnH3QLtCt1amoWfvVXAd7pGJlm8c41RC
         BepfZTr6lmRiu5WI+24k24vpiHDVk/2TF2MpE3xE=
Date:   Thu, 13 Jul 2023 17:06:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
Message-ID: <2023071341-twitter-apron-e023@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
 <2023071221-blade-reactive-0707@gregkh>
 <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
 <2023071215-able-mushy-c889@gregkh>
 <18238769-39c3-2b40-7725-367aa0e5c50b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18238769-39c3-2b40-7725-367aa0e5c50b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:48:14AM +0200, Thorsten Leemhuis wrote:
> On 12.07.23 21:00, Greg KH wrote:
> > On Wed, Jul 12, 2023 at 07:02:34PM +0200, Thorsten Leemhuis wrote:
> >> On 12.07.23 17:16, Greg KH wrote:
> > [...]
> >>>>   .. warning::
> >>>>      The branches in the -stable-rc tree are rebased each time a new -rc
> >>>>      is released, as they are created by taking the latest release and
> >>>>      applying the patches from the stable-queue on top.
> >>>
> >>> Yes, that is true, but they are also rebased sometimes in intermediate
> >>> places, before a -rc is released, just to give CI systems a chance to
> >>> test easier.
> > [...]
> >> Nevertheless makes me wonder: is that strategy wise in times when some
> >> ordinary users and some distributions are building kernels straight from
> >> git repos instead of tarballs? I'm one of those, as I distribute
> >> stable-rc packages for Fedora here:
> >> https://copr.fedorainfracloud.org/groups/g/kernel-vanilla/coprs/
> > 
> > As we keep the patches in quilt, not git, it's the best we can do.  The
> > -rc releases are never a straight-line if we have to do multiple ones,
> > we remove patches in the middle, add them at the end or beginning, and
> > sometimes even change existing ones.
> > 
> > All of this is stuff that a linear history tool like git can't really
> > model well, so we keep a quilt series of the patches in git for anyone
> > that want to generate the tree themselves, and we provide the -rc git
> > tree for those that don't want to generate it and can live with the
> > constant rebasing.
> 
> /me first didn't want to reply, as this is not really important, but
> then reconsidered; again, feel free to just ignore this
> 
> FWIW, I do not consider that rebasing to be problem at all; it are those
> rebases "sometimes in intermediate places, before a -rc is released,
> just to give CI systems a chance to test easier" make things this
> slightly annoying bit harder when you want to distribute stable-rc
> releases to users.
> 
> But as I said, I can fully understand why you do those as well. I just
> with there was a way to reliably get a -rc release from git as well.
> Simply tagging them when you do a -rc release would solve all that. Is
> that maybe something that could be easily added to your -rc release scripts?

I can add a tag, but it would have to be a tag that can be rebased, and
git doesn't like that very well :)

> /me looks at https://github.com/gregkh/gregkh-linux/tree/master/stable
> but failed to find the -rc release script :-/

Hah, no github, it's at:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/scripts/quilt-mail

But I don't think tags will help much.  I'll let anyone who actually
runs a CI that uses this to speak up to see if it would before adding
them.

Also, as proof this works, I just got a report of someone testing the
queues and finding a problem at the moment, before we sent anything out
for review.  So this is working well today.

thanks,

greg k-h
