Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E977DB338
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjJ3G3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3G32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:29:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4AAB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:29:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50917cd6d6eso2241e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698647364; x=1699252164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzVHmjEI+YpEe4gZLECBFUB4/fthvdQpMU6WpBuzUV0=;
        b=KjESlcO0g4o7IpYQhSZpDNTE5vfv1v1m1tmoJ/14crc9m18CMtgf/A1BpRDPldgDRY
         +el+PQn5YjW0goEbdseq4MPE8XV9/B7vmXhOcOj6X05m5Gi2g7VHUW5cF4m2AUVSD/w1
         ye+zo9X880Bo++vUlJ3EOfdxS0KpYpKecPAkYJUhmZWBzYU/HlWsN/HNa+47iqIiMmU4
         FELmTA5expLe37hoGR2JKEAQTQbcTOoeGAi5fmKGeBfyKLl0pOFewq2k0Ep7vysElD93
         ac2bOmkmax4XCxwp/HU+ZGgFAJIPo3ce9IjEcnE7XXxYU299H7pRose3uzJBHOf73C0t
         EmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698647364; x=1699252164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzVHmjEI+YpEe4gZLECBFUB4/fthvdQpMU6WpBuzUV0=;
        b=Bd6FfKTtuT/EGUuAqYAbybhiybo6ibvPSqNZWgUcWcdQbO7dmsRkjqN31bGfR9wdWn
         xTBIR+LG5maDHEkhwVURt9VLTNGauML84DMVjklTyPGIabo/CJozStpqUAYwHi1bb7s7
         rdD6aIT3C0g9Kg3gjj42lCCM2vYae7sWsTeHms8CEhGeR91TKBDBxlWwDyW2kISmDQ0/
         pa2JzpcZ2wDv15QT/ggkjgvBXLlTJQ8prATyiB//ibdMddsJRmtLBEXG2z2MdbBo4X2d
         NucSvr3p43o0RiecdGXB0pFw01/UGoXcpMBHv5GAAAyRDkegu1vfScJHiXBjMbx/hYdQ
         ONQw==
X-Gm-Message-State: AOJu0Yz8A7tuRIMv0qpz37Wtu9dN047b4/eu0Yj5wXfErZlKTM9z40nG
        +FfqfHa2NmayhixAzjpilrz95yg0maGmlS15xlgmeA==
X-Google-Smtp-Source: AGHT+IGNd8Zyh1SuuCCalJuqfkJij1W8Z950z1DL0BW7grGmSYMkrmd9YuoBi5W65KCG6eZKQxoa4NdSsGzWynyaMVE=
X-Received: by 2002:ac2:4e85:0:b0:501:b029:1a47 with SMTP id
 o5-20020ac24e85000000b00501b0291a47mr58180lfr.1.1698647363870; Sun, 29 Oct
 2023 23:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com> <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Oct 2023 07:29:10 +0100
Message-ID: <CACT4Y+a+xfzXBgqVz3Gxv4Ri1CqHTV1m=i=h4j5KWxsmdP+t5A@mail.gmail.com>
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN report
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>, ryabinin.a.a@gmail.com,
        glider@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 at 10:05, Juntong Deng <juntong.deng@outlook.com> wrote=
:
>
> On 2023/10/26 3:22, Andrey Konovalov wrote:
> > On Tue, Oct 17, 2023 at 9:40=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> The idea came from the bug I was fixing recently,
> >> 'KASAN: slab-use-after-free Read in tls_encrypt_done'.
> >>
> >> This bug is caused by subtle race condition, where the data structure
> >> is freed early on another CPU, resulting in use-after-free.
> >>
> >> Like this bug, some of the use-after-free bugs are caused by race
> >> condition, but it is not easy to quickly conclude that the cause of th=
e
> >> use-after-free is race condition if only looking at the stack trace.
> >>
> >> I did not think this use-after-free was caused by race condition at th=
e
> >> beginning, it took me some time to read the source code carefully and
> >> think about it to determine that it was caused by race condition.
> >>
> >> By adding timestamps for Allocation, Free, and Error to the KASAN
> >> report, it will be much easier to determine if use-after-free is
> >> caused by race condition.
> >
> > An alternative would be to add the CPU number to the alloc/free stack
> > traces. Something like:
> >
> > Allocated by task 42 on CPU 2:
> > (stack trace)
> >
> > The bad access stack trace already prints the CPU number.
>
> Yes, that is a great idea and the CPU number would help a lot.
>
> But I think the CPU number cannot completely replace the free timestamp,
> because some freeing really should be done at another CPU.
>
> We need the free timestamp to help us distinguish whether it was freed
> a long time ago or whether it was caused to be freed during the
> current operation.
>
> I think both the CPU number and the timestamp should be displayed, more
> information would help us find the real cause of the error faster.
>
> Should I implement these features?

Hi Juntong,

There is also an aspect of memory consumption. KASAN headers increase
the size of every heap object. So we tried to keep them as compact as
possible. At some point CPU numbers and timestamps (IIRC) were already
part of the header, but we removed them to shrink the header to 16
bytes.
PID gives a good approximation of potential races. I usually look at
PIDs to understand if it's a "plain old single-threaded
use-after-free", or free and access happened in different threads.
Re timestamps, I see you referenced a syzbot report. With syzkaller
most timestamps will be very close even for non-racing case.
So if this is added, this should be added at least under a separate config.

If you are looking for potential KASAN improvements, here is a good list:
https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&component=3DS=
anitizers&list_id=3D1134168&product=3DMemory%20Management
