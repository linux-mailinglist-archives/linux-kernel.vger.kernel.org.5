Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2238F777397
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjHJJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjHJJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4832127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691657999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nKyPrvxOKqENhpjoZF1fWfducNpAl/tgriHmOVfHW4=;
        b=eCqHvLZl+v3uJfy9v1F1PGbY2325LbSeGQQGE3iJPpN/9UMG43aC/PxzLla3fHgaGG8Mf1
        ePHSmZ5GS51We67Io7JRoeWdZS0KYPgMpp8u0nR9U1h8TXxV/zJKeVadNiCpMuKLu+m6K1
        +AykEsN6ExiJQ0cBcxO1w20J9QWJXkA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-2c39PLBfMaGp4rwn90pmGw-1; Thu, 10 Aug 2023 04:59:58 -0400
X-MC-Unique: 2c39PLBfMaGp4rwn90pmGw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b50be2ccso7232701fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657996; x=1692262796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nKyPrvxOKqENhpjoZF1fWfducNpAl/tgriHmOVfHW4=;
        b=YEmwSNxUAnZtZWS+oZ2PdlZopw3k+627LSq8JzzNHA9zkeFAynWLCQSVhtbCMPlkz7
         MviNynPimZ+RgQhf1Qcp5T8vfSHoiNIEEOoeVmz4bm44AT7Ewx4n4dTJ9Uxk4UeNLrli
         An5XqYQSaPjxUH37C2I1acxttEU1TG1ZrZh0C+Wzr6DwER55dU9m4hbS89u+KdsSpGnb
         Kj6ZPyHRVzRKNrJyuP2QVwfrx0xzwqTpnG/+1rRsCLqQg8fEqWPgFZYKlRo8pAtncHOk
         DrMQVF/l2KmST07BteC4oh7xM5QhEU+xDtq5aLVf6bkDTqvCdK/8HLqpFu6FyZfRvxoR
         jBtA==
X-Gm-Message-State: AOJu0Yw73lnRIT9B4hDPWqaRe9K/sTNqtO7Em4I3P7VEUw5X1J46nHMZ
        D3pdLyyoNUn6w4JNCaxQFqeSjZ/eC9xfJPEDCm/wMMTiLMWhMY7Rda3maLUWKbMU+3EYOjuPgB1
        unCOI8/r5Il8ZoiLLf4Cb9XGWvuG+BED2edPTrNMJ
X-Received: by 2002:a2e:9988:0:b0:2b1:ad15:fe38 with SMTP id w8-20020a2e9988000000b002b1ad15fe38mr1294162lji.3.1691657996724;
        Thu, 10 Aug 2023 01:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErTTpEI2vZq9rET0Cw/qHN+pTIeRy3QhOlPdBylyLuwsK9G5DMgUIJj2wRiA/+NWIhUcJx/tEumeoY9qvUFME=
X-Received: by 2002:a2e:9988:0:b0:2b1:ad15:fe38 with SMTP id
 w8-20020a2e9988000000b002b1ad15fe38mr1294149lji.3.1691657996352; Thu, 10 Aug
 2023 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230810045328-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810045328-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Aug 2023 16:59:45 +0800
Message-ID: <CACGkMEtM+PJkZ09iYZ-wZaGNa-4aEJktGeCZX3U5hmAYjVp9oA@mail.gmail.com>
Subject: Re: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
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

On Thu, Aug 10, 2023 at 4:54=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Aug 02, 2023 at 08:12:16PM +0300, Dragos Tatulea wrote:
> > This patch series is based on Eugenio's fix for handling CVQs in
> > a different ASID [0].
> >
> > The first patch is the actual fix.
> >
> > The next 2 patches are fixing a possible issue that I found while
> > implementing patch 1. The patches are ordered like this for clarity.
> >
> > [0] https://lore.kernel.org/lkml/20230112142218.725622-1-eperezma@redha=
t.com/
>
>
> So what are we doing with this patchset? If we are merging anything
> for this release it has to happen now.

I think we can merge this and do optimization on top.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > Dragos Tatulea (1):
> >   vdpa/mlx5: Fix mr->initialized semantics
> >
> > Eugenio P=C3=A9rez (1):
> >   vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary
> >
> >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +
> >  drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  4 +-
> >  3 files changed, 74 insertions(+), 29 deletions(-)
> >
> > --
> > 2.41.0
>

