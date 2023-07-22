Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF575D900
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGVCXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGVCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7735AB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689992529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lGXyRvvOTWAiP2i+H+p8f2DO1VQ/VfdgvLVCErvmOcM=;
        b=eMifrLNJTNRJdtBb0+PJpP2EkdkzfQByG9udYHEoqOWzWRmjkA4/IoODMsoaVKNCS0Em6T
        88rA/nUvYmQ1d/KHELk3Ih/C8DOtpXMnbd0Qx70SAPxr5IV1//HsVzCuTkWfp2qOw9KjSZ
        XEXxyriUvDulxnCsGYhQm7QWY8i5NlA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-QMaaJ_2NMvidIk6rQ4xkEg-1; Fri, 21 Jul 2023 22:22:07 -0400
X-MC-Unique: QMaaJ_2NMvidIk6rQ4xkEg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b4436d4b6eso5460770fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689992527; x=1690597327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGXyRvvOTWAiP2i+H+p8f2DO1VQ/VfdgvLVCErvmOcM=;
        b=W4Yn9fcotJrljMAQdIgT9SHs/e65gyIbBPNKne8HAiyJlwVsbpg/ChBNkzoX979iDg
         fTfdMUi697MK+yYaZfOO1CkpwVAydIzL/Wg1oyhQYPiasIx3ycb58e5o0qNnRJHbEG+L
         0p7ruatqBVNxJKUy9Yxjfp+XUZ3M4OOwLC7eBPUNDJTnQVWQ1Dl9U4/bgmd0LlJ3vQur
         J1vvTgmQcI0KTv3EZftsB0GomowPOniNUY6TmcJm0s9bIuNIq4Z3Jc1Ty3YsaXqEmUV4
         LVAhKPiKl0Xb7lUHag6YEvqHkXYRgMI6ERN0Mh6ROeSHTHr+ZOrdktbVKTs2IudU9J4x
         cZrQ==
X-Gm-Message-State: ABy/qLYwVAwLYZ3WhgbrDpwK5kbPbA4Z2ngKK2FsArJGBTHwYfkY1xlE
        WOTTM6O8yLxdOOxvT6VlT3UithcFwWzASS1zqM0SKWTljscouTwO4eUsNnclIsHPAUHEc4Tm1BN
        HjCbOGAcHcdYDC6w2nnpGtU76qrl6BgIJhepUYR6w
X-Received: by 2002:a05:6871:29b:b0:1bb:3b94:c651 with SMTP id i27-20020a056871029b00b001bb3b94c651mr325402oae.41.1689992527230;
        Fri, 21 Jul 2023 19:22:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZJQFIRWMQ5HZX9/fDBkAcweuMzUKYQ8OBaCQ06GX1oJcws787tWIidhAtwWsMjIszKYmb89X9Shbimo3fgJA=
X-Received: by 2002:a05:6871:29b:b0:1bb:3b94:c651 with SMTP id
 i27-20020a056871029b00b001bb3b94c651mr325396oae.41.1689992526974; Fri, 21 Jul
 2023 19:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718185156.1015753-1-costa.shul@redhat.com> <87y1j9ca42.fsf@meer.lwn.net>
In-Reply-To: <87y1j9ca42.fsf@meer.lwn.net>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Sat, 22 Jul 2023 05:21:56 +0300
Message-ID: <CADDUTFxu4owj_aXo2OBug3qBLbmS8boNXzcra8qLsqDYwN5Kpg@mail.gmail.com>
Subject: Re: [PATCH] docs: remove tree links from the main index
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The left column "Contents" is overloaded and hard to use. The value of
this patch is to make it more usable.

Sections of the main page are not displayed after patch "docs: Add
more information to the HTML sidebar". So sections don't work now and
should be fixed too.

I have in mind to reorganize the main page so the left column
"Contents" becomes usable.

Thanks
Costa

On Fri, 21 Jul 2023 at 22:56, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Costa Shulyupin <costa.shul@redhat.com> writes:
>
> > and leave only their neighbor subsystem-apis
> >
> > because these links are already listed under
> > section "Core subsystems" of Documentation/subsystem-apis.rst:
> >
> >     Core subsystems
> >     ---------------
> >
> >     .. toctree::
> >        :maxdepth: 1
> >
> >        core-api/index
> >        driver-api/index
> >        mm/index
> >        power/index
> >        scheduler/index
> >        timers/index
> >        locking/index
> >
> > Reference:
> > - https://www.kernel.org/doc/html/next/subsystem-apis.html#core-subsystems
> >
> > Motivation:
> > - make the documentation more organized
> > - increase consistency, observability and maintainability
> > - improve balance of ToC tree by reducing overly populated lists
> > - avoid duplicate parallel links
> > - escape tangling of links
> > - intention to fit the main index into one page
> >
> > Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> > ---
> >  Documentation/index.rst | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 9dfdc826618c..8d8b7eab1131 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -38,10 +38,7 @@ kernel.
> >  .. toctree::
> >     :maxdepth: 1
> >
> > -   core-api/index
> > -   driver-api/index
> >     subsystem-apis
> > -   Locking in the kernel <locking/index>
>
> So I don't really see the value of this.  It takes away some of the most
> important links from the documentation front page, leaving the "Internal
> API manuals" section nearly empty.  Why would we want to do this?
>
> Thanks,
>
> jon
>

