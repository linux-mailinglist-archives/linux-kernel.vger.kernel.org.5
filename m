Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A298081C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377771AbjLGHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjLGHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:20:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B9D53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:20:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d06d4d685aso4123605ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701933647; x=1702538447; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j53nqNU7jMgvgRvYSWrD1Dh7t93e+rnrWj/PotqK0BA=;
        b=MD/BumprF9xqKfB6752eRZ7GFq5+Z+EHobjhRN9QVvWTlCycgN+FjkZhwUstXhzhl7
         yauWSk2aeLHice2vdJvlYjnZCwv9dMbyCdQV5Vyf+I0QXhn8JZjYMYph+PnXLu3BwuCf
         wY9Q7hRq8DnzPdMcmc1KA3/dPjzau/dtue2TOAQMW89ITKqn9O1+DY8lXY7xnBnJch9x
         29buCJZe1/nlC0vZkGyDbTxMQQdMKSRZ6hCDcnPg9cQGZFrBA5Alh3C6JSD9TaVy0kUV
         pjgrKOBfHVkPJ8VauSuGxZSO7vYoQTwtvdRddF0x6YWI9VrcJLHbxMTTui7vYnRP0XZn
         eOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701933647; x=1702538447;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j53nqNU7jMgvgRvYSWrD1Dh7t93e+rnrWj/PotqK0BA=;
        b=eJ5A7CmkK+2ymJKKEAKdi3udiltShWFvknUP6X/3hTCLehFlfo+qGiGbIwkIlx06qJ
         XbtOcwEnelGC858Dz6uUjn9DpedcumMWvmIMpz3abuAeTd0TJA48F58S5vva/8bDwdmp
         T/WN59Wgt4Tw0GZqrHzWIyG7aScP3/VpBQn7ZdtxpDzpS2OzD2jB98jbRqoeZjiWcbtq
         4IEPlmnvNujqo6RmgZSShLx+5sMftG1hRaVRV/WQsxhSdhdv7v8Jm85S+/q6/HNDuezF
         WnMsPuG7k7rEEhR/bmLPEKSjYeHxP445cUbceviUyYIpE5hxLwuVZmlVTe5WJ96d/aip
         kcSQ==
X-Gm-Message-State: AOJu0Yzfd1L1Badp+3SHc6c0rkle/V+tfuK96aQ940evHSu5YzctNdHs
        d0Nv+fqUj+kEqAN6174Oy2WAPw==
X-Google-Smtp-Source: AGHT+IEcHwrgZ609ib1Kc+VIk23LvoQqX7Hw9/y0DIrVmUjiSFR5zAD8EnbsROb67jMnfQsP0p39Qw==
X-Received: by 2002:a17:903:2448:b0:1d0:9416:efec with SMTP id l8-20020a170903244800b001d09416efecmr2048898pls.74.1701933646273;
        Wed, 06 Dec 2023 23:20:46 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001d04c097d32sm624915plf.270.2023.12.06.23.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 23:20:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <9b963af6-0a3f-4957-9227-43673e70b720@nvidia.com>
Date:   Thu, 7 Dec 2023 15:21:44 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
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
Message-Id: <ADCE81A1-D65A-41C4-A485-66E1B056B1CC@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <9b963af6-0a3f-4957-9227-43673e70b720@nvidia.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2023, at 14:53, Chaitanya Kulkarni <chaitanyak@nvidia.com> =
wrote:
>=20
> On 12/6/23 20:31, Li Feng wrote:
>> virtio-blk is generally used in cloud computing scenarios, where the
>> performance of virtual disks is very important. The mq-deadline =
scheduler
>> has a big performance drop compared to none with single queue. In my =
tests,
>> mq-deadline 4k readread iops were 270k compared to 450k for none. So =
here
>> the default scheduler of virtio-blk is set to "none".
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>>=20
>=20
> This patch looks good to me, however I'd update the commit log and add
> performance numbers for the non-mq case also, just in-case to show =
that we
> are not breaking non-mq setup.
>=20
> Being said that, in case we want to be future proof, we can also think =
of
> adding a module param so if someone comes with a scenario where =
NO_SCHED is
> not providing the performance then they can just use the module =
parameter
> instead of again editing the code, irrespective of that :-
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> -ck

Hi ck,

What I put above(450k vs 270k) is the data of single queue(non-mq). I =
think
we don=E2=80=99t need to add module parameters because the scheduler can =
be modified
through sysfs.

Thanks.

>=20
>=20

