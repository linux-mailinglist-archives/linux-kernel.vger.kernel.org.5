Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972727C7BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjJMDD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjJMDDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818BF91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697166145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fh5pL38+B6R3gU+K0Col33PyIlfMXMZvWZg4AIIPXj0=;
        b=b+mkcRtFCtkentf7pQ/ZFPRBiVy/JWUcmnjMFlA/7vbkp5iLyq3WqUHRPbI1nbB9EoLPiD
        kNkKw2AkML479DWm09Z3AJvHlXRb1R+pJ/QwcyeStSzlflE4KEFlp33Q5ql/S28VnnXSK0
        51wSZW/tofYYdbAkd6FmjkTnZhkoj7Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-umina9EYONyGIbzZK-GeyA-1; Thu, 12 Oct 2023 23:02:14 -0400
X-MC-Unique: umina9EYONyGIbzZK-GeyA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5042d5a3f13so1589768e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697166132; x=1697770932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fh5pL38+B6R3gU+K0Col33PyIlfMXMZvWZg4AIIPXj0=;
        b=NosmMzBtiSYw9XHPAdzzEaB/TPDrf5WGO7en4OSivy4aelr/l5lNF9AkUAnzMoPcyj
         JbAeIZ7FwGBMeXDftUPFr/UhHTzIfJrt1hu7cYxt0a8xR4+Vs5fS6n1xqdQnsP8IWnSI
         RQZseb0n6eMcSOaVuh2S4pTYFJYHAuxp8zV+CCv0R+YmJ/KH5LMzArFVKLGEy2NeRnc6
         UtbP0R84R0U0DQH0AeZmrFHAs3NKUFPXkK0/NCmvXp5a1zUK+nIZ7zizu7DTg59gYFiE
         EPi9HqpPUirdUU/IqMQCRMTWquiYOX+DHuYdALLFiu4PjJpYGSYdI0AQJSUAuNweyBwm
         sOzw==
X-Gm-Message-State: AOJu0Yz3Y0bpF/b6MNkLJ9Wodg7PLDeSB7texldAYh2pbJOrk5GVv+2l
        WQUppWjps7gABnpMECeTTlPXNxmX2CcZ2oGnKFSd67TcMI/S6oOaL2pE5zWN6+9ALMyu8WuTe2f
        F9ywNzh8Wm8Pk9cKUclHfTBmKChVRUnY0b2N6DA/m
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id t21-20020a056512069500b0050328cbc087mr32985467lfe.29.1697166132485;
        Thu, 12 Oct 2023 20:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHuVr/OjVrU/12Uzu6MgIHAsEMtvjUL8K454unWWAu/RqnNAL4TKk85GMF0sHqXNsyIBYN789XrHxITvoGNqw=
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id
 t21-20020a056512069500b0050328cbc087mr32985456lfe.29.1697166132169; Thu, 12
 Oct 2023 20:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com> <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 13 Oct 2023 11:01:59 +0800
Message-ID: <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Devices with on-chip IOMMU or vendor specific IOTLB implementation
> may need to restore iotlb mapping to the initial or default state
> using the .reset_map op, as it's desirable for some parent devices
> to solely manipulate mappings by its own, independent of virtio device
> state. For instance, device reset does not cause mapping go away on
> such IOTLB model in need of persistent mapping. Before vhost-vdpa
> is going away, give them a chance to reset iotlb back to the initial
> state in vhost_vdpa_cleanup().
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 851535f..a3f8160 100644
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
> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v=
, u32 asid)
>
>         hlist_del(&as->hash_link);
>         vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> +       /*
> +        * Devices with vendor specific IOMMU may need to restore
> +        * iotlb to the initial or default state which is not done
> +        * through device reset, as the IOTLB mapping manipulation
> +        * could be decoupled from the virtio device life cycle.
> +        */

Should we do this according to whether IOTLB_PRESIST is set? Otherwise
we may break old userspace.

Thanks

> +       vhost_vdpa_reset_map(v, asid);
>         kfree(as);
>
>         return 0;
> --
> 1.8.3.1
>

