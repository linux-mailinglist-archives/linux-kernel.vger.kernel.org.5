Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE46D7EFC8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbjKRA2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjKRA2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:28:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5B2D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:28:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so11395e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700267286; x=1700872086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73Tnq90BIIK+bWzVstEpI62VolU0zG+vjIVvtoSbajE=;
        b=YjdjuBTLV+yjUtLYAO+4MkPfoKp4+ZmQriAwSPapoPI0BjJiWpyO8/h5Ec3dOzw8OP
         XgvzfgPksfMJq+SnMfhxTWiMJP87XeisrcLqhhE3eV6PV+nMsQZZTW0YDZ2/gu7tkaZf
         JpTW72vZZJeZdCFtYhDD9ruoofEWDJaPLbsE/2VXPVI9fIuRBWfsl44oRKH8EJPy+3Ba
         gHjCtWPH+c3w/PKdlYJjcn2/hFW5A2CI0gcwOH9D97SDLrDM5NjWTtZkstDX76MwdULG
         atypZBckDasjaWQVjGt2ia13DgeU+CiSNVEuo9yY653MLcYIKiUli7EpCtjv1ocacjiT
         TKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700267286; x=1700872086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73Tnq90BIIK+bWzVstEpI62VolU0zG+vjIVvtoSbajE=;
        b=jwWenoRYH88jQL5/F0AtZjWorOR2e2Pc1Cjhnu0OBOVINoXgwdBPTk+IfzoY9OCl8N
         5LxCOrFVI67TLrnl8R7NOMjAc3Iq0gz3mtK59WW3Nm5jEdAoXYnacJ6x8pwUEcmO935Z
         JK3m6K0wFzRjbtV2KnwaI3DkNvw4PotRV+Orb4kCtkWPZuh+d6KYkMtN7bIFx4Cctg6l
         CxX0WjFsM6eAaXedMfuftrA9CPty89ETsrOShZM1t86I36GflhKMe9Zngfc8eNw6O/R7
         FvIzIUxTaCGdGM1h8FeJBwRwZlS7cP6OvGnSZ/Fbcv59dYotd8/cyB6o9jHzD5PcbOan
         3/NA==
X-Gm-Message-State: AOJu0YyNrjmCF+ocnqCPnln6UzP5wwMj5Rl4U+5yQGdpv4SWsE7uNG4F
        d3VilZ5GHiyFnLd197+STr0ttn8vdsEAqkjkvn1l
X-Google-Smtp-Source: AGHT+IHSq9c3SB879A4Y9X7B/NWEeDJZN+VTUL58zVS4FNEdH+w9beguhDsgVswh9vpjwc0wz4o1URoruZbhe/6DnnU=
X-Received: by 2002:a05:600c:3c8b:b0:3f7:3e85:36a with SMTP id
 bg11-20020a05600c3c8b00b003f73e85036amr201414wmb.7.1700267285667; Fri, 17 Nov
 2023 16:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-16-jstultz@google.com> <202311081028.yDLmCWgr-lkp@intel.com>
In-Reply-To: <202311081028.yDLmCWgr-lkp@intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 17 Nov 2023 16:27:52 -0800
Message-ID: <CANDhNCrT-CRbSZhPtxQ+mD97x6+2C0uE4WsmS-ymPiYewrNviw@mail.gmail.com>
Subject: Re: [PATCH v6 15/20] sched: Add proxy deactivate helper
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:52=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> kernel test robot noticed the following build warnings:
>
...
> >> kernel/sched/core.c:6616:6: warning: no previous prototype for 'proxy_=
deactivate' [-Wmissing-prototypes]
>     6616 | bool proxy_deactivate(struct rq *rq, struct task_struct *next)
>          |      ^~~~~~~~~~~~~~~~


Thank you! I've fixed this up for v7

thanks again
-john
