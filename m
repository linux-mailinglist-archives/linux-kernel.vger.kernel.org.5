Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5B7E8069
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjKJSK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjKJSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0227DB3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699599019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0M1EG+vkP/oHQ3C8AC569hjRGE3An7KZi4c6BBHfHyQ=;
        b=Gjz9+aRY6IHphGSu1Jql0Q+OiRrR3uO4s0GJWz77RdJvwag4VSQ7trKd5uR+6SyaK72AiM
        jEWDriPHxT8LXxsrc9D2MizifqnK9ZcimH9R/QMYTcrr7kTAWhRgvY+ffLXDm/a/hRcKyN
        SXVOuWcT1HOxEq668ShgngCYqkgoN34=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-eDuS-micNm6Pip3cGMm_lA-1; Fri, 10 Nov 2023 01:50:18 -0500
X-MC-Unique: eDuS-micNm6Pip3cGMm_lA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54356d8ea43so1319966a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599017; x=1700203817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0M1EG+vkP/oHQ3C8AC569hjRGE3An7KZi4c6BBHfHyQ=;
        b=UEYe2sD8SSIhhw9mZ5KOK3FZIoJ0y8rcqtJRtq38ZJwmCGa9U+rmYxqANmbVznWf1q
         2Z2VBhF7qSOPIYMRSp8pRYRspjec6RPI9ez0HKEt5QkVzJP3RbwIUW4OxoON/L3u03B5
         1jjBnHbBCuye+66FaA2t4wM5WJZoH//hc0gxdEIf/gqpSW5mfAdn2uHAzYqfpAQG8mKt
         8poEtqIysz3smzXtzE9fQIs+++1DvoCdsTgFbz52Og34M313hJjaskPo7ezrDu/kXP4x
         Ywnrd7mq6DMycfO4uKIQqwXBdwLwA7P+m7ERv/swOJmCiexBj74JU661RYg/FHGdGFKX
         MvXw==
X-Gm-Message-State: AOJu0Yw7J67gAw8x6gshwoSODMc8AwEed0dGLZgJrbvlp6Ui6k7spKZz
        sVQ25rypVzHC/RljJkYRH8dGUg3zqjIHKDm1oSmK26eEc5ve8zYoNaHfs4703dL6ge86cRGC0Aw
        6OM8Ze/ZdKmXN7LZhUSDvGZ3apiSLKqzu7D19Jo5m
X-Received: by 2002:a50:9b19:0:b0:543:c388:1d69 with SMTP id o25-20020a509b19000000b00543c3881d69mr6199682edi.16.1699599017183;
        Thu, 09 Nov 2023 22:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJKgFLm8IAWbD4pDRiL75jQXjIaaTe0xwSRHT7UApyxw5o/GJCLUzV1pFMAY6YeZ6y/T9BJxhpOlXosUbTuEo=
X-Received: by 2002:a50:9b19:0:b0:543:c388:1d69 with SMTP id
 o25-20020a509b19000000b00543c3881d69mr6199675edi.16.1699599016862; Thu, 09
 Nov 2023 22:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
 <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
 <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
 <CACLfguW3NZawOL0ET2K7bmtGZuzQwUfJ2HSgnirswzZK1ayPnA@mail.gmail.com>
 <CACGkMEvnNXC8PhBNQn_F0ROGRX3CvwmXM6wP2A69aydSuzThYw@mail.gmail.com> <CACGkMEtVqAYP3ec0+uxmdiOdXXevjy5S+7Vuc9s=PcS3ry0nCg@mail.gmail.com>
In-Reply-To: <CACGkMEtVqAYP3ec0+uxmdiOdXXevjy5S+7Vuc9s=PcS3ry0nCg@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Fri, 10 Nov 2023 14:49:33 +0800
Message-ID: <CACLfguXNtzD5TW4VC_Yu755Mtkz4vVo6_Vvo=gVs4pHdF3-NCg@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=94 10:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 8, 2023 at 3:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Nov 8, 2023 at 2:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > On Wed, Nov 8, 2023 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> w=
rote:
> > > > >
> > > > > On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.co=
m> wrote:
> > > > > > >
> > > > > > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > > > > > >
> > > > > > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iom=
mufd
> > > > > > > address space specified by IOAS id.
> > > > > > >
> > > > > > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > > > > > from the iommufd address space
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > ---
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/=
vhost.h
> > > > > > > index f5c48b61ab62..07e1b2c443ca 100644
> > > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > > @@ -219,4 +219,70 @@
> > > > > > >   */
> > > > > > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7=
E)
> > > > > > >
> > > > > > > +/* vhost_vdpa_set_iommufd
> > > > > > > + * Input parameters:
> > > > > > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to uns=
et
> > > > > > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMM=
U_IOAS_ALLOC)
> > > > > > > + * Output parameters:
> > > > > > > + * @out_dev_id: device identifier
> > > > > > > + */
> > > > > > > +struct vhost_vdpa_set_iommufd {
> > > > > > > +       __s32 iommufd;
> > > > > > > +       __u32 iommufd_ioasid;
> > > > > > > +       __u32 out_dev_id;
> > > > > > > +};
> > > > > > > +
> > > > > > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > > > > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommuf=
d)
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > > > > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommuf=
d_as)
> > > > > > > + *
> > > > > > > + * Attach a vdpa device to an iommufd address space specifie=
d by IOAS
> > > > > > > + * id.
> > > > > > > + *
> > > > > > > + * Available only after a device has been bound to iommufd v=
ia
> > > > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > > > + *
> > > > > > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > > > > > + *
> > > > > > > + * @argsz:     user filled size of this data.
> > > > > > > + * @flags:     must be 0.
> > > > > > > + * @ioas_id:   Input the target id which can represent an io=
as
> > > > > > > + *             allocated via iommufd subsystem.
> > > > > > > + *
> > > > > > > + * Return: 0 on success, -errno on failure.
> > > > > > > + */
> > > > > > > +struct vdpa_device_attach_iommufd_as {
> > > > > > > +       __u32 argsz;
> > > > > > > +       __u32 flags;
> > > > > > > +       __u32 ioas_id;
> > > > > > > +};
> > > > > >
> > > > > > I think we need to map ioas to vDPA AS, so there should be an A=
SID
> > > > > > from the view of vDPA?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > The qemu will have a structure save and  maintain this informatio=
n,So
> > > > > I didn't add this
> > > > >  in kernel=EF=BC=8Cwe can add this but maybe only for check?
> > > >
> > > > I meant for example, a simulator has two AS. How can we attach an i=
oas
> > > > to a specific AS with the above uAPI?
> > > >
> > > > Thank>
> > > this   __u32 ioas_id here is alloc from the iommufd system. maybe I
> > > need to change to new name iommuds_asid to
> > > make this more clear
> > > the process in qemu is
> > >
> > > 1) qemu want to use AS 0 (for example)
> > > 2) checking the existing asid. the asid 0 not used before
> > > 3 )alloc new asid from iommufd system, get new ioas_id (maybe 3 for e=
xample)
> > > qemu will save this relation 3<-->0 in the driver.
> > > 4) setting the ioctl VDPA_DEVICE_ATTACH_IOMMUFD_AS to attach new ASID
> > > to the kernel
> >
> > So if we want to map IOMMUFD AS 3 to VDPA AS 0, how can it be done?
> >
> > For example I didn't see a vDPA AS parameter in the above uAPI.
> >
> > vhost_vdpa_set_iommufd has iommufd_ioasid which is obviously not the vD=
PA AS.
> >
> > And ioas_id of vdpa_device_attach_iommufd_as (as you explained above)
> > is not vDPA AS.
>
> For example, the simulator/mlx5e has two ASes. It needs to know the
> mapping between vDPA AS and iommufd AS. Otherwise the translation will
> be problematic.
>
> Thanks
>
Got it, thanks Jason. I will re-write this part
Thanks
Cindy
> >
> > Thanks
> >
> >
> > > 5=EF=BC=89 while map the memory=EF=BC=8C qemu will use ASID 3 to map =
/umap
> > > and use ASID 0 for legacy mode map/umap
> > >
> > > So kernel here will not maintain the ioas_id from iommufd=EF=BC=8C
> > > and this also make the code strange since there will 2 different asid
> > > for the same AS, maybe we can save these information in the kernel
> > > Thanks
> > > cindy
> > > > > Thanks
> > > > > Cindy
> > > > > > > +
> > > > > > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > > > > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_io=
mmufd_as)
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > > > > > + *
> > > > > > > + * Detach a vdpa device from the iommufd address space it ha=
s been
> > > > > > > + * attached to. After it, device should be in a blocking DMA=
 state.
> > > > > > > + *
> > > > > > > + * Available only after a device has been bound to iommufd v=
ia
> > > > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > > > + *
> > > > > > > + * @argsz:     user filled size of this data.
> > > > > > > + * @flags:     must be 0.
> > > > > > > + *
> > > > > > > + * Return: 0 on success, -errno on failure.
> > > > > > > + */
> > > > > > > +struct vdpa_device_detach_iommufd_as {
> > > > > > > +       __u32 argsz;
> > > > > > > +       __u32 flags;
> > > > > > > +};
> > > > > > > +
> > > > > > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > > > > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_io=
mmufd_as)
> > > > > > > +
> > > > > > >  #endif
> > > > > > > --
> > > > > > > 2.34.3
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>

