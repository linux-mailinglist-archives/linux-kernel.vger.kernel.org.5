Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8B802E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjLDJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3ECD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701680830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOT92qB4CMJ9QUbkuwnTO771HPULUzewrnuOIhnYnrA=;
        b=V6fUcEMFkmJKX2j9SO2AVmOibMrQoaIH6zS6e2B+lveZqXiA30QQs+dSdPM6gisVqMvku9
        9DROCT4E5kvyewyUiV0cIrHcoQuLLCLW2W5b9GLCoeX1vKzURH5GGfOttVSxzfDu65j8+g
        8c4wfub5U4EopCY2b/fjCYTa1Dbazbc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-idleBifQMLaQpkRyw0PE0A-1; Mon, 04 Dec 2023 04:07:09 -0500
X-MC-Unique: idleBifQMLaQpkRyw0PE0A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bf44ff4a5so618949e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680827; x=1702285627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOT92qB4CMJ9QUbkuwnTO771HPULUzewrnuOIhnYnrA=;
        b=m/t4rwOakQpdl8J+WhY76vq/4BEgTPOkVuTY0I1Y2J5Qunof8CINEMZNzo48f2N+LB
         LuyagRQyhG9Fb9XO0ltoRt/+oszv37EE+x89AvPzpJl3ywZwJCPGggWrDkS336oFnjv4
         o3Camlxjw8R4HecuFonjAtpq1oqjPpA5L2WdDCSbPZtLOlI8V9RFxGIXG74gxDLHmokR
         UCjH16P1FzqBtdYLc8FbwSoCxH4mU6B5cMXQDSR4lLEqqIiliXIEhxD06LDzHfS2/3yj
         1D4Gw7ngACnFrL7q3H4VpIIAQnLI5GFlToGwvDUHc/kqJU6o0Ztk4dXni15QKJ+XvJPF
         PgAQ==
X-Gm-Message-State: AOJu0Yx/LAXwc2KhDhCMAyKcd78FdMazgOB7wmx6ct9/ODKLgznJ2fs7
        LFUVFh3QHr77kgo9KG7zIuznL2m3ABXpjFWSEzO8PO7jhCvza5ScrPxTSiTXC6FV4dXpsu04SOE
        0XyZiqN1ChVKmWsTYvZJOCl8cEe1wjiXqTocifN7Z
X-Received: by 2002:ac2:5ddc:0:b0:50b:ed75:e41e with SMTP id x28-20020ac25ddc000000b0050bed75e41emr1071690lfq.137.1701680827486;
        Mon, 04 Dec 2023 01:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFloYnZJhKiWXJvfZn9O+NlEFY8BvoUovFJHb+vkj50ZLTND8ieQqQqM7hWWze49I6e4qF+4+KMyiuUX3+Z9lo=
X-Received: by 2002:ac2:5ddc:0:b0:50b:ed75:e41e with SMTP id
 x28-20020ac25ddc000000b0050bed75e41emr1071685lfq.137.1701680827120; Mon, 04
 Dec 2023 01:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20231102143507.840-1-jiangkunkun@huawei.com> <87msvt6cc7.wl-maz@kernel.org>
 <1fb8353e-e9c4-2570-c2ca-ec537c18ac4d@huawei.com> <86edh228xx.wl-maz@kernel.org>
 <952bd5dc-dd20-acc3-d77e-c9b14e5728d3@huawei.com> <87fs0k94og.wl-maz@kernel.org>
 <CACGkMEt5sapZjpyBSM5oX_=k1AcefEe5D4wtX=HqtHy4AD3j_g@mail.gmail.com>
 <CACGkMEub4f0FWsrJzSK4e+9cC6LUNFm3vAcfSkpsp6pD=WM5qA@mail.gmail.com> <86r0k2bavu.wl-maz@kernel.org>
In-Reply-To: <86r0k2bavu.wl-maz@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 4 Dec 2023 17:06:56 +0800
Message-ID: <CACGkMEvLpHm+vEB80mc0QdzJkFK5bAt-gH72ypV-oOb7oJvB+A@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 5:00=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 04 Dec 2023 08:47:49 +0000,
> Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 4, 2023 at 4:39=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Sat, Dec 2, 2023 at 8:20=E2=80=AFPM Marc Zyngier <maz@kernel.org> =
wrote:
> > > >
> > > > Hi Kunkun,
> > > >
> > > > On Wed, 08 Nov 2023 09:45:51 +0000,
> > > > Kunkun Jiang <jiangkunkun@huawei.com> wrote:
> > > > >
> > > > > Hi Marc,
> > > > >
> > > > > On 2023/11/6 23:33, Marc Zyngier wrote:
> > > > > > On Mon, 06 Nov 2023 14:59:01 +0000,
> > > > > > Kunkun Jiang <jiangkunkun@huawei.com> wrote:
> > > > > >> The virtio-pci driver write entry1-6
> > > > > >> massage.data in the msix-table and trap to QEMU for processing=
. The
> > > > > >> massage.data is as follow:
> > > > > >>> entry-0 0
> > > > > >>> entry-1 1
> > > > > >>> entry-2 1
> > > > > >>> entry-3 1
> > > > > >>> entry-4 1
> > > > > >>> entry-5 1
> > > > > >>> entry-6 1
> > >
> > > It looks like a bug from the driver. It should only use vector 0 and =
1
> > > in this case.
> > >
> > > Could you please check the queue_msix_vector for each queue in this c=
ase?
> >
> > Or did you actually mean queue_msix_vector here? I'm not familiar with
> > ARM but 0 doesn't seem to be a good message.data anyhow.
>
> Why? What's special about 0? 0 is a perfectly fine value.

Ok, looks like I mis-read it as a message.addr. So it's fine.

Thanks

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>

