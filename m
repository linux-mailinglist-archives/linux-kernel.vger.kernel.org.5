Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8C75FA05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjGXOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGXOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:39:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11E19C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:39:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99b9421aaebso155109966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690209580; x=1690814380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDCS4BThuikrxfZ3pVdXGKzBm4hBT5BkVcG2+9VDxdM=;
        b=HeqltN6YysoNpPmF8jOq4BMenkVF/UoLLGTs2f73eDVL6RZGg995n4rlajiD4OwBuD
         x0vh4COeuwAnTWyjIuPulyOqktMXVNRXkQvWwZ2l7X/x2xyzf/5z6rmKcfg7LEQUKape
         g2rrI9p67ze5EjPEeChlbuzjserRkK4xiP6HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690209580; x=1690814380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDCS4BThuikrxfZ3pVdXGKzBm4hBT5BkVcG2+9VDxdM=;
        b=NRlRTJtP66Kzjt4y2zxQgslx1xFt//MTS/kmJWjoZDB0XOM/058KEmbltaHaxiSyYm
         CyH9zs84XWrrzQuW+mOA6wxGB97NS+3aYPD7HQuZlep233JnJt1QDEDxJ0r6SSYTrKvh
         p25/1X53qleIphJlZOgOIhgghkBFRLEAADIcKxcUa49Ib2GFugO8LtQeUs5pdKMemuKO
         0ZTCgDWBeJJ3uFflL6g8am9jzIA1tS++yLgd0yx0AlaHLuNuINgRfIxIYUiRMG3K/Syd
         wqb2WgYcF1fLgWDS0W2sPIdtV6jkcU4emOg7GTZcZAyPfa9/X+KDgDoqGj+Difi4IywD
         3mKQ==
X-Gm-Message-State: ABy/qLYzwfuXr+qAYyYbi4yg0kdcaFvkGaNYfkFV4kDhcEAqEuiZXyvX
        o2IWlZ9NW44PtlnZMBaUEmaznMH/zbpoBGuFwMaSBg==
X-Google-Smtp-Source: APBJJlE0zUZ7/H33uBPyJRFhIz1QyaXjiJwtFyZumY0VqAzl+PAYgjNUtMvdni5ppE3UlH/+Fep0Bw==
X-Received: by 2002:a17:907:771a:b0:993:d617:bdc5 with SMTP id kw26-20020a170907771a00b00993d617bdc5mr9486318ejc.37.1690209579912;
        Mon, 24 Jul 2023 07:39:39 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b00997d7aa59fasm6911354ejr.14.2023.07.24.07.39.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 07:39:39 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15318a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:39:39 -0700 (PDT)
X-Received: by 2002:a50:ab56:0:b0:51e:5773:891d with SMTP id
 t22-20020a50ab56000000b0051e5773891dmr168221edc.4.1690209578716; Mon, 24 Jul
 2023 07:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <D98ED975-F617-4885-8D3F-DCFDC524E933@oracle.com>
In-Reply-To: <D98ED975-F617-4885-8D3F-DCFDC524E933@oracle.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jul 2023 07:39:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuJZNirf1DtcE_d8-aBRb9O_fYk_r252WCzC-YHwYnbg@mail.gmail.com>
Message-ID: <CAD=FV=VuJZNirf1DtcE_d8-aBRb9O_fYk_r252WCzC-YHwYnbg@mail.gmail.com>
Subject: Re: VM Boot Hangs with Commit "Revert "scsi: core: run queue if SCSI
 device queue isn't ready and queue is idle"" on linux-5.4.y
To:     Sherry Yang <sherry.yang@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 23, 2023 at 10:28=E2=80=AFPM Sherry Yang <sherry.yang@oracle.co=
m> wrote:
>
> Hi Douglas,
>
> We observed linux-stable v5.4 VM boot hangs, but probably only 1 in thous=
ands of boots (less than 10,000 boots).  We started 16 VMs on a Bare Metal =
with loop reboots, I chose 10,000 boots as a threshold, and bisected it. Af=
ter a painful bisection, I found the culprit commit 578c8f09c04b (=E2=80=9C=
Revert scsi: core: run queue if SCSI device queue isnt ready and queue is i=
dle=E2=80=9D). This commit actually was merged to v5.8 the 1st time. It's a=
 series of patch set (https://www.spinics.net/lists/linux-block/msg51866.ht=
ml). Actually, in the 4-patch series, 2 of them have already been backporte=
d to linux-stable v5.4, but not at the same time:
>
> 1) ab3cee3762e5 (=E2=80=9Cblk-mq: In blk_mq_dispatch_rq_list() no budget =
is a reason to kick=E2=80=9D) in tag v5.4.86
> 2) 578c8f09c04b (=E2=80=9CRevert scsi: core: run queue if SCSI device que=
ue isnt ready and queue is idle=E2=80=9D) in tag v5.4.235, it=E2=80=99s bac=
kported as stable dependency for another commit
>
>         Signed-off-by: Douglas Anderson <dianders@chromium.org>
>         Reviewed-by: Ming Lei <ming.lei@redhat.com>
>         Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>         Signed-off-by: Jens Axboe <axboe@kernel.dk>
>         Stable-dep-of: c31e76bcc379 ("blk-mq: remove stale comment for bl=
k_mq_sched_mark_restart_hctx=E2=80=9D)
>         Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> And I tried backporting the other 2 patches to v5.4, the issue is still r=
eproducible.
>
> I tested multiple kernels, the issue is not reproducible within 10,000 bo=
ots in the following kernels:
> 1) Linux v5.9
> 2) Linux v5.4.249 + revert of 578c8f09c04b (=E2=80=9CRevert scsi: core: r=
un queue if SCSI device queue isnt ready and queue is idle=E2=80=9D)
>
> Not exactly sure how this commit is affecting linux-stable v5.4, but I su=
spect some prerequisite commits are missing which lead to boot hangs on lin=
ux-stable v5.4 but not on higher releases. Could you take a look at this is=
sue and share your insight?

Ugh, I spent many days pouring over the code and digging through debug
traces in order to write those patches. I don't think I'd be able to
give any concrete advice without spending many days and being able to
reproduce multiple times with traces since pretty much any knowledge I
learned during the course of developing those patches has decayed over
the last several years. :( I don't happen to know any dependencies
offhand...

That being said, it seems like:

1. Backporting the revert (the 4th patch in the series) without all
the other patches in the series feels wrong. In the text of the revert
I explicitly refer to the other patches in the series as
prerequisites. I guess you said you tried backporting the other two
patches and they didn't help, though? That's no good. :(

2. I don't think the revert is actually important to backport to
stable. While the first 3 patches were important to fix the problems I
was seeing, the revert was just a cleanup. If the revert is causing
problems in 5.4.x then I'd suggest removing it from 5.4.x

Does that make sense? So ideally you'd submit 3 patches to the stable kerne=
l:

a) Revert the revert

b) Pick ("blk-mq: Add blk_mq_delay_run_hw_queues() API call")

c) Pick ("blk-mq: Rerun dispatching in the case of budget contention")


FWIW, we seem to have all 4 patches in the ChromeOS 5.4 kernel tree.
They all landed together plus 1 prerequisite.

* https://crrev.com/c/2155423 - FROMGIT: Revert "scsi: core: run queue
if SCSI device queue isn't ready and queue is idle"
* https://crrev.com/c/2133069 - FROMGIT: blk-mq: Rerun dispatching in
the case of budget contention
* https://crrev.com/c/2155422 - FROMGIT: blk-mq: Add
blk_mq_delay_run_hw_queues() API call
* https://crrev.com/c/2125232 - FROMGIT: blk-mq: In
blk_mq_dispatch_rq_list() "no budget" is a reason to kick
* https://crrev.com/c/2155421 - UPSTREAM: blk-mq: Put driver tag in
blk_mq_dispatch_rq_list() when no budget

When I saw the prerequisite in there I was hopeful that it was the one
you needed, but it looks like that's already in 5.4 stable so (I
presume) you've already been testing with it...

-Doug
