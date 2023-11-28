Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8097FC17B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjK1Qwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjK1Qws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:52:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC4D4B;
        Tue, 28 Nov 2023 08:52:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso5667358b3a.2;
        Tue, 28 Nov 2023 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190374; x=1701795174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2GFpgF/UShDGrhmadEJvLPiDWgQypGxozPNByeW60o=;
        b=NDWmC4MH7Mm8z/Z8L8CxHtmHUSKUlUQd86MiCD8Gl4OyMG+oAmYSBxx6QsGn42edpB
         DhexSvUjC493LFwfH03GUjIv3+b/ZZ9dyh/brIQjWOuSDRG+UouzNF3lRw4/ycPfDjvV
         l3cpVnHZXnESIVh5BBJUoRUnQrgr4Rbu4wOCz7kP5H3FOTY9x/TZskRBE5yX4E3gIt+D
         CfCv9jWtcFa5nxd9VqLJaaTJEiozXa9WdOkcQp6aPJyTIzYhLh1Qsp9u9z9UYchos+mp
         FCSyonoW0ZE4+0C2TKYMZE4P7xW5y7VPDE+SkP1Y51M4cH70Uv3bcZp+iGgjDvDPlQ1k
         j//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190374; x=1701795174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2GFpgF/UShDGrhmadEJvLPiDWgQypGxozPNByeW60o=;
        b=QkTakBxmYNjNIp2Gf9m7jazJHChxAujBBm92bLQwi+dXZHjdOuKxTFjh4ZCteZy7B3
         5G53irlDVsgHhE/nnVvyhUhvg68Zs1AmnnFeItDc5r6XyIUdLJW73zzoXEQV3CYykz/B
         PoddfW1gmgOCDk067BEQfoP6LlHOdq5D6lu1y/98sdeLceGjbA614KGpsIm/wiDvn9Xu
         ITht5wnBt4hXdyukcnJ7gubPw0ag2XyI822h2D5sQpVAK4vMj/odJzT/EeSBKg9+PjM6
         EQ6Mgqrn2M4x0nhk88s1vJWN0VfCfVUtkKdSn5bN/hz6oVl6zNdmnoolLokaPh3rBfHz
         OsAQ==
X-Gm-Message-State: AOJu0YwfOuQIF5qwnlhdsoOhsDGEZQ1lkmBeeCSit7XvJmmEp6NbgpHI
        w1WWjcdKBQnff++WYspqMm4=
X-Google-Smtp-Source: AGHT+IESZLkr/1OKBV5n340oK9Jlw1VXrLMt+uC0XUIpwOTG/i3VDKrrFNQVcCHkdDaR5zTGF7B+2A==
X-Received: by 2002:a05:6a00:1486:b0:68f:bb02:fdf with SMTP id v6-20020a056a00148600b0068fbb020fdfmr20872768pfu.27.1701190374037;
        Tue, 28 Nov 2023 08:52:54 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id fc14-20020a056a002e0e00b006cd08377a13sm5045838pfb.190.2023.11.28.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:52:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 28 Nov 2023 06:52:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mark Hasemeyer <markhas@google.com>
Cc:     Tim Van Patten <timvp@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
Message-ID: <ZWYa5IlXpdus2q3R@slm.duckdns.org>
References: <20231115162054.2896748-1-timvp@chromium.org>
 <ZVokO6_4o07FU0xP@slm.duckdns.org>
 <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:19:52AM -0700, Mark Hasemeyer wrote:
> > Applied to cgroup/for-6.7-fixes.
> >
> > Thanks.
> >
> > --
> > tejun
> 
> Thanks Tejun!
> As this hasn't been merged to Linus's tree yet, do you think you could
> Cc: stable@vger.kernel.org?

Yeah, I can do that. That'd be for v6.1+ and fix f5d39b020809
("freezer,sched: Rewrite core freezer logic"), right?

Thanks.

-- 
tejun
