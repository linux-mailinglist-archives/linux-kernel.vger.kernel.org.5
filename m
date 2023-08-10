Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5594D777375
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjHJIzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjHJIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C3010E7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691657666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syF1yE0Uo9LWT8K9qVuNApPlR5YgTqMfG6lKK6clKkQ=;
        b=I1Vs3e2JxYmR1gGl+CH9IP2RPfrvHRVA52dgAYB17U69wrUUvPYmya1tH8PeVVPnNxqR4t
        CbLGkLp9jv2w8UlivEgNpJJJD5ngO68aLXkracFPnGpbsUon6dRFmSolhjl4AN8HuUuQGL
        RbfmoeQpUVzim9HTkQcZp1x4jz6lbak=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-4lJsANtkNxiqmgQ_R7py-Q-1; Thu, 10 Aug 2023 04:54:25 -0400
X-MC-Unique: 4lJsANtkNxiqmgQ_R7py-Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99c01c680beso54377566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657664; x=1692262464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syF1yE0Uo9LWT8K9qVuNApPlR5YgTqMfG6lKK6clKkQ=;
        b=AbhBkONE1RwoAdWOOGLesqergI2zET1u/c+80n2SM+jnHuQU14xPW7afH1jxHTVRjU
         pqpwvGbM+WI+G7vOVjN+u+epxVR9jqbSn7St0NZs2EmJlQ3OgPhw93Nkb4yyCb+JfA8X
         WAp5ne/KrtCSPEX4nGtsQTIm9RHE7gujv30UW79GInrDlymfVG5EfK+JvhNNFZO5vOn0
         YsQxaNeWakpA0yYJ9aWrK17rmMLWjmgR8oZztsHuNWPBigAFaYXOyoSjdIHAsN5smy02
         x1GLmmR0FWgn7aluqBpma8vkt/JT8WqaBc9dIg/eTKo9CS9QJ9TXD2rugTOznuk++znW
         xzcg==
X-Gm-Message-State: AOJu0YwVT75EZCSieT/uB3ghEictdBOzTTITbWarsLG65AF8chGHyFO3
        NChU5dPIZuuUaI2stjuz29iqhGIhP5QApintqQVuV60Be35GMZjSyLI/y76p95gAcpD9OzTyI++
        DK/BqA/fJKyWScENgPtpYVa0V
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id jx27-20020a170907761b00b0099beca247a8mr1511608ejc.38.1691657664382;
        Thu, 10 Aug 2023 01:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfoYcwfAed0pASymHc6kVO4/QGY/UY6jbAbQ1bPq1grl4/G73DT3oQNt2A8/r/JxJnzu6vQw==
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id jx27-20020a170907761b00b0099beca247a8mr1511585ejc.38.1691657663865;
        Thu, 10 Aug 2023 01:54:23 -0700 (PDT)
Received: from redhat.com ([2.52.137.93])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b0099d0a8ccb5fsm627267ejb.152.2023.08.10.01.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:54:23 -0700 (PDT)
Date:   Thu, 10 Aug 2023 04:54:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling
Message-ID: <20230810045328-mutt-send-email-mst@kernel.org>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802171231.11001-1-dtatulea@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:12:16PM +0300, Dragos Tatulea wrote:
> This patch series is based on Eugenio's fix for handling CVQs in
> a different ASID [0].
> 
> The first patch is the actual fix.
> 
> The next 2 patches are fixing a possible issue that I found while
> implementing patch 1. The patches are ordered like this for clarity.
> 
> [0] https://lore.kernel.org/lkml/20230112142218.725622-1-eperezma@redhat.com/


So what are we doing with this patchset? If we are merging anything
for this release it has to happen now.

> Dragos Tatulea (1):
>   vdpa/mlx5: Fix mr->initialized semantics
> 
> Eugenio Pérez (1):
>   vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +
>  drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  4 +-
>  3 files changed, 74 insertions(+), 29 deletions(-)
> 
> -- 
> 2.41.0

