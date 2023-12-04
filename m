Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB480350A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjLDNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjLDNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69DFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701696945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPLjkMKhb/yN6uza/CZonJukPPzHmDUsgYusJt0FzJI=;
        b=OgTu38yHGzJm7mLQ0ToJUQ2qFTBGbL493Mati9774n2Iz+LsZT9qC0RB4VUVfOPmIoYXrk
        3xzWCcVdXJeXtzhzsrtHOaa9USgHufyFP+yPP2NQWZ8eON7HQKiFbED0u3YLZz7r+MF5lv
        JjTCx+Flqc1D2MImKMsRz/J8WjYQvfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-15jMGRiJMdWVnIBXOZbIZA-1; Mon, 04 Dec 2023 08:35:44 -0500
X-MC-Unique: 15jMGRiJMdWVnIBXOZbIZA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4083717431eso31823935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696943; x=1702301743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPLjkMKhb/yN6uza/CZonJukPPzHmDUsgYusJt0FzJI=;
        b=B1jpCrkRTd310riQiuc2tR1PkTL4jyKje0QmXIYfx3zAnNq+rjEN4C7F6C1vB5ROVK
         GvL7e7voj6+CMOFgodVOdldaOJ5cE4mXWlvqG6dsmMPt3whTsjVmbqPYliLhGQQf89R5
         XApfx1uXXNnVbZRSMxYF8WeBpfiK+zjkcszGeIEL860w0Ui0+GtORmBT+JBSNCECwjGX
         kFujvoHyNZWIhIrlphgfagDP713h00Renk06RS2fHb9RqFJGa4fYOdmsxdcyb5FCnIQu
         DfFJyriXpjT3h94o+1flhvs9rpkqO35qq6GPhugDoU4dsC8mtusnrML4WkSc8tKHxuhz
         bwrQ==
X-Gm-Message-State: AOJu0Yz9cw2t3X/LaGevdpH/FvmMSOc+FG35yZnYob2drH1Acp4H9g0E
        aRqm2soi04wseTLuQ5O/D8/joj1oCEaNOleyG/TS0TwVlAWKV5vx2DpRwNQFN+QqtPEK6QdiKgo
        8oaL/fEAlZ5el4ekGbp8dSM44
X-Received: by 2002:a05:600c:5249:b0:40b:4812:22e2 with SMTP id fc9-20020a05600c524900b0040b481222e2mr3037647wmb.11.1701696943435;
        Mon, 04 Dec 2023 05:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDp2grvGqA7ydmNhVKG2SPd8szY8OykiJCR53YNzSTxnrJyMz3Bw/UJ5gx/+EYILIKlV3bSQ==
X-Received: by 2002:a05:600c:5249:b0:40b:4812:22e2 with SMTP id fc9-20020a05600c524900b0040b481222e2mr3037640wmb.11.1701696943098;
        Mon, 04 Dec 2023 05:35:43 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0040b4b66110csm15028901wmo.22.2023.12.04.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:35:42 -0800 (PST)
Date:   Mon, 4 Dec 2023 08:35:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH V3] vdpa/mlx5: preserve CVQ vringh index
Message-ID: <20231204083524-mutt-send-email-mst@kernel.org>
References: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
 <22981f62-5c57-41c4-8ed2-a11b7b93d062@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22981f62-5c57-41c4-8ed2-a11b7b93d062@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's in my tee and I'm sending it to Linus.

On Mon, Dec 04, 2023 at 08:33:22AM -0500, Steven Sistare wrote:
> What's the decision here, pull it, or do not fix it?
> 
> - Steve
> 
> On 11/3/2023 8:26 AM, Steve Sistare wrote:
> > mlx5_vdpa does not preserve userland's view of vring base for the control
> > queue in the following sequence:
> > 
> > ioctl VHOST_SET_VRING_BASE
> > ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
> >   mlx5_vdpa_set_status()
> >     setup_cvq_vring()
> >       vringh_init_iotlb()
> >         vringh_init_kern()
> >           vrh->last_avail_idx = 0;
> > ioctl VHOST_GET_VRING_BASE
> > 
> > To fix, restore the value of cvq->vring.last_avail_idx after calling
> > vringh_init_iotlb.
> > 
> > Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 946488b8989f..ca972af3c89a 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
> >  	struct mlx5_control_vq *cvq = &mvdev->cvq;
> >  	int err = 0;
> >  
> > -	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> > +	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> > +		u16 idx = cvq->vring.last_avail_idx;
> > +
> >  		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> >  					MLX5_CVQ_MAX_ENT, false,
> >  					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
> >  					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
> >  					(struct vring_used *)(uintptr_t)cvq->device_addr);
> >  
> > +		if (!err)
> > +			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
> > +	}
> >  	return err;
> >  }
> >  

