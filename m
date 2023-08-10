Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E367772CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjHJIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjHJIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:23:33 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D31ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:23:33 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso2580889276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691655812; x=1692260612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FSQOxCgo47VmIjcYi/njGt347ahAIyw5h4v3LyUWu0=;
        b=eIW4Fs5A42B2jvHBg7u7h7ZH53RGKE9aq6BXQT/kJuJA7pwmgm8ERy9rF371C7gjl8
         HmXYa19Fo2AgBFTzm3z1ESM+b7kgLu9yVwHF9ZQx07oFflmNZzqH2KWlhXCBMm359YqE
         xIiZTXdBwjkcXqziCH3qy10kCKRTn2dDujpAl+nUkpZee4tgmO5VrEeUHM7Z7M5qHLMD
         xS1tC/uqJ+fe9i7rrZ61v9lsjdmdmbaRkJAvdm1ZWegU47VzYUAGqU5jUBfJ8EyzHaYN
         2MzP2BPJWj61L9ts1B9NKbD7KPY+8Np/9Zl8oJPBsWAntVhfuV/q8NhZNF1pjRjmyWab
         stOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655812; x=1692260612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FSQOxCgo47VmIjcYi/njGt347ahAIyw5h4v3LyUWu0=;
        b=asptOwHCU1K9dgBvvQnPBR8NwdPFBVscsouYcwOShOtxHhxwyJUx1ndKHzTd0S72Xy
         haewVBmO7PH+w6RSEgVDMiwZaqhJhJdIsAlQqgI4zmZGhto7xDYJetFYoER6Ib5g4k9V
         rZ2izPGfXl4Rfogc1e0ucRH+iylP6zep/btqe5JYJbMffF3Yv54+hG+g5/tGf0FMu/he
         2baOPSjx7cNqqQn0sqeljjhW5xasNE17dfU/1blyRhizfXS4L+W2DsKT0z+ZCXIYITvL
         bolEYffouDKNJuBSrDejzFfrdMaZmye1g36UqOG++HVkMn3avQ/xk0eqcgqZLoCRkwKe
         dlaQ==
X-Gm-Message-State: AOJu0YzAKTxBXm6nJrRuzOfl2CukbluXIETY7NMW9ynkgygvojAnOEdB
        f95itCNR3dfSZGXDiZgR+eYSH/4qyAPI91nCzp/Wiw==
X-Google-Smtp-Source: AGHT+IGvMAyo4iVUK0KCiOuLVtXH4HFq8epNfYNz2HxnUTtMcuEIenQ0cd01eohWWTH+rLFqJyxWQRkAuz/SPRd4vxs=
X-Received: by 2002:a25:e6d4:0:b0:d47:7448:81a with SMTP id
 d203-20020a25e6d4000000b00d477448081amr1662391ybh.23.1691655812036; Thu, 10
 Aug 2023 01:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org>
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:23:21 +0200
Message-ID: <CACRpkdaF4GqHtdJeBed0JGVXNkpA9dvbPgGMK=Qy0_RZyvOtNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] drm/panel: Remove most store/double-check of
 prepared/enabled state
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ondrej Jirman <megi@xff.cz>, Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 11:07=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:

> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>
> This series attempts to do just that. While the original grep, AKA:
>   git grep 'if.*>prepared' -- drivers/gpu/drm/panel
>   git grep 'if.*>enabled' -- drivers/gpu/drm/panel
> ...still produces a few hits after my series, they are _mostly_ all
> gone. The ones that are left are less trivial to fix.
>
> One of the main reasons that many panels probably needed to store and
> double-check their prepared/enabled appears to have been to handle
> shutdown and/or remove. Panels drivers often wanted to force the power
> off for panels in these cases and this was a good reason for the
> double-check. As part of this series a new helper is added that uses
> the state tracking that the drm_panel core is doing so each individual
> panel driver doesn't need to do it.
>
> This series changes a lot of drivers and obviously the author can't
> test on all of them. The changes here are also not completely trivial
> in all cases. Please double-check your drivers carefully to make sure
> something wasn't missed. After looking at over 40 drivers I'll admit
> that my eyes glazed over a little.
>
> I've attempted to organize these patches like to group together panels
> that needed similar handling. Panels that had code that didn't seem to
> match anyone else got their own patch. I made judgement calls on what
> I considered "similar".
>
> As noted in individual patches, there are some cases here where I
> expect behavior to change a little bit. I'm hoping these changes are
> for the better and don't cause any problems. Fingers crossed.
>
> I have at least confirmed that "allmodconfig" for arm64 doesn't fall
> on its face with this series. I haven't done a ton of other testing.

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please send out a non-RFC version, this is clearly the right thing to
do.

Yours,
Linus Walleij
