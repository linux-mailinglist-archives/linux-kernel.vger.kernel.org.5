Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CE8079AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379582AbjLFUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379446AbjLFUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:43:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1937135;
        Wed,  6 Dec 2023 12:44:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701895443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tt/d27mY59C3uUO6MUg2plSSXPKh9R05K6pzapnG0gA=;
        b=kIlh4/LDNh8d4Kj8mF2tshqjkGW8VUg6IY6TQZALVmfSU1bOYfxNCFkPNET+IL3SuoCHK7
        38cFzSwsoTIpPnaj2XHCvqHMpqZd25mTW7oDvJARAvwjU86YavzyZEAtxpG+ucN4kfMQW3
        87wk/GrPJnAjopOogtnHZjj/Gzh56ux4sIl8cb+7WqkkYopClnkB1saOBCXzKsDPsgNsgn
        qFF6W0h0V6+08QAtk6cKFTSlx4R+7pRVRKlsvhaXlMjzn1fRPRxryRgo++x34fpjC9QgkT
        fIJoKbzOioRZWjvDowdLAqmGbIz/qBjMbCAPpStUdL0vb2aWD8HYUUp5uuuMKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701895443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tt/d27mY59C3uUO6MUg2plSSXPKh9R05K6pzapnG0gA=;
        b=uKMrxTVRbmTQOuVwzsvgOlKvSPYJrwjcJ2j6NmtCUTFAY0aZNpzQ6QzlKQz/zs3C1NujSf
        62DSSdDBuApYu8Bg==
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
Subject: Re: [PATCH RFC 11/13] iommu/vt-d: Add an irq_chip for posted MSIs
In-Reply-To: <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
Date:   Wed, 06 Dec 2023 21:44:02 +0100
Message-ID: <87wmtrt625.ffs@tglx>
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
>  static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
>  {
>  	memset(msg, 0, sizeof(*msg));
> @@ -1361,7 +1397,7 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>  
>  		irq_data->hwirq = (index << 16) + i;
>  		irq_data->chip_data = ird;
> -		irq_data->chip = &intel_ir_chip;
> +		irq_data->chip = posted_msi_supported() ? &intel_ir_chip_post_msi : &intel_ir_chip;

This is just wrong because you change the chip to posted for _ALL_
domains unconditionally.

The only domains which want this chip are the PCI/MSI domains. And those
are distinct from the domains which serve IO/APIC, HPET, no?

So you can set that chip only for PCI/MSI and just let IO/APIC, HPET
domains keep the original chip, which spares any modification of the
IO/APIC domain.


