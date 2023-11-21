Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C937F24BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjKUECQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:02:12 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC76BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:02:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso4132908a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700539329; x=1701144129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Alddf/rfwkWuk73xrqt9x2cn9i/amVeo+Vu17tmfqls=;
        b=K1AYMHurLKjvxH+ZwpeJjQfrjdPjwLYYCWTfHNWHQpssW3C2FTaPcUlyv/wmhqKsxy
         /ouCOWWFQi1N7fTYXmgWby8U9UsZYMgkNp0qpgrlEOpJyg11LstQQMF4HRSOgXyFL+d9
         80aI10HvfRdo/0TRDuJaqLswg0O3BR5wySK4sgFGwaaQjpdetH7X04l4f7eOFUT8QL2D
         uVf38ZQLGnZFFRVKQMcT/iWOyR2irPmHqLNyMHhZ5OqD86a4aWAt8s0O1lzqfTynRsit
         NgB48ioRTZR2k2N5dnpiZXWDeQBsXWYyj88rrEWSoMEfTsw0xuGnzEwkF+v9ISyQPkXh
         B6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700539329; x=1701144129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alddf/rfwkWuk73xrqt9x2cn9i/amVeo+Vu17tmfqls=;
        b=OkwRQFwn5fLzr5X0wNpsGUCVHYNgs3UaMYFmNhTS70HEAQ+4vQvdoJeb/g+mwT4IwV
         0oFX+x8jtY+MSeUIklEz/zsodFPhRM8z8CwUxNOnpHAv5p3Xv0Hn1ireueotGXu4jwx6
         s8jmB9uwEpYd9RUgReZyqcKGmGYZwBIKWG374VRDFDAkPU3fsPbmpfI+JLhqq6EPPZIK
         9ol1bGaWM+8PzZ/MpGkqRnFw0YJxSregCb+OqSAq4GDrE+kr4MbEEcYwo96XT0vcS/nq
         a1bhVxs4aWJ5t9fpHUxFhZ0MRR1svba39N5WDrqvv5wgkTqgrzXUZ5/d7dDg9fQ2knZU
         qbMQ==
X-Gm-Message-State: AOJu0Yxnswh8RGbdLtZM226HasBAPJhUTjCMxnNidvzIwuHIx3io5yVK
        fCUqiZJdGFgNMlC0s1+0p18ydUDHWY6//S/zcR8=
X-Google-Smtp-Source: AGHT+IGNmQam00kiTPR9dc3DdUnBMVg1na3qetNi9zgurXE6FlpBpUkAjxGctybkYdkNqLUj5eJEp4y29GefjULwjTY=
X-Received: by 2002:a17:90a:4941:b0:27d:a0e5:2a67 with SMTP id
 c59-20020a17090a494100b0027da0e52a67mr9452482pjh.18.1700539328767; Mon, 20
 Nov 2023 20:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20231120121623.119780-1-alexyonghe@tencent.com> <ZVuudtAtDqHqYJr8@slm.duckdns.org>
In-Reply-To: <ZVuudtAtDqHqYJr8@slm.duckdns.org>
From:   zhuangel570 <zhuangel570@gmail.com>
Date:   Tue, 21 Nov 2023 12:01:56 +0800
Message-ID: <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: fix invalid cpu in kick_pool
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I have uploaded my configuration and console logs to the following
links, please check.

https://raw.githubusercontent.com/zhuangel/misc/main/debug/workqueue/consol=
e.log
https://raw.githubusercontent.com/zhuangel/misc/main/debug/workqueue/config=
-6.7.rc1
https://raw.githubusercontent.com/zhuangel/misc/main/debug/workqueue/config=
-4.18.0-348.el8.x86_64

The issue was first discovered in my BM machine and for ease of debugging,
I ran a virtual machine of the same case and reproduced it. My test virtual
machine was installed from centos 8.5.2111 DVD (origin kernel is 4.18.0-348=
)
and then the kernel was updated from the 6.7.rc1 source code. The virtual
machine ran on 4 CPU, 8G memory and some virtio devices.

My investigation show, when "workqueue.unbound_cpus" and "isolcpus" are
configured as same cpuset, this will make the "wq_unbound_cpumask" as an
empty set, when some idle work task try to set "wake_cpu" from
"cpumask_any_distribute", an invalid CPU will be set, then may trigger
panic.

To be honestly, I am not really known why there is a "not-present page"
exception, after I remove "workqueue.unbound_cpus" from command line or
apply this patch to the running kernel, the system could boot successfully.

On Tue, Nov 21, 2023 at 3:07=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Nov 20, 2023 at 08:16:23PM +0800, Yong He wrote:
> > With incorrect unbound workqueue configurations, this may introduce ker=
nel
> > panic, because cpumask_any_distribute() will not always return a valid =
cpu,
> > such as one set the 'isolcpus' and 'workqueue.unbound_cpus' into the sa=
me
> > cpuset, and this will make the @pool->attrs->__pod_cpumask an empty set=
,
> > then trigger panic like this:
>
> This shouldn't have happened. Can you share the configuration and the ful=
l
> dmesg? Let's fix the problem at the source.
>
> Thanks.
>
> --
> tejun



--=20
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94
   zhuangel570
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94
