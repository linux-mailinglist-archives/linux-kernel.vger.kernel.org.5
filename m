Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3577ACEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjIYDVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjIYDVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339CA9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695612028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrR3zPpsYfW5fFIFy5P2/fVt+bsSu1JVw5qNlGgU7cU=;
        b=Lhp3Iux75/TXFqa/ofugAWfaldXrhsTdNXMgdvnvsSNTZJTRcOxoYPyLEv389hFlki50dQ
        hSu+zhun56HgY96AKa3LsNx/B0+IRVcOYYhThv8N/RrNle+M3q96CD3b9js2ionf/uGv6x
        dLw70G4mSWWeLPmj/pHcfKS0JwqfX8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-ZGZ8dHF4PyaRuIDM4k583A-1; Sun, 24 Sep 2023 23:20:27 -0400
X-MC-Unique: ZGZ8dHF4PyaRuIDM4k583A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fd49d8f2aso4457361f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695612026; x=1696216826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrR3zPpsYfW5fFIFy5P2/fVt+bsSu1JVw5qNlGgU7cU=;
        b=WGyRZZXrDA5Uuh29AhKXDsp7f7kxBKJ0CUmn6nShHyABd1KB2oHBYAMtWjTu2rXUrq
         6g5RIc5CflOmq8Uoj2xaARKWzHegIsMoHfNE1+At745erGpFLZvfsSXX3APrQTngnlhV
         YAQLZXUG67y8X3OGIDIN2SN7PO+CbS6NHT3WrG2qHYlCghA0XxTLeNRac+vKtjgK6Mhq
         hlbu5UAnJwEXvHxz9qW3AzJ02saNhhuE3qcogZKjSRDrBfZ/X9fMXJW72BriHbVkYwIB
         BloCsOibPPbyqikGDiA0PG/pRJV4YaZIEe7APEkkpFz4p98+jLIxmWSsJTvDBfLfTogE
         wJUw==
X-Gm-Message-State: AOJu0Yzj6oHE+chqX4zAml9dMblhTDx7cp2eKPN2CXhZ5qYFz+CDcmXo
        AvesIpAeIUUxFZHuFblquKSzyrsLQ8CtDZtVuhBF6/9XF6eBTZLab5jnRXZuXCTggRBrF+kQ+4K
        TlJdSXvsRPKhUqQMoLV7H7R3L/wzoMcF/AdWaDFGo
X-Received: by 2002:a5d:46d2:0:b0:321:5211:8e20 with SMTP id g18-20020a5d46d2000000b0032152118e20mr4758431wrs.59.1695612026252;
        Sun, 24 Sep 2023 20:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbXDBE4JRcEE3biGXQuHAfiqMbcwu40ARqWUHJUoOs6GS1iq/4wyEprZ6iOJlEp6+YDnDyEiJj72z74/YU8Os=
X-Received: by 2002:a5d:46d2:0:b0:321:5211:8e20 with SMTP id
 g18-20020a5d46d2000000b0032152118e20mr4758423wrs.59.1695612025955; Sun, 24
 Sep 2023 20:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
 <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com> <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com>
In-Reply-To: <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Mon, 25 Sep 2023 11:19:47 +0800
Message-ID: <CACLfguWQ=-M1f2QLH-_Y44xd7-AWtWg=v89W_u83NTGjRmAkqg@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Sep 21, 2023 at 10:07=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > On Mon, Sep 18, 2023 at 4:49=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 11:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> w=
rote:
> > > >
> > > > In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> > > > and The number of mapping memory pages from the kernel. The userspa=
ce
> > > > App can use this information to map the pages.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++++++
> > > >  include/uapi/linux/vduse.h         | 15 +++++++++++++++
> > > >  2 files changed, 30 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 680b23dbdde2..c99f99892b5c 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -1368,6 +1368,21 @@ static long vduse_dev_ioctl(struct file *fil=
e, unsigned int cmd,
> > > >                 ret =3D 0;
> > > >                 break;
> > > >         }
> > > > +       case VDUSE_GET_RECONNECT_INFO: {
> > > > +               struct vduse_reconnect_mmap_info info;
> > > > +
> > > > +               ret =3D -EFAULT;
> > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > +                       break;
> > > > +
> > > > +               info.size =3D PAGE_SIZE;
> > > > +               info.max_index =3D dev->vq_num + 1;
> > > > +
> > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > +                       break;
> > > > +               ret =3D 0;
> > > > +               break;
> > > > +       }
> > > >         default:
> > > >                 ret =3D -ENOIOCTLCMD;
> > > >                 break;
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index d585425803fd..ce55e34f63d7 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -356,4 +356,19 @@ struct vhost_reconnect_vring {
> > > >         _Bool avail_wrap_counter;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct vduse_reconnect_mmap_info
> > > > + * @size: mapping memory size, always page_size here
> > > > + * @max_index: the number of pages allocated in kernel,just
> > > > + * use for check
> > > > + */
> > > > +
> > > > +struct vduse_reconnect_mmap_info {
> > > > +       __u32 size;
> > > > +       __u32 max_index;
> > > > +};
> > >
> > > One thing I didn't understand is that, aren't the things we used to
> > > store connection info belong to uAPI? If not, how can we make sure th=
e
> > > connections work across different vendors/implementations. If yes,
> > > where?
> > >
> > > Thanks
> > >
> > The process for this reconnecttion  is
> > A.The first-time connection
> > 1> The userland app checks if the device exists
> > 2>  use the ioctl to create the vduse device
> > 3> Mapping the kernel page to userland and save the
> > App-version/features/other information to this page
> > 4>  if the Userland app needs to exit, then the Userland app will only
> > unmap the page and then exit
> >
> > B, the re-connection
> > 1> the userland app finds the device is existing
> > 2> Mapping the kernel page to userland
> > 3> check if the information in shared memory is satisfied to
> > reconnect,if ok then continue to reconnect
> > 4> continue working
> >
> >  For now these information are all from userland,So here the page will
> > be maintained by the userland App
> > in the previous code we only saved the api-version by uAPI .  if  we
> > need to support reconnection maybe we need to add 2 new uAPI for this,
> > one of the uAPI is to save the reconnect  information and another is
> > to get the information
> >
> > maybe something like
> >
> > struct vhost_reconnect_data {
> > uint32_t version;
> > uint64_t features;
> > uint8_t status;
> > struct virtio_net_config config;
> > uint32_t nr_vrings;
> > };
>
> Probably, then we can make sure the re-connection works across
> different vduse-daemon implementations.
>
> >
> > #define VDUSE_GET_RECONNECT_INFO _IOR (VDUSE_BASE, 0x1c, struct
> > vhost_reconnect_data)
> >
> > #define VDUSE_SET_RECONNECT_INFO  _IOWR(VDUSE_BASE, 0x1d, struct
> > vhost_reconnect_data)
>
> Not sure I get this, but the idea is to map those pages to user space,
> any reason we need this uAPI?
>
> Thanks
>
Sorry=EF=BC=8C I didn't write it clearly, I mean if I we don't want to use =
the
mmap to sync/check the vduse status, we need to add these 2 new uAPIs,
 these 2 methods are all ok for me.
For the vq related information still need to use the mmap to sync
Thanks
cindy
> >
> > Thanks
> > Cindy
> >
> >
> >
> >
> > > > +
> > > > +#define VDUSE_GET_RECONNECT_INFO \
> > > > +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> > > > +
> > > >  #endif /* _UAPI_VDUSE_H_ */
> > > > --
> > > > 2.34.3
> > > >
> > >
> >
>

