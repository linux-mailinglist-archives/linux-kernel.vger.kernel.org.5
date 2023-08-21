Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62D9782211
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjHUEA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjHUEA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FE8E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692590377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nreHUn0JxkoanDSj8+vpmXEimTfEctb6qeC7zgFBAZ8=;
        b=ICN4cEz3U0IlxfhiEx0ijb8hT9J/8Y4ZgK7X2IYajPhLaapEhepstvcTvX7u8rGg8NL7tM
        AVkyVzJGE0QjziZnIEP6HXJZRaXVkSHdcNpDlXx3px9dJD5cOIMRk5r9wrUjwMfBhNtQBp
        fiyDWtElHwvWPb1DIfwNfCcm59igB3E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-67fzzZ24NVeb13X3c9rlog-1; Sun, 20 Aug 2023 23:59:36 -0400
X-MC-Unique: 67fzzZ24NVeb13X3c9rlog-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bb9bcac581so29339071fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 20:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692590374; x=1693195174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nreHUn0JxkoanDSj8+vpmXEimTfEctb6qeC7zgFBAZ8=;
        b=G4Vo/mH8dY9EnQnAiWtI33h6OcL9TjEPJShr0cXhcMKGNttRKewszmMJ7K8rFebWAa
         z6JBC+9uZVhNL9Y+tWaJdZIgc3yMqxlGCd/3rGhpl/qvgzMJj6nWbvkD7JXg6cp/+YVP
         OfbMnlsACJKQ+32UglmpS3b5Er79mg3MZC5Gt/VAiAJ7XwauG7M64uOAcGC3tVfGsidL
         AK98OTQfvcPh3eWfheJwP9U739zT+wdvReFg75p0lNHuEFbQRcpMwx0fWtKMbkNaRylW
         criyb7f3fhccVEUd2AHuChoj6E7bu+uxVw4wGOAx8mjC3DjtMTfkLvvKTeepM6SIKGlK
         SxUg==
X-Gm-Message-State: AOJu0YzjlECx7vZ5AuUV17gH5CUE1nIxnA+SJsX1wP3XP9OXpT6fukU0
        TOIDaw8j7f/Zz1F2yIQyhQ8NywGGsizulegDNDHFWDA6v+zOD4/3jtp7CMQimdfr7eXT87hWmU7
        +VCAGZHQZm9vGxUer+3+Bqf8xmZOZBh7GtilQFSL/
X-Received: by 2002:a2e:3112:0:b0:2b9:f13b:6139 with SMTP id x18-20020a2e3112000000b002b9f13b6139mr3790128ljx.20.1692590374666;
        Sun, 20 Aug 2023 20:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoBfF77nVJ4yrfjIeH14bn2Sai5TI3z+fImzUqsK4koFFUoPXY3bC1l2hD9WkdtuxTln8L++7hBwtc5Kq6axs=
X-Received: by 2002:a2e:3112:0:b0:2b9:f13b:6139 with SMTP id
 x18-20020a2e3112000000b002b9f13b6139mr3790120ljx.20.1692590374399; Sun, 20
 Aug 2023 20:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230821021835.1134-1-shawn.shao@jaguarmicro.com>
In-Reply-To: <20230821021835.1134-1-shawn.shao@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 21 Aug 2023 11:59:23 +0800
Message-ID: <CACGkMEs=B6yswCE0O_J+_X_XO9bPx-R+dM9SvSM77wyoCTroDg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: Fix the potential leak of mgmt_dev
To:     "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lege.wang@jaguarmicro.com
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

On Mon, Aug 21, 2023 at 10:18=E2=80=AFAM Shawn.Shao <shawn.shao@jaguarmicro=
.com> wrote:
>
> If the shared_buffer allocation fails, need to unregister mgmt_dev first.
>

Please add a Fixes tag.

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 00d7d72713be..b3a3cb165795 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -499,12 +499,13 @@ static int __init vdpasim_blk_init(void)
>                                          GFP_KERNEL);
>                 if (!shared_buffer) {
>                         ret =3D -ENOMEM;
> -                       goto parent_err;
> +                       goto mgmt_dev_err;
>                 }
>         }
>
>         return 0;
> -
> +mgmt_dev_err:
> +       vdpa_mgmtdev_unregister(&mgmt_dev);
>  parent_err:
>         device_unregister(&vdpasim_blk_mgmtdev);
>         return ret;
> --
> 2.34.1
>

