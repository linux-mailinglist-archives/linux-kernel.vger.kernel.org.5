Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF87F8C31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjKYPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810BAD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700927714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4DuV8JTESzzxqBGp7dNjwcx+vBJ2PdS3sx5qeVBSYI=;
        b=X08pAe2fh6nHzcwRII6MJOA/c3mnGB1V1DVRxpPYId1wvODnuew3Q0UuDcaSfyktfvyR2s
        Cdd86Z2jJl11lvoxC2F9tNl/VmNjtP+QCeGy315OUPWtGNN1JRhC/Mq/dqq7TWRLCaG/dg
        6ajFcETKd2T9cN9qO7VOAaa8WUOnwf8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-2F-XPN3aNYG4nVm1r36LJg-1; Sat, 25 Nov 2023 10:55:12 -0500
X-MC-Unique: 2F-XPN3aNYG4nVm1r36LJg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54b38db76e1so111290a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700927712; x=1701532512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4DuV8JTESzzxqBGp7dNjwcx+vBJ2PdS3sx5qeVBSYI=;
        b=j5TnWl9ptOem9w8Cii6tu6t/j2UhyqiWjkh7OSLislBJQerT/HvUxKQMCBJ2hHldV9
         C+w0lUqMhRgi9+Ptytgcw2v7ZeSjLv8czshUKYG3lUSxnYSDRx5Bp290d2iDBeL2JSK5
         DgvpqMKAPhfzigz70t19Nq6LKVTen7QMCZZxkGIaHs2q2NW99Kr2rgR65UV8AFfLEHDy
         t+Cb9s6K4xELbOATzay0wtPIuJDoFRQJetf7ZTRUkNgXNNFOzBnADN0UT8CDZTuSgkJT
         hStwfhjCjFW4ZkCKh5ILnluI783FsqVA6W5p+ALANHuOUsWni5EpLITczIdoAKi+jOSp
         b8+g==
X-Gm-Message-State: AOJu0YwC01qBtEVtgYfAD9ZX9uY1tlmotcYO/1/HCj5y21IejRu5YBJa
        Xao+THGD8BCrWTvtqmjmsA6z4LZcq4084jhaNz6XRqYjJQPFGYsZIEN83U0nn7/kSJLPK8yDh2d
        PPT4Nt30TSaX1t+6RqGwpSISzcuj5JxoMvuGgOWUB
X-Received: by 2002:a50:c01e:0:b0:543:5281:2ad8 with SMTP id r30-20020a50c01e000000b0054352812ad8mr5048184edb.18.1700927711874;
        Sat, 25 Nov 2023 07:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS7yVWxJOdcC/UEifXcy2RQK94YqpLEVG5PX+Ur5kiV9h7JnpqEw3iHoz8eL4IuTpMNHI2FowSOGrLFPhNg8o=
X-Received: by 2002:a50:c01e:0:b0:543:5281:2ad8 with SMTP id
 r30-20020a50c01e000000b0054352812ad8mr5048173edb.18.1700927711624; Sat, 25
 Nov 2023 07:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-2-lulu@redhat.com>
 <CACGkMEsC-8tW30pDR4NcqP1gfK8dWpbVwE5KV4Q9nkQuXFYhdA@mail.gmail.com>
In-Reply-To: <CACGkMEsC-8tW30pDR4NcqP1gfK8dWpbVwE5KV4Q9nkQuXFYhdA@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 25 Nov 2023 23:54:34 +0800
Message-ID: <CACLfguXSdYgrb=A9kb_C_91y6DTbMpmv1eN2vUmZp49+B_h7uw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Add function to get/free the pages for reconnection
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 2:23=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function vduse_alloc_reconnnect_info_mem
> > and vduse_alloc_reconnnect_info_mem
> > In this 2 function, vduse will get/free (vq_num + 1)*page
> > Page 0 will be used to save the reconnection information, The
> > Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> > the reconnection information for vqs.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 80 ++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 26b7e29cb900..6209e2f00278 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -41,6 +41,16 @@
> >  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/* struct vdpa_reconnect_info saved the alloc pages info
> > + * these pages will mmaped to userspace for reconnection
> > + */
> > +struct vdpa_reconnect_info {
> > +       /* Offset (within vm_file) in PAGE_SIZE */
> > +       u32 index;
>
> Is index ever used in this series?
>
this index was use for sanity check in mmap function

> > +       /* virtual address for this page*/
> > +       unsigned long vaddr;
> > +};
> > +
> >  struct vduse_virtqueue {
> >         u16 index;
> >         u16 num_max;
> > @@ -57,6 +67,7 @@ struct vduse_virtqueue {
> >         struct vdpa_callback cb;
> >         struct work_struct inject;
> >         struct work_struct kick;
> > +       struct vdpa_reconnect_info reconnect_info;
> >  };
> >
> >  struct vduse_dev;
> > @@ -106,6 +117,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> > +       struct vdpa_reconnect_info reconnect_info;
> >  };
> >
> >  struct vduse_dev_msg {
> > @@ -1030,6 +1042,64 @@ static int vduse_dev_reg_umem(struct vduse_dev *=
dev,
> >         return ret;
> >  }
> >
> > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +       struct vdpa_reconnect_info *info;
> > +       struct vduse_virtqueue *vq;
> > +
> > +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> > +               if (i =3D=3D 0) {
> > +                       /*page 0 is use to save status,Userland APP wil=
l use this to
> > +                        *save the information needed in reconnection,
> > +                        *kernel don't need to maintain this
>
> Please tweak the case here and to make sure the series can pass checkpatc=
h.
>
sure will do
> > +                        */
> > +                       info =3D &dev->reconnect_info;
> > +                       info->vaddr =3D get_zeroed_page(GFP_KERNEL);
> > +                       if (info->vaddr =3D=3D 0)
> > +                               return -ENOMEM;
> > +                       /* index is vm Offset in PAGE_SIZE */
>
> The case seems odd but anyhow this has been explained in the uAPI file?
>
sure will fix this
thanks
Cindy
> Thanks
>

