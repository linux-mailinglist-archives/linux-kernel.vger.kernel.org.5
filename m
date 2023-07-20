Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE075B742
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGTS64 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGTS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:58:54 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6E1734;
        Thu, 20 Jul 2023 11:58:53 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5216cf475e9so325388a12.0;
        Thu, 20 Jul 2023 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879532; x=1690484332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnPv017HXvT+5hhEzMVCHJiSOe685zyo6k5IiZLINlA=;
        b=UXfRlU1CWN2hh8UMzZn+D8uNKqqL7BCQ0oyY571Iiwvt4ki8re+ZGDm/XiHSlAVCCs
         poJNOUGhx+hGnM2FXoeYSGLh/NWvsfugJO2qXIs5vO0tRoMDHjF0ojCSx3wp5QdQxEIp
         7ossnacmTCIvTZ7yadKoghvI5b2Y8KvkKx5v+OlM9W75FcAh1bF7Lm9IO6HWf2q7PkmV
         VffPAdS7k7xaM6XR7xzmQbGpM+2lZR47WdZieZpbbjsbF1QzAaOx3V9Ul+9XSvosLQnd
         wZfCEDlEus5zYnzZmt7CyAy8Xnt/xDVBTHmJuoGOdkRKscqVAjSTX7Kn3ojkJ7r3sY3c
         hLrw==
X-Gm-Message-State: ABy/qLZf8CpA23RqXWfy8BkdVhVZMXTLLRhUkcj7Yht0PuNq8DKx/aTQ
        m8aAINF4E3cRSp+mKvA546Mn+JyJMxZ3B1R4PCc=
X-Google-Smtp-Source: APBJJlHAQGKflfF9VPM1v7jzVIYblu020hVzuJGQQ8MbG1RG2vhNe7h8D6gqb2rjQgJD2K+oYkZlgQDFID5EUs5UfAU=
X-Received: by 2002:a17:906:242:b0:993:eed1:8f0 with SMTP id
 2-20020a170906024200b00993eed108f0mr3121134ejl.3.1689879531779; Thu, 20 Jul
 2023 11:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de> <29d2533f-9297-6383-e26c-dced2756f817@linaro.org>
In-Reply-To: <29d2533f-9297-6383-e26c-dced2756f817@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 20:58:40 +0200
Message-ID: <CAJZ5v0is-=Tdn5UKdFhDQYBhSANe9sCQEyBv2JO7QYPkp7812g@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: constify params in thermal_zone_device_register
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 2:55 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/07/2023 13:27, Ahmad Fatoum wrote:
> > Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
> > parameters structure"), thermal_zone_device_register() allocates a copy
> > of the tzp argument and callers need not explicitly manage its lifetime.
> >
> > This means the function no longer cares about the parameter being
> > mutable, so constify it.
> >
> > No functional change.
> >
> > Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > ---
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Both patches in the series applied as 6.5-rc material, thanks!
