Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986F763EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGZSmy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGZSmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:42:52 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2F1710;
        Wed, 26 Jul 2023 11:42:51 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5666a2b7f55so27139eaf.0;
        Wed, 26 Jul 2023 11:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396971; x=1691001771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHGJiTdlB+dQD70EMhHhI8xvC4trd7Ff2YAN4Uy5bO0=;
        b=fWfhN9XMlCSXkOM5nl7TysGvcv3RYp+RJlGeMfND1nKIx97wFWHudBsTtOZBPrH4Qk
         qLRhlvXhxsHDLs6wp1e/SU8d3a7C8IkshpCRQreXCqiS73bkie65l9SJlq8kPuNYo5vh
         +YmLL5dZXmXwPpW9T5uK6TBIOLgb6URoOcU4CLRVD/kfJjKcznA7FCnxqO8V1HwgHDey
         e4Ugo/Nou+tvq7IoDRp8F3vMpF3dndO050fEnU9HhkAL4UNeN5VGq6msgzjBYPmjTOkz
         Ukci7oO2xDZdtE5ndZDipZllMU9+pDcThQgBUNsfcY0VjukkaYiEeU9Wfscr2KUV5Mi/
         YfMg==
X-Gm-Message-State: ABy/qLbdEzPMjwso0J7CZM3uFSKklB8C3GxogzcxFHuUhos7HmHplyro
        0q5AH653DERuSXMeZzRwQxcEgM/An32mHg5cIjY=
X-Google-Smtp-Source: APBJJlH2x90Q7lDJXp2zFV9JTsLkAsPOTtP2AQhhIx6ipnMvhPSFtKFj5OTgP4amlKMBVmsiWEo6/1u7nvN10N6++l4=
X-Received: by 2002:a05:6870:3291:b0:1bb:8ff4:1830 with SMTP id
 q17-20020a056870329100b001bb8ff41830mr2906100oac.3.1690396970780; Wed, 26 Jul
 2023 11:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230723-thermal-fix-of-memory-corruption-v1-1-ed4fa16d199d@kernel.org>
 <f559a614-93d5-121a-8ff3-0da77bc85f44@linaro.org> <ZL054LHAZv8VmIk3@finisterre.sirena.org.uk>
In-Reply-To: <ZL054LHAZv8VmIk3@finisterre.sirena.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 20:42:39 +0200
Message-ID: <CAJZ5v0jJ+YM=7LUEKB_b5GUsGopLTT0eyPmomYV0OcGQp2gvig@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Fix double free of params during unregistration
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 4:32 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Jul 23, 2023 at 11:57:52AM +0200, Daniel Lezcano wrote:
> > On 23/07/2023 01:26, Mark Brown wrote:
>
> > I think this issue has been fixed by:
>
> > https://lore.kernel.org/all/20230708112720.2897484-2-a.fatoum@pengutronix.de/
>
> Yes, that should fix the same issue.
>
> > Rafael ? Did you pick it up ?
>
> There was a message on the thread saying the patches have been applied
> for v6.5 but I can't see them in either mainline or -next.

They should be there in linux-next (as of today).

Surely, they are present in my linux-next branch.
