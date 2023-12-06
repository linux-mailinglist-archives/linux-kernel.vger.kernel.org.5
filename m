Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFD8075CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442609AbjLFQvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442665AbjLFQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:51:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEEED49;
        Wed,  6 Dec 2023 08:51:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701881464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkueEXleFbgExk0a0lURGsIHGLxrWyf0HqszIiThf44=;
        b=WSNs1+i1dStYIoVoJafri4vNythtGmzPymVdl5afymUnz3jDXKHQMZGXEKSWnvASC7Z702
        t6MVoKRw7b8/FEePGwOdmPLUnRRTzZm5sCba6FgoFaxlrevmJkoX5L2xAk4VZDsZaNDgKX
        mgEotppHj7sQEa3i5LN9Ajj07GbrdYwjumNb/BlEmKH6QeBB59HBQg2g2opNUL+7EtOpQb
        yPG1a0bM8bZbWK7fWSk2+cJWCBOxGUPVR095250MC6RgtU/9aQqh6F5H+Z3FKYS5inb5R8
        8uJvyRTqORm2rBccG5ITwi3CxU98kBKMLeXRYJ8NOyrQruTnDA9kqVWJGZQI3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701881464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkueEXleFbgExk0a0lURGsIHGLxrWyf0HqszIiThf44=;
        b=Vp3C8OgryszFtbRjBLJPG+uKFiNUYhtaARIoZDBsqtJRJi98GUEYobrbL9oHlqul+gOrJM
        R3Fft0AnJAOnkwDQ==
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
Subject: Re: [PATCH RFC 06/13] x86/irq: Unionize PID.PIR for 64bit access
 w/o casting
In-Reply-To: <20231112041643.2868316-7-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-7-jacob.jun.pan@linux.intel.com>
Date:   Wed, 06 Dec 2023 17:51:04 +0100
Message-ID: <87lea7uvev.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> Make PIR field into u64 such that atomic xchg64 can be used without ugly
> casting.

Make PIR field into... That's not a sentence.


> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  arch/x86/include/asm/posted_intr.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
> index 2cd9ac1af835..3af00f5395e4 100644
> --- a/arch/x86/include/asm/posted_intr.h
> +++ b/arch/x86/include/asm/posted_intr.h
> @@ -9,7 +9,10 @@
>  
>  /* Posted-Interrupt Descriptor */
>  struct pi_desc {
> -	u32 pir[8];     /* Posted interrupt requested */
> +	union {
> +		u32 pir[8];     /* Posted interrupt requested */
> +		u64 pir_l[4];

pir_l is really not intuitive. What's wrong with spelling the type out
in the name: pir64[4] ?

> +	};
>  	union {
>  		struct {
>  				/* bit 256 - Outstanding Notification */
