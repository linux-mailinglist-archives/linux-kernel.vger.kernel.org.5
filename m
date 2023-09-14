Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBF7A0FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjINVUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjINVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE52703
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:20:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925fb6087bso18420387b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726445; x=1695331245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob3uAvnOoSCrtCSZPkBDgY1akrbFBa78/VkbR/tD3Zk=;
        b=vOINow2YxM/MoSfukFZ+ffrZCGQymL1/8iS4WZMKdLIOjR5lWXaAC7A8DVAmDEuYSJ
         eVarJzpkG9cb+yEJ9ex8zSMdTP5BIxrCgLWVUJJWm+nuz4cuaxe6+ZKRFxf/vuDP1AOO
         Igxca97ZL1BJEgGVbJBDmAIu0+JF09MnlKp6LA4bb0yCKyk2vm8FTWyHVMQMx9bOhPcL
         RSJJwqI4cdBz7jr8JUBRzH3DJyaHjtl9/2b0Lfn4Yw3Hwn94ZF/Ci2oKsJGaHvOIgZhr
         HBhFoU6klN3eTC3QkiE+S58oOHd42DD4sL/C3/mvDNXWdPBu0fIcFFFyGOo3BC7IHyRy
         GU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726445; x=1695331245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob3uAvnOoSCrtCSZPkBDgY1akrbFBa78/VkbR/tD3Zk=;
        b=dJQKJgsVva0FbeJZkO46v4GrBdsLrUZSnsi/kb61vyg2poq5+9qLXtp3fS48aWJYiz
         QPcG0Ux0noZxgcv/HeWqxU2z+Ny+G7OV+G8U8JiHknpisAcwak3p4+9eRDX0uyLjQe3x
         wUR8xewO1x08zJU+6bMDoHviW1XHDxU5LCo8dnRQWYmVIfxOlSiIy2Q3+GmaU9WPBLh/
         Gijpti7UFTYJbyncNeHYtmAoZ5CKtgmxkHrxC0YvPx568n2ajuRQ4gaqZLns9bJ4N1xC
         wMY5WN1nVO8Ek7GJysFoY3TS1pbP9M7ic1haxN1ENWuIPKmjPXBFKUMW35xSAaLlFCN5
         kGWQ==
X-Gm-Message-State: AOJu0YwHy6ayyfhkn8cxJioWh3Hp1wHRsLZ+WPFwqJsCHeBd0QIqBH2r
        Rz3UUHI32udJQPwCE8klSNWPVdoKm598Kw==
X-Google-Smtp-Source: AGHT+IHqKkwRb4VbopLin6Ia5XmxbD4rC+NeBFNXt+55ae4VdsIBmIxgGh8mmlngX1m+Fr0aiJb37+HMAskv5w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:af11:0:b0:565:9bee:22e0 with SMTP id
 n17-20020a81af11000000b005659bee22e0mr176595ywh.0.1694726444854; Thu, 14 Sep
 2023 14:20:44 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:20:42 +0000
In-Reply-To: <20230901062141.51972-1-wuyun.abel@bytedance.com>
Mime-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
Message-ID: <20230914212042.nnubjht3huiap3kk@google.com>
Subject: Re: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on alloc
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
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
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

On Fri, Sep 01, 2023 at 02:21:25PM +0800, Abel Wu wrote:
> 
[...]
> As expected, no obvious performance gain or loss observed. As for the
> issue we encountered, this patchset provides better worst-case behavior
> that such OOM cases are reduced at some extent. While further fine-
> grained traffic control is what the workloads need to think about.
> 

I agree with the motivation but I don't agree with the solution (patch 2
and 3). This is adding one more heuristic in the code which you yourself
described as helped to some extent. In addition adding more dependency
on vmpressure subsystem which is in weird state. Vmpressure is a cgroup
v1 feature which somehow networking subsystem is relying on for cgroup
v2 deployments. In addition vmpressure acts differently for workloads
with different memory types (mapped, mlocked, kernel memory).

Anyways, have you explored the BPF based approach. You can induce socket
pressure at the points you care about and define memory pressure however
your use-case cares for. You can define memory pressure using PSI or
vmpressure or maybe with MEMCG_HIGH events. What do you think?

thanks,
Shakeel
