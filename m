Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E915279862E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIHKvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjIHKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ABF1FEB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694170207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+VMi9AIhBNUiIBj7p6LIsHTOc75fW6SCtZhhU9EiKk=;
        b=MYCaigRDb4kqw+E7CdJO/5VIjfdk4ozFMEZVjwq08eKN2+JamU6TMaQB6ZjF9hkzqAWMT2
        TyzcYSCzz4NZFa4pPhbkjXLq9BTKW11prtuH3TEwCQydtjWejG5Gem4TE5FtiK9Js+ISNc
        7tj9MFIF4ftpiOKC0KDnILsawGiv8qM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-rbTDIA1oPICpKYZfjKkQ0w-1; Fri, 08 Sep 2023 06:50:06 -0400
X-MC-Unique: rbTDIA1oPICpKYZfjKkQ0w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-64aaa3c2bc2so21397466d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694170206; x=1694775006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+VMi9AIhBNUiIBj7p6LIsHTOc75fW6SCtZhhU9EiKk=;
        b=omGzlbb3yqftretQXAxrPpuhDcJ0wuYb2EFkLEvdLvmp2o6xlyVuu15c1Rb4K428Rn
         5//vhHgHkfyvtriqk91rJ6MK4inoRmxgtj1ncYcKt/ttFySMu85IwNw6+kREcCC7pFmF
         RtKINmQgmV/gut/gdIBPH7xvVZ3BDWG0GkLCZ64AKZioSFQS2EVgMJzMCfUs/wEA062G
         MZ41nU89eans59xk2p0WCPUEJC9py57r/CLYXiKlQtCxBo4qXGZe4Vy0Zp3ptEOcLqYv
         6QPA/yfA1tMAOcjWVEMYNIfDh+6po+oXq6/M7DJf1L94LX02wTJU+VGLnYYvfkF49xlN
         gFDg==
X-Gm-Message-State: AOJu0Yym9GmxSTeMUk8Dz+pWV7lGxo2Hj3y2SCQhqzYSKgOZm7iWlQq0
        SoiH0ki3f9oqgk1DfL6Wu6z/HeVKp+Zp+ADtxF9aJcc9BJWIJaQ3vaGpmoH+NL1UwksK9FbFl27
        c1vmdFTRRyZLsp/PwwhQLq27a
X-Received: by 2002:a0c:ab89:0:b0:647:3083:4575 with SMTP id j9-20020a0cab89000000b0064730834575mr2029163qvb.57.1694170206153;
        Fri, 08 Sep 2023 03:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHowHtg/7qrbTUfBYxyvRbh2OPQB25QBt9WjKZGbCz85nIw1hL9MNtMb7UxlXjOJ57Pf4AT3A==
X-Received: by 2002:a0c:ab89:0:b0:647:3083:4575 with SMTP id j9-20020a0cab89000000b0064730834575mr2029154qvb.57.1694170205926;
        Fri, 08 Sep 2023 03:50:05 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id i16-20020a0cf390000000b0064f57d3100asm582030qvk.102.2023.09.08.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:50:05 -0700 (PDT)
Date:   Fri, 8 Sep 2023 06:50:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPr8ZUsw+/oNzs/p@bfoster>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <20230906222847.GA230622@dev-arch.thelio-3990X>
 <202309061658.59013483F@keescook>
 <20230907203946.xbtd2ddp3wztcffz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907203946.xbtd2ddp3wztcffz@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:39:46PM -0400, Kent Overstreet wrote:
> On Wed, Sep 06, 2023 at 05:03:06PM -0700, Kees Cook wrote:
> > On Wed, Sep 06, 2023 at 03:28:47PM -0700, Nathan Chancellor wrote:
> > > Hi Kent,
> > > 
> > > On Sat, Sep 02, 2023 at 11:25:55PM -0400, Kent Overstreet wrote:
> > > > here's the bcachefs pull request, for 6.6. Hopefully everything
> > > > outstanding from the previous PR thread has been resolved; the block
> > > > layer prereqs are in now via Jens's tree and the dcache helper has a
> > > > reviewed-by from Christain.
> > > 
> > > I pulled this into mainline locally and did an LLVM build, which found
> > > an immediate issue. It appears the bcachefs codes uses zero length
> > 
> > It looks like this series hasn't been in -next at all? That seems like a
> > pretty important step.
> > 
> > Also, when I look at the PR, it seems to be a branch history going
> > back _years_. For this kind of a feature, I'd expect a short series of
> > "here's the code" in incremental additions (e.g. look at the x86 shstk
> > series), not the development history from it being out of tree -- this
> > could easily lead to ugly bisection problems, etc.
> 
> Chris already commented on this, but - we really want the full history
> available, that's important context for anyone working on the code going
> forward. Brian was just mentioning digging through the history for
> context in the meeting last Tuesday, and I've been going to a lot of
> effort to make sure every commit builds and runs.
> 

Yeah.. IMO the main advantages of a sort of squashed down/sanitized git
history is to either aid in code review or just clean up a history that
is aesthetically a mess. For the former, the consensus seems to be that
no one person is going to sit down and review the entire codebase, but
rather folks have been digging into peripheral areas they have
experience in (i.e., locking, pagecache, etc.) to call out any major
concerns. I believe Kent has also offered to give pointers or just sit
down with anybody who needs assistance to navigate the codebase for
review purposes. For the latter, ISTM that bcachefs has pretty much
followed kernel patch conventions, with it being originally derived from
another upstream kernel subsystem and whatnot.

The flipside is that losing the history makes it incrementally more
annoying for developers working on bcachefs going forward. So I can see
an argument for doing things either way in general just depending on
context, but it looks like there's precedent for either approach.
Looking back at btrfs in v2.6.29, that looks like a ~900 or so commit
history that was pulled in. bcachefs has a larger commit log (~2500+) at
this point, but if we can do whatever magic Chris referred to to try and
avoid any logistical issues for the broader kernel community, I think
that would be ideal.

BTW this is just my .02 of course, but I'm also fairly certain at least
one or two developers have looked at the git log and expressed the exact
opposite opinion expressed here: that seeing an upstream-like history is
appreciated because it reflects a sane/compatible development process.
That again isn't to say one way or the other is the right approach for a
merge, just that it seems subjective to some degree and so inevitably
there will be different opinions..

Brian

