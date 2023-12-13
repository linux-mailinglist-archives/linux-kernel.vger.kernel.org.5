Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF608119AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjLMQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:38:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18688E;
        Wed, 13 Dec 2023 08:38:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d348653591so11433665ad.1;
        Wed, 13 Dec 2023 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485518; x=1703090318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WngvNIIdUAOImz6VKCR6KlDDLoKgFI0GBra4+hjHdaY=;
        b=NzLYDsBPHGzS50irHggm2iGtEK3B4zIDR0Bq+Uc0Yv6/W5Tpp4LCsJn1MxEErCUNJ+
         MTgsiDSJzhWpDuEQPfpN2GWEl0GbqzqKUrm7WEpPbByTIXYH5dbReQAi3GXZn0yroXMI
         x2vKWxSDFr0t3xs2AoAdC/odWnsiqbLQvCB5jcBeOoymtfTRgFJF2KXDdvtC8QCasbnN
         NY5Weu5dmhKIhyjxJ165kthOjz3+zoo53I8NB4/vKWfqr8HVE3eq1MczJ4jnhG2TJcan
         BpltIBFY0BsCnL8qP0m+j0GpL4Xr2BQZxQXZ742USicR3YvBQDm7fqhTkE4mvhFSqaXk
         aoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485518; x=1703090318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WngvNIIdUAOImz6VKCR6KlDDLoKgFI0GBra4+hjHdaY=;
        b=K800IrK64mE0Ew6GYDR2t02M0fDrBFg9l3YhTgbY4u5ZoDpuXO3hSCVr5qBSrkfPtK
         2S+ZD2A390ebOWPXzLgfso2TmG/BDvarbPXALl4QsfATc5r0dAqtb/AA0mehgFwpz5Q6
         JGBY7M6gNNxxlf3Zrg9Zyxz8xEjHdcbcDpn6QrZtA78RxQY0jQ5UlRdqIGPGsr4vwJBU
         n+e6QLwICRFy5t3jiHO52WORTwCXIU4HU8zJNTlD+dW0jlAU65GHoRun65VqRU1WkXYX
         BJ2l6vMSxFNkuTLJqyKP2HEzFO85LGNvpnBAPQIhsUElAcD7EMmZ+VvdHE1MW7xyE3BV
         F2Sg==
X-Gm-Message-State: AOJu0Yz/8cQzqNhlXt+njLRzfxGYzsHpxKNtOgWSIXOm+C7NwRklS6TZ
        2QjMegyb6etjzrs82fS6XNw=
X-Google-Smtp-Source: AGHT+IG40cDam0iwIQQ0yixGvC12xVks7Auh91vEMpA9cC4FQkIMzHTpnOC5tJomQzgVmo/Fg54fjQ==
X-Received: by 2002:a17:902:e887:b0:1d3:3768:90a0 with SMTP id w7-20020a170902e88700b001d3376890a0mr3641678plg.40.1702485518164;
        Wed, 13 Dec 2023 08:38:38 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:4500])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001c71ec1866fsm10810814plb.258.2023.12.13.08.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:38:37 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:38:33 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXneCaeJjHvFvecK@dschatzberg-fedora-PF3DHTBV>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com>
 <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:05:36PM -0700, Yu Zhao wrote:
> On Tue, Dec 12, 2023 at 6:39 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > Allow proactive reclaimers to submit an additional swappiness=<val>
> > argument to memory.reclaim. This overrides the global or per-memcg
> > swappiness setting for that reclaim attempt.
> >
> > For example:
> >
> > echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> >
> > will perform reclaim on the rootcg with a swappiness setting of 0 (no
> > swap) regardless of the vm.swappiness sysctl setting.
> >
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> 
> NAK.
> 
> Please initialize new variables properly and test code changes
> thoroughly before submission.

Could you be a bit more specific? The patch is compiling and working
locally but perhaps there's some configuration or behavior that I
haven't been testing.
