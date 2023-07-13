Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0D752B87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjGMUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGMUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:20:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76942120
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:20:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262c8746f08so170214a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689279606; x=1691871606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByjKI8sFPMlEN7YQ9geGxwGAL2cBDCMNaAzjBV7NkH0=;
        b=F0BVOQTvwF8gO8MqFR8XcNCP59o6HC5NSsmwn32J7aTT/fY7Uk1rkPASYUkLK0RP9K
         XDMxSCZGUhrJ/L2yrgFu5XLwN5fL3Ir28bRVO/WBVd81ouqk6l3Tuju7/+Xk/i8qh13G
         Hc1q22CjTL3ZT4/yMk7bI25jSqbYjm/3FoQdZ+JiUP8yCrIYFK+HdKheAvvlIXvLeVX5
         jZRQ1qamTB4JKLXxUKXS3qW6JgFWLKstk8umtIUhdU+U+WlUtg6EdwuWaOb8JLZd+DE5
         +Pk/9z3slCOgM3gilFCEXnnrdV8v2y4aQBgmUJWNm8ATxI6PQOhT0cJnjawfoPEit1zA
         rMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279606; x=1691871606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByjKI8sFPMlEN7YQ9geGxwGAL2cBDCMNaAzjBV7NkH0=;
        b=jVsUXaDjC83vfyPnl1jQDyKdd4o9rCT0xn7Ee4QlMvb+zskYhGZ7r4VdHnPmo4tGuQ
         XyslAWT6MSokFLRpOVS7Y0ru/fnAaZWf8B/K2QwzzopjufbEDikf30qn9eypeugY3Pmr
         w03HEKUx1u2lGFj68dzVN8iv6MDrvJ2xaHOVdSg8m8iXTlnWND//yCslluI7Yu24jnX2
         1Owr/nBHqw0Hzqs5unAV4pz1YxbO6xNMRBaK8Dyhj7D/80o4S260JyXlE18+a2ntgDIf
         XBwcFAAR1bEnz9OLcJtRFKQ0YQ5cjELGWnL+bEinJh6UcdhS9H0ko9xROM+9pTJ/XVvq
         c3Zg==
X-Gm-Message-State: ABy/qLZ+8HQdIKqjYOtjP30XuVMSzsDWVsXweC/Mb3vxwem2bH56hReN
        LXlhlYrozQCShuHhYAXzq0znA3QY4j3u5gsYBb/kmheankc=
X-Google-Smtp-Source: APBJJlF6lDjz5Lo//RBprdWEIPvYPeiJg9NsNxMPgdbnmM+tubPcDLTmfieSzW5qXAHCtjUt0/IbpqFhjQLNIt1mNWo=
X-Received: by 2002:a17:90b:4fcc:b0:262:c2a1:c029 with SMTP id
 qa12-20020a17090b4fcc00b00262c2a1c029mr2668009pjb.2.1689279606189; Thu, 13
 Jul 2023 13:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230516164416.11616-1-alex@shruggie.ro>
In-Reply-To: <20230516164416.11616-1-alex@shruggie.ro>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 13 Jul 2023 17:19:54 -0300
Message-ID: <CAOMZO5Br-nMxLSekZL5jLHNpyfOH_KgL1WUgAZ25wu86S2eYwA@mail.gmail.com>
Subject: Re: [PATCH] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 4:08=E2=80=AFAM Alexandru Ardelean <alex@shruggie.r=
o> wrote:
>
> From: Bogdan Togorean <bogdan.togorean@analog.com>
>
> For ADV7533 and ADV7535 low refresh rate is selected using
> bits [3:2] of 0x4a main register.
> So depending on ADV model write 0xfb or 0x4a register.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>

Should this contain a Fixes tag so that it could be backported to
stable kernels?
