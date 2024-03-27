Return-Path: <linux-kernel+bounces-120443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5E88D788
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40AC29A914
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C7208A8;
	Wed, 27 Mar 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e67VcMg2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132F2C1A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525384; cv=none; b=e/kOratfFHwG9Zg91cNSSSoyIXotAHXUKZfNKA7t7A3EZ5vDYwwPy2YAmHJCtAM+lMh7xBkY1MkQYRqfMjUNaBFOITnBmiKpgfE0jA5uKB7VWkSP0fxJIf5tFIgUtJ8+oCrTYUGIwOWmDTFHIKYrxGFzt2506dw5irHPppg1fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525384; c=relaxed/simple;
	bh=7EA/daWGnv/NVXm5JJhuA1mge+UvdPLgSdjgIcWOrrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRe/QcgL882ahMDng/yeddbbTMlP5w4Fmt02/jpI4vmIV+xbuV0NfP21/PiMHZ5zgKzWcDHcXjVmwuqefFxR6fVfaQhqH6ld0vgJXMUgCFp++MqVhNJ+zEHTpdPesg72Fiq49x0/SQpLsL9dCKNRR/lGBQ7tdB3TE6/e3nUIRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e67VcMg2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711525381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeymL4z1bCM8IDHscCswoY62GKtZkRs0NUbQj9gofho=;
	b=e67VcMg2fLWmHPQ3LX6vZVn/imgdBzYUICMZj/MkycOpZmMAT/pd3u/GPn0uBNwWRuPjOK
	Lq5/+wjwFLcFzKbXSGSBCgIOPKv5FgIYRSN3jH3xAtU3gCcHKhgtt3ZOi9zDusl4DjeOn1
	KkbKWsFFteUoGepjmGkiykOh5AXsyEQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-Sa3G_OvwMvCEIDtm7PNZcw-1; Wed, 27 Mar 2024 03:42:58 -0400
X-MC-Unique: Sa3G_OvwMvCEIDtm7PNZcw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e6a1625e4bso6315997b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525378; x=1712130178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeymL4z1bCM8IDHscCswoY62GKtZkRs0NUbQj9gofho=;
        b=Jx2/4PcdGXGeRnWS1HZThZQ9hvHSE4c899zFkSt5keCXylHgMc8eJgzb9l+opwultq
         MC7JDUsUz8iF6YhvysO+H92ilBWiT39/gtNGtUqGTg+OHl1xVnLEDeHOGb4o+KhDsUYH
         WxhK/+FUsK602g4aw5r072tF2aegBcpI3VvtDgQuLluzdmEH017s6t+iliGLu+lwu/Jr
         wIpX2iJjb02MZv9aT6V2W03LdEAXS6wM7k8pLciYaC0RIHAj8s4re2Khox9d78dju7+d
         lO8FMgEEuARn1faFkj9DoM8BX1raTMubIWDa2f+xuW2XsNNDKiN0fbOth0cLNosPodOp
         fNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxwALfT77dRHd1JoGHhaZZ5hUVZtvXl89tg9AJrgBhGNzxZgfawstU2lnNz6/OpkLH+oadsIbBX0urobk1qNeNqONOCPBnwdimmG1v
X-Gm-Message-State: AOJu0YxGBHjK8cyKBnJmH3jXm9YgmHfkJ7bdCiJsqPHVkCEgJxHFa6gI
	ptYsljXzmSCT/AMZ2iON4rw2LtttKnN5jTDdfCI9DIN4BxTroKfkvdolrAwyYzsS9JHw2njl+tB
	yj6699qogKtfJZldAA2dEjArRCrp6aeuXPBdsnp8EEdcumvJkcBeXRFVM8e6T6GEy0Vr56P9+qz
	UwIUprECMn5udA9GrYbUrw/uA1V9osrQ+jY6br
X-Received: by 2002:a05:6a00:2e08:b0:6ea:c501:b264 with SMTP id fc8-20020a056a002e0800b006eac501b264mr2452230pfb.18.1711525377856;
        Wed, 27 Mar 2024 00:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu6ZrhHFFU/cNQY2rKmeyFgQw7ULvu/SaNtvr064DrJO0UAnP2duZ3DsY8To+OPgMrQxcia5r8O2F8LO0SWDY=
X-Received: by 2002:a05:6a00:2e08:b0:6ea:c501:b264 with SMTP id
 fc8-20020a056a002e0800b006eac501b264mr2452204pfb.18.1711525377513; Wed, 27
 Mar 2024 00:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-2-gshan@redhat.com>
 <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
 <CACGkMEtUdgDr_M-F8-gdFkJp+29Xuw9DCib2-diFmJxFxDN2Bw@mail.gmail.com>
 <b6f4e8c1-bdd1-496e-aa1a-68349674671c@redhat.com> <92ac171a-0004-45ef-a6c8-01b1c135a8ca@redhat.com>
In-Reply-To: <92ac171a-0004-45ef-a6c8-01b1c135a8ca@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 15:42:45 +0800
Message-ID: <CACGkMEti3xtqHxhM-DGcquP6UncELUzrNeVor45wfGRCBkkZrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:35=E2=80=AFPM Gavin Shan <gshan@redhat.com> wrote=
:
>
> On 3/27/24 14:08, Gavin Shan wrote:
> > On 3/27/24 12:44, Jason Wang wrote:
> >> On Wed, Mar 27, 2024 at 10:34=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>> On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com>=
 wrote:
> >>>>
> >>>> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> >>>> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> >>>> available ring entries pushed by guest can be observed by vhost
> >>>> in time, leading to stale available ring entries fetched by vhost
> >>>> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> >>>> grace-hopper (ARM64) platform.
> >>>>
> >>>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
> >>>>    -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
> >>>>    -smp maxcpus=3D1,cpus=3D1,sockets=3D1,clusters=3D1,cores=3D1,thre=
ads=3D1 \
> >>>>    -m 4096M,slots=3D16,maxmem=3D64G                                 =
\
> >>>>    -object memory-backend-ram,id=3Dmem0,size=3D4096M                =
\
> >>>>     :                                                           \
> >>>>    -netdev tap,id=3Dvnet0,vhost=3Dtrue                              =
\
> >>>>    -device virtio-net-pci,bus=3Dpcie.8,netdev=3Dvnet0,mac=3D52:54:00=
:f1:26:b0
> >>>>     :
> >>>>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
> >>>>    virtio_net virtio0: output.0:id 100 is not a head!
> >>>>
> >>>> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> >>>> should be safe until vq->avail_idx is changed by commit 275bf960ac69=
7
> >>>> ("vhost: better detection of available buffers").
> >>>>
> >>>> Fixes: 275bf960ac697 ("vhost: better detection of available buffers"=
)
> >>>> Cc: <stable@kernel.org> # v4.11+
> >>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
> >>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >>>> ---
> >>>>   drivers/vhost/vhost.c | 11 ++++++++++-
> >>>>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >>>> index 045f666b4f12..00445ab172b3 100644
> >>>> --- a/drivers/vhost/vhost.c
> >>>> +++ b/drivers/vhost/vhost.c
> >>>> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *d=
ev, struct vhost_virtqueue *vq)
> >>>>          r =3D vhost_get_avail_idx(vq, &avail_idx);
> >>>>          if (unlikely(r))
> >>>>                  return false;
> >>>> +
> >>>>          vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> >>>> +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> >>>> +               /* Similar to what's done in vhost_get_vq_desc(), we=
 need
> >>>> +                * to ensure the available ring entries have been ex=
posed
> >>>> +                * by guest.
> >>>> +                */
> >>>
> >>> We need to be more verbose here. For example, which load needs to be
> >>> ordered with which load.
> >>>
> >>> The rmb in vhost_get_vq_desc() is used to order the load of avail idx
> >>> and the load of head. It is paired with e.g virtio_wmb() in
> >>> virtqueue_add_split().
> >>>
> >>> vhost_vq_avail_empty() are mostly used as a hint in
> >>> vhost_net_busy_poll() which is under the protection of the vq mutex.
> >>>
> >>> An exception is the tx_can_batch(), but in that case it doesn't even
> >>> want to read the head.
> >>
> >> Ok, if it is needed only in that path, maybe we can move the barriers =
there.
> >>
> >
> > [cc Will Deacon]
> >
> > Jason, appreciate for your review and comments. I think PATCH[1/2] is
> > the fix for the hypothesis, meaning PATCH[2/2] is the real fix. However=
,
> > it would be nice to fix all of them in one shoot. I will try with PATCH=
[2/2]
> > only to see if our issue will disappear or not. However, the issue stil=
l
> > exists if PATCH[2/2] is missed.
> >
>
> Jason, PATCH[2/2] is sufficient to fix our current issue. I tried with PA=
TCH[2/2]
> only and unable to hit the issue. However, PATCH[1/2] may be needed by ot=
her scenarios.
> So it would be nice to fix them in one shoot.

Yes, see below.

>
>
> > Firstly, We were failing on the transmit queue and {tvq, rvq}->busyloop=
_timeout
> > =3D=3D false if I remember correctly. So the added smp_rmb() in vhost_v=
q_avail_empty()
> > is only a concern to tx_can_batch(). A mutex isn't enough to ensure the=
 order
> > for the available index and available ring entry (head). For example, v=
host_vq_avail_empty()
> > called by tx_can_batch() can see next available index, but its correspo=
nding
> > available ring entry (head) may not be seen by vhost yet if smp_rmb() i=
s missed.
> > The next call to get_tx_bufs(), where the available ring entry (head) d=
oesn't
> > arrived yet, leading to stale available ring entry (head) being fetched=
.
> >
> >    handle_tx_copy
> >      get_tx_bufs                 // smp_rmb() won't be executed when vq=
->avail_idx !=3D vq->last_avail_idx
> >      tx_can_batch
> >        vhost_vq_avail_empty      // vq->avail_idx is updated from vq->a=
vail->idx
> >
> > The reason why I added smp_rmb() to vhost_vq_avail_empty() is because t=
he function
> > is a exposed API, even it's only used by drivers/vhost/net.c at present=
 It means
> > the API has been broken internally. So it seems more appropriate to fix=
 it up in
> > vhost_vq_avail_empty() so that the API's users needn't worry about the =
memory access
> > order.

When tx_can_batch returns true it means there's still pending tx
buffers. Since it might read indices so it still can bypass the
smp_rmb() in the vhost_get_vq_desc().

I'd suggest adding those above to change log.

With this,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> >
> >>>
> >>>
> >>>> +               smp_rmb();
> >>>> +               return false;
> >>>> +       }
> >>>>
> >>>> -       return vq->avail_idx =3D=3D vq->last_avail_idx;
> >>>> +       return true;
> >>>>   }
> >>>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>
> Thanks,
> Gavin
>


