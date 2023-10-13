Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A87C826A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjJMJoB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjJMJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:43:57 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70688C9;
        Fri, 13 Oct 2023 02:43:55 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57bf04841ccso320898eaf.0;
        Fri, 13 Oct 2023 02:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190234; x=1697795034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfzVeBGlCtn28JvQB3WfY39pPCGkqHh2o4hPti47OQQ=;
        b=gxk7qsIeyFzMgNt5tDWMCdI2i2ydRnl+AJBD5FK8Y5E7NM/duCF9/Rr6vs7gxkqful
         vqbm8qHfrM9fJETv9g5zYXRF2Y1WKVPFq0Lohx+YfzXv5sZpOqTzYo8lndQNiL44bnRH
         PMHGuvh3VCQHbrlRkC27Rb9SU6xUNBlrXf6TJXvEfVvelVqcSZ3HLlT6sCkVajYS0Tea
         gHIn8F5bxjsP5eZVuUPE15RHg/C6/Qf10p/CdtLtkVTaWuGSl/UZnsf0TBK57Qqzzz/v
         /lDxBvFCFSxwJg4HZTzn5iHecuasTDdGLl5QXX2lvoEmU7EnSVFBwpKR9TyhgAlrgG6l
         JQlA==
X-Gm-Message-State: AOJu0YzoHLQV02Uxb6+1mhhhXkEhwW9ZS1vXyj4gIrbu96NhR8Kxe4Dk
        YOKZRYc8NK1RiZXK04QstQOjgcCTZmoPbTYktOHTtLC5
X-Google-Smtp-Source: AGHT+IHvgdwNtvZXwQEr3DE2/CbIc46cOQDdEsffqjKc8qBIAs04cmchaw2bD8CWkJgYaSM0dNLnWdZIlo6iHYmaiF4=
X-Received: by 2002:a4a:c509:0:b0:57e:c9bf:696e with SMTP id
 i9-20020a4ac509000000b0057ec9bf696emr25681079ooq.1.1697190234588; Fri, 13 Oct
 2023 02:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com> <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
 <CAJZ5v0gC4+Jam0a4KpEr7onydn8Sp8MkN2yzVxm0W9qDpmEoDw@mail.gmail.com> <dcafb275-40eb-4663-8ede-bf15546f83f6@linaro.org>
In-Reply-To: <dcafb275-40eb-4663-8ede-bf15546f83f6@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Oct 2023 11:43:42 +0200
Message-ID: <CAJZ5v0gxd3hCOAVXGnKZc=arfoV6=9OQVDuHFP6xkHMk9o1hEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:13 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/10/2023 19:44, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> Yes, we should but there is the series for nvidia (pointed in the
> >> changelog) which need a slight refresh for the bindings AFAIR. That
> >> series is since March 2023 and Thierry seems busy [1]. I'm holding the
> >> hardening since then.
> >>
> >> So I don't know how to make progress on this? I was assuming we can
> >> merge this series and let the compiler recall what has to be fixed.
> >>
> >> [1] https://lore.kernel.org/all/ZK14edZUih1kH_sZ@orome/
> >>
> >> and as soon as it is fixed, we convert the WARNING to ERROR :P
> >
> > To be honest, I'm not sure if anything needs to be done along the
> > lines of this patch right now or even at all.
> >
> > The only concern here would be that some new drivers would include
> > thermal_core.h while we were waiting for the remaining existing
> > abusers to be fixed, but since this hasn't happened for the last 6
> > months, I'm not worried.
> >
> > It would be good to add a notice to thermal_core.h that this file is
> > for internal use in the thermal core only, though.
>
> So this series will give a warning for the remaining nvidia driver but
> Thierry just send the changes to get rid of the thermal_core.h (Thanks!)
>
> AFAICT, the last user of the thermal_zone_device structure is the
> int340x driver but the patch fixing the structure internal usage is
> already in the bleeding edge (well perhaps one nit is missing for the trace)
>
> As soon as the bindings are acked, then I can pick the patches from
> Thierry which will end up in your tree. Then you can apply the current
> series. And finally I'll send the last patch moving the thermal zone
> device structure to the thermal_core.h. And we will be done with this part.

OK

> Having a compilation warning (I would prefer a more coercive error if we
> agree on that) will help to not have to double check every time
> thermal_core.h is not pulled in the drivers when patches are submitted.

Well, at least it doesn't hurt to have it.
