Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D037BCC1D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjJHEh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 00:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344355AbjJHEh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 00:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA1BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696739835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvtyRRz+nwNRt7FvkUoa8BCNkTJILEam9tMkM/HCha0=;
        b=GqenPu+dl1ud/IxCDURRYbNVjTgPCujCHHXdSDZd37ePVwRBPQH+e+lQIvHXclmWTfiFRn
        j08r00G7lFrM64wh7Vp5Zp7NMUoSATufx4oxnDMG6Jii5JskukYP2hlM2f8x/CveqT1Px7
        7rvJPsNEga3Wed0/lC3rLF8pqvzW+iI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-nb-vXxSiOeitvWi_zFiy-Q-1; Sun, 08 Oct 2023 00:37:13 -0400
X-MC-Unique: nb-vXxSiOeitvWi_zFiy-Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-503177646d2so3021497e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 21:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696739832; x=1697344632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvtyRRz+nwNRt7FvkUoa8BCNkTJILEam9tMkM/HCha0=;
        b=RA4pBWw2G4RVjOau6rm24tnK4Xm5bQn4jTgKqKkAjWSs/VbKOQq0xWxY90AETDfFt8
         dm9ZjEU/n3HU6Xkbl6106B3qid1tQoyDnzuCCT3VmkRG/y52SwYpo59Cp7JTTH+80lbr
         +RHAdaKcv0pGmK0zII7n8JRgsWcPcnmngJ8BWHoSkT2MC83vKZ6la53ExAlapTNneJXS
         hgn2zTJGK3lRED5BxWcsi7ft/WT4jx7pkxlmBQ9grDQGX9px5d+BWd0ZdHoL3AK29XjP
         wBSFR/ec/5bdaoXXa+mp7kZoJLJMFZ4qpJ0EPlB1zLiCIANv+/JBJM8wQhgby+w9BS7f
         +u6A==
X-Gm-Message-State: AOJu0YxO4cFuVKy/YGA3XDTa+0GEyJ8Um/ch7wz7HqygACdFJYVODxng
        EQ4Gkm8D9nCYJ79Re64S9ItABklRPo+oT6s1hPV2wdo/7D/iZfE4vNHVeQeLFJ3xkH2wmgB7GyH
        LKlzs4sYc8A6Fu5K9D3kvbitGZC3D09OhVAGKjPbE
X-Received: by 2002:ac2:4c9b:0:b0:500:9a15:9054 with SMTP id d27-20020ac24c9b000000b005009a159054mr8820041lfl.20.1696739831933;
        Sat, 07 Oct 2023 21:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbwdFniTDysoOdy55vJ9mvDY2iLbB22GYbgOhSxJ2xBXcK3O2G6gfgJld3IG0br8gYtQV4XFjb14Blx0X7c18=
X-Received: by 2002:ac2:4c9b:0:b0:500:9a15:9054 with SMTP id
 d27-20020ac24c9b000000b005009a159054mr8820036lfl.20.1696739831548; Sat, 07
 Oct 2023 21:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20230926050021.717-1-liming.wu@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 8 Oct 2023 12:37:00 +0800
Message-ID: <CACGkMEtF7hZ8kGYi8rF68SzZqdYJ6i1SeuVU2hiBTY-FLapSBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/virtio: Add dma sync api for virtio test
To:     liming.wu@jaguarmicro.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 398776277@qq.com
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

On Tue, Sep 26, 2023 at 1:00=E2=80=AFPM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Fixes: 8bd2f71054bd ("virtio_ring: introduce dma sync api for virtqueue")
> also add dma sync api for virtio test.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  tools/virtio/linux/dma-mapping.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-ma=
pping.h
> index 834a90bd3270..822ecaa8e4df 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -24,11 +24,23 @@ enum dma_data_direction {
>  #define dma_map_page(d, p, o, s, dir) (page_to_phys(p) + (o))
>
>  #define dma_map_single(d, p, s, dir) (virt_to_phys(p))
> +#define dma_map_single_attrs(d, p, s, dir, a) (virt_to_phys(p))
>  #define dma_mapping_error(...) (0)
>
>  #define dma_unmap_single(d, a, s, r) do { (void)(d); (void)(a); (void)(s=
); (void)(r); } while (0)
>  #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s);=
 (void)(r); } while (0)
>
> +#define sg_dma_address(sg) (0)
> +#define dma_need_sync(v, a) (0)
> +#define dma_unmap_single_attrs(d, a, s, r, t) do { \
> +       (void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
> +} while (0)
> +#define dma_sync_single_range_for_cpu(d, a, o, s, r) do { \
> +       (void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> +} while (0)
> +#define dma_sync_single_range_for_device(d, a, o, s, r) do { \
> +       (void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> +} while (0)
>  #define dma_max_mapping_size(...) SIZE_MAX
>
>  #endif
> --
> 2.34.1
>

