Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDC7BFB73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjJJMbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjJJMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:31:01 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72859B0;
        Tue, 10 Oct 2023 05:30:59 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7abb93528e2so2254558241.0;
        Tue, 10 Oct 2023 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941058; x=1697545858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jgq1hohZKa0dNoy7yXEMkucv0MQJifBsOzJHvG5k90=;
        b=QIecgthFlAOQ2z8lZ+qNoreErwZbBg4ZcBorse3TSwJOEkOmRXD/6sNoZD5GT6wbFi
         2mAQON2DcWwYVsYOxJQn9BzgqIo8zLfpka4nMFi/xMcCp2SykG7XOM6yYfbRKCe3xbcg
         /DB0/obknP6NTppmXEFstAlvmf1BubXWzLncRJm2UP94woadKrNcltFB3wmaG/GCMFKy
         +cz/uiX8ALwuGBYgO9kNhbvBaBQ96h5FLB75nV0moI3kyPRTPVGm1BdXYMgu+dbYEc5Q
         Zwkz9H6IxMP0PphsexEKMn8qxyB2LwyrxD6z2RvuK+B55U6IurR5FUqlyPbpdUaWtD25
         RD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941058; x=1697545858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Jgq1hohZKa0dNoy7yXEMkucv0MQJifBsOzJHvG5k90=;
        b=ORAuUJIv8Llk99zZ60KK3TZLAsBMjeySwu+euHeUwY8apDokFanufLgRuuGFIU7Yeu
         sEGlAQkBhtc8+VGZLDPhyZuYmHOEpd5vUHMS1JkS4fknXQKjmzBAYNGdV9DauwyWxhOC
         QoUMELdYlX9RGmcklGcav/r8ZOHjzv8iQl2Ub3xP3a1QrkOSVDc0xqLM7d1TbHhZw9wl
         JuHR2lGf1IeKKCJirHRq6QEnjkQX+IZzzEEIodawFmIsSbX4HNcmW+0YADlUExAa5VmI
         6RSr6ZF9q5YkNPNXuAnO5bOyEYQQRHhz40RmfIuKGVHXkgQYsuK6rZ7iCcyeVvbxvHLh
         a+OA==
X-Gm-Message-State: AOJu0Ywe0yB/t3vF2YSze12pexQnBSw7GVOx/4aXKqjE39+CpmU97BWD
        zlT555C/3GzYBiuTJsTfX7aeFgSjsCWPe1QZ6Uq6Z00h
X-Google-Smtp-Source: AGHT+IHE5HVwDH+3cFb7GWrpi0mBpaa87jqRz7jxzqBJlN7SCzdT5XPSophvYbptrFtqoWGWETS5KuvsreHFbtRbJPI=
X-Received: by 2002:a67:fc43:0:b0:450:f9eb:f412 with SMTP id
 p3-20020a67fc43000000b00450f9ebf412mr17512072vsq.5.1696941057972; Tue, 10 Oct
 2023 05:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231003075512.2081141-1-milkfafa@gmail.com> <1e5bb09f-be36-4fc6-88f3-8f6565b6147f@xs4all.nl>
In-Reply-To: <1e5bb09f-be36-4fc6-88f3-8f6565b6147f@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Tue, 10 Oct 2023 20:30:47 +0800
Message-ID: <CADnNmFqqOOo75hmt6FKGFjC2XcQD53SuX3gHEqnifWcCas-m-g@mail.gmail.com>
Subject: Re: [PATCH] media: nuvoton: npcm-video: Fix sleeping in atomic context
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, dan.carpenter@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the review.

> > -     list = kzalloc(sizeof(*list), GFP_KERNEL);
> > +     list = kzalloc(sizeof(*list), GFP_ATOMIC);
> >       if (!list)
> >               return NULL;
> >
>
> I'm not really sure this is the right approach.
>
> Looking closer at the code I notice that npcm_video_irq is a threaded
> interrupt handler, so wouldn't it be easier to change the video->lock
> spinlock to a mutex?
>

Agree it's better to use mutex. Will send v2 for this.

Regards,
Marvin
