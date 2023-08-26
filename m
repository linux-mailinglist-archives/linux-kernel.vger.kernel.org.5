Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A517892EB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHZBOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjHZBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:14:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641C126BB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:14:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-56c2e840e70so860560a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693012450; x=1693617250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dedr5HqUtts1etyB0Pt4WEe2EknXWGsmo5waqr4X8oY=;
        b=Sh2qvTznd7rY6WjG0rQMlDbnZv2kxzj9BLwmCQgdH5I0jv8yql0Yt+iDkI5OV/SKZB
         pIGsfBwVvwzHkWcunmwIt31FPvppr6P+ixkfXbJFUhCbRNvopNENcCXT5E+35b6VfHiQ
         W/ypKEeEm0EXv34iRbRGo5uFIXYNaDfEWR95yY153BoDGBhbaxtYKJoiQcxXomarcSCq
         kcDo2ytEY3td9zCSoRK0HXUE4uUKfsRstJJZP7pstfy++ZvsgMsu0+YrfRqe+tl9bcNJ
         6s7oqi8ekZxF+dvjPGWkhIJgWOy/3PWSzTmL7w8Hv6npiwNnspHB6s+vVhKQtyDmCvR9
         SvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693012450; x=1693617250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dedr5HqUtts1etyB0Pt4WEe2EknXWGsmo5waqr4X8oY=;
        b=PUmopBpRIwci4vPtw/VFZh1Bt2RhAXmIma0/39ITyr3q1woJ9URCRyGyuAxRxfyYwI
         IhuBdDE0NCdH6FX52eJgJnYkiaprmJVdwGILxL5K6qsb+jJlJOKRKZ0rVoT6JPykaHuf
         PAybxnt/iCedhUA5ivLrXSPPj8VYaAdgHoRu+NRQDTfHOQ1Zpm2sGrdWaHMSo+zGCy11
         brwhuhGDCoMl4Nogf2cJJJY2il2H1VVhjRNFuCaVXXB7PNDnaGlJqhrF7x0Ne1ifA3Xb
         dmdUZQOQHWkwoU/9fPnxXLi4cR0vmo8GbTmRMH/1zmJggY0+rwlhqvOC99kvUpKckpp5
         akXg==
X-Gm-Message-State: AOJu0YylwBOYLPROqhzbgPRrXNYCEYNx8+XQdBZt4Q0AoBd/P0bdz1KB
        XAEb44q9ZgMEfvAcogmXenP/XSkGTXomc6eq+LI=
X-Google-Smtp-Source: AGHT+IEHX6tc7RFf/f/DCY5gA7YQ8UqOg3SHKrI4+Qvy6dNLhKSX2zOTa9Csf0gRIISrkn7t9Jl+Q6gduY9fKjPb2oM=
X-Received: by 2002:a17:90a:bf88:b0:26b:c3f:1503 with SMTP id
 d8-20020a17090abf8800b0026b0c3f1503mr19734814pjs.17.1693012449784; Fri, 25
 Aug 2023 18:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 26 Aug 2023 09:13:56 +0800
Message-ID: <CAJhGHyAF0LR=sOudW9Rd=GmpZ_LrnZAa_bb7jKBojwE8LGtVNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] workqueue: make the increment pwq->stats[]
 increment atomic
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 3:45=E2=80=AFAM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> KCSAN has discovered a data race in kernel/workqueue.c:2598:
>
> [ 1863.554079] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_wo=
rk
>
> [ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu=
 27:
> [ 1863.554154] process_one_work (kernel/workqueue.c:2598)
> [ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue=
.c:2752)
> [ 1863.554177] kthread (kernel/kthread.c:389)
> [ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
> [ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>
> [ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu =
12:
> [ 1863.554224] process_one_work (kernel/workqueue.c:2598)
> [ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue=
.c:2752)
> [ 1863.554247] kthread (kernel/kthread.c:389)
> [ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
> [ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>
> [ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a
>
> [ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
> [ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G          =
   L     6.5.0-rc6+ #44
> [ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightnin=
g, BIOS 1.21 04/26/2023
> [ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
> [ 1863.554941] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     lockdep_invariant_state(true);
> =E2=86=92   pwq->stats[PWQ_STAT_STARTED]++;
>     trace_workqueue_execute_start(work);
>     worker->current_func(work);
>
> The quick and dirty solution is to use atomic_inc():
>

Great thanks for reporting the problem.

IMO, the best way to fix it is just to move the line
"pwq->stats[PWQ_STAT_STARTED]++;" up and above the line
"raw_spin_unlock_irq(&pool->lock);"

Thanks
Lai
