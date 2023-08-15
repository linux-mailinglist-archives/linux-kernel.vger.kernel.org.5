Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1577C5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjHOCdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjHOCdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57F10C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692066737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNemsS+xeBZrPRoyejjjBBpC6xRjaAOSiLlxHQBTkjs=;
        b=QNPcU9mSCB8QVnOWhC2qh7tFJ6fkP+1vRU3/0JOS3b3Dw9rCViThRJDITzw/CBj6p0NIE9
        dxPBK75i+kj2FhqXzOEVT75Xmqn0rCpdOhKwZWh2hC9dwzvi1/ndPnrO2qsdcqlYy5fXCj
        IvdC+lzaiXn5DLjUkSVrp0CtCtVqeNU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-zpAhEd9KPFqQ4g8jhL6Oxw-1; Mon, 14 Aug 2023 22:32:15 -0400
X-MC-Unique: zpAhEd9KPFqQ4g8jhL6Oxw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9dc1bfdd2so50524321fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066734; x=1692671534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNemsS+xeBZrPRoyejjjBBpC6xRjaAOSiLlxHQBTkjs=;
        b=UxZXRFUQlQtOPM/MosbYYUYTcMnfYowZ8NU3ZJvu5zQWZHift84J7YtOqItAUqVlVd
         MoxFI/uLY6uYGaNUWHHBGOsPoDhZT75UAogyjprPYNO+pdXYd9o7vdbBGrlsbLlRd3Ba
         QtLFGxTSUAVDhdbH+qnXTXp/56B/A6RQ5UTMzrFJ/w18l+1r2P5KADINmnRh5F0FhtXR
         UhjW/LVYRjXrZ35muh1ihjZTWl6p2HLJ3s/w2Abe7spUCCM7vx+2vUzwKYDt8Jypsjnc
         6pkh1IHv0YxsS3u6YB2ehB31Cn0eEkeH3VU0aZ2pECQlEHpwoiGAGBYahnci03mTX7F7
         B8kA==
X-Gm-Message-State: AOJu0YzdS6oUd8A9QAPFduidhs8zdSsQqNyrcdzagszgT1bvbik8TzLw
        5EhFb/nMvzK7mx4Ybduh+iOEHPSrRfThaJ+LCJxE17McYOOKg+P/0+DHSxW6DcSntVICcv7uxtn
        p/ny0mzU9Ukbo3bzNlGr/7dvS7XCHdUsRsLfwLj70
X-Received: by 2002:a2e:3206:0:b0:2b7:3656:c594 with SMTP id y6-20020a2e3206000000b002b73656c594mr8648544ljy.3.1692066734381;
        Mon, 14 Aug 2023 19:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJmvQQV3BTnu4wfl0ducCx2L3QaITyRrAxjqVHnhDP/J1HYi/le3Ws0YJdz9jLCvMX+/IOIXZAR7suJHeaZ8=
X-Received: by 2002:a2e:3206:0:b0:2b7:3656:c594 with SMTP id
 y6-20020a2e3206000000b002b73656c594mr8648534ljy.3.1692066734088; Mon, 14 Aug
 2023 19:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Aug 2023 10:32:03 +0800
Message-ID: <CACGkMEvrg0qA6=E-5WJL79XAdO3SpSr=rumsyYMW4a-7tZkD8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] vhost-vdpa: should restore 1:1 dma mapping before
 detaching driver
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
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

On Tue, Aug 15, 2023 at 9:45=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b43e868..62b0a01 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_a=
s(struct vhost_vdpa *v,
>         return vhost_vdpa_alloc_as(v, asid);
>  }
>
> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +
> +       if (ops->reset_map)
> +               ops->reset_map(vdpa, asid);
> +}
> +
>  static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>  {
>         struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> @@ -140,6 +149,14 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v=
, u32 asid)
>
>         hlist_del(&as->hash_link);
>         vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> +       /*
> +        * Devices with on-chip IOMMU need to restore iotlb
> +        * to 1:1 identity mapping before vhost-vdpa is going
> +        * to be removed and detached from the device. Give
> +        * them a chance to do so, as this cannot be done
> +        * efficiently via the whole-range unmap call above.
> +        */

Same question as before, if 1:1 is restored and the userspace doesn't
do any IOTLB updating. It looks like a security issue? (Assuming IOVA
is PA)

Thanks

> +       vhost_vdpa_reset_map(v, asid);
>         kfree(as);
>
>         return 0;
> --
> 1.8.3.1
>

