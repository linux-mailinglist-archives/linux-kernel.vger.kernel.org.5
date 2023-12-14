Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A178131F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573220AbjLNNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573225AbjLNNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:45:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB0118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702561547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV78XCom468gjByA/ysRM79kmfYh0HxExW4XSclxsMk=;
        b=LLZHF1hslBSNzoZ2L6OPrISZDZaXPrheuSlrDwaPJxqPxS4F7m7rzCyoXIiOMM8VJumyTi
        VXTk7ZxsoIutQN6xplUKWBYQTW14TPpAeSjcpPCKb7VZscnGwyfbicOLpGLbeZZhyZqtiL
        g22hdNzUR0D1TB2BksHuVmTQPwce0mQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ojw9eg8AMxqgPHSJN5apZA-1; Thu, 14 Dec 2023 08:45:45 -0500
X-MC-Unique: ojw9eg8AMxqgPHSJN5apZA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1fa0ed2058so275911766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561545; x=1703166345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aV78XCom468gjByA/ysRM79kmfYh0HxExW4XSclxsMk=;
        b=wfvsah/OFXUizg0U27PNKKVTWl+XChMPGcoQEALX5U8h8eVD/Nz970BlErZn6mXNBO
         x40gHOAldJCvaXUTmW5pjU7P6SoHy3TzFoTLRQAqx6E8Za+qZKKtMH2V4X1bD0NvWgJg
         l9A/luk5KuKbDtEj4Ir8apWxaTTG9DVM0+mnQHE7vpwKNq0YJfJKWCiz0L0SqBo+0t2M
         zH/1mrw7UO6jQivwEWgbUI1XqLf/EOXCEaFG0OOIf0XFCvxJML2yzAnvsoHq9FaUJdsS
         iJeFINA8BLGCB9HoiBvMuA37jWABrGMzzZkkvJCIvssVhJGqIMfNOLBfqy1rL5soL+GB
         BgYQ==
X-Gm-Message-State: AOJu0YydNc3gMHbblYaYaI+4My1af8pBQwtrWStHrNAQyCGxqgWxwD+Z
        hkbFgO7YTWhyZgw2auPyAPKxlw019znuemzZvZoM9Jb9/ZbFHxP6vjl29B3S6bU2Db4juChb++h
        DbLd7r8Ca9yUTvzBWk3JPKZZx
X-Received: by 2002:a17:906:209:b0:a19:a19b:4265 with SMTP id 9-20020a170906020900b00a19a19b4265mr3263377ejd.208.1702561544851;
        Thu, 14 Dec 2023 05:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcKoJdGrfLfIVGj148YKZojuyQTnvdpix1v5CYIVe1qOhT5bCOlzXJQ2KE6uYYYmKDHEmL4w==
X-Received: by 2002:a17:906:209:b0:a19:a19b:4265 with SMTP id 9-20020a170906020900b00a19a19b4265mr3263361ejd.208.1702561544471;
        Thu, 14 Dec 2023 05:45:44 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1cf3fce937sm9372030ejc.162.2023.12.14.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:45:43 -0800 (PST)
Date:   Thu, 14 Dec 2023 08:45:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH vhost v2 4/8] vdpa/mlx5: Mark vq addrs for modification
 in hw vq
Message-ID: <20231214084526-mutt-send-email-mst@kernel.org>
References: <20231205104609.876194-1-dtatulea@nvidia.com>
 <20231205104609.876194-5-dtatulea@nvidia.com>
 <CAJaqyWeEY9LNTE8QEnJgLhgS7HiXr5gJEwwPBrC3RRBsAE4_7Q@mail.gmail.com>
 <27312106-07b9-4719-970c-b8e1aed7c4eb@oracle.com>
 <075cf7d1ada0ee4ee30d46b993a1fe21acfe9d92.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <075cf7d1ada0ee4ee30d46b993a1fe21acfe9d92.camel@nvidia.com>
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

On Thu, Dec 14, 2023 at 01:39:55PM +0000, Dragos Tatulea wrote:
> On Tue, 2023-12-12 at 15:44 -0800, Si-Wei Liu wrote:
> > 
> > On 12/12/2023 11:21 AM, Eugenio Perez Martin wrote:
> > > On Tue, Dec 5, 2023 at 11:46 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > Addresses get set by .set_vq_address. hw vq addresses will be updated on
> > > > next modify_virtqueue.
> > > > 
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > I'm kind of ok with this patch and the next one about state, but I
> > > didn't ack them in the previous series.
> > > 
> > > My main concern is that it is not valid to change the vq address after
> > > DRIVER_OK in VirtIO, which vDPA follows. Only memory maps are ok to
> > > change at this moment. I'm not sure about vq state in vDPA, but vhost
> > > forbids changing it with an active backend.
> > > 
> > > Suspend is not defined in VirtIO at this moment though, so maybe it is
> > > ok to decide that all of these parameters may change during suspend.
> > > Maybe the best thing is to protect this with a vDPA feature flag.
> > I think protect with vDPA feature flag could work, while on the other 
> > hand vDPA means vendor specific optimization is possible around suspend 
> > and resume (in case it helps performance), which doesn't have to be 
> > backed by virtio spec. Same applies to vhost user backend features, 
> > variations there were not backed by spec either. Of course, we should 
> > try best to make the default behavior backward compatible with 
> > virtio-based backend, but that circles back to no suspend definition in 
> > the current virtio spec, for which I hope we don't cease development on 
> > vDPA indefinitely. After all, the virtio based vdap backend can well 
> > define its own feature flag to describe (minor difference in) the 
> > suspend behavior based on the later spec once it is formed in future.
> > 
> So what is the way forward here? From what I understand the options are:
> 
> 1) Add a vdpa feature flag for changing device properties while suspended.
> 
> 2) Drop these 2 patches from the series for now. Not sure if this makes sense as
> this. But then Si-Wei's qemu device suspend/resume poc [0] that exercises this
> code won't work anymore. This means the series would be less well tested.
> 
> Are there other possible options? What do you think?
> 
> [0] https://github.com/siwliu-kernel/qemu/tree/svq-resume-wip

I am fine with either of these.

> Thanks,
> Dragos
> 
> > Regards,
> > -Siwei
> > 
> > 
> > 
> > > 
> > > Jason, what do you think?
> > > 
> > > Thanks!
> > > 
> > > > ---
> > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 9 +++++++++
> > > >   include/linux/mlx5/mlx5_ifc_vdpa.h | 1 +
> > > >   2 files changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index f8f088cced50..80e066de0866 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1209,6 +1209,7 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
> > > >          bool state_change = false;
> > > >          void *obj_context;
> > > >          void *cmd_hdr;
> > > > +       void *vq_ctx;
> > > >          void *in;
> > > >          int err;
> > > > 
> > > > @@ -1230,6 +1231,7 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
> > > >          MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> > > > 
> > > >          obj_context = MLX5_ADDR_OF(modify_virtio_net_q_in, in, obj_context);
> > > > +       vq_ctx = MLX5_ADDR_OF(virtio_net_q_object, obj_context, virtio_q_context);
> > > > 
> > > >          if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE) {
> > > >                  if (!is_valid_state_change(mvq->fw_state, state, is_resumable(ndev))) {
> > > > @@ -1241,6 +1243,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
> > > >                  state_change = true;
> > > >          }
> > > > 
> > > > +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS) {
> > > > +               MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> > > > +               MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
> > > > +               MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
> > > > +       }
> > > > +
> > > >          MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select, mvq->modified_fields);
> > > >          err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
> > > >          if (err)
> > > > @@ -2202,6 +2210,7 @@ static int mlx5_vdpa_set_vq_address(struct vdpa_device *vdev, u16 idx, u64 desc_
> > > >          mvq->desc_addr = desc_area;
> > > >          mvq->device_addr = device_area;
> > > >          mvq->driver_addr = driver_area;
> > > > +       mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS;
> > > >          return 0;
> > > >   }
> > > > 
> > > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > index b86d51a855f6..9594ac405740 100644
> > > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > @@ -145,6 +145,7 @@ enum {
> > > >          MLX5_VIRTQ_MODIFY_MASK_STATE                    = (u64)1 << 0,
> > > >          MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      = (u64)1 << 3,
> > > >          MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE = (u64)1 << 4,
> > > > +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           = (u64)1 << 6,
> > > >          MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          = (u64)1 << 14,
> > > >   };
> > > > 
> > > > --
> > > > 2.42.0
> > > > 
> > 
> 

