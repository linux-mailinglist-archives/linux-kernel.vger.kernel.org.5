Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187F803A85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjLDQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjLDQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:38:12 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D76B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:38:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cfc4af9668so19938365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701707899; x=1702312699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDk8VCjkq3XxlHbdv1HgLMD6AIZzaNXkLSxsVVtlfDU=;
        b=ugkvx+DHP4h3V/3/qYu0LuPwb9lAqPV+dulupC0KssmtHBP1Tpaumi3PxrGrbcq9MK
         9weBh3Z259AeuD+nMjPDM5uv7Fbun/MYMp7h3svlIwI19jvBxCFe1HaVVmOPY099BakM
         XzVliDimplLnuHzE7IX3BL8IW6tG0t4w31qHQy9TRQ52GpRSWJOfBndVP99NSqfPDCs2
         PdyXMpm51l4WZEqqZEq1SdXEifBJ18N+ICz/E2DkKDU2iwKmBRYVdYtPqG2WI3UPqVXy
         zbAadWjmTop2y4iYkc7MvUU1tfJ/DUIFpoRHyR256ihxYV01KJGeOzc6n22oHr3cT7eT
         YhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707899; x=1702312699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDk8VCjkq3XxlHbdv1HgLMD6AIZzaNXkLSxsVVtlfDU=;
        b=ADpQ48d3HDyw7NXHkdkg0wxKUOQeirVF37mg1DTHg4R7SyH1WCwE7A33iy5ieG6Mld
         Rskh+Xw/BtIy3Oo33mcsOze9+8FLTfqboySnJD6T0/VgB1sIImLo272bVRmu8/6EQ2PF
         1B2Js2t4DW+rPMiys7tngh6k1FAs8A7k6bzUPMBC1SB06cgTZNaxokWGeVqWo2RgiKH5
         WyiWjdE8hpVqp3NzI8a+U2ZRYSEh8mjrVuWxS73NnPxW5oAs0xo70s2HattAhbEZW0PK
         5bvDDq18uWfzpndAjRpG5Q6v6OZYbljgeY0HnAkyF++6RH3cBoW5VNEOB8C85W24Wt9e
         Zgxg==
X-Gm-Message-State: AOJu0YwMLwqdnyzhpABTYyIFHK0advAOWUPjF+ZOV0PuFs7/ODkGuULe
        skS1U4FSQdv7nI/xmEF5aDGCWGZbzLg=
X-Google-Smtp-Source: AGHT+IH0KOf6e9SiOq5ykueCM2o/G5wmIdosmf1/SYoTYHBbgp+mKLWEKcRI/yzXpAEsOcbbgjKj2C8Ipoo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8204:b0:1d0:71fc:b39c with SMTP id
 x4-20020a170902820400b001d071fcb39cmr163767pln.3.1701707898848; Mon, 04 Dec
 2023 08:38:18 -0800 (PST)
Date:   Mon, 4 Dec 2023 08:38:17 -0800
In-Reply-To: <20231204150800.GD1493156@nvidia.com>
Mime-Version: 1.0
References: <20231202091211.13376-1-yan.y.zhao@intel.com> <20231204150800.GD1493156@nvidia.com>
Message-ID: <ZW4AeZfCYgv6zcy4@google.com>
Subject: Re: [RFC PATCH 00/42] Sharing KVM TDP to IOMMU
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, pbonzini@redhat.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023, Jason Gunthorpe wrote:
> On Sat, Dec 02, 2023 at 05:12:11PM +0800, Yan Zhao wrote:
> > In this series, term "exported" is used in place of "shared" to avoid
> > confusion with terminology "shared EPT" in TDX.
> > 
> > The framework contains 3 main objects:
> > 
> > "KVM TDP FD" object - The interface of KVM to export TDP page tables.
> >                       With this object, KVM allows external components to
> >                       access a TDP page table exported by KVM.
> 
> I don't know much about the internals of kvm, but why have this extra
> user visible piece?

That I don't know, I haven't looked at the gory details of this RFC.

> Isn't there only one "TDP" per kvm fd?

No.  In steady state, with TDP (EPT) enabled and assuming homogeneous capabilities
across all vCPUs, KVM will have 3+ sets of TDP page tables *active* at any given time:

  1. "Normal"
  2. SMM
  3-N. Guest (for L2, i.e. nested, VMs)

The number of possible TDP page tables used for nested VMs is well bounded, but
since devices obviously can't be nested VMs, I won't bother trying to explain the
the various possibilities (nested NPT on AMD is downright ridiculous).

Nested virtualization aside, devices are obviously not capable of running in SMM
and so they all need to use the "normal" page tables.

I highlighted "active" above because if _any_ memslot is deleted, KVM will invalidate
*all* existing page tables and rebuild new page tables as needed.  So over the
lifetime of a VM, KVM could theoretically use an infinite number of page tables.
