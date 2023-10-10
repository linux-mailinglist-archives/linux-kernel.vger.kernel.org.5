Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09A17BF317
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442245AbjJJGbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D04A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696919451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8kjDRjOJKKJXRR5u7v3wOkH6EfelrGYi06F0LmbMIM=;
        b=hxiZrMLyM/gM/iDdYJZTzw01NqIEcv9zjdM57q4zl1cxdWcKXnFIr0MYu7wKZtcn1ysB2A
        DJU0HycORP6WgmRshCaKEA+exDYU/pHPoxn5XuzzeZDSqblwsCbycmhXvn1836kZWAriFy
        JRA/A30bdir9w1K9qKixb3VSO25RmQg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-rIKeFgsINZWqX1ab2VGoLg-1; Tue, 10 Oct 2023 02:30:50 -0400
X-MC-Unique: rIKeFgsINZWqX1ab2VGoLg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-503317b8d26so4617727e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919449; x=1697524249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8kjDRjOJKKJXRR5u7v3wOkH6EfelrGYi06F0LmbMIM=;
        b=iQPlt+sQt4yZfiefGmqy9XzMGel8ucUMxarCAX0M3fw9pf5W7hYsj4Ru0Rx6X73nqW
         cEVXMw0H1syW/39B7XB8n3IxEwqDuMqeInfKXNhtgXcVruyFEqnngl4YKtlQIW9Vyu7E
         /cox/zJbzs8Jmnu1DTkfRKSOcDcB5H9P+HFknFXDH4pauNjKuFpNUGjBZ0llroGLbC3z
         SxN6Ch/0Aupml/Rs/vyUGlJ+dcwejp1cLVL8fMlU6TUopifL1B8EFOGim2LOSQDi9flN
         yLbflakwfE74lDS+kj0Ytw5lx9m3bwrMJTc2MEaDuAHBaHYLy3UUemmWroYcfBHI8mVL
         4Txg==
X-Gm-Message-State: AOJu0YyXJtsKTDIg+y3KCvGJW4mO+9KFEUPQ5wM5NVZ5zKivRHkmpDi9
        Zo7Ww42y9hZhxkBPLhnCpKE9MitzubAo/rZdpZmuCCJIg4gcd/JY1kC12xrsUatNpFRu5Nbr+Ib
        zgvUJtJYHUOWVy1Kit7d7Nq/WO6udnDjHkgi4Q+kM
X-Received: by 2002:ac2:5f89:0:b0:4fb:89e2:fc27 with SMTP id r9-20020ac25f89000000b004fb89e2fc27mr12884999lfe.54.1696919449080;
        Mon, 09 Oct 2023 23:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmDA/vg0tl4u4YUxBy8HtRi4GakgkYvYLlL5YgdSd3QDLzEy3RLtMK2lk5R1+3JDmVtS3GeTuqJDtI9tK9sac=
X-Received: by 2002:ac2:5f89:0:b0:4fb:89e2:fc27 with SMTP id
 r9-20020ac25f89000000b004fb89e2fc27mr12884990lfe.54.1696919448905; Mon, 09
 Oct 2023 23:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com> <20231009112401.1060447-14-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-14-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:30:38 +0800
Message-ID: <CACGkMEupdNSyE-cNCwePjobn8V3rSMi=TV0imfTAUBbAyaeKjQ@mail.gmail.com>
Subject: Re: [PATCH vhost v3 13/16] vdpa/mlx5: Introduce mr for vq descriptor
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:25=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Introduce the vq descriptor group and mr per ASID. Until now
> .set_map on ASID 1 was only updating the cvq iotlb. From now on it also
> creates a mkey for it. The current patch doesn't use it but follow-up
> patches will add hardware support for mapping the vq descriptors.
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

