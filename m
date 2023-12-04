Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D2802DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbjLDIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEC19B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701679155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lscDHZ3yIZ/I6JT9P4DnclNKVqFrNnL7Ykz8yhYHIkY=;
        b=RjOICxCwtgtiz6D0EzSF8c8o0L4EgBQ3hEXS9kNITikruPcnefLbmQ5OPKpwGw7QI/v2K5
        Y19ssLpzZeNzgmFcuQJeDH+bbv2X+g1fGiSXeTjPirmSG3FmgLZxIiWwk+5ylGl7a++mES
        x6UDLJQZVAxWUlAqhDwPPMhE0Q4UnzI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-0qjdUYfuOjSfHBJzT0tyGg-1; Mon, 04 Dec 2023 03:39:13 -0500
X-MC-Unique: 0qjdUYfuOjSfHBJzT0tyGg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bec8466b6so1001183e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679151; x=1702283951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lscDHZ3yIZ/I6JT9P4DnclNKVqFrNnL7Ykz8yhYHIkY=;
        b=TMW/b+Q4ggZxSstH+CByMW7oiAedw79OA/vzwy5mJvnzE8F0jvKamST3g+mr+iLjqT
         2b4VCXu938zbRS5jtEa40Iy6FXfzo38szIuD20xHHFJ7o5QXOP/CYqgzTchQo1XO4mSg
         KQO5aYPSN3DHVPLzB2xL81hgU43bKCUbig/yVjWnNL5fPmmTXnkRj+aUobyZGfw6A4dL
         ne0TH31SfJeYOUUi5wfavXSYVRJ73z5whG1dH4qXV0s/G7lrcmhUq5euhx35SqBKk7Bb
         2ndrobYaXbpoDdqltF9jWZvt+v/22o8UZ9zebVy5xRAqyzF03BtyHIpQJcOj8O0f18cV
         CuRw==
X-Gm-Message-State: AOJu0YyjcU54oQO5hOWeRRR7BXfH+60rZ/urXaX2PxyVDPiohhw13y/6
        fouqn7vlO/YsJEFghe0oja+pxawgGKGMucvlzdaToRKBxsYkx3ViOlMYOnVLZl8EZd5DUAKpXFd
        9h+7Nw4h2341SFBejkeC/At3dWcKipX7ly9eanIRW
X-Received: by 2002:a19:c516:0:b0:50b:d764:8807 with SMTP id w22-20020a19c516000000b0050bd7648807mr2128138lfe.83.1701679151724;
        Mon, 04 Dec 2023 00:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnL4fXkMjcRU8JcX5iOM2K50RXffBA5cF0/9EhGkq9ffq7aFG4xQmmO0uFOQqbnohhHm7yM+U7oYAHpRgFKkE=
X-Received: by 2002:a19:c516:0:b0:50b:d764:8807 with SMTP id
 w22-20020a19c516000000b0050bd7648807mr2128133lfe.83.1701679151331; Mon, 04
 Dec 2023 00:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20231102143507.840-1-jiangkunkun@huawei.com> <87msvt6cc7.wl-maz@kernel.org>
 <1fb8353e-e9c4-2570-c2ca-ec537c18ac4d@huawei.com> <86edh228xx.wl-maz@kernel.org>
 <952bd5dc-dd20-acc3-d77e-c9b14e5728d3@huawei.com> <87fs0k94og.wl-maz@kernel.org>
In-Reply-To: <87fs0k94og.wl-maz@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 4 Dec 2023 16:39:00 +0800
Message-ID: <CACGkMEt5sapZjpyBSM5oX_=k1AcefEe5D4wtX=HqtHy4AD3j_g@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm/arm64: GICv4: Support shared VLPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kunkun Jiang <jiangkunkun@huawei.com>, dongli.zhang@oracle.com,
        cohuck@redhat.com, stefanha@redhat.com, mst@redhat.com,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 8:20=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Kunkun,
>
> On Wed, 08 Nov 2023 09:45:51 +0000,
> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
> >
> > Hi Marc,
> >
> > On 2023/11/6 23:33, Marc Zyngier wrote:
> > > On Mon, 06 Nov 2023 14:59:01 +0000,
> > > Kunkun Jiang <jiangkunkun@huawei.com> wrote:
> > >> The virtio-pci driver write entry1-6
> > >> massage.data in the msix-table and trap to QEMU for processing. The
> > >> massage.data is as follow:
> > >>> entry-0 0
> > >>> entry-1 1
> > >>> entry-2 1
> > >>> entry-3 1
> > >>> entry-4 1
> > >>> entry-5 1
> > >>> entry-6 1

It looks like a bug from the driver. It should only use vector 0 and 1
in this case.

Could you please check the queue_msix_vector for each queue in this case?

> > > Urgh... is vp_modern_queue_vector() used in your configuration? This
> > > is ... terrible.
> > I encountered this problem using the 4.19 version kernel, but not the
> > 5.10 version. This vp_modern_queue_vector() function does not exist
> > in 4.19, but it uses 'vp_iowrite16(msix_vec, &cfg->queue_msix_vector)',
> > the same as vp_modern_queue_vector().
> >
> > In the past two days, I learned about the virtio driver and made some
> > new discoveries. When 'num_queues' is greater than maxcpus, it will
> > fall back into MSI-X with one shared for queues. The two patches[1],
> > submitted by Dongli, limits the number of hw queues used by
> > virtio-blk/virtio-scsi by 'nr_cpu_ids'. The two patches were merged
> > in 5.1-rc2. And the patch related virtio-blk was merged into the 4.19
> > stable branch.The patch related virtio-scsi was not merged.
> > [1]
> > https://lore.kernel.org/all/1553682995-5682-1-git-send-email-dongli.zha=
ng@oracle.com/
> >
> > This is the earliest discussion.
> > https://lore.kernel.org/all/e4afe4c5-0262-4500-aeec-60f30734b4fc@defaul=
t/
> >
> > I don't know if there are other circumstances that would cause it to
> > fall back into MSI-X with one shared for queues. At least the hack
> > method is possible.
> > > I wonder if PCIe actually allows this sort of thing.
> > Do you think the virtio driver should be modified?
>
> I think the virtio driver should stop messing with the MSI-X
> configuration behind the kernel's back. For example, what happens if
> the kernel needs to do a disable_irq() on the "shared" interrupt? It
> will mask the interrupt in *one* of the vectors, and the interrupt
> will still be screaming.
>
> This is terribly broken, even on x86.

Let's try to see the queue_msix_vector. A correct implemented device
should not try to use a vector more than 1.

>
> > > In any case, this sort of behaviour breaks so many thing in KVM's
> > > implementation that I'd recommend you disable GICv4 until we have a
> > > good solution for that.
> > There seems to be no restriction in the GIC specification that multiple
> > host irqs cannot be mapped to the same vlpi. Or maybe I didn't notice.
> > Do you think there are any risks?
>
> Please see 5.2.10 ("Restrictions for INTID mapping rules"), which
> clearly forbids the case we have here: "Maps multiple EventID-DeviceID
> combinations to the same virtual LPI INTID-vPEID.".
>
> > GICv3 does not have this issue, but is this configuration legal?
>
> With GICv3, the ITS doesn't see multiple mappings to the same
> LPI. Each DeviceID/EventID pair has its own LPI, and KVM will just see
> the injection callback from VFIO.
>
> Honestly, the virtio driver is broken (irrespective of the
> architecture), and incompatible with the GIC architecture.

No matter how the driver is written, the host/KVM should be able to
survive from that.

Thanks

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>

