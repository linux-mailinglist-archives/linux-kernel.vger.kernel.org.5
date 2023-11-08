Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E859C7E518F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKHIBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKHIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:01:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74EF0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:01:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so11236858a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699430479; x=1700035279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNi4fClCOjk3xdFXZ5yiVbLFHsXzEYt3ZKrZiBMxjyw=;
        b=gcATRfuZwPQuaMDXVN2zDuOrndRmF2UiI+D7rRbBhUXsxpmla4rBOKmW9ptzlL+lhm
         79Jkv8o7dWQyn6g4osleydpNdMRyHBQer3YuWS28GXp/LvcQu1vSrgPyru6MrltpsRGZ
         ZdwFsKiAZiQA6u90NCjLLnTSVa2Y4qV+LRzveJ0KKyowkR6qK4L2K3T/rNymhBL0C5+h
         NoQKsDr73A//t+hTx0O/77sCl081ZGSDOR1R+uEtNLpGssPZn54gorRJpelNFDzKevex
         gA7TAhYg24TK0p2+FfQIsk+ek3tKti2gmaoMsGiUovoUH9U6Oz/zFPVxSz7EbninUnE8
         Dw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430479; x=1700035279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNi4fClCOjk3xdFXZ5yiVbLFHsXzEYt3ZKrZiBMxjyw=;
        b=llzBAlmYCRrBZpAHSV3wecv+s79aYZA4dNfacnfdPKbXP4Rpc1JC3Q35fZAVua0W6b
         WWBr+GPg5Ydzo2+vKsrbm3CoUlLZba6aF2JKVjMOTVknRO402hdqNnUAfzEDsEvgAat+
         reanMqtRUvmEM33ybY7d/Pc8MdS611bMvFsTAVjmYBDmGfM1mnZPvFENW9g064+RLYjT
         0B1sKxRoTEw3iRk1dFIHC6ciWYcAV2SDG2jCGlsM6tcW5peFP2DjZl623N6n7IArWd5l
         /5dXe+Xd289kwIRDq5BJuUGav4tARpS/M/lc3I6KvTlFWkv2Cg4tyeVuXk8EFV8A3HmF
         Fk+w==
X-Gm-Message-State: AOJu0Yw6pokzNxcy0Hzb8sEtId6d80zc4sAGQiboOE8i/zH6HWjYLTs6
        X2rscVqUOp61mT3ipqPYqoBCNRkTUS18y7VWOoWdig==
X-Google-Smtp-Source: AGHT+IF9zLVkQKgYnQFEJtbLFMGxGUHm/ggdeeQ390qH4xEE1KzKzMRdaKCiHY6k9DQcMexREYD80V4ZtE1hNp9Thbc=
X-Received: by 2002:a17:907:60d4:b0:9ad:e298:a5d with SMTP id
 hv20-20020a17090760d400b009ade2980a5dmr789580ejc.19.1699430478750; Wed, 08
 Nov 2023 00:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20231108065818.19932-1-link@vivo.com>
In-Reply-To: <20231108065818.19932-1-link@vivo.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 00:00:39 -0800
Message-ID: <CAJD7tkYVtaX=W5XWhn-Y+d==mbHs5AZG-7sAaYmo7FDONpoQ7g@mail.gmail.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To:     Huan Yang <link@vivo.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Wei Xu +David Rientjes

On Tue, Nov 7, 2023 at 10:59=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
> In some cases, we need to selectively reclaim file pages or anonymous
> pages in an unbalanced manner.
>
> For example, when an application is pushed to the background and frozen,
> it may not be opened for a long time, and we can safely reclaim the
> application's anonymous pages, but we do not want to touch the file pages=
.
>
> This patchset extends the proactive reclaim interface to achieve
> unbalanced reclamation. Users can control the reclamation tendency by
> inputting swappiness under the original interface. Specifically, users
> can input special values to extremely reclaim specific pages.

I proposed this a while back:

https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yK=
SNgD7aGdg@mail.gmail.com/

The takeaway from the discussion was that swappiness is not the right
way to do this. We can add separate arguments to specify types of
memory to reclaim, as Roman suggested in that thread. I had some
patches lying around to do that at some point, I can dig them up if
that's helpful, but they are probably based on a very old kernel now,
and before MGLRU landed. IIRC it wasn't very difficult, I think I
added anon/file/shrinkers bits to struct scan_control and then plumbed
them through to memory.reclaim.

>
> Example:
>         echo "1G" 200 > memory.reclaim (only reclaim anon)
>           echo "1G" 0  > memory.reclaim (only reclaim file)
>           echo "1G" 1  > memory.reclaim (only reclaim file)

The type of interface here is nested-keyed, so if we add arguments
they need to be in key=3Dvalue format. Example:

echo 1G swappiness=3D200 > memory.reclaim

As I mentioned above though, I don't think swappiness is the right way
of doing this. Also, without swappiness, I don't think there's a v1 vs
v2 dilemma here. memory.reclaim can work as-is in cgroup v1, it just
needs to be exposed there.
