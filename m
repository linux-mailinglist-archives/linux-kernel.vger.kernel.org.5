Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8540808F08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443451AbjLGRhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443464AbjLGRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:37:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE31710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:37:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE67C433CA;
        Thu,  7 Dec 2023 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701970665;
        bh=3sD3ogk0NVpfU+VklXA2R5FUXoYkr9sHh9QdJwrb4lM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sp+8mrnjzS0mh8ZWo/b1VT7M7xanGjzrL4R3/XA1w/JAYje7CiSLb5pRkhwIQah6g
         LFA8wuhDBjy/4X1vGOgNrRuuAWkkJD6iae8Jescm6zG++r8bGmwwhSaWBQfP5/wB1L
         KR0KzPYFBj+fgtYbZnOhUjiUPiXQSr2c8kER503VXVvoqzbtDmlIW+qV8Y5GNMgJrr
         Lqa6l4kKHheSHZgybaBDkR1+Vjuwcoj51Y1k8zsYOVF5kTcrU6Jc+V9dqf6T0kXJwn
         BTyvDIxNo60IizDKOgFk+D6R0BhGw9nRmoDGrM7ghTPtkVry6iNmpHdtxECQOUaSCM
         zwZN8q56cnHrQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bfd7be487so1237430e87.0;
        Thu, 07 Dec 2023 09:37:45 -0800 (PST)
X-Gm-Message-State: AOJu0YyHbZdQPuOgsdKs6Yp2yOMGeIaH+KAwE0Yaofo061MANnntZfIs
        k4JB58tM3flslq6ZmU05VJc6AdiGfQrtixuxro4=
X-Google-Smtp-Source: AGHT+IGnhB2V4T9wS2G8joBMZDTQ2ugpnSkGBO4NIT3rKkY72x3w4bHhZdGuY04nqk011RmddRW8kyBMrqTVy7c5eeE=
X-Received: by 2002:a05:6512:3da1:b0:50b:f9b2:cf2 with SMTP id
 k33-20020a0565123da100b0050bf9b20cf2mr2182723lfv.40.1701970663497; Thu, 07
 Dec 2023 09:37:43 -0800 (PST)
MIME-Version: 1.0
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me> <be56b5df-fef8-4dbe-bb98-f6370a692d6e@sapience.com>
 <714b22c7-b8dd-008d-a1ea-a184dc8ec1cf@linux.dev> <c866bcfa-85cc-44fb-9b54-bb4840f588e6@sapience.com>
In-Reply-To: <c866bcfa-85cc-44fb-9b54-bb4840f588e6@sapience.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Dec 2023 09:37:32 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4Cu5DdxZtZDbwLJ85oUpN9prS78Rr9UeFtgx88OGxUcA@mail.gmail.com>
Message-ID: <CAPhsuW4Cu5DdxZtZDbwLJ85oUpN9prS78Rr9UeFtgx88OGxUcA@mail.gmail.com>
Subject: Re: md raid6 oops in 6.6.4 stable
To:     Genes Lists <lists@sapience.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, snitzer@kernel.org,
        yukuai3@huawei.com, axboe@kernel.dk, mpatocka@redhat.com,
        heinzm@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bhanu Victor DiCara <00bvd0+linux@gmail.com>,
        Xiao Ni <xni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Thu, Dec 7, 2023 at 7:58=E2=80=AFAM Genes Lists <lists@sapience.com> wro=
te:
>
> On 12/7/23 09:42, Guoqing Jiang wrote:
> > Hi,
> >
> > On 12/7/23 21:55, Genes Lists wrote:
> >> On 12/7/23 08:30, Bagas Sanjaya wrote:
> >>> On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
> >>>> I have not had chance to git bisect this but since it happened in
> >>>> stable I
> >>>> thought it was important to share sooner than later.
> >>>>
> >>>> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
> >>>>
> >>>>    commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
> >>>>    Author: Song Liu <song@kernel.org>
> >>>>    Date:   Fri Nov 17 15:56:30 2023 -0800
> >>>>
> >>>>      md: fix bi_status reporting in md_end_clone_io
> >>>>
> >>>> log attached shows page_fault_oops.
> >>>> Machine was up for 3 days before crash happened.
> >
> > Could you decode the oops (I can't find it in lore for some reason)
> > ([1])? And
> > can it be reproduced reliably? If so, pls share the reproduce step.
> >
> > [1]. https://lwn.net/Articles/592724/
> >
> > Thanks,
> > Guoqing
>
>    - reproducing
>      An rsync runs 2 x / day. It copies to this server from another. The
> copy is from a (large) top level directory. On the 3rd day after booting
> 6.6.4,  the second of these rysnc's triggered the oops. I need to do
> more testing to see if I can reliably reproduce. I have not seen this
> oops on earlier stable kernels.
>
>    - decoding oops with scripts/decode_stacktrace.sh had errors :
>     readelf: Error: Not an ELF file - it has the wrong magic bytes at
> the start
>
>     It appears that the decode script doesn't handle compressed modules.
>   I changed the readelf line to decompress first. This fixes the above
> script complaint and the result is attached.

I probably missed something, but I really don't think the commit
(2c975b0b8b11f1ffb1ed538609e2c89d8abf800e) could trigger this issue.

From the trace:

  kernel: RIP: 0010:update_io_ticks+0x2c/0x60
    =3D>
       2a:* f0 48 0f b1 77 28     lock cmpxchg %rsi,0x28(%rdi)  << trapped =
here.
  [...]
  kernel: Call Trace:
  kernel:  <TASK>
  kernel:  ? __die+0x23/0x70
  kernel:  ? page_fault_oops+0x171/0x4e0
  kernel:  ? exc_page_fault+0x175/0x180
  kernel:  ? asm_exc_page_fault+0x26/0x30
  kernel:  ? update_io_ticks+0x2c/0x60
  kernel:  bdev_end_io_acct+0x63/0x160
  kernel:  md_end_clone_io+0x75/0xa0     <<< change in md_end_clone_io

The commit only changes how we update bi_status. But bi_status was not
used/checked at all between md_end_clone_io and the trap (lock cmpxchg).
Did I miss something?

Given the issue takes very long to reproduce. Maybe we have the issue
before 6.6.4?

Thanks,
Song
