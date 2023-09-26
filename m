Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0931D7AE4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjIZEpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZEpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE9D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695703497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKd9lX9BKAg4Mb3Rgphudf1CD/sMa9gnwnekBt6buI8=;
        b=dYb/qY4nn6TiAVL/gtNkKWz4IYjLtCJOpB4HKd219x9NpIOoXwqSL0gi1J4TbW1FodMK5F
        8jb5MDjJH8vgD+e2q8jVThjPN4ILk5s8zfERsbpeeYdnVQPPZ4YvSLqaN5wRAmwogU4PP8
        XReG3ajoGWFeTgebdnodu5KPtmJtwWc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ImWaDquEPpq_-NQpMCsP8Q-1; Tue, 26 Sep 2023 00:44:56 -0400
X-MC-Unique: ImWaDquEPpq_-NQpMCsP8Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50433961a36so10105149e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703494; x=1696308294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKd9lX9BKAg4Mb3Rgphudf1CD/sMa9gnwnekBt6buI8=;
        b=K7EqBIQFEmfDd6QYEUJhR0MYKgBQ5cfF1wiTXpnNERX5SvNciyqgBdb2Dcv9CLr1k7
         ENcWHv2HdZGIzMbYWLlNEf0mIBqIB97nb3WekHfB8vfFY3tSTdGPJILYlWhGEOf+GBRA
         /HTPkoKCcuSOxzOAzoRXiEZxVMb/V0fcsxijHoji94XjUvtXW//vBUbe2vj5HbOp7PW+
         Kdbpi5bTXmNlFc+kh/OyBE1SKD9mR9haaFZYsKp7y559p7xeJ5LLf7nSNoeyVZBQBtt2
         m/sy78ryYA389oRUNvGvXvPGSg8pWVsLsGVW0fFWFRkytFSNBPXRbDN6ZIQqKTwqGX35
         YJLQ==
X-Gm-Message-State: AOJu0Yz+HS8R7fkissuePKsZFc8h4dzOcsLjnByEHyHuDzphuTy/MCRL
        AINQq/9VOn48EDBBvdtSX4sXFZsQDeerpEpnq7cbWRcRqVggFTlq10S+w7om1o2yWVpl0U6w5/D
        zFOXNuKPMZ2t6fqe1N8btm2zWqpaV94BwvfNk3FQn2DoCJutRVgaXfw==
X-Received: by 2002:ac2:5298:0:b0:500:9a45:63b with SMTP id q24-20020ac25298000000b005009a45063bmr6461820lfm.13.1695703494185;
        Mon, 25 Sep 2023 21:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU/RlQVUf27AIXEYRyQljY5TrTb67tO7dTmq4dl8jclKO22hbKDJfJ0W7Wj+Lu4TwB0pdoCzPHtpU0PCHihoQ=
X-Received: by 2002:ac2:5298:0:b0:500:9a45:63b with SMTP id
 q24-20020ac25298000000b005009a45063bmr6461810lfm.13.1695703493888; Mon, 25
 Sep 2023 21:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com> <20230912130132.561193-10-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-10-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 12:44:43 +0800
Message-ID: <CACGkMEsC_rgnKyG3stFbc-Mz2yiKGwNUYYqG64jQbNpZBtnVvg@mail.gmail.com>
Subject: Re: [PATCH 09/16] vdpa/mlx5: Allow creation/deletion of any given mr struct
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:02=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> This patch adapts the mr creation/deletion code to be able to work with
> any given mr struct pointer. All the APIs are adapted to take an extra
> parameter for the mr.
>
> mlx5_vdpa_create/delete_mr doesn't need a ASID parameter anymore. The
> check is done in the caller instead (mlx5_set_map).
>
> This change is needed for a followup patch which will introduce an
> additional mr for the vq descriptor data.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Thinking of this decoupling I think I have a question.

We advertise 2 address spaces and 2 groups. So we actually don't know
for example which address spaces will be used by dvq.

And actually we allow the user space to do something like

set_group_asid(dvq_group, 0)
set_map(0)
set_group_asid(dvq_group, 1)
set_map(1)

I wonder if the decoupling like this patch can work and why.

It looks to me the most easy way is to let each AS be backed by an MR.
Then we don't even need to care about the dvq, cvq.

Thanks

