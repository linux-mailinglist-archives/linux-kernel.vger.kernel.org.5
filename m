Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5C807944
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442889AbjLFUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442871AbjLFUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:19:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A4109;
        Wed,  6 Dec 2023 12:19:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701893951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6TvwDJnaqqPW4TKCaM9yFlVVCjb/BuENvek6Jb76QA=;
        b=yTwcWeDw7jPqj5+q0Tx4CJX0jhjsa8DXjdRMbR8dfVtqxJ7USOz0OxSri/O/U/KLk1wG/6
        CWdZo5rXeBZ3QgYogA9k01EOEn1ckb6+Y1IhHI6VVbp1oW7DBS/TutaLzgZquJqIqMO0IY
        zD5UQEjc5ugi45SXhRLlkO8gBXAm3xbdvi+syUjCDaryjTeCz6VzH9JooLyiPuldtJ7xi2
        3cHu2IwFbaQ4t2mVJJneP2swPjBaSpCM78mketPCPH1Fr7HNg68ufaHD6G/QTFTssXMYZh
        tkwRktIzScZ3Hs2QrBWMyjHnp578AGAfFMIOB/kLDNwdC20OJW9BnfNa9fpBFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701893951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R6TvwDJnaqqPW4TKCaM9yFlVVCjb/BuENvek6Jb76QA=;
        b=/IhuCefGBcRqXjbOu3r6B3enCMu7fAlAAfJvyNQkViUERDz3yOwRbSMVuQvwtQRnthcLvo
        ieKXyNIikRBRqRCA==
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 12/13] iommu/vt-d: Add a helper to retrieve PID address
In-Reply-To: <20231112041643.2868316-13-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-13-jacob.jun.pan@linux.intel.com>
Date:   Wed, 06 Dec 2023 21:19:11 +0100
Message-ID: <874jgvuls0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> When programming IRTE for posted mode, we need to retrieve the
> physical

we need .... I surely did not write this changelog.

> address of the posted interrupt descriptor (PID) that belongs to it's
> target CPU.
>
> This per CPU PID has already been set up during cpu_init().

This information is useful because?

> +static u64 get_pi_desc_addr(struct irq_data *irqd)
> +{
> +	int cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));

The effective affinity mask is magically correct when this is called?

