Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B775459B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGOAOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGOAOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:14:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77E3A91
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:14:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3159da54e95so2452565f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689380070; x=1691972070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHB6MmDpW6mOW/AgkDp+ObJjFMKRQPqgz5eDHwER+yU=;
        b=W6GGyrjngXNyfkKbzBP757uoR9/rxEagoiMv4f1IGMSJeGCDSjINCa5zj4OukJxmlx
         v8tWhz33W130IhEua5jQxOvZvUXYTWOPem8PhPVPjpiqqQoGCgraF3LsNYGKV4SQ/+Xn
         SbbRovXFK1Nzj4i3EBYMzf5xIjum6gRDURoHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689380070; x=1691972070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHB6MmDpW6mOW/AgkDp+ObJjFMKRQPqgz5eDHwER+yU=;
        b=X0dedOMR6j+jVrmJBmcxK+B9ENraahFkckjHzd4Jymb7Y1mXS0bUL1pJkSfGz+gPF7
         26aU4sPLI+WGWbnE/KKyip3vn0DssbXbOm+WbFGlMlSGddUfFbXzEHcb4pGjhCuQ/jTb
         CQgkS3Y4bNsmuuDazRz7wksY/fRF+HGZ+9BYzuNXQR7KuuhBbf2IrFKHaTp89TWh2J1O
         V9w1kaMRTfsSGygwD656hzkNmhSpH6RQeh+/4C0OjGvZHNdj4o0MEmqWGSKL9pNOUs/i
         jW0qhDRo34O+GLjVG0Kyxn2R6s1g+M2dOoUCW8Qp2CqpUTJO0qO8IdwiuYASgSge2f59
         qV5g==
X-Gm-Message-State: ABy/qLZyUlykl7T4N9Ob5s6K6M7nSHjB1WpYJhT04hKXo6X8o1xro0SZ
        3GiTvMjXLf4o97bBlYFYhALp10ADJL1zpYFcU+mXkKykMixezuPKHq8ahA==
X-Google-Smtp-Source: APBJJlElw7WGo7L2Nkp8lIMM55qTMGczq+eOnpcSfNh0ZomFN+VdPKiCMfC1jCJnc1H+zHib3xVakiXNH9CD0E0N8Dw=
X-Received: by 2002:a5d:5485:0:b0:313:ee69:fb21 with SMTP id
 h5-20020a5d5485000000b00313ee69fb21mr5399250wrv.62.1689380070674; Fri, 14 Jul
 2023 17:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
In-Reply-To: <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 14 Jul 2023 17:14:19 -0700
Message-ID: <CABWYdi2L_qp8SmZ_w3pSSracYHEVku3TaBoXL7E0Nzn7CN3neg@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:21=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
> The fast one is v6.1.37 and the slow one is v6.1.25. I'm not sure if
> the kernel version makes a difference or if it's a matter of uptime /
> traffic profile. The data is from two different locations. The fast
> location has gone through an expansion, which meant a full reboot with
> a kernel upgrade, so maybe that affected things:
>
> * https://i.imgur.com/x8uyMaF.png
>
> Let me try to reboot the slow location and see if there's any lasting
> improvement.

There is no correlation with the kernel version, v6.1.38 is slow too:

completed: 23.09s [manual / cpu-stat + mem-stat]
completed:  0.30s [manual / mem-stat]
completed:  0.64s [manual / cpu-stat]
