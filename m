Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6977BEB2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376628AbjJIUF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:05:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B11B94
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:05:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c877f27e8fso39064065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881955; x=1697486755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hjzU7db6bUamkT6xiqRGhvTQeGzTNRIxgy2fWy35yMo=;
        b=m1TwsCX1AblvJE7QmMJD2072elnplujtYFGczyXtzXBHnOXKHTdZZiFY6gasGuvncx
         AwtmYZagVfNKrtxuCjwBfBk6X9HR/xOg8L0dT541UfogTtUifuyYtyOOHSFzgfk6H/uk
         gd3EJhpl6TUPmWI+qM6PzGmXIfaDgthijX9L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881955; x=1697486755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjzU7db6bUamkT6xiqRGhvTQeGzTNRIxgy2fWy35yMo=;
        b=gI9QVZqlfZFu4nCRVm6du65sOD9sxhEbCdgwA84M0tMDbbMr9ZRUhC11NdSUy8QeqE
         hifj5TRD0zOSbb2r16kq6kK/V7O5vQ46pbNwg16nUThu5B9MDRAIIHS4Py3LbC7fFU2G
         57lvObu72h6jI/Z1i9iFaUcY5DPLBLB1kxU+7IJNDUYUHOVO0ZoOf1BEGJQgDanlxENH
         sQxDbmPrIhW8qIKYG0Xm7Z0V2wHo+cUdTjGbAfF8+kL42mr/9Iqa+7mIqqz/0clO/76P
         MbvASOldyMygPcmjkXhnKgNTym2e7oWIEVCS9753uuX34bDRNFGfCXNuIc9/m1n605PL
         to/g==
X-Gm-Message-State: AOJu0YxopkwYQjntdy+X2sue1eHb6jd0LiYeU0TEVMMyOHienGlZOMEO
        iLNd6dPuR3e7D1B8hqB5TKyZdg==
X-Google-Smtp-Source: AGHT+IFDHHm6Q1QBk7Z6QBiHLWWju6zhN3AlmVoQT9ZbjFGMUKMNma650aW38XQLN8BhdCeT5zJClg==
X-Received: by 2002:a17:902:d4c4:b0:1c8:a06c:2de2 with SMTP id o4-20020a170902d4c400b001c8a06c2de2mr7570473plg.54.1696881954893;
        Mon, 09 Oct 2023 13:05:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001c44c8d857esm9974703plb.120.2023.10.09.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:05:54 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:05:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>,
        Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Allow frozen userspace to reboot from non-init pid
 ns
Message-ID: <202310091304.AC3C7245A@keescook>
References: <20230929174442.1635558-1-bgeffon@google.com>
 <202309291304.9AC4F5CFB@keescook>
 <CADyq12xRZfafeu1PVxB1G9zTgThB0W5nok2eXPFLC+T28-b-Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyq12xRZfafeu1PVxB1G9zTgThB0W5nok2eXPFLC+T28-b-Bg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 08:25:42PM -0400, Brian Geffon wrote:
> On Fri, Sep 29, 2023 at 4:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 29, 2023 at 01:44:42PM -0400, Brian Geffon wrote:
> > > When the system has a frozen userspace, for example, during hibernation
> > > the child reaper task will also be frozen. Attmepting to deliver a
> > > signal to it to handle the reboot(2) will ultimately lead to the system
> > > hanging unless userspace is thawed.
> > >
> > > This change checks if the current task is the suspending task and if so
> > > it will allow it to proceed with a reboot from the non-init pid ns.
> >
> > I don't know the code flow too well here, but shouldn't init_pid_ns
> > always be doing the reboot regardless of anything else?
> 
> I think the point of this is, normally the reaper is runnable and so
> an appropriate signal will be delivered allowing them to also clean up
> [2]. In our case, they won't be runnable and doing this wouldn't make
> sense.
> 
> >
> > Also how is this syscall running if current is frozen? This feels weird
> > to me... shouldn't the frozen test be against pid_ns->child_reaper
> > instead of current?
> 
> The task which froze the system won't be frozen to make sure this
> happens it will have the flag PF_SUSPEND_TASK added, so we know if we
> have this flag we're the only running user space task [1].
> 
> >
> > -Kees
> 
> I hope my understanding is correct and it makes sense. Thanks for
> taking the time to review.

Christian, is this something you can take a look at? I'm much less
familiar with this area of the process list logic.

-Kees

-- 
Kees Cook
