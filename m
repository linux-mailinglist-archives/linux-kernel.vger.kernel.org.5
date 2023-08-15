Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0177C5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjHOC0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjHOC0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705710D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692066334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huMkYyI3IopZTTExqIZljSG+E6z9zvyVd59pXzY9sp0=;
        b=ZWwcMBorVRDwHEH9JdZ0K4Zz0sR68a1j2Js5cJQZndy3CElAAMpUBeTITbKiSaGjSgVBV9
        LqlCKVltEWDIiPFdTVreAJsQx180AowHTFJD1jXpFI/x0ekpMwElTcKR+8dd0Nq2PwmHIv
        bHLd0Cd2eITtRYwHz3Bi0d0oxGofsZk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-MDOKDVoXOci7a18IL5ruTg-1; Mon, 14 Aug 2023 22:25:33 -0400
X-MC-Unique: MDOKDVoXOci7a18IL5ruTg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ba7e6c988dso24064321fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066331; x=1692671131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huMkYyI3IopZTTExqIZljSG+E6z9zvyVd59pXzY9sp0=;
        b=GmFnD3e5CgzdE3CYtHJs4q296COH8m63T2PFI37Iq4JLQX5BWXlBmrCbDCHWv/nBMq
         6LRsi/EMZknnLd51V9Zvoqly7h+tgkhBejBSldgC0Vcu68Aam0mI/UKL2lVVqn5R7yQ3
         XZ2vgy6EfyMulr3jiaky4I/3+igJZU9W8M03T2ilZgG4aM/qTZS1JWE3IWvqq5lg67vL
         NtmhKbJaEDhzlBbhyv9X+C6NfU0UNxk93y8X9FhQ6cuGYYrEuGGPe8Jsyn38RoaPWBqH
         P/FgAZj/2Wm8zZk+K+vRcvSRVwyiWAw8uFF6SRdRt2qsEx2/c7BFJoTlVLE28GGUT5It
         wB5A==
X-Gm-Message-State: AOJu0YzjxwnpKw2REjPu9vSRsFiTMk/uR1eovmSl4Tbc6CGEuk8k+JwZ
        i7ElY+Qy0skjCIPTEAoLsHSXxUC1AoFryBklMxEimoud/xMq/kkR97P3IyEbdi3xCoqjpYIHz7o
        IY1ZFnl6B+3PyXOjH5qVqXmO9JJdEhLtFYKiEgelJ
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id e8-20020a2e8188000000b002b1ad15fe38mr8101338ljg.3.1692066331497;
        Mon, 14 Aug 2023 19:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvNiChZXsvQ/GLTCda14YUfdruIORDb1RwBBHhABgmjUe5mDgZEACu5ef/nXi9/8n+tfCK+O1Ea5+BczO9278=
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id
 e8-20020a2e8188000000b002b1ad15fe38mr8101327ljg.3.1692066331219; Mon, 14 Aug
 2023 19:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Aug 2023 10:25:20 +0800
Message-ID: <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
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
>  drivers/vhost/vdpa.c             | 16 +++++++++++++++-
>  include/uapi/linux/vhost_types.h |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 62b0a01..75092a7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -406,6 +406,14 @@ static bool vhost_vdpa_can_resume(const struct vhost=
_vdpa *v)
>         return ops->resume;
>  }
>
> +static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +
> +       return (!ops->set_map && !ops->dma_map) || ops->reset_map;

So this means the IOTLB/IOMMU mappings have already been decoupled
from the vdpa reset. So it should have been noticed by the userspace.
I guess we can just fix the simulator and mlx5 then we are fine?

Thanks

