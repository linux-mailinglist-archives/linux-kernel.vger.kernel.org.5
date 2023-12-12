Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5480FB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377448AbjLLXkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjLLXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:39:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C89A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:40:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C632CC433C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702424405;
        bh=zXHQF7Ay6V2DwGSP7PW43cHZ4MHQlH5fsUBGMwcWepg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ak1A7XbWbA90dkwBKsEigjDs8hvO1EyeHLu5Za7bAtS9gSA3NVJncL8L8ZsonydYL
         mzisi+1P5FcOez/sAQ1LopGYS88NiYlk0WACaafRLr3RB0HqTwEMKx6t5AZZn0Kb7p
         BE+5ofqPFyd6p+Lx6pAnhHRkspJ+NCxmpy5Efg840lZyqe77XpE/g6bBqYrjDf994J
         F6HSNdnfjCrPb7kpbSUyDzgMuGfNFKqJSwVvXZFUzrLWPAIv4pQhj3wpkzKnHE4Aiu
         NM8K42QyOtFVd1YiX5P50tW8GBIZHfkmcyLNiYEMaHSE3DQJ6l0Gkh+ApjE1X4URw/
         nEP6DwW0XuBFw==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso5239365a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:40:05 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7/laBxabHsIBNUNFULhzpQwcNl1m7uvlRfuFDh6Vo3lpyPhp/
        CPDLfQYPFHrpx9Rbe8NB7x4lDrUPyzzbwJSUeqSnBA==
X-Google-Smtp-Source: AGHT+IEmqfa4ep60xPurty5z6OFDCdyneMw1aoInldpxnnUT16j6Ovr9QuBYq9vrMR1uZBLj+lHa8r4Xxm1cJx1AwG0=
X-Received: by 2002:a17:90a:510f:b0:28a:d858:b6ba with SMTP id
 t15-20020a17090a510f00b0028ad858b6bamr673250pjh.42.1702424385003; Tue, 12 Dec
 2023 15:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com> <CAMgjq7AjO=Z4Wa3DYaOJdWA+8aNQ1JHZQYKYOm5-SvvgPPOGKg@mail.gmail.com>
In-Reply-To: <CAMgjq7AjO=Z4Wa3DYaOJdWA+8aNQ1JHZQYKYOm5-SvvgPPOGKg@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 12 Dec 2023 15:39:33 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN=E0RA_JyVnAVraYSyHx5sk=znM2A-JKnAfDc4M2BYGg@mail.gmail.com>
Message-ID: <CAF8kJuN=E0RA_JyVnAVraYSyHx5sk=znM2A-JKnAfDc4M2BYGg@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Minchan Kim <minchan@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

Thanks for sharing the information on how you use swap.

On Mon, Dec 11, 2023 at 1:31=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> > 2) As indicated by this discussion, Tencent has a usage case for SSD
> > and hard disk swap as overflow.
> > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.co=
m/
> > +Kairui
>
> Yes, we are not using zswap. We are using ZRAM for swap since we have
> many different varieties of workload instances, with a very flexible
> storage setup. Some of them don't have the ability to set up a
> swapfile. So we built a pack of kernel infrastructures based on ZRAM,
> which so far worked pretty well.

This is great. The usage case is actually much more than I expected.
For example, I never thought of zram as a swap tier. Now you mention
it. I am considering whether it makes sense to add zram to the
memory.swap.tiers as well as zswap.

>
> The concern from some teams is that ZRAM (or zswap) can't always free
> up memory so they may lead to higher risk of OOM compared to a
> physical swap device, and they do have suitable devices for doing swap
> on some of their machines. So a secondary swap support is very helpful
> in case of memory usage peak.
>
> Besides this, another requirement is that different containers may
> have different priority, some containers can tolerate high swap
> overhead while some cannot, so swap tiering is useful for us in many
> ways.
>
> And thanks to cloud infrastructure the disk setup could change from
> time to time depending on workload requirements, so our requirement is
> to support ZRAM (always) + SSD (optional) + HDD (also optional) as
> swap backends, while not making things too complex to maintain.

Just curious, do you use ZRAM + SSD + HDD all enabled? Do you ever
consider moving data from ZRAM to SSD, or from SSD to HDD? If you do,
I do see the possibility of having more general swap tiers support and
sharing the shrinking code between tiers somehow. Granted there are
many unanswered questions and a lot of infrastructure is lacking.
Gathering requirements, weight in the priority of the quirement is the
first step towards a possible solution.

> Currently we have implemented a cgroup based ZRAM compression
> algorithm control, per-cgroup ZRAM accounting and limit, and a
> experimental kernel worker to migrate cold swap entry from high
> priority device to low priority device at very small scale (lack of
> basic mechanics to do this at large scale, however due to the low IOPS
> of slow device and cold pages are rarely accessed, this wasn't too
> much of a problem so far but kind of ugly). The rest of swapping (eg.
> secondary swap when ZRAM if full) will depend on the kernel's native
> ability.

Thanks for confirming usage needs of per cgroup ZRAM enable and
flushing between swap devices. I was hoping the swap.tiers can support
some thing like that.

> So far it works, not in the best form, need more patches to make it
> work better (eg. the swapin/readahead patch I sent previously). Some
> of our design may also need to change in the long term, and we also
> want a well built interface and kernel mechanics to manage multi tier
> swaps, I'm very willing to talk and collaborate on this.
>

Great. Let's continue this discussion in a new thread and start
gathering some requirements and priorities from everyone one. The
output of this discussion should be some one pager document listing
the swap tiers requirement and rate the priorities between different
requirements.

Once we have that nail down, we can then discuss what are the
incremental milestones to get there.

I am very interested in this topic and willing to spend time on it as well.

Chris
