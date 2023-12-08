Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC380A1D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573752AbjLHLHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjLHLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5B122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702033668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZ68z0Zmw8ZgsbDmEzD6URQldfv+XNMK6DMNEIcDVTU=;
        b=VVfgRTVEmjt5/W/rfuPGjVr0mhe+P+K3ZvtHwgTbd0BbvJV8+K+ggLoPJaff4DLpyp/ull
        z9HkWV46iV1trBZs3Igf2U58SBRe4ZwW0ZrY49Rr2Nzx/9VfJqBLjS2SzAF8MdpP8UrKxy
        kdWCrpAM9xrN0aiurngFb8RBsJawtCA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-7PJmhRINPAOYbJsLYZ8_bg-1; Fri, 08 Dec 2023 06:07:46 -0500
X-MC-Unique: 7PJmhRINPAOYbJsLYZ8_bg-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b309d9aad0so534521e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033666; x=1702638466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ68z0Zmw8ZgsbDmEzD6URQldfv+XNMK6DMNEIcDVTU=;
        b=Op5Y9c6zp9qOvDjW9Ol2I+z6DK1D4R3j3e/+sYI8iUqBCyGXTU2BmPeYvKvsi+Irms
         efkZPNk1J2Yk+FWiVN/rVGUQ4V/9Fe+rS69r/q6WKu50U2QDpIcaHfXibz7fp8aCNZgj
         Njmgm3KhMxdbV+NM6+6EVeJzY6tH7VWN8dNh+tcu+bFbYvRy5fxMXk3z6vt/6pcWpJWI
         zGh+dc+OoUuL1Blw+zwpFPEs3l1CHXhCWXwOaF4vbBuqZiZKddQyAVmlaEErNJRXu4Es
         4SGE+a2QaaxfaG6HDgxXyfzHYORiW5qD0hDG9aGRNA6cKN7BemjmKAp44J4YHGOVWSxL
         HCIA==
X-Gm-Message-State: AOJu0YzUXYQNn7T2XekIDD4BuyPHqd04rfeuEwl+U1A5Q6DVbK6g2/p2
        ZyztT4LpHhaAY03Yv8MXtIMXiI1aZZMjfbJOFWBi3oUO8LiW8EjH2rJg1tEuqxFhuyFl6zj2Z/S
        KNa8wey17mAy4yojwAjOupqGJAJa9LavwQFeYgOwN
X-Received: by 2002:a05:6122:2a49:b0:4b2:891e:225a with SMTP id fx9-20020a0561222a4900b004b2891e225amr5351322vkb.11.1702033666412;
        Fri, 08 Dec 2023 03:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrUEvJUaFrYyr5PGOydD15wueB/vwO/OYhbev5UD7asruhM4Q4Ek5B68h+qhR0sIfIIlM2RUFm2TU+UMtSssA=
X-Received: by 2002:a05:6122:2a49:b0:4b2:891e:225a with SMTP id
 fx9-20020a0561222a4900b004b2891e225amr5351317vkb.11.1702033666140; Fri, 08
 Dec 2023 03:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <ZXJ4xNawrSRem2qe@fedora>
 <ZXKDFdzXN4xQAuBm@kbusch-mbp> <ZXKTW7z3UH1kPvod@fedora> <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
In-Reply-To: <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 8 Dec 2023 12:07:33 +0100
Message-ID: <CABgObfatL_NaPxU4RmmGsx9rz=8EVkpro=7Tpw_nLjKguzMDUQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To:     Li Feng <fengli@smartx.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 6:54=E2=80=AFAM Li Feng <fengli@smartx.com> wrote:
>
>
> Hi,
>
> I have ran all io pattern on my another host.
> Notes:
> q1 means fio iodepth =3D 1
> j1 means fio num jobs =3D 1
>
> VCPU =3D 4, VMEM =3D 2GiB, fio using directio.
>
> The results of most jobs are better than the deadline, and some are lower=
 than the deadline=E3=80=82

I think this analysis is a bit simplistic. In particular:

For low queue depth improvements are relatively small but we also have
the worst cases:

4k-randread-q1-j1      |    12325  |     13356  |   8.37%
256k-randread-q1-j1    |     1865  |      1883  |   0.97%
4k-randwrite-q1-j1     |     9923  |     10163  |   2.42%
256k-randwrite-q1-j1   |     2762  |      2833  |   2.57%
4k-read-q1-j1          |    21499  |     22223  |   3.37%
256k-read-q1-j1        |     1919  |      1951  |   1.67%
4k-write-q1-j1         |    10120  |     10262  |   1.40%
256k-write-q1-j1       |     2779  |      2744  |  -1.26%
4k-randread-q1-j2      |    24238  |     25478  |   5.12%
256k-randread-q1-j2    |     3656  |      3649  |  -0.19%
4k-randwrite-q1-j2     |    17096  |     18112  |   5.94%
256k-randwrite-q1-j2   |     5188  |      4914  |  -5.28%
4k-read-q1-j2          |    36890  |     31768  | -13.88%
256k-read-q1-j2        |     3708  |      4028  |   8.63%
4k-write-q1-j2         |    17786  |     18519  |   4.12%
256k-write-q1-j2       |     4756  |      5035  |   5.87%

(I ran a paired t-test and it confirms that the improvements overall
are not statistically significant).

Small, high queue depth I/O is where the improvements are definitely
significant, but even then the scheduler seems to help in the j2 case:

4k-randread-q128-j1    |   204739  |    319066  |  55.84%
4k-randwrite-q128-j1   |   137400  |    152081  |  10.68%
4k-read-q128-j1        |   158806  |    345269  | 117.42%
4k-write-q128-j1       |    47576  |    209236  | 339.79%
4k-randread-q128-j2    |   390090  |    577300  |  47.99%
4k-randwrite-q128-j2   |   143373  |    140560  |  -1.96%
4k-read-q128-j2        |   399500  |    409857  |   2.59%
4k-write-q128-j2       |   175756  |    159109  |  -9.47%

At higher sizes, even high queue depth results have high variability.
There are clear improvements for sequential reads, but not so much for
everything else:

256k-randread-q128-j1  |    24257  |     22851  |  -5.80%
256k-randwrite-q128-j1 |     9353  |      9233  |  -1.28%
256k-read-q128-j1      |    18918  |     23710  |  25.33%
256k-write-q128-j1     |     9199  |      9337  |   1.50%
256k-randread-q128-j2  |    21992  |     23437  |   6.57%
256k-randwrite-q128-j2 |     9423  |      9314  |  -1.16%
256k-read-q128-j2      |    19360  |     21467  |  10.88%
256k-write-q128-j2     |     9292  |      9293  |   0.01%

I would focus on small I/O with varying queue depths, to understand at
which point the performance starts to improve; queue depth of 128 may
not be representative of common usage, especially high queue depth
*sequential* access which is where the biggest effects are visibie.
Maybe you can look at improvements in the scheduler instead?

Paolo

