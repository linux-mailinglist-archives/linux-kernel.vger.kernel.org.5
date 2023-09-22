Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518147AB90C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjIVSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjIVSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:21:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3FC2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:21:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41761e9181eso39971cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695406882; x=1696011682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFXnvm90AnZS5ugwYzLgHg0vzuSZu/RHex9JeJs8pKc=;
        b=ckFcenzCQARDq2vH179vjehHy1Up3xZygz0lAwpXe5YuV6AH/z2MtqnVmPvV3BXODA
         oEUo4Fz7V798hHJ81WLApnVIwRrtRNItLw+Dd8IFyzq0PMjOqqVzPGRezIuE1q2QkZGX
         1TKts5mHdnzK+AMLp3o5M8/sINAuxBz4ZhVS1cQLsZNHnNkmkE55Q1S0YZLJJVQG/zXR
         23tA2hZpaGAe9MPXBR1nsd57M5y32F16SShzrH7j0sWDogcmWlXLQOAQgrCHOsQJ9Ocb
         muakfLyajXLYLZJxIZtmi+LQqAwNc+014fOxeUfyslkkrVGNWiXtIi2O5knCUbB9Q62H
         xpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406882; x=1696011682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFXnvm90AnZS5ugwYzLgHg0vzuSZu/RHex9JeJs8pKc=;
        b=vkb8GhTc9PHFbPM903lGpnHmbYhgyS/jF+C3qR49zsJDTnu8K7ZRm5ACYUcvog3ii1
         yb/GcGOTLqntwarVoPeC9iR9X7ekHTnCnXMaLy+Fu2Aizc5M8QxXFZ4dwlgyuL6tHFcR
         4GrnlK96zWxD4Jr43bXEI9dkjZRoWoxWfx79qDpjWgLOTAedd2FrAFAhevXzzumAH18J
         xtF/hqtvai1v2bWO1I5dBkBdBJZk5VrpBmvCMi8w1vMdbzz15x82D9mj8TznJZ8mezhU
         2qzgSNcc/b/1piDlZ3lV/eI1/ymHqltDsV2ApZQb5y7hd8usG2ZI72nMamDw19ydXwhb
         c5og==
X-Gm-Message-State: AOJu0YxVl27Ez5KipkA8NFZuP2Hx/IcrwgfDonB60BMYanlx7FHVFJgv
        2i7k/a53OXVqXJX5/YtgP2sAby4fSMFkSgaeADgkCowrV0dMJdPT/f3zTbUg
X-Google-Smtp-Source: AGHT+IG+aBHFGKfyx4fK4ZjMyyr00JPufXWbmH7atMAjhgHiFc+jsv5T4h5cZjF7hN68WGhqxxLyCZTr/EufF0l2vSA=
X-Received: by 2002:a05:622a:1aa6:b0:3ef:5f97:258f with SMTP id
 s38-20020a05622a1aa600b003ef5f97258fmr30782qtc.16.1695406881586; Fri, 22 Sep
 2023 11:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230921182012.3965572-1-saranyamohan@google.com> <2023092258-clothing-passerby-e0f2@gregkh>
In-Reply-To: <2023092258-clothing-passerby-e0f2@gregkh>
From:   Saranya Muruganandam <saranyamohan@google.com>
Date:   Fri, 22 Sep 2023 11:21:10 -0700
Message-ID: <CAP9s-SrHMFD6Q8t9Htk8W5OrQTAoe2D51ZRf-Zap4O_3E485LA@mail.gmail.com>
Subject: Re: [PATCH] block: fix use-after-free of q->q_usage_counter
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for leaving out the stable release info.
This is for both 5.10 and patch applies cleanly for 5.15.

I just sent out a (different) modified patch for 6.1 LTS.


On Fri, Sep 22, 2023 at 2:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Sep 21, 2023 at 11:20:12AM -0700, Saranya Muruganandam wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> >
> > commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.
> >
> > For blk-mq, queue release handler is usually called after
> > blk_mq_freeze_queue_wait() returns. However, the
> > q_usage_counter->release() handler may not be run yet at that time, so
> > this can cause a use-after-free.
> >
> > Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
> > Since ->release() is called with rcu read lock held, it is agreed that
> > the race should be covered in caller per discussion from the two links.
> >
> > Backport-notes: Not a clean cherry-pick since a lot has changed,
> > however essentially the same fix.
> >
> > Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
> > Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
> > Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
> > Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
> > Cc: Hillf Danton <hdanton@sina.com>
> > Cc: Yu Kuai <yukuai3@huawei.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref=
 in fast path")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.=
com
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> > ---
> >  block/blk-core.c  | 2 --
> >  block/blk-sysfs.c | 2 ++
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> What stable kernel(s) are you expecting this backport to be applied to?
>
> thanks,
>
> greg "not a mind reader" k-h
