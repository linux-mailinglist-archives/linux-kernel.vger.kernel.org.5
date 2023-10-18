Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB57CD5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjJRIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJRIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24CCBC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697616310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oo2WWDvelf9ZpXmn8Aak1z8e708XX+d9Qhv4aD4RB10=;
        b=Ip0VsnilP6S92U+DK05kGSdvVAf5bPIYvD2dY6GlmS5aw1OyJa1b+uquieK3mCB27cEdrq
        qsL1AeP8nksIip4E0XlYJkmoaYxKxqDHMbu52TAvERVf98b2Vf2mZJcP5OAUDwIMWQ20rM
        32331CfCtmVekuFP5TnYtTGE0Xfrmpk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-8p7-bxkFOL6ZOxEsUNaOxQ-1; Wed, 18 Oct 2023 04:05:08 -0400
X-MC-Unique: 8p7-bxkFOL6ZOxEsUNaOxQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53da5262466so5028872a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616307; x=1698221107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo2WWDvelf9ZpXmn8Aak1z8e708XX+d9Qhv4aD4RB10=;
        b=tUNzXkSWEzUa3a6ZqRFr1Bh/S4gMNIMrUrN2qJ+3xwlTtfaiac2P7ddOs2GkwhMXZj
         7W2IuBOGsZQ9tn6b42BhffACKGCfEhaLAsxVz5sOUTr67Sej4s48599e3IOLzkpY3xSx
         yqhXO1mOlPoomx8rLCwTCVz5QP5UNjzhdcWk7Ng/VVZIeFxAxVzPsx3tEKFnEtzzQJeD
         N5xS+4hWFI/laF4mjBTCyHnwSrzk3aEys/ImP1Rnu3jFXUkUWknN63Je6CFtlYh/TKxk
         T2fbWY0likyYQxyb2POKtvi9pxkkJe9EFHmTIlSWz7WX1IoztNZVKLC9UO/fwZ3dtoL2
         u1iQ==
X-Gm-Message-State: AOJu0Yxysom9W1/yWvsthI7Dqv/eieTdnySr57lbW1qmDZ/6gxIuctyO
        li3XkQU9B5396d83zPlFA4HeFbuV0D0VjrWDX2JWK+ydXx4Igb9Cm3m5nwdtElLKpUoyjrXcDTm
        ynnf9aTLB9hzNU1Vk05/y62RN
X-Received: by 2002:a50:8e58:0:b0:53e:72be:2b31 with SMTP id 24-20020a508e58000000b0053e72be2b31mr2999942edx.42.1697616307573;
        Wed, 18 Oct 2023 01:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDuei3eKTB65Uz4qXZJ89lMBjiG5Glw5JUyTbr28bRF7oy7Tqap/SHqHaxBWW8wJxzQLQQdw==
X-Received: by 2002:a50:8e58:0:b0:53e:72be:2b31 with SMTP id 24-20020a508e58000000b0053e72be2b31mr2999928edx.42.1697616307174;
        Wed, 18 Oct 2023 01:05:07 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id f19-20020a50d553000000b0053f0e4e0411sm2449088edj.76.2023.10.18.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:05:06 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:05:02 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Message-ID: <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:11:33PM -0700, Si-Wei Liu wrote:
>RFC only. Not tested on vdpa-sim-blk with user virtual address.
>Works fine with vdpa-sim-net which uses physical address to map.
>
>This patch is based on top of [1].
>
>[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>
>Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
>---
>RFC v2:
>  - initialize iotlb to passthrough mode in device add

I tested this version and I didn't see any issue ;-)

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 34 ++++++++++++++++++++++++--------
> 1 file changed, 26 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 76d41058add9..2a0a6042d61d 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -151,13 +151,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> 				 &vdpasim->iommu_lock);
> 	}
>
>-	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
>-		vhost_iotlb_reset(&vdpasim->iommu[i]);
>-		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
>-				      0, VHOST_MAP_RW);
>-		vdpasim->iommu_pt[i] = true;
>-	}
>-
> 	vdpasim->running = true;
> 	spin_unlock(&vdpasim->iommu_lock);
>
>@@ -259,8 +252,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	if (!vdpasim->iommu_pt)
> 		goto err_iommu;
>
>-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
>+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
> 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
>+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
>+				      VHOST_MAP_RW);
>+		vdpasim->iommu_pt[i] = true;
>+	}
>
> 	for (i = 0; i < dev_attr->nvqs; i++)
> 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>@@ -637,6 +634,25 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
> 	return ret;
> }
>
>+static int vdpasim_reset_map(struct vdpa_device *vdpa, unsigned int asid)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+
>+	if (asid >= vdpasim->dev_attr.nas)
>+		return -EINVAL;
>+
>+	spin_lock(&vdpasim->iommu_lock);
>+	if (vdpasim->iommu_pt[asid])
>+		goto out;
>+	vhost_iotlb_reset(&vdpasim->iommu[asid]);
>+	vhost_iotlb_add_range(&vdpasim->iommu[asid], 0, ULONG_MAX,
>+			      0, VHOST_MAP_RW);
>+	vdpasim->iommu_pt[asid] = true;
>+out:
>+	spin_unlock(&vdpasim->iommu_lock);
>+	return 0;
>+}
>+
> static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct *mm)
> {
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>@@ -759,6 +775,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_group_asid         = vdpasim_set_group_asid,
> 	.dma_map                = vdpasim_dma_map,
> 	.dma_unmap              = vdpasim_dma_unmap,
>+	.reset_map              = vdpasim_reset_map,
> 	.bind_mm		= vdpasim_bind_mm,
> 	.unbind_mm		= vdpasim_unbind_mm,
> 	.free                   = vdpasim_free,
>@@ -796,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> 	.get_iova_range         = vdpasim_get_iova_range,
> 	.set_group_asid         = vdpasim_set_group_asid,
> 	.set_map                = vdpasim_set_map,
>+	.reset_map              = vdpasim_reset_map,
> 	.bind_mm		= vdpasim_bind_mm,
> 	.unbind_mm		= vdpasim_unbind_mm,
> 	.free                   = vdpasim_free,
>-- 
>2.39.3
>

