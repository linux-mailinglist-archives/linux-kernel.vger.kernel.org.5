Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC297AA745
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 05:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIVDSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 23:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D7194
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695352671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKRFydK7gHJIGc1An0jO34UIyrf6X6QxSb8Wda3PFS4=;
        b=SLqm9b9JeLb5cLUaGKGSDCESjE/sQwdFHMzBCIpS8m6nJaiWBvWuLRunn6sTtQdi2z44sj
        QRi+tB/VnZXVQcQg1ERfJ822Qf+/7YWeaYIV/XmiyA9IVDklpdTgOdJvKK7PB9VWPCLYMG
        puz2Ua6xnfVnpPDxLDrqqHyD3nqXE+g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-_fUxX7PSPvmFtnrBEJN2fQ-1; Thu, 21 Sep 2023 23:17:49 -0400
X-MC-Unique: _fUxX7PSPvmFtnrBEJN2fQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c131ddfeb4so15175651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695352668; x=1695957468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKRFydK7gHJIGc1An0jO34UIyrf6X6QxSb8Wda3PFS4=;
        b=VzYe9eyMh3Spk/p9Z75dF4zOvpprm+//BqhEqSdewx4Ma3XmtD21M7sguTaJuZ6M/W
         Iw/+A5R3XFi4h7JyTg8CsehIL37FfbVaC9G0fPDSaFO+MUEgoWf8rNIankvoWY1AuaaM
         iOtMwVbEGwJOuiIiIYxHYtlqJOu9387Bo57VguGOvp3KvmS8ORZ8FjUNAqOhSEtXDn0+
         nTFaj8Z9Oei3XG6AzQAgB9ruICyWJvc5pAbg3W8iWVZxBxqUvCyJBdsSCYJVH1wEMaTX
         6r2oOJhJcJdxP8ReOrHn59wW0LkP09b7heMqdJRObuZr9mfpjeGyLXh2vQ1Nun7skZJD
         5LFA==
X-Gm-Message-State: AOJu0YyFPB+7e+Zh2hwW4M2aiyiRSq5s3gHjrXqp/dyqlEj/QnjX0axo
        qehRr13w0/KmUHMG1G19ow6Mh4k6lXkJSrqYdwAeslwKggGm5747dK9pdWfpDyAq/eSS0v0WCKB
        ibuvROKxuMu4Q07lYubP2q48QNJWOGFF5+AvPbhv4x9c3LMdncpw=
X-Received: by 2002:a05:6512:b21:b0:503:3278:3221 with SMTP id w33-20020a0565120b2100b0050332783221mr7377463lfu.69.1695352667963;
        Thu, 21 Sep 2023 20:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6jLFAWQobQu7YJsr0/J9NeK5RMThuSKcfHKr41/y/dxVLwUK0Y97f/SS/vWZNDHC+0xxpwdioFz9c/eyEV7A=
X-Received: by 2002:a05:6512:b21:b0:503:3278:3221 with SMTP id
 w33-20020a0565120b2100b0050332783221mr7377433lfu.69.1695352667519; Thu, 21
 Sep 2023 20:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com> <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com> <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 22 Sep 2023 11:17:35 +0800
Message-ID: <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 2:28=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> Hi Jason,
>
> On 2023/9/21 12:22, Jason Wang wrote:
> > On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.co=
m> wrote:
> >>
> >> When guest vm does S3, Qemu will reset and clear some things of virtio
> >> devices, but guest can't aware that, so that may cause some problems.
> >> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> >> resume, that function will destroy render resources of virtio-gpu. As
> >> a result, after guest resume, the display can't come back and we only
> >> saw a black screen. Due to guest can't re-create all the resources, so
> >> we need to let Qemu not to destroy them when S3.
> >>
> >> For above purpose, we need a mechanism that allows guests and QEMU to
> >> negotiate their reset behavior. So this patch add a new parameter
> >> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> >> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> >> devices can change their reset behavior on Qemu side according to
> >> freeze_mode. What's more, freeze_mode can be used for all virtio
> >> devices to affect the behavior of Qemu, not just virtio gpu device.
> >
> > A simple question, why is this issue specific to pci?
> I thought you possibly missed the previous version patches. At the beginn=
ing, I just wanted to add a new feature flag VIRTIO_GPU_F_FREEZE_S3 for vir=
tio-gpu since I encountered virtio-gpu issue during guest S3, so that the g=
uest and qemu can negotiate and change the reset behavior during S3. But Pa=
rav and Mikhail hoped me can improve the feature to a pci level, then other=
 virtio devices can also benefit from it. Although I am not sure if expandi=
ng its influence is appropriate, I have not received any feedback from othe=
rs, so I change it to the pci level and made this version.
> If you are interested, please see the previous version: https://lists.oas=
is-open.org/archives/virtio-comment/202307/msg00209.html, thank you.

This is not a good answer. Let me ask you differently, why don't you
see it in other forms of transport like virtio-gpu-mmio?

Thanks

>
> >
> > Thanks
> >
> >
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  transport-pci.tex | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/transport-pci.tex b/transport-pci.tex
> >> index a5c6719..2543536 100644
> >> --- a/transport-pci.tex
> >> +++ b/transport-pci.tex
> >> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
> >>          le64 queue_desc;                /* read-write */
> >>          le64 queue_driver;              /* read-write */
> >>          le64 queue_device;              /* read-write */
> >> +        le16 freeze_mode;               /* read-write */
> >>          le16 queue_notif_config_data;   /* read-only for driver */
> >>          le16 queue_reset;               /* read-write */
> >>
> >> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure lay=
out}\label{sec:Virtio Transport
> >>  \item[\field{queue_device}]
> >>          The driver writes the physical address of Device Area here.  =
See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >>
> >> +\item[\field{freeze_mode}]
> >> +        The driver writes this to set the freeze mode of virtio pci.
> >> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> >> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and =
virtio-pci enters S3 suspension;
> >> +        Other values are reserved for future use, like S4, etc.
> >> +
> >>  \item[\field{queue_notif_config_data}]
> >>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been=
 negotiated.
> >>          The driver will use this value when driver sends available bu=
ffer
> >> --
> >> 2.34.1
> >>
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
> --
> Best regards,
> Jiqian Chen.

