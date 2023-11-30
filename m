Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7557FF2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjK3O4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjK3O4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:56:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0D133
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:56:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF04C433C7;
        Thu, 30 Nov 2023 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701356218;
        bh=GpBXBuO6iixv10ETLZMpn7khg0ZMspsWXBNle1mq37U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j23gMi96EXhnTOprv0TuU8Or8MmOdcYvxLznXcAghhv7HR0rRqVqQRMf9Aewyy3RU
         TencKa4igtrQMc6Lq+diZUvs83N2Bpn8QGWosZCW7yh28lDHF2YRNTbHhpECuyM6Bu
         yD5m6LOMCxB/x0aUNdz+mVVFadzg42PLNNwEagtyGJLuY6/freGE7/3IBC2u7V7H1s
         UMSlsk9jaIqSN+7TI/iPysEbW61wDGbTVr3y6WSMeL7taITRvVKBM/NlzF3+iH5aGH
         Wz9nBpWNpjjurYTharEeuEjfPdzAZEGHHiBPwZ2RYRgjZj1pCoVKZvqeQmvql3YhL7
         eyBS0bDjl16wA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bb92811c0so1025913e87.1;
        Thu, 30 Nov 2023 06:56:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/yk5NlIjNUN6g0h3awUEQankLz8BXXnVcfE+0lazrQCTZ85wv
        FTf6MCe6NsJ72+sGpMYKWhi0ipfVcU/UqK3dDw==
X-Google-Smtp-Source: AGHT+IGo9+hwZbxNr54yXWh69cfY32jjew+hEBiuusC6kMJDQptRw29wukfMiu6+gPSwl3ItrcFP74MRuMgWAcqeURY=
X-Received: by 2002:a19:ac0d:0:b0:50b:c42e:7c4f with SMTP id
 g13-20020a19ac0d000000b0050bc42e7c4fmr1756657lfc.15.1701356195582; Thu, 30
 Nov 2023 06:56:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701268753.git.robin.murphy@arm.com> <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
In-Reply-To: <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 30 Nov 2023 08:56:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+V_=um5+Kz1AofDxx8_gqdWGeYqPdaxMDV1HiPsvq=A@mail.gmail.com>
Message-ID: <CAL_JsqJ+V_=um5+Kz1AofDxx8_gqdWGeYqPdaxMDV1HiPsvq=A@mail.gmail.com>
Subject: Re: [PATCH 2/7] OF: Simplify DMA range calculations
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:43=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> Juggling start, end, and size values for a range is somewhat redundant
> and a little hard to follow. Consolidate down to just using inclusive
> start and end, which saves us worrying about size overflows for full
> 64-bit ranges (note that passing a potentially-overflowed value through
> to arch_setup_dma_ops() is benign for all current implementations, and
> this is working towards removing that anyway).
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/device.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
