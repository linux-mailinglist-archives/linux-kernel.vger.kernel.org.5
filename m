Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C37514C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGLXwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGLXwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:52:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153A1BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:52:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9d80e33fbso1213025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689205963; x=1691797963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EK3bP9StwfGqXNuskzFyO16EhMwkltUyoXwDFC2U/i8=;
        b=G8O/g2xzAW/pvRSJNe08rpvHCLh9Rj27H5GLixWV6psuOyVJqW5T04A4YVbbXfZvyL
         wzENG5vsVfiC9E0G62q5mRjqtSouoGnFtquDq1p4FINeGv3rsbM//iddE2xzON3D8VQI
         NomPURKgkxiDekEYqkCQn72w6ecJ7IwVFkX8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205963; x=1691797963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EK3bP9StwfGqXNuskzFyO16EhMwkltUyoXwDFC2U/i8=;
        b=Vp8g2aSOLkb/aj+QSSIyRMoDESYVQJfdwTLS58lA9zeh/lFk8tc2EzKOwrvEjtH3Yr
         04o4NqD/Zp7B5RXRaTjjjh8MW1+1JulDDyVTMOwATmLmlQSvVFlUG8CkVDYG4iZVQOgO
         /VSzzJVOt3yNXFffBs4SpB30xVdbX2kQcSvlosELryGKBzSDnIR9qLfXx53f0fHq83Om
         HWKxn/zM4iO2iDBYWYxCJQ5KmqHKMAB228HEYSM7leW4QhSFUISvOkIdkJcWJWc0RO5H
         leVj58Xvrapka4LvOpwrs+fO+DtxkFWxyO5uFEKx2KKaND5LZ/n9fui3YoECZA+c2mAd
         rebw==
X-Gm-Message-State: ABy/qLbQC1NchkeAXJo9G6tVU9o5Te4OX6/5f09ab9mYD7pNU0ZiaTE8
        mT4t2VWgAkb2AQaHizsGaQCNh1lMi6ffkcIMqGY=
X-Google-Smtp-Source: APBJJlHf4uJppKcWVPSIjYNjEbX2YaZ+ggECGEXpDxmZPoiZXS+nrPC0VGttlX6aGa/c96/ZEDVelw==
X-Received: by 2002:a17:902:a401:b0:1b9:d310:e85b with SMTP id p1-20020a170902a40100b001b9d310e85bmr22589plq.68.1689205963284;
        Wed, 12 Jul 2023 16:52:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902a60200b001b9da42cd7dsm4488027plq.279.2023.07.12.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:52:42 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:52:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Azeem Shaikh' <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject: Replace strlcpy with strscpy
Message-ID: <202307121651.04D1758@keescook>
References: <20230703180528.3709258-1-azeemshaikh38@gmail.com>
 <ad25bb8552704028860cf7a419c54fa3@AcuMS.aculab.com>
 <CADmuW3XOcGDBszYw80Dy03DXk3T25k8FNUrJWLKU9tL2znzanw@mail.gmail.com>
 <0aaa9355aa714e608091af2a5fca1373@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aaa9355aa714e608091af2a5fca1373@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:14:30AM +0000, David Laight wrote:
> From: Azeem Shaikh
> > Sent: 10 July 2023 19:07
> > 
> > On Mon, Jul 10, 2023 at 9:13 AM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > >       int len;
> > > >
> > > > -     len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
> > > > -     if (len >= buffer_size) {
> > > > +     len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
> > > > +     if (len < 0) {
> > > >               pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
> > > >                       buffer_size, len);
> > > >               return -ENOMEM;
> > >
> > > The size in the error message is now wrong.
> > 
> > Thanks for catching this.
> > 
> > > It has to be said that mostly all the strings that get copied
> > > in the kernel are '\0' terminated - so maybe it is all moot.
> > > OTOH printing (at least some of) the string that didn't fit
> > > is a lot more useful than its length.
> > 
> > How about printing out strlen(subsystem) along with the entire value
> > of @subsystem? So that the warn reads:
> > 
> > pr_warn("init_uevent_argv: buffer size of %d too small for %s, needed
> > %d\n", buffer_size, subsystem, strlen(subsystem));
> > 
> > Does that seem better?

Yeah, that'll retain the intention of the warning. It shouldn't really
even be possible to hit that warning, so I don't think we need to worry
about the "extra" call to strlen().

> Not with the justification for not using strlcpy() :-)

What?

-Kees

-- 
Kees Cook
