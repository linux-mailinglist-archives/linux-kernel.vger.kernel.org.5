Return-Path: <linux-kernel+bounces-32314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6108359F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE01C2174C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E686337B;
	Mon, 22 Jan 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvzRsY6H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BE1FA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896394; cv=none; b=UxKIyxHDJ1cgpYJNPZ4Vs6PK33h+oUCKPegUf4h6c2oM2zfSyAMr9tvBiLguBh+ADMkNJkoxDMV1LptyScxDYMAL23dCB+/C7oMZxOYyXn2TulsayHaEULpXv9HTnrB5QRlk6P3j+O1Ozf0A1hylucWeO2WmVfWm0GVcW1hdjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896394; c=relaxed/simple;
	bh=w/E9F7Uv9VHzG+a2XSEpab7stLqBdgdfZsfwuTMD2Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS+6BSpXt5ETQtVt3cSVZKVhrAlTmuhUvWVCCCwnX0oGsJtElCka5VsTYgvXH7iD7g4rOEQhWFXNejJhKRjyzbS92L+8ujqgBnmiQqQBKLrsKNkoM2Ijen48ESuLEVDuKvbJn0TbNKOScrrzOKTMiuLOfTPY1EvBbPmcdeB2RmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvzRsY6H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705896391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0G1zcOMwYVF5Am6q3I5TfizUQR1r7FxkBnQWhGkczY=;
	b=UvzRsY6HdShOiPglftH3A8LrMhxfN1LxLo+Tl8YU9e3M6EiEmbiujzTAJE/i3wcekZ2N+/
	hIWbLwjWyRt96T+gBsigfMtvcTJX5zyg0/CJv9a3H8ds0uy/ZwcExkZplgyU814MHKdDqy
	0JlQCeeoAPGtEihs/xs2pK9XjiBZHF0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-jME1UIFeMPKyQ_oQQ8gfZA-1; Sun, 21 Jan 2024 23:06:29 -0500
X-MC-Unique: jME1UIFeMPKyQ_oQQ8gfZA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-598f047f034so3258704eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896387; x=1706501187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0G1zcOMwYVF5Am6q3I5TfizUQR1r7FxkBnQWhGkczY=;
        b=ofFOoXPSg6Z318Xi+Hxdkpw7iXyszJQwwy4YNXOzSjSXI8ToXcow0zAVv/5phLsHOX
         lE/FNOsPTS8NYNQ/65ale9Yx/+r46FdKG67Pq9lzXLSH9WN0Yj19higA6qJi504uZknV
         o3hEiOgd47aUTe9Y+DDoQv3ns5rKjKmUqBxVm357vltvHwVdsiinY61bE3OyrMqh1/qX
         6H2MaCbO5DfbhG3TyiDniJsa0W1YqO6tAGT/y8mcKn8wTZMIpOj/8QAby1Izu7sR6IIe
         I7qnIhtp6xzuAZInK9O82mupuOIT3l6lmK5xgH7xNxmL/EAHyxhxEB0lM4v6QMxeU3q4
         Bu1w==
X-Gm-Message-State: AOJu0Ywpqr/fCDUsmXY98cAwBgWOOQTzJ8kuZxrAXT+LInz02DjVa3SP
	Otc9VELV5lJqRRDiLfYx8kLTO/oRYUBnrIrA9uxusxy7bnjAO2A9IJlzDRqtY0hQLCzDfeQ7FyX
	qQoacfyrejO4Ns8uP6BSk/NzdBaVO+ipD7akfZ1ZYEt/ccorB0t3eNSDgd9+G36IhTd/Pyv3XuE
	Gl36Ki4HcjGdzhrzx+3v0nHfD+1TcAqN2z82Pq
X-Received: by 2002:a05:6358:15d6:b0:176:5bef:d33e with SMTP id t22-20020a05635815d600b001765befd33emr436386rwh.14.1705896387146;
        Sun, 21 Jan 2024 20:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGti6AsyCdu5QIJLNdUXo0z42+dA2eB5mYJ/oRVBM0DY85CRNaixV6Ce/TAxYJK7oXKAQdEjuv+kgdbqW2tATE=
X-Received: by 2002:a05:6358:15d6:b0:176:5bef:d33e with SMTP id
 t22-20020a05635815d600b001765befd33emr436374rwh.14.1705896386879; Sun, 21 Jan
 2024 20:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEsCzLNdRXu25tzhrnTVatM6pHwVXVUn7kE=3erVWQUL4g@mail.gmail.com> <700fc2e5-445d-46c4-bdde-0dd29bcdb2bc@oracle.com>
In-Reply-To: <700fc2e5-445d-46c4-bdde-0dd29bcdb2bc@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:05:28 +0800
Message-ID: <CACGkMEsVNNJfUE7JVX6mYdrZ+uWxZYbdwJVOrxXGiK++WwA4Sg@mail.gmail.com>
Subject: Re: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:32=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 1/10/2024 10:08 PM, Jason Wang wrote:
> > On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> When device ownership is passed to a new process via VHOST_NEW_OWNER,
> >> some devices need to know the new userland addresses of the dma mappin=
gs.
> >> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uadd=
r
> >> of a mapping.  The new uaddr must address the same memory object as
> >> originally mapped.
> >>
> >> The user must suspend the device before the old address is invalidated=
,
> >> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
> >> requirement is not enforced by the API.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  drivers/vhost/vdpa.c             | 34 +++++++++++++++++++++++++++++++=
+
> >>  include/uapi/linux/vhost_types.h | 11 ++++++++++-
> >>  2 files changed, 44 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index faed6471934a..ec5ca20bd47d 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa =
*v,
> >>
> >>  }
> >>
> >> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> >> +                                         struct vhost_iotlb *iotlb,
> >> +                                         struct vhost_iotlb_msg *msg)
> >> +{
> >> +       struct vdpa_device *vdpa =3D v->vdpa;
> >> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +       u32 asid =3D iotlb_to_asid(iotlb);
> >> +       u64 start =3D msg->iova;
> >> +       u64 last =3D start + msg->size - 1;
> >> +       struct vhost_iotlb_map *map;
> >> +       int r =3D 0;
> >> +
> >> +       if (msg->perm || !msg->size)
> >> +               return -EINVAL;
> >> +
> >> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> >> +       if (!map)
> >> +               return -ENOENT;
> >> +
> >> +       if (map->start !=3D start || map->last !=3D last)
> >> +               return -EINVAL;
> >> +
> >> +       /* batch will finish with remap.  non-batch must do it now. */
> >> +       if (!v->in_batch)
> >> +               r =3D ops->set_map(vdpa, asid, iotlb);
> >> +       if (!r)
> >> +               map->addr =3D msg->uaddr;
> >
> > I may miss something, for example for PA mapping,
> >
> > 1) need to convert uaddr into phys addr
> > 2) need to check whether the uaddr is backed by the same page or not?
>
> This code does not verify that the new size@uaddr points to the same phys=
ical
> pages as the old size@uaddr.  If the app screws up and they differ, then =
the app
> may corrupt its own memory, but no-one else's.
>
> It would be expensive for large memories to verify page by page, O(npages=
), and such
> verification lies on the critical path for virtual machine downtime durin=
g live update.
> I could compare the properties of the vma(s) for the old size@uaddr vs th=
e vma for the
> new, but that is more complicated and would be a maintenance headache.  W=
hen I submitted
> such code to Alex W when writing the equivalent patches for vfio, he said=
 don't check,
> correctness is the user's responsibility.

Ok, let's document this somewhere.

Thanks

>
> - Steve
>
> >> +
> >> +       return r;
> >> +}
> >> +
> >>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> >>                                            struct vhost_iotlb *iotlb,
> >>                                            struct vhost_iotlb_msg *msg=
)
> >> @@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct v=
host_dev *dev, u32 asid,
> >>                         ops->set_map(vdpa, asid, iotlb);
> >>                 v->in_batch =3D false;
> >>                 break;
> >> +       case VHOST_IOTLB_REMAP:
> >> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> >> +               break;
> >>         default:
> >>                 r =3D -EINVAL;
> >>                 break;
> >> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vho=
st_types.h
> >> index 9177843951e9..35908315ff55 100644
> >> --- a/include/uapi/linux/vhost_types.h
> >> +++ b/include/uapi/linux/vhost_types.h
> >> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
> >>  /*
> >>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
> >>   * multiple mappings in one go: beginning with
> >> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> >> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REM=
AP or
> >>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END=
.
> >>   * When one of these two values is used as the message type, the rest
> >>   * of the fields in the message are ignored. There's no guarantee tha=
t
> >> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
> >>   */
> >>  #define VHOST_IOTLB_BATCH_BEGIN    5
> >>  #define VHOST_IOTLB_BATCH_END      6
> >> +
> >> +/*
> >> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping a=
t iova.
> >> + * The new uaddr must address the same memory object as originally ma=
pped.
> >> + * Failure to do so will result in user memory corruption and/or devi=
ce
> >> + * misbehavior.  iova and size must match the arguments used to creat=
e the
> >> + * an existing mapping.  Protection is not changed, and perm must be =
0.
> >> + */
> >> +#define VHOST_IOTLB_REMAP          7
> >>         __u8 type;
> >>  };
> >>
> >> --
> >> 2.39.3
> >>
> >
>


