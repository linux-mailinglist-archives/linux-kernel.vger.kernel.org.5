Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE42D79FB37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjINFrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjINFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:47:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A3C1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:47:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fb8933e18so8616717b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694670444; x=1695275244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tS5rZvk+JQ82ZNIv0TH5Yi0ePQfGELuD7tGPhOL+JYg=;
        b=JJsu+zvXz4xlIkQi2s39lZUMWsulckQVhIA8PIlJqAzDbjCyhzBF/dR28dY8VSaNof
         HirQgVEkS09wtAZQs7V27kiHtQjDpsaBEUM+Mp/sar19WwJ2sukwT1VZyfZiOYXCeAK3
         mliPuZcVl5IabVDiUHToiVXsaLE0ej31w1GmjO6xMOGm9Tv+ugQYY5D0FhqWNdly1h/o
         UGiHubetQE2aFly8LGeh8xfkDnZueFye+DCzuOCSyUmQ4bxovf1bq+f6luTVGdzbbsfx
         mTM5fNw5DLdQrPOJr8V2CwotWZW2dIGj6ARTVGpYj4YNlesn2rsYbbMJUE7O/UKbsl0a
         Jd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670444; x=1695275244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS5rZvk+JQ82ZNIv0TH5Yi0ePQfGELuD7tGPhOL+JYg=;
        b=DvgFitzmMipURfp3prJ6PaltOHCemeP/cuOZ/Tb2Bz8hX7BmrzESAtZkLIMGSBdCiW
         t0y8xCBAE6/CCzL7/VNQ8vOjKXP0EBbVxSY2s2ES59Gs5egIVhtoWMlCoQkRoMgNU3l+
         kobeuRQwIr0B0P9/YvfkauXEYXIT+frtWUUAZ8EDXlY79z6xGbu1G1gX5OpMOlZDZXCS
         QbpdxAgHUVft738Syj+YnuGk9Y3lDOLZnwTHkTHzNgyPn/b+EC/gn8ZHNmoEfrueREPb
         Viip0iPlZynAUy3oB39lTbq9h6yWMWj4BcDhtINBn/GEBZesCdb1Oix3/Q7uWUr9vfgK
         urFg==
X-Gm-Message-State: AOJu0YzPZE0KvwXeNL5mlN+qlZYciHkeGLxjrPwssaYp5q4Gx38FY8rl
        vZ+2xW781IEwNsQBGS36R8eAnr6sYNEpMg==
X-Google-Smtp-Source: AGHT+IG6p2OhgSYYFCejxWmLnsMS9maAkvo3+M0NMvomjvoXTGY12ej1IMxp2jnwMQibdFuQBsfPZY8GukgG6A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:fd0:b0:59b:c6bb:bab9 with SMTP
 id dg16-20020a05690c0fd000b0059bc6bbbab9mr122311ywb.3.1694670443972; Wed, 13
 Sep 2023 22:47:23 -0700 (PDT)
Date:   Thu, 14 Sep 2023 05:47:21 +0000
In-Reply-To: <20230901062141.51972-2-wuyun.abel@bytedance.com>
Mime-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com> <20230901062141.51972-2-wuyun.abel@bytedance.com>
Message-ID: <20230914054721.kaojkal2kcfz7drb@google.com>
Subject: Re: [RFC PATCH net-next 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:21:26PM +0800, Abel Wu wrote:
> Code cleanup for both better simplicity and readability.
> No functional change intended.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

This is simple cleanup and can be included independently.

Acked-by: Shakeel Butt <shakeelb@google.com>
