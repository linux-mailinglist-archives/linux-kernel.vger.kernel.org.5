Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5C79C2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjILCbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbjILCbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:31:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67581018BC;
        Mon, 11 Sep 2023 18:55:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so3506401e87.1;
        Mon, 11 Sep 2023 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694483745; x=1695088545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dfh8/mDNgK8vxrADw9UDg9zBqSEE3ndEwyQtmVmeyWM=;
        b=dGkwDdBCX3cXrz8Ue9ZL6uoO1ie1TIMpf4wzbZ3qWw+Mhd7e2Fz/55RqjyRfhcmVkr
         lrOKLz9frG/wJbmma7JNaunjK9me9ZOvrdS2i6BB6HXeNq9SYBrDdeq0IBp3oOeLDKEA
         g8RojhzRXq/mY6d0+kR9JnGOlrP0e0wSCh0dJphcO7yfTozuZV3MGepDjXi7aR2lZRgI
         vZRIzAtxRVc056brgE5gS0RUByIlyCNYaYDsJg0g9AuY4eUbmhROaSItRGRjoowD1674
         TNEeJ/KunB7/8Z3ko9Cx8K1jB4mOOydKnvpq011PT/xyQUr5s9jZzuigCnLGs+mc3L62
         m1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483745; x=1695088545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dfh8/mDNgK8vxrADw9UDg9zBqSEE3ndEwyQtmVmeyWM=;
        b=qggRUVVBuUo7Jvg54FguPz7NPP1vRM09CvPkqL0OpOGcoEhXor6HKtVZPCP5vhOqTc
         A7M5C/G9IqgHJdJg8NXmRB0LEetR1LiQACgkSwLQuK9Fo7zv0IfpA7CGXvY8MSat999Z
         i2mbCnTzcFnMeqbcW8A4h8M+rtxGwiC5JADv8KLBQNh0xyo6TotknSC9y3FuG/UA9LS/
         oO0RZ7Z3j4stWAiDUd/FkzqJjUdTcdGWC2rIqfLTssPwMlPUUDYksttJy7W+orGZmWed
         mMihkDPfmCwIIA+xz+E1QS6wg2aGnEw1IlsY3CXtqMGdXEj/HPE/eqC9xtEhYSQZahv2
         3D6Q==
X-Gm-Message-State: AOJu0YzV9GoBDfg34LzcldVfnE2Yxym6BNvj8/rKQhNYVGF6tOf0xI99
        2Q+ZdopxGyNoZZbQ+ma1NTojBX2tzzDR+3bd1Eo=
X-Google-Smtp-Source: AGHT+IHCiNJcSbNJ7RSxRhN3Yzlcqa52uNMH/Uq5EU5bd/OleEn/UkclTnAiq3uWYeQwY9zvyocqW9aSvAzI8CUXWrA=
X-Received: by 2002:a05:6512:2038:b0:500:75f1:c22e with SMTP id
 s24-20020a056512203800b0050075f1c22emr7814227lfs.40.1694483744716; Mon, 11
 Sep 2023 18:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694202430.git.pstanner@redhat.com> <CA1AA415-FDF0-4A7A-9BB0-FFF055803F77@kernel.org>
In-Reply-To: <CA1AA415-FDF0-4A7A-9BB0-FFF055803F77@kernel.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 12 Sep 2023 11:55:32 +1000
Message-ID: <CAPM=9txUQ64PMmN-KSXC6PG5ozhSB4eLQN8iAUMrv1R9F6Sm6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
To:     Kees Cook <kees@kernel.org>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 11:27, Kees Cook <kees@kernel.org> wrote:
>
> On September 8, 2023 12:59:39 PM PDT, Philipp Stanner <pstanner@redhat.com> wrote:
> >Hi!
> >
> >David Airlie suggested that we could implement new wrappers around
> >(v)memdup_user() for duplicating user arrays.
> >
> >This small patch series first implements the two new wrapper functions
> >memdup_array_user() and vmemdup_array_user(). They calculate the
> >array-sizes safely, i.e., they return an error in case of an overflow.
> >
> >It then implements the new wrappers in two components in kernel/ and two
> >in the drm-subsystem.
> >
> >In total, there are 18 files in the kernel that use (v)memdup_user() to
> >duplicate arrays. My plan is to provide patches for the other 14
> >successively once this series has been merged.
> >
> >
> >Changes since v1:
> >- Insert new headers alphabetically ordered
> >- Remove empty lines in functions' docstrings
> >- Return -EOVERFLOW instead of -EINVAL from wrapper functions
> >
> >
> >@Andy:
> >I test-build it for UM on my x86_64. Builds successfully.
> >A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
> >fine.
> >
> >If there is more I can do to verify the early boot stages are fine,
> >please let me know!
> >
> >P.
> >
> >Philipp Stanner (5):
> >  string.h: add array-wrappers for (v)memdup_user()
> >  kernel: kexec: copy user-array safely
> >  kernel: watch_queue: copy user-array safely
> >  drm_lease.c: copy user-array safely
> >  drm: vmgfx_surface.c: copy user-array safely
> >
> > drivers/gpu/drm/drm_lease.c             |  4 +--
> > drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
> > include/linux/string.h                  | 40 +++++++++++++++++++++++++
> > kernel/kexec.c                          |  2 +-
> > kernel/watch_queue.c                    |  2 +-
> > 5 files changed, 46 insertions(+), 6 deletions(-)
> >
>
> Nice. For the series:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hey Kees,

what tree do you think it would best to land this through? I'm happy
to send the initial set from a drm branch, but also happy to have it
land via someone with a better process.

Dave.
