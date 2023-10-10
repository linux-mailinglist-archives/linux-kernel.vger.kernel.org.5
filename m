Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE967BF32D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442310AbjJJGeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442269AbjJJGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113991
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696919609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/WWvP4QrvqQqSlBOZhfRHFJcoPieF7wXeR0DebzApE=;
        b=CSSG9fYvrrcfDqlDSH0qF6qYktvSa4blBdZ2qMn7QzGVZGawBWKDy98ZWZEcmmFmJQDGmi
        2TVLOcUQsOWweC3w/JbnW/0vFMJ2STLuLERYHVHLbNMh5/0VKxMreoNuGzR33GwSrrqiA7
        QLCFqpkSTNIQnvu4auR/D3qALixTTfE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-yMMFDbdiNQG9bE5ZGblzZA-1; Tue, 10 Oct 2023 02:33:27 -0400
X-MC-Unique: yMMFDbdiNQG9bE5ZGblzZA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-503269edbb3so4888232e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919606; x=1697524406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/WWvP4QrvqQqSlBOZhfRHFJcoPieF7wXeR0DebzApE=;
        b=ByTEnd9TFfqpMfVg8cf38i4EUoaO0Y/CYVCpaCM4FnOF76AGovSmG6q1RZYVtTSBVj
         CseOdpxIQBrV1we7J2xIvjiA2y4Zv93ieF+w1aKGwnYURoWOndOH3GwiBJqWy1+vPqzO
         Ar6T5qakH66AIOexYwfZJ85Ay0ylINvPbvyH8+CJShTErSYP1Lx236H9elTz+7e3b19/
         ItRMpq/WIZeZDpwmg8oMQHCdxREhPyqPMJ4K/lrlsiz17q6HMn8Oan0O0hvVcMLtuMzk
         EZA7cPKmYxdXYWz+YcNLgqjCgE0j270HJsID5r+VvPaRY7DBz+gaBRQhM0Pr+wt8UsZ0
         /sWw==
X-Gm-Message-State: AOJu0YyYJ3XdgpbwJbsF6M+EIsW/YzrcP6I8nBjt+zj5+wZut6Sbpz48
        qPKO4sooCKSZMExxaglAp1RxldeDonOTMP4gaXykKMY8Q48QsjrTtg60+I5x84lZvnSEwCfTtnr
        axFMG2ClSjMJ9UcpBx2BFGODPMm8x4iqKRZVSqkM2
X-Received: by 2002:ac2:4f09:0:b0:500:b553:c09e with SMTP id k9-20020ac24f09000000b00500b553c09emr18089923lfr.32.1696919605992;
        Mon, 09 Oct 2023 23:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfDwrS8UnprtgX0H66/N9LaZXIPIn1izgf0p9kGHS1+OexDm2JvipAbhcvFs0hN9t/aq0yQfXWido0W9mnmrw=
X-Received: by 2002:ac2:4f09:0:b0:500:b553:c09e with SMTP id
 k9-20020ac24f09000000b00500b553c09emr18089905lfr.32.1696919605637; Mon, 09
 Oct 2023 23:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com> <20231009112401.1060447-17-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-17-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:33:14 +0800
Message-ID: <CACGkMEuffeRaJh9P4Mo-PnXk06mFWKDbCcR_0Eogx3FBU-KW-A@mail.gmail.com>
Subject: Re: [PATCH vhost v3 16/16] vdpa/mlx5: Update cvq iotlb mapping on
 ASID change
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:25=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> For the following sequence:
> - cvq group is in ASID 0
> - .set_map(1, cvq_iotlb)
> - .set_group_asid(cvq_group, 1)
>
> ... the cvq mapping from ASID 0 will be used. This is not always correct
> behaviour.
>
> This patch adds support for the above mentioned flow by saving the iotlb
> on each .set_map and updating the cvq iotlb with it on a cvq group change=
.
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

