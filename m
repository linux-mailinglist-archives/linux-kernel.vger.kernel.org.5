Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5108807924
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442864AbjLFUIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442860AbjLFUIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:08:23 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2980D1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:08:29 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4b2ceee07e5so133053e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893309; x=1702498109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SfYIeu14tCXK8E3Za44CV4qWg51U2kdyUz3RWXxawQ=;
        b=TnR8Raftn7XyzgSznlyjRGG2t1Lv9T1bn7qoc7IX45haNbWMMa1ZxOjrWY1Wq0rrTV
         rPV4B32ZMbt2+j4R4zk55CZcA+7+Zp87rrmX7lXJoySn1bdJjPuCv1d9nSE7s4ge26pY
         1M+ApPm4V0n32mSLl1p7J7X98a+UBR+ibar8374/KH7sVZoXy80eYSwoRMIqY4CEr6i0
         r3OlJRYYz/LO5Di8t9myuSbOS6k7Oie/AEEh3NsT3LLaWaYFyvy8DkO9ZyF+Ytj97O22
         UQORcvzXUsnhVz6zLhd6bRm6LVPG/0JBbg816TQ7p+HZftGuUKZ3f7ZAmrt7rzY1xTwL
         2RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893309; x=1702498109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SfYIeu14tCXK8E3Za44CV4qWg51U2kdyUz3RWXxawQ=;
        b=A3dGKsUITosXmkQNh9Hc9OzTtCmbcg2kiOh/Iy9vAK4w8ZKzIeQtzefVYnHzcwSFdC
         XEoO18DQTG2X5FHHPjiJyAQy5LwBNqbAPUiuijKT0AA73rwYTlclCgVDlO5FqNxL08AD
         J5aiVo81T4zSzJbytbLvKiJquB6w/KVzBHBpTl2KUDfuzS19gH+OJZgwKzRLv0T0A9QD
         HJLUsY0zTez1zEeJYd2xwOGtanyHVrZ87JJY19FJYF9f0uXfFyRzZzig+xpmwuoPgemO
         U4YvIQONK+ewUpLOxd20hJf6exhAkGXyfFpa8TAYOqW2xh8i5hlyOq9j6vU35I2rSvfM
         xrfQ==
X-Gm-Message-State: AOJu0YwS3IQjsZ2X2kX6yw/5M2/s0vcNpLH9gBIljjNYemJ5b9STbOoB
        GSvWOAYDvxF5L174gR4TWxW3FCs0dRSjKZDDH9M=
X-Google-Smtp-Source: AGHT+IHe02MEVz7Be6DdmFr7DSfmJUUxAP+wHlwxCJjgnIhbuyrHJbmYVUuhbD47v/gkgt0DmytXtO6YnhoqGZepol4=
X-Received: by 2002:a1f:ecc4:0:b0:4b2:c554:cd05 with SMTP id
 k187-20020a1fecc4000000b004b2c554cd05mr1332842vkh.17.1701893308918; Wed, 06
 Dec 2023 12:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 6 Dec 2023 12:08:17 -0800
Message-ID: <CAKEwX=OqMK881u3kPB99KX_9UWreddz-cUT5ArzdwpHwQjQ6yA@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
> When testing the zswap performance by using kernel build -j32 in a tmpfs
> directory, I found the scalability of zswap rb-tree is not good, which
> is protected by the only spinlock. That would cause heavy lock contention
> if multiple tasks zswap_store/load concurrently.
>
> So a simple solution is to split the only one zswap rb-tree into multiple
> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea i=
s
> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks=
").
>
> Although this method can't solve the spinlock contention completely, it
> can mitigate much of that contention.

By how much? Do you have any stats to estimate the amount of
contention and the reduction by this patch?

I do think lock contention could be a problem here, and it will be
even worse with the zswap shrinker enabled (which introduces an
theoretically unbounded number of concurrent reclaimers hammering on
the zswap rbtree and its lock). I am generally a bit weary about
architectural change though, especially if it is just a bandaid. We
have tried to reduce the lock contention somewhere else (multiple
zpools), and as predicted it just shifts the contention point
elsewhere. Maybe we need a deeper architectural re-think.

Not an outright NACK of course - just food for thought.

>
> Another problem when testing the zswap using our default zsmalloc is that
> zswap_load() and zswap_writeback_entry() have to malloc a temporary memor=
y
> to support !zpool_can_sleep_mapped().
>
> Optimize it by reusing the percpu crypto_acomp_ctx->dstmem, which is also
> used by zswap_store() and protected by the same percpu crypto_acomp_ctx->=
mutex.

It'd be nice to reduce the (temporary) memory allocation on these
paths, but would this introduce contention on the per-cpu dstmem and
the mutex that protects it, if there are too many concurrent
store/load/writeback requests?
