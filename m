Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213767D3C37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjJWQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjJWQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CEDD7B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698078013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k37AOFeZP6MoGUQ4Vb6wM81gZSQoevmW3tnnk23uv6g=;
        b=M3xUdv7X+cUNIOUODfQ7py6LCJ/u/Q620Y9DA2w/EYhsupbs0iNtEau5HzMuFG3IIo32RT
        RVwGjohrN1nLPKEm8FPh7lNln6qJWUEE1r4KdkGw56GkuutkMwjd/JU8N36uT/v0dXiXt+
        XwNkgRO3ZXPcb1z7GQ23ABnM++La8q8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-pJJjJQerO4i7QsTjW4RruQ-1; Mon, 23 Oct 2023 12:20:11 -0400
X-MC-Unique: pJJjJQerO4i7QsTjW4RruQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457cf1d3546so1071480137.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698078011; x=1698682811;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k37AOFeZP6MoGUQ4Vb6wM81gZSQoevmW3tnnk23uv6g=;
        b=kie5GiEr0SMEJiNeI2ddaeE8xzca1tMNQW5UOFy1YJ48UAyFt2Sl0RdoN7TFIYNbTq
         xuc4DMYUY6zv6wZFwFHgRpiyBevCT9elkx+QHIe2sChN+6uWCvehgdP6d4SxEXJhWU7S
         Qn7KQ2OIu03X2wjDN7D4P/x4LYx+6hsYBkx94xPPzXSeK86/6jgHHwQx+HHysjFSLsia
         0RwkL1wK+mpE+PM3VfI+VyA9qedcQErIJdHgYgtt+JAXqULtJSydiMkaihksN8/AAEvO
         4vsBWIvKC9UGZziSkGQPSNb5L5/ICnjankszoZqkAl9VpPifkx/qAh751x7MFivB7lLz
         aa6w==
X-Gm-Message-State: AOJu0YyLGpV5Z2CksmQks8Wc2hRkAwGZVcfCVpZIG7I95Zw/Fgy6j09G
        eSejzp+/9AKUMkaAt5zhU1RKTcUMxHOmx0x9p6bI9ZjkkXL8yXGfnhqjgZFqCm1hEmxNVRsDwdp
        MHoUBVs8RVOo/stjeQnpearkY
X-Received: by 2002:a05:6102:201e:b0:45a:446e:9e56 with SMTP id p30-20020a056102201e00b0045a446e9e56mr2318775vsr.9.1698078010938;
        Mon, 23 Oct 2023 09:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi48t6vWTK9XJQ7E5pyKLYihfMFWMt0mcnEpdf7HDs/kK+hudXHJ+x0AjO5S+z8qlQD+tK/g==
X-Received: by 2002:a05:6102:201e:b0:45a:446e:9e56 with SMTP id p30-20020a056102201e00b0045a446e9e56mr2318758vsr.9.1698078010681;
        Mon, 23 Oct 2023 09:20:10 -0700 (PDT)
Received: from rh (p200300c93f0047001ec25c15da4a4a7b.dip0.t-ipconnect.de. [2003:c9:3f00:4700:1ec2:5c15:da4a:4a7b])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a0a0700b00767d572d651sm2816785qka.87.2023.10.23.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:20:10 -0700 (PDT)
Date:   Mon, 23 Oct 2023 18:20:05 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v8 04/13] KVM: arm64: PMU: Set PMCR_EL0.N for vCPU based
 on the associated PMU
In-Reply-To: <20231020214053.2144305-5-rananta@google.com>
Message-ID: <d6721a96-ddbb-6cf9-0fed-6fc754982ffe@redhat.com>
References: <20231020214053.2144305-1-rananta@google.com> <20231020214053.2144305-5-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Raghavendra Rao Ananta wrote:
> The number of PMU event counters is indicated in PMCR_EL0.N.
> For a vCPU with PMUv3 configured, the value is set to the same
> value as the current PE on every vCPU reset.  Unless the vCPU is
> pinned to PEs that has the PMU associated to the guest from the
> initial vCPU reset, the value might be different from the PMU's
> PMCR_EL0.N on heterogeneous PMU systems.
>
> Fix this by setting the vCPU's PMCR_EL0.N to the PMU's PMCR_EL0.N
> value. Track the PMCR_EL0.N per guest, as only one PMU can be set
> for the guest (PMCR_EL0.N must be the same for all vCPUs of the
> guest), and it is convenient for updating the value.
>
> To achieve this, the patch introduces a helper,
> kvm_arm_pmu_get_max_counters(), that reads the maximum number of
> counters from the arm_pmu associated to the VM. Make the function
> global as upcoming patches will be interested to know the value
> while setting the PMCR.N of the guest from userspace.
>
> KVM does not yet support userspace modifying PMCR_EL0.N.
> The following patch will add support for that.
>
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>

