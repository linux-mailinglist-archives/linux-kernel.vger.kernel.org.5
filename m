Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF3F7865D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjHXDZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbjHXDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF910EF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692847447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPglN9jWCOWkDHiaVESzd3fbifjjVGG3Y2tLlmCAqyw=;
        b=YUcZrJDx4MKgaE6mggOC/NfxnV8JswraF0my3vZzvliflbdcTLtVXsL1O7pH+lx2RavZJQ
        y8KgM+xKXYtUNhRZetCOrs74BTxu+vI4H6qWiM636jhRaLhjB551bMKUKhq/HzVt5iFZRl
        N1qxYh3k8P3QCegLtY4rY8Vs7WfT+MI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-9PNl8kMyOK24lvCA0irGJw-1; Wed, 23 Aug 2023 23:24:04 -0400
X-MC-Unique: 9PNl8kMyOK24lvCA0irGJw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bcdd6ba578so14805081fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692847443; x=1693452243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPglN9jWCOWkDHiaVESzd3fbifjjVGG3Y2tLlmCAqyw=;
        b=kWDwQ3jt77Ip5wRuwmR42e8FBojsTAPy6LzUQEJ5mtnnEA0Ln3NXsmnWZZUzXPXPOr
         s+/WzWo51z8PZoQ2/SVCbHqw73ohDb0Scs/4eZRTM2ktl9aSnh3H3NwDjrel0GKpMDjS
         nxyX/lO0nM1vl3e0ZsX8dwT+CDSRSqVSIb3vDNAENkhxA64cOA4xGUTOqz8n2edHeuGn
         Qd+y0K7aIwA4Vu74brmYNEaM2FR3ARdXOPzpUAusSJyUQUZ8RFKkB3twQkWO2IaWLcZ8
         HXxeojO022IN0J2pSaiMJAu69kUqOsJaM8/kFtSjnmuOF20LJ62PBv5FvMkyuNwcdiz7
         8dAg==
X-Gm-Message-State: AOJu0YzUaZ3U0YiUtgBjEE1otEt331HhU1PdrVJBB083o0RD/aQ5+dG8
        6BXBID5CWwreda6Uv5wG9+QjgCkoBfRLKrTgCf0v3CJewQAIlavHBYE/AoK4zbmXXfIi4oHqfSm
        ymFnK05EcspQPudeiij9rIaGcqCVzu5rwJyv5sEik
X-Received: by 2002:a2e:b710:0:b0:2b5:80e0:f18e with SMTP id j16-20020a2eb710000000b002b580e0f18emr11256982ljo.3.1692847443057;
        Wed, 23 Aug 2023 20:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjkeGqdviCPH5wTUExjQLr+CqEbEiWt/ba0nY6S4lLgHFwDlCy0ER84ojf2Z39Sci9dtg33fDr0zJFePv+spQ=
X-Received: by 2002:a2e:b710:0:b0:2b5:80e0:f18e with SMTP id
 j16-20020a2eb710000000b002b580e0f18emr11256978ljo.3.1692847442724; Wed, 23
 Aug 2023 20:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230823153032.239304-1-eric.auger@redhat.com>
In-Reply-To: <20230823153032.239304-1-eric.auger@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 24 Aug 2023 11:23:51 +0800
Message-ID: <CACGkMEseBgbQx1ESA+QV_Y+BDdmwYPVg1UjUu2G0S2B6ksDeyQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
        mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:30=E2=80=AFPM Eric Auger <eric.auger@redhat.com>=
 wrote:
>
> Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
> entries") Forbade vhost iotlb msg with null size to prevent entries
> with size =3D start =3D 0 and last =3D ULONG_MAX to end up in the iotlb.
>
> Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
> only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
> message types to fix a regression observed with batching hit.
>
> Still, the introduction of that check introduced a regression for
> some users attempting to invalidate the whole ULONG_MAX range by
> setting the size to 0. This is the case with qemu/smmuv3/vhost
> integration which does not work anymore. It Looks safe to partially
> revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
> with null size. vhost_iotlb_del_range() will compute a correct end
> iova. Same for vhost_vdpa_iotlb_unmap().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Cc: stable@vger.kernel.org

I think we need to document the usage of 0 as msg.size for
IOTLB_INVALIDATE in uapi.

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entri=
es")
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c71d573f1c94..e0c181ad17e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>                 goto done;
>         }
>
> -       if ((msg.type =3D=3D VHOST_IOTLB_UPDATE ||
> -            msg.type =3D=3D VHOST_IOTLB_INVALIDATE) &&
> -            msg.size =3D=3D 0) {
> +       if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
>                 ret =3D -EINVAL;
>                 goto done;
>         }
> --
> 2.41.0
>

