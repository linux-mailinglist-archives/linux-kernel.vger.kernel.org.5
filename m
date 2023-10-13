Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36F7C7BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJMDFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMDFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498091
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697166299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zDrSwzdAeWMb/6P4lK++T4MCrJYZFn5wg8AsD0sQBw=;
        b=h7dpMCZKqkum9wGdPIb6Paynw1zG2n15MiVikE6uB/UDWObSrGK8oqI6w4Nve0reVHaQPr
        Ovr9QuK5aiD2AqhfUrjZ7kOF79XFu0y267UCX3Q/daonDu/6xwiZq2pALqK4Z+8wxP8KIu
        llx9F69SmQxAEqsSUfyfCflmpYT4/mI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-DU5cjUsrOluEKYqvN-EV3A-1; Thu, 12 Oct 2023 23:04:57 -0400
X-MC-Unique: DU5cjUsrOluEKYqvN-EV3A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-503c774fd61so1566480e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697166296; x=1697771096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zDrSwzdAeWMb/6P4lK++T4MCrJYZFn5wg8AsD0sQBw=;
        b=HTmTINHJxoXmYZlnecynfReSlgdNuuidafxhdMhRCjkIFiyHSvUK3MFYAf/vg5poBX
         8Mp6OlYri1ytKncg35aNp/z21DJov3mUy7u3Z1zAcSQsUcgXY30RRyxy9+stHVU0GBAY
         owv5Sm+EXG40TudnA6Evw8feql7qifT8gz+Qb4FkUAbA8JIlwN9xrjAQQ78ca8smj2pd
         UPpag3eHJnBnoOnu5n5Y0AyoN0C6w4Oa/CiNcApnuF1tKW55gd4j2lf1Q+0mJsMifqw5
         heWAo4N8NUbFQlJGUGSHm2nvLK3TOwNWlmCNIvvt0y8K8gcwN9LdBZjTiurHdbGVESoi
         UZRQ==
X-Gm-Message-State: AOJu0Yx5bWhgWRMQ7UOQfRXU4h8+HLTYxKi0WjtBKLadjc+b1L/4kic8
        Fl6zUXT+IMcSync/k6da7Zevq7hBYPz3/E7enTIYplPi5V2mRSlmTfReLHizFGIPa1tlL4A5zwc
        Q6zVsWRVhGzMOsS+C0ep6caD3vwlTVOGggnO2bs4l
X-Received: by 2002:a05:6512:220b:b0:500:a66b:b189 with SMTP id h11-20020a056512220b00b00500a66bb189mr27156027lfu.51.1697166296492;
        Thu, 12 Oct 2023 20:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGddNL/kYX2H3Iu0ZNgDi52JWSlSlKIs1t+wGjc1PqbgAKfekZ6PZ06oO8kQyqeje+O7m30cse1FthqZTJhn5c=
X-Received: by 2002:a05:6512:220b:b0:500:a66b:b189 with SMTP id
 h11-20020a056512220b00b00500a66bb189mr27156017lfu.51.1697166296198; Thu, 12
 Oct 2023 20:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com> <1696928580-7520-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-5-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 13 Oct 2023 11:04:45 +0800
Message-ID: <CACGkMEtCasGmTNBZxfu2gJfSMCfD1jtKGH3cb9HCPXFP7YACpQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] vdpa/mlx5: implement .reset_map driver op
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Since commit 6f5312f80183 ("vdpa/mlx5: Add support for running with
> virtio_vdpa"), mlx5_vdpa starts with preallocate 1:1 DMA MR at device
> creation time. This 1:1 DMA MR will be implicitly destroyed while
> the first .set_map call is invoked, in which case callers like
> vhost-vdpa will start to set up custom mappings. When the .reset
> callback is invoked, the custom mappings will be cleared and the 1:1
> DMA MR will be re-created.
>
> In order to reduce excessive memory mapping cost in live migration,
> it is desirable to decouple the vhost-vdpa IOTLB abstraction from
> the virtio device life cycle, i.e. mappings can be kept around intact
> across virtio device reset. Leverage the .reset_map callback, which
> is meant to destroy the regular MR on the given ASID and recreate the
> initial DMA mapping. That way, the device .reset op can run free from
> having to maintain and clean up memory mappings by itself.
>
> The cvq mapping also needs to be cleared if is in the given ASID.
>
> Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

I wonder if the simulator suffers from the exact same issue. If yes,
let's fix the simulator as well?

Thanks

