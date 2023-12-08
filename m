Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F268B809BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573191AbjLHFyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHFya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:54:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C41171E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:54:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d0a5422c80so15557445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702014874; x=1702619674; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0dJWd9G+sm5E3RRx4cYTh5/x5fCpyDFVWuNoswKM0k=;
        b=P6hMuT+bMGaVO7WgUOyKaJvsPLFHrsxtvlBFuP/hmdQ9jiaCd83/Sz/tm7tMvJIVOX
         +bbFcPhTWtx+Kb2b8B9n88XBNF8C5btadL38D5ErBzhXL+9E3srZ7LlJi2/s9Bo+LgKe
         wb5rmLpVwX6YtbSrsI7ecLqvK4wiLurqORJylR0zsXFg+TsiXx8t51d59yqknlHlQKIF
         dLwlWVOVD95Zf8jFeR0pldXKC+3TqGKXWhuuhVOFZm97yRQgimUcFBPAa/DzCBMqBAf7
         MYjFqM/J7L2ma+apyLA7YQ+10NlVkx0yyLtwLIcxVERiMNCEBNnlIqRa1PJ586irRNKm
         1Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014874; x=1702619674;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0dJWd9G+sm5E3RRx4cYTh5/x5fCpyDFVWuNoswKM0k=;
        b=fXv7s0keNflRp1KhC/mQR5Ve+RyNiEKGVOweodY4KUutUf2hOaFNQFnwNwLSL6ilv4
         zRTjoWAvSJJlbTXWDZJyvwCzGDP8I4jhXh+Cl4ielYhIzj2QM9wL+rPx+pE74ZYbj8bI
         ha39jjkCbClhDkPUuZq7O1H1wGjeYQMeDBX+r0CF1XCpd+zqWiFuK68VLIhQRZUEtOjz
         7Q03EjfqIqf4xcM3+JGU0mWMYHQbcyzZg5U6v5dejppSHapku+80D23bjqjD7/bHEOR+
         VmwE9r8QhXaMHrW5bMaq9esghmTiJe94e7e1HfW4bL4fscLJJ7iM7cqyQCVIP2B5o/05
         Nwew==
X-Gm-Message-State: AOJu0Yx+dmCzZvSJf/tv05IvBXFvuF76A9MRphJbmYMXez+esL7fD/UX
        QYjBjlFiqW63BHBm4uswLVMe1A==
X-Google-Smtp-Source: AGHT+IG/aBWwa8v3wyUG5zePLSh6SqSTaYGzLjkN7YAm5Eja/8NJYSXXBjxt3VFtC5jAU259MbuMeQ==
X-Received: by 2002:a17:902:7887:b0:1d1:cdb2:a93c with SMTP id q7-20020a170902788700b001d1cdb2a93cmr3319986pll.130.1702014873548;
        Thu, 07 Dec 2023 21:54:33 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001d0b0353a92sm784275pls.304.2023.12.07.21.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 21:54:33 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <ZXKTW7z3UH1kPvod@fedora>
Date:   Fri, 8 Dec 2023 13:55:30 +0800
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <ZXJ4xNawrSRem2qe@fedora> <ZXKDFdzXN4xQAuBm@kbusch-mbp>
 <ZXKTW7z3UH1kPvod@fedora>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have ran all io pattern on my another host.
Notes:
q1 means fio iodepth =3D 1
j1 means fio num jobs =3D 1

VCPU =3D 4, VMEM =3D 2GiB, fio using directio.

The results of most jobs are better than the deadline, and some are =
lower than the deadline=E3=80=82


pattern                        |  iops(mq-deadline)    | iops(none)      =
 | diff
:-                             | -:                    | -:              =
 | -:
4k-randread-q1-j1              | 12325             |	 13356      	=
|8.37%
256k-randread-q1-j1            | 1865              |	 1883       	=
|0.97%
4k-randread-q128-j1            | 204739            |	 319066     	=
|55.84%
256k-randread-q128-j1          | 24257             |	 22851      	=
|-5.80%
4k-randwrite-q1-j1             | 9923              |	 10163      	=
|2.42%
256k-randwrite-q1-j1           | 2762              |	 2833       	=
|2.57%
4k-randwrite-q128-j1           | 137400            |	 152081     	=
|10.68%
256k-randwrite-q128-j1         | 9353              |	 9233       	=
|-1.28%
4k-read-q1-j1                  | 21499             |	 22223      	=
|3.37%
256k-read-q1-j1                | 1919              |	 1951       	=
|1.67%
4k-read-q128-j1                | 158806            |	 345269     	=
|117.42%
256k-read-q128-j1              | 18918             |	 23710      	=
|25.33%
4k-write-q1-j1                 | 10120             |	 10262      	=
|1.40%
256k-write-q1-j1               | 2779              |	 2744       	=
|-1.26%
4k-write-q128-j1               | 47576             |	 209236     	=
|339.79%
256k-write-q128-j1             | 9199              |	 9337       	=
|1.50%
4k-randread-q1-j2              | 24238             |	 25478      	=
|5.12%
256k-randread-q1-j2            | 3656              |	 3649       	=
|-0.19%
4k-randread-q128-j2            | 390090            |	 577300     	=
|47.99%
256k-randread-q128-j2          | 21992             |	 23437      	=
|6.57%
4k-randwrite-q1-j2             | 17096             |	 18112      	=
|5.94%
256k-randwrite-q1-j2           | 5188              |	 4914       	=
|-5.28%
4k-randwrite-q128-j2           | 143373            |	 140560     	=
|-1.96%
256k-randwrite-q128-j2         | 9423              |	 9314       	=
|-1.16%
4k-read-q1-j2                  | 36890             |	 31768      	=
|-13.88%
256k-read-q1-j2                | 3708              |	 4028       	=
|8.63%
4k-read-q128-j2                | 399500            |	 409857     	=
|2.59%
256k-read-q128-j2              | 19360             |	 21467      	=
|10.88%
4k-write-q1-j2                 | 17786             |	 18519      	=
|4.12%
256k-write-q1-j2               | 4756              |	 5035       	=
|5.87%
4k-write-q128-j2               | 175756            |	 159109     	=
|-9.47%
256k-write-q128-j2             | 9292              |	 9293       	=
|0.01%

> On Dec 8, 2023, at 11:54, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Thu, Dec 07, 2023 at 07:44:37PM -0700, Keith Busch wrote:
>> On Fri, Dec 08, 2023 at 10:00:36AM +0800, Ming Lei wrote:
>>> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
>>>> virtio-blk is generally used in cloud computing scenarios, where =
the
>>>> performance of virtual disks is very important. The mq-deadline =
scheduler
>>>> has a big performance drop compared to none with single queue. In =
my tests,
>>>> mq-deadline 4k readread iops were 270k compared to 450k for none. =
So here
>>>> the default scheduler of virtio-blk is set to "none".
>>>=20
>>> The test result shows you may not test HDD. backing of virtio-blk.
>>>=20
>>> none can lose IO merge capability more or less, so probably =
sequential IO perf
>>> drops in case of HDD backing.
>>=20
>> More of a curiosity, as I don't immediately even have an HDD to test
>> with! Isn't it more useful for the host providing the backing HDD use =
an
>> appropriate IO scheduler? virtio-blk has similiarities with a =
stacking
>> block driver, and we usually don't need to stack IO schedulers.
>=20
> dm-rq actually uses IO scheduler at high layer, and early merge has =
some
> benefits:
>=20
> 1) virtio-blk inflight requests are reduced, so less chance to =
throttle
> inside VM, meantime less IOs(bigger size) are handled by QEMU, and =
submitted
> to host side queue.
>=20
> 2) early merge in VM is cheap than host side, since there can be more =
block
> IOs originated from different virtio-blk/scsi devices at the same time =
and
> all images can be stored in single disk, then these IOs become =
interleaved in
> host side queue, so sequential IO may become random or hard to merge.
>=20
> As Jens mentioned, it needs actual test.
>=20
>=20
> Thanks,
> Ming
>=20

