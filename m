Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF880B079
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjLHXQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:16:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3690;
        Fri,  8 Dec 2023 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702077387; x=1733613387;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrkQgErWxcsZqBk5WmhIoSbSMmbYCndRvIe0pEDMALU=;
  b=f8ilxil0l648S3YJRWS9mQP6//5RLmA3gJ26kRymCPMmx99k5+mScP/M
   qt+I1BWiND1VTq5dXpS1AnzFWU5pcPh6uYix4X7qQyb0WaraS1lZVbnCG
   hts8nD7XH6b3FdgvC3FvU36xkZtfrdsug42PSIYmmsLjZxouATyH8Y7dc
   /T+jKvuLlC1eE8OfG7Fk7DqjDs/sY/crMk79O+FgZB7AdRql08BVa4ioa
   ylFeWNzk4TljQKZnUaG3pOtFIwL9tP7RQnyzNgmFBR5oZ85fFqtFbmy5X
   YnmUMFFWRoZFqWCfpbJa6FjTVG1qbncjZDpKxtOWM+v863cOopfoAmgA/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1328109"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1328109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1103722427"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1103722427"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:16:24 -0800
Date:   Fri, 8 Dec 2023 15:21:16 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 01/13] x86: Move posted interrupt descriptor out of
 vmx code
Message-ID: <20231208152116.1c09a17c@jacob-builder>
In-Reply-To: <875y19t507.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
        <20231112041643.2868316-2-jacob.jun.pan@linux.intel.com>
        <87wmtruw87.ffs@tglx>
        <20231207205431.75a214c2@jacob-builder>
        <875y19t507.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, 08 Dec 2023 10:31:20 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Thu, Dec 07 2023 at 20:54, Jacob Pan wrote:
> > On Wed, 06 Dec 2023 17:33:28 +0100, Thomas Gleixner <tglx@linutronix.de>
> > wrote: =20
> >> On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> >> 	u32			rsvd[6];
> >> } __aligned(64);
> >>  =20
> > It seems bit-fields cannot pass type check. I got these compile error. =
=20
>=20
> And why are you telling me that instead if simply fixing it?
My point is that I am not sure this change is worthwhile unless I don't do
the per CPU pointer check.

gcc cannot take bit-field address afaik. So the problem is that with this
bit-field change we don't have individual members anymore to check pointers.

e.g.
./include/linux/percpu-defs.h:363:20: error: cannot take address of
bit-field =E2=80=98nv=E2=80=99 363 |  __verify_pcpu_ptr(&(variable)); =20


Thanks,

Jacob
