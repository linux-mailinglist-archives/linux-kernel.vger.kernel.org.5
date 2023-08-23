Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AC78624A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbjHWV0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjHWV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:26:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2622C10D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:26:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so32025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692825961; x=1693430761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE5NUi80BYiMWmMQEl2r329pNGrPmM5nPALAZHC39A8=;
        b=gyVSt5OXIy9m33InJl2cRqgjTnAXbscfq16qPU8ezve9IYTQsTSP5HdhxOX+DoxKLn
         ZYPT+ALh7vZnEZoxXFyZXlPTcxdSm5cNO6JxpZlLh9mwB4wUS2kVFfPtLdL+DTKjR3ii
         CvTlFQJf3XvbjN8QRnmnUp/Hi1yeld4e7t4TP1xxaB6JknbqVlFfo11S9vvR/eUpSiwK
         IC1K12qEHGfIK3dqtZ3jF4b25uB1Veaz8Rls8/4g+sxIXKQNJrD6TCUWyOgMoxhhrKXr
         CQ8C533uzQnegYLv3BvKUOGIgyqHyNBK+4++27nRAocXKbBxncTb0UKgGbW8XumSoh/M
         RxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825961; x=1693430761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE5NUi80BYiMWmMQEl2r329pNGrPmM5nPALAZHC39A8=;
        b=a0IkSepEAb0UTTves9T01pnVCZuY+T3gUN4YiCBdiUa+P5yDd5xfuYTwrUZN2eJjwg
         +k2dZQ46kw4Y12ndxT+MFNINbh7R9ZDDuMXNKIhFA1pyM8yl5oSHHmYMI5H2W3Oox4Bn
         giFEy8dbQHJkVBLmor/2Hc7WWUJXdxDkD/JWaixnvvHCSHwIwQllYBp+z2kwaCfvAoGK
         ce1db/kDuxVLdV/ZWk8DI3K4IEim9gsgPlsh1bhf0Ee50t3ICLZUK5/PJLrps4Aq1il5
         x0uUm8MrellwJVxOnpPT3VibSCcWFSYv7k2c/nwoTSJViLGiGcBJIQb1iUyaCbHKl+Xj
         AJ+w==
X-Gm-Message-State: AOJu0Yx59HaqnjIBTTkMA1FpZybLewi/h/C1i8sWrhfNCRAEGEHz5644
        ilQXLmLdgWn0fOb1YQxCx4VRKNqDWBKB2dG4+U2Q
X-Google-Smtp-Source: AGHT+IGyZvegz/OMu2JzbjOWZUXuqzRYNJvCk+urb/uxPw44a1nWVrvdjKbzjjJTWgDt8+60lSyMmAMzeWYEoBaYYeE=
X-Received: by 2002:a05:600c:512a:b0:3f7:3e85:36a with SMTP id
 o42-20020a05600c512a00b003f73e85036amr299558wms.7.1692825961407; Wed, 23 Aug
 2023 14:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230819060915.3001568-14-jstultz@google.com> <202308240439.2aDXO6Ks-lkp@intel.com>
In-Reply-To: <202308240439.2aDXO6Ks-lkp@intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 23 Aug 2023 14:25:50 -0700
Message-ID: <CANDhNCpuozSe7Ygf84iRmmUtA2C+MhNUj+TfBn-rqe=7BwVu3Q@mail.gmail.com>
Subject: Re: [PATCH v5 13/19] sched: Split out __sched() deactivate task logic
 into a helper
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, oe-kbuild-all@lists.linux.dev,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 2:13=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi John,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tip/locking/core]
> [also build test WARNING on linus/master tip/auto-latest v6.5-rc7]
> [cannot apply to tip/sched/core tip/master next-20230823]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-=
Unify-runtime-accounting-across-classes/20230821-121604
> base:   tip/locking/core
> patch link:    https://lore.kernel.org/r/20230819060915.3001568-14-jstult=
z%40google.com
> patch subject: [PATCH v5 13/19] sched: Split out __sched() deactivate tas=
k logic into a helper
> config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/202308=
24/202308240439.2aDXO6Ks-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240439=
.2aDXO6Ks-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308240439.2aDXO6Ks-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/sched/core.c:6565:6: warning: no previous prototype for 'try_to=
_deactivate_task' [-Wmissing-prototypes]
>     6565 | bool try_to_deactivate_task(struct rq *rq, struct task_struct =
*p, unsigned long state)
>          |      ^~~~~~~~~~~~~~~~~~~~~~

Ah, thanks for pointing this out. Switched it to being static.

thanks
-john
