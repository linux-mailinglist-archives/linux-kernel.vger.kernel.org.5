Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D07EC80C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjKOQAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKOQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:00:50 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DDA19F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:00:47 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b5393fb101so704095b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1700064046; x=1700668846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFmbaY0oGVZ7sScVBLanmu7D2D9vxvb7T+NtcQ3NkJ4=;
        b=gT6deisKI4WEaVwsq+NFFTt6ergwIaW4HqJ4M5a1BlMxrKIPGufiSXnGNKkhonwvBW
         ou3uzIVEUQIbGU2kWZGyg2o4A5D9R+GbXtCrgEz5eeCymCAAR18Xwyv133Cvzyog/eaS
         Gtd2f/DsabugquTwOGhyVYDMc6jrPt6bSHDO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064046; x=1700668846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFmbaY0oGVZ7sScVBLanmu7D2D9vxvb7T+NtcQ3NkJ4=;
        b=YxjxqCJClZIxFPlJHhWGWn3G/0rMESiY51Z9wKGRmyostYD87KWJNgUSCJAT+Xt4X7
         EOJAQeZXyIAcSYRkIas23jdOLA1LUSyAEP09buV+s7+/02aPCgG+Eikgxdx+wk5WAwlM
         ZrWj3xb9qO31A8J5kfeACjmSB6UCTI5YkFv9ptq10KAqI7Q3f8MPDb+/8MEfjLJB95NG
         XUxoAnJoRIYz9F1Oz6iByPGp1FNyTtK8BcCC3bd2Ntlb7QqzzVUvXV1ZpgDpiJDuKXrH
         bDLc0J3xC57moN+ZXgEIoByNYPLq8omggfpj+UVK8C01LXcRDIga7uXR2O3AtEN+dgny
         cWuQ==
X-Gm-Message-State: AOJu0YzZobD52+jQrSUZM+gLIPTjJ1KkQz4lPY9s2I5VP+EaEc82wPgR
        HfOrH+DhtB6J1iWaOqZuKm8xYEpLHvnaLs1cZ0vKhQ==
X-Google-Smtp-Source: AGHT+IEC7e0xzEZvfFar3WHPgtO7pOAY07ejbJf+y9ARFz7vkcAW/xxvlGk01OR2uItXzOvVmoLvaArE9Pf6m0XXx+0=
X-Received: by 2002:a05:6871:5c47:b0:1e9:bbfe:6458 with SMTP id
 os7-20020a0568715c4700b001e9bbfe6458mr7237902oac.1.1700064046168; Wed, 15 Nov
 2023 08:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20231110200830.1832556-1-davidgow@google.com> <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
In-Reply-To: <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 15 Nov 2023 17:00:35 +0100
Message-ID: <CAKMK7uG-FH6iLpNpQ74xXPZoyGoDGvg+L99oCK3nFZT43o6GcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Add a macro to wrap a deferred action function
To:     Maxime Ripard <mripard@kernel.org>
Cc:     David Gow <davidgow@google.com>, dlatypov@google.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Airlie <airlied@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Rae Moar <rmoar@google.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 16:51, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sat, 11 Nov 2023 04:08:26 +0800, David Gow wrote:
> > KUnit's deferred action API accepts a void(*)(void *) function pointer
> > which is called when the test is exited. However, we very frequently
> > want to use existing functions which accept a single pointer, but which
> > may not be of type void*. While this is probably dodgy enough to be on
> > the wrong side of the C standard, it's been often used for similar
> >
> > [ ... ]
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Daniel Vetter <daniel@ffwll.ch> for merging through kunit
tree, since I guess that's the simplest way to land this.

Cheers!
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
