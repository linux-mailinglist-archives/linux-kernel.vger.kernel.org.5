Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153D7F3EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjKVHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjKVHNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731F1981
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700637163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOZkO8qhRakrGWQK6hXlhD9YdOROybaos54DNqPfh8g=;
        b=UK4vV6Rk30x0yCyKEvaZ8rkC20PknHrfu6yapnzoENtCe5bcHKEVXzZ6kRoChad12ABrTq
        AOEKjwlPB8yD99aE5wFImgt3G+44rRyyAS1HjkGAj8ODZzkFGhSd68+Yzb+ibUH/MkhjsS
        R+1E6c12Q7Z1RL5soGxSb4NHEYudLDM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-u4Ew-QIFOkGneoY-Toncmw-1; Wed, 22 Nov 2023 02:12:41 -0500
X-MC-Unique: u4Ew-QIFOkGneoY-Toncmw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50943cb2d96so362421e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700637159; x=1701241959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOZkO8qhRakrGWQK6hXlhD9YdOROybaos54DNqPfh8g=;
        b=eHRJhNLy/ZqFs1bme8tgAfRUi+Aj6pIhrG9XRaipMINBEtx8l4D/FTObY3MGhEaQz0
         lkoYxY7cop5vgvecYEVSdE+jZPfme/M4uozbrsT2X6PVXiRmnkzpoxPlXn/D1zSLWJBF
         vIC5yBmfeh2COBiou543XG/+GfbI5mluxIlVC6jJSb9W9/oZOt30og9MBmPlmGZ+q3qQ
         dbyfxvs8MDypWbZAu64tsAu3DAMAdw6JPJARnLwpvfrzrajqv4Tyj3+1BK7QYejLWu19
         hQ4u8SSZTJ1wZUudFootuMF8lm521uP191eEWeQ+sV5hgQEna/ZziMdCMEw/yRiJga+u
         4wpg==
X-Gm-Message-State: AOJu0YyaR4jl8k2qjPoaUqr4Ya/YzIQmrXvbnsnOQudBCNg6zbsJMxHa
        naqQgc90c8synizJrVnCrN4VzR7/PDoYfJf6Jrr6Ykoc8HLPl1x2dwPOJUT/nA7y7F0eAVI1j6c
        0sz25/Fa4ed+d/r/A5UmriusOifXqrK9QaB2nY7ErQqoBVFHAt6Cz2g==
X-Received: by 2002:a05:6512:ac7:b0:50a:aa64:a6a9 with SMTP id n7-20020a0565120ac700b0050aaa64a6a9mr2004106lfu.16.1700637159306;
        Tue, 21 Nov 2023 23:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5vAgAyvxdngS5ywYOyBZ1tyQMV/GjsHPnqNMDi+yIB6mg8/iiuC7yRX/7sAP3XbtEbyeU5UfeYeX0asPQLsw=
X-Received: by 2002:a05:6512:ac7:b0:50a:aa64:a6a9 with SMTP id
 n7-20020a0565120ac700b0050aaa64a6a9mr2004099lfu.16.1700637159020; Tue, 21 Nov
 2023 23:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-5-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-5-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Nov 2023 15:12:28 +0800
Message-ID: <CACGkMEtPk=n5RFp0yAKddYbsAm3dd1U8qgYXmHHOr9MP-+wWpg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vduse: update the vq_info in ioctl
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx

For driver, did you mean virtio driver?

> with reconnect info, After mapping the reconnect pages to userspace
> The userspace App will update the reconnect_time in
> struct vhost_reconnect_vring, If this is not 0 then it means this
> vq is reconnected and will update the last_avail_idx

I have a hard time understanding the above.

Thanks

