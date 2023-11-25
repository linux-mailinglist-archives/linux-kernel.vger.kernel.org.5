Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617F7F88EE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjKYHoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjKYHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F62A10F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700898225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPcp2kfkJWwJkN3y6bMbR5mAObAMJOnKE0qW0hK6n2c=;
        b=X7HxousYPPff3f+OxMxQrqy3Bvxy2JKAlTwR30/HfM1o8WNdfE0ppXx9iFwV4NRdpm4128
        1q8XmNJWphP5EV2eNVghPBiNwSbLhC89/cBAYKNR1uwXt3xaudh2XT7uffc8APIrzil23U
        JAp9CqLNZeIr1ykeRsgcqGSRpYmF7sc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-ove06uA9OCCzM7Henf4tFg-1; Sat, 25 Nov 2023 02:43:43 -0500
X-MC-Unique: ove06uA9OCCzM7Henf4tFg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a01c7b09335so193537566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700898222; x=1701503022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPcp2kfkJWwJkN3y6bMbR5mAObAMJOnKE0qW0hK6n2c=;
        b=i8HYQQN+c7zLOLkafGp0Q5uNTWNSn1iNSmtyphPG5ix1VkvqHUwskoAc4uN4N+C6cp
         r8ZZ7gNYlibNdAN9OwssDS8eUWdjNGr96K3o2RAUEANDTDCrr0CBd9MsT421kbsfvgaN
         dQSdxR4dHIHmO7iouv7RxsgRKKaDRvvdnCLc59ZoUoypM3RMMHilQXcb9ahpmxdu3sGA
         khyGxxUEwk0zXByKQkPqGeJRCRa55+En9F7G7FAnaGJ1hK1oyi4EzXSNkUaSk0Wq4V1C
         Lx4gY+6Ay20Q1biCEy/h0jVMpWznapn0Wn0SULb7D3v5kJsx8nUiRvjZxyM/lMNLfhn6
         8mbQ==
X-Gm-Message-State: AOJu0YyUc735kPBevFv/ygPAkqIQxPHqKEuvK4eyi4iDDF/mliEW0c0S
        7Tlb6983ZB4zJ1rabUDPuie+J+BQoWdeODACZWOarBmuTyLImWnriwOe1gXV0M/zvA1hRoDWMOk
        oV2zfGaOBuBL2VEGAn3PC/ozyZrgk7VN7g6T6dGVe
X-Received: by 2002:a50:a6d4:0:b0:54b:1aae:8560 with SMTP id f20-20020a50a6d4000000b0054b1aae8560mr1088154edc.15.1700898222342;
        Fri, 24 Nov 2023 23:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3UOv4zlSap3s8nXa6WBtVb5dFpv4YY8ms50ZA2GiF/2GvnNXPJ3aXe2rbF3/WuWoFq3x+WGWcKaQlnPK2nKo=
X-Received: by 2002:a50:a6d4:0:b0:54b:1aae:8560 with SMTP id
 f20-20020a50a6d4000000b0054b1aae8560mr1088147edc.15.1700898222118; Fri, 24
 Nov 2023 23:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-5-lulu@redhat.com>
 <CACGkMEtPk=n5RFp0yAKddYbsAm3dd1U8qgYXmHHOr9MP-+wWpg@mail.gmail.com>
In-Reply-To: <CACGkMEtPk=n5RFp0yAKddYbsAm3dd1U8qgYXmHHOr9MP-+wWpg@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 25 Nov 2023 15:43:04 +0800
Message-ID: <CACLfguWEUgsbuvCzZUWiEtwJvQqun6mo-jkzhS=PYTNTzMWeiQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vduse: update the vq_info in ioctl
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 3:12=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
>
> For driver, did you mean virtio driver?
>
> > with reconnect info, After mapping the reconnect pages to userspace
> > The userspace App will update the reconnect_time in
> > struct vhost_reconnect_vring, If this is not 0 then it means this
> > vq is reconnected and will update the last_avail_idx
>
> I have a hard time understanding the above.
>
sure, I will re-write this part
thanks
cindy
> Thanks
>

