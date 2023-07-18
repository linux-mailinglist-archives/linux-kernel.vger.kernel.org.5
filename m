Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB7757FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGROgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGROga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07410E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689690942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhLLlJe15TTGeGNUnSwUWGBDLVxxR5vwYDItCmzrLcY=;
        b=ZBcKip50M7tjTzNoP1WORgeKsFCx0xiQIKOG2/g0QldXfmAz9MoQk3TV2l832m+5cFoXVN
        XMWxQf66xOT7CnXKjTCY3HyzavSqo3BCoePbDZJ1h3wi3calJsq7gS/me/yAj1Qj8ClHwq
        +56Dgg5bnddwlQo36Y0YTGaPSTlIbcg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-U1b4gpFyM_aqRkA2L3CB9A-1; Tue, 18 Jul 2023 10:35:31 -0400
X-MC-Unique: U1b4gpFyM_aqRkA2L3CB9A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b710c5677eso54768311fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690920; x=1692282920;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhLLlJe15TTGeGNUnSwUWGBDLVxxR5vwYDItCmzrLcY=;
        b=kMkkEZq2bh5Q/fhLPzfK7NVz3JqDxUaoxQfoWWF4PTDH1r/baow/cvpl421CX7JD2K
         /27CigBwIR4AFVWkgzcspt1QWnQJSJ+2yorZZJZ6mYNabHMWbJDu0hFThkXtAKTfn/Tw
         b5wLNsUpINdSEHECm/SWbFxT6/0g8pddFf3b+gpg4b1Oj81MClTYBWe6n56dTUOJd1ie
         G7xMZRRU+j/XIlhh4l8b5gFBP0K6brkhJH9vX4r0SabI4TQMHgg+zlM+ishkeUivF9pH
         HEffzygWZUxivAdqnk0cqtjf1OetTFbpVwaULrpEFVHvxIlh4nn7BIOzKjhWj3CBWxyv
         qCgQ==
X-Gm-Message-State: ABy/qLbSr3uq6LLxsIk5Yze5mPE1i7S5QbZW8liXu0vLSbjD8aAYgMQA
        C7uYxUnZBw15hIwKjnkzZ5hvFm/hmQxa9xw9dNwXFEGuYfTahmJUuPfFI5Br1E8fGH1kGxlsFiy
        ekJiJnGQT667pnO6gT9rSIo4x
X-Received: by 2002:a2e:868e:0:b0:2b8:377a:22f1 with SMTP id l14-20020a2e868e000000b002b8377a22f1mr9986044lji.32.1689690920142;
        Tue, 18 Jul 2023 07:35:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFh3f5eIawq1YhuGmmxtzjX/DeBV50+gIIA66BFvkRE+KbRquEb54gkOF2kq30UeW3hYmvAvw==
X-Received: by 2002:a2e:868e:0:b0:2b8:377a:22f1 with SMTP id l14-20020a2e868e000000b002b8377a22f1mr9986025lji.32.1689690919757;
        Tue, 18 Jul 2023 07:35:19 -0700 (PDT)
Received: from nuthatch (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b0098f99048053sm1115217eji.148.2023.07.18.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:35:19 -0700 (PDT)
From:   Milan Zamazal <mzamazal@redhat.com>
To:     Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: core: Prevent invalid memory access when there is
 no parent
References: <20230718120700.132579-1-mzamazal@redhat.com>
        <4a5d6ca0e2c9529d5eb0bbacbaed56e2645719c6.camel@gmail.com>
Date:   Tue, 18 Jul 2023 16:35:18 +0200
In-Reply-To: <4a5d6ca0e2c9529d5eb0bbacbaed56e2645719c6.camel@gmail.com>
 ("Nuno
        =?utf-8?Q?S=C3=A1=22's?= message of "Tue, 18 Jul 2023 15:10:07 +0200")
Message-ID: <87lefdcmop.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

> On Tue, 2023-07-18 at 14:07 +0200, Milan Zamazal wrote:
>> Commit 813665564b3d ("iio: core: Convert to use firmware node handle
>> instead of OF node") switched the kind of nodes to use for label
>
>> retrieval in device registration.=C2=A0 Probably an unwanted change in t=
hat
>> commit was that if the device has no parent then NULL pointer is
>> accessed.=C2=A0 This is what happens in the stock IIO dummy driver when a
>> new entry is created in configfs:
>>=20
>> =C2=A0 # mkdir /sys/kernel/config/iio/devices/dummy/foo
>> =C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000000278
>> =C2=A0 ...
>> =C2=A0 ? asm_exc_page_fault+0x22/0x30
>> =C2=A0 ? container_offline+0x20/0x20
>> =C2=A0 __iio_device_register+0x45/0xc10
>> =C2=A0 ? krealloc+0x73/0xa0
>> =C2=A0 ? iio_device_attach_buffer+0x31/0xc0
>> =C2=A0 ? iio_simple_dummy_configure_buffer+0x20/0x20
>> =C2=A0 ? iio_triggered_buffer_setup_ext+0xb4/0x100
>> =C2=A0 iio_dummy_probe+0x112/0x190
>> =C2=A0 iio_sw_device_create+0xa8/0xd0
>> =C2=A0 device_make_group+0xe/0x40
>> =C2=A0 configfs_mkdir+0x1a6/0x440
>>=20
>> Since there seems to be no reason to make a parent device of an IIO
>> dummy device mandatory, let=E2=80=99s prevent the invalid memory access =
in
>> __iio_device_register when the parent device is NULL.=C2=A0 With this
>> change, the IIO dummy driver works fine with configfs.
>>=20
>> Fixes: 813665564b3d ("iio: core: Convert to use firmware node handle ins=
tead
>> of OF node")
>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>> ---
>
> LGTM (just one minor question below...)
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
>> =C2=A0drivers/iio/industrialio-core.c | 11 ++++++-----
>> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-=
core.c
>> index c117f50d0cf3..229527b3434a 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1888,7 +1888,7 @@ static const struct iio_buffer_setup_ops
>> noop_ring_setup_ops;
>> =C2=A0int __iio_device_register(struct iio_dev *indio_dev, struct module=
 *this_mod)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev_opaque *i=
io_dev_opaque =3D to_iio_dev_opaque(indio_dev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode =
=3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!indio_dev->info)
>> @@ -1899,11 +1899,12 @@ int __iio_device_register(struct iio_dev *indio_=
dev,
>> struct module *this_mod)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* If the calling driver=
 did not initialize firmware node, do it here
>> */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev_fwnode(&indio_de=
v->dev))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fwnode =3D dev_fwnode(&indio_dev->dev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (indio_dev->dev.paren=
t !=3D NULL)
>
> Maybe this is odd enough that it could have an explicit comment referenci=
ng the
> iio-dummy device?=20

Good idea, also to not forget about iio-dummy generally.  I'll add it.

> Not sure if there's any other place where this can actually happen...
>
> Apparently there are also some dev_err() on the parent device (even though
> dev_err() handles it) but yeah, unrelated with this.
>
>
> - Nuno S=C3=A1

