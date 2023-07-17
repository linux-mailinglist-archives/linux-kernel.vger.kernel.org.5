Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A412755FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGQJqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGQJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:45:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375F8191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689587151; x=1721123151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDXsm4U6iPwm/gHpcA6eH2CMKgicEHwy5vRLSE1JCUI=;
  b=E6GmhAVL0Gf5eS79Kx9o61Aa5aKuGMwzqynDWxTnXLFdhOOSB7TPgJNp
   aQnNpnLRZEx4lkvzxalMkPbS+q/xyKtYC7LFZKLUKzK9sr4qtKUy9c0pH
   coXotaq2TXQfBm7Dv/2gL2ROJq13J0Diu4QZHsJjJivwnCdg8tdgcCTFx
   h69KcH2JOPFnHOnho6Z+/PbuZgpUuYZQqZxj0vZUvFXVKkbCrPjEeUrPX
   bp5AVnyqaXHsszC9/9A/UUAVIB5mIsUVkBeo8ubGD0RjZStTq6mEGWf/a
   sAUJk0xQcVfmREcO0rULNCstv+shLy5E7XI55pgm/TV6uTJ/85YvPY3MC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="368531673"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368531673"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="847220700"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="847220700"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.9.176])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:45:47 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Gross, Jurgen" <jgross@suse.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Marczykowski, Marek" <marmarek@invisiblethingslab.com>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page protection modify
 mask
Date:   Mon, 17 Jul 2023 11:45:45 +0200
Message-ID: <7545651.EvYhyI6sBW@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <9c14a3597d658a065e853b6e5f64ff21b4b7b575.camel@intel.com>
References: <20230710073613.8006-2-janusz.krzysztofik@linux.intel.com>
 <9c14a3597d658a065e853b6e5f64ff21b4b7b575.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

On Monday, 10 July 2023 19:58:07 CEST Edgecombe, Rick P wrote:
> On Mon, 2023-07-10 at 09:36 +0200, Janusz Krzysztofik wrote:
> > The issue needs to be fixed by including _PAGE_PAT bit into a bitmask
> > used
> > by pgprot_modify() for selecting bits to be preserved.  We can do
> > that
> > either internally to pgprot_modify() (as initially proposed), or by
> > making
> > _PAGE_PAT a part of _PAGE_CHG_MASK.  If we go for the latter then,
> > since
> > _PAGE_PAT is the same as _PAGE_PSE, we need to note that
> > _HPAGE_CHG_MASK
> > -- a huge pmds' counterpart of _PAGE_CHG_MASK, introduced by commit
> > c489f1257b8c ("thp: add pmd_modify"), defined as (_PAGE_CHG_MASK |
> > _PAGE_PSE) -- will no longer differ from _PAGE_CHG_MASK.  If such
> > modification of _PAGE_CHG_MASK was irrelevant to its users then one
> > might
> > wonder why that new _HPAGE_CHG_MASK symbol was introduced instead of
> > reusing the existing one with that otherwise irrelevant bit
> > (_PAGE_PSE in
> > that case) added.
> > 
> > Assume that adding _PAGE_PAT to _PAGE_CHG_MASK doesn't break
> > pte_modify()
> > and its users, and go for it.  Also, add _PAGE_PAT_LARGE to
> > _HPAGE_CHG_MASK for symmetry.  For better clarity, split out common
> > bits
> > from both symbols to another one and use it together with specific
> > bits
> > when defining the masks.
> 
> I think this whole entanglement is a bit confusing, but not
> functionally broken.
> 
> The problem is kind of that the existing code assumes that all vma-
> >vm_page_prot relevant prot bit positions are identical between PTE and
> PMDs. The bug is that _PAGE_PAT is not treated as relevant, but it
> actually is. So fixing it breaks the assumption.
> 
> Not trying to suggest we shouldn't do the simple fix here, but I wonder
> if it is worth clearing it up further?
> 
> I think at least we should include a comment around _PAGE_CHG_MASK or
> _PAGE_PAT as to why it is assumed that this will not cause problems.
> This way, someone in the future can see the error in the reasoning if
> something changes. Would something like this be useful and correct
> reasoning?
> 
> /*
>  * Bit 7 has different meanings for PTEs and PMDs. On PTEs it is the
>  * PAT bit, and on PMDs it is the PSE bit. This creates some confusing 
>  * entanglement in code that operates page table bits that end up in
>  * both PTEs and PMDs.
>  *
>  * vma->vm_page_prot is used for constructing both PTE's and huge
>  * page PMDs. This member is set via vm_pgprot_modify() which, despite
>  * vma->vm_page_prot being used to set huge pages as well, only filters
>  * bits with _PAGE_CHG_MASK (actually in pgprot_modify()). This means
>  * by having _PAGE_PAT in _PAGE_CHG_MASK, _PAGE_PSE will also be 
>  * preserved.

AFAICU, your concern is different than mine was.  I was wondering if by adding 
_PAGE_PAT to _PAGE_CHG_MASK we didn't break PTEs in pte_modify(), while you 
seem to be rather thinking of potential breakage of PMDs in pgprot_modify().

>  *
>  * This should be harmless because vma->vm_page_prot is only applied to
>  * leaf page table entries. In the case of _PAGE_PAT in
>  * vma->vm_page_prot being inadvertently applied to a huge page, this
>  * is fine because _PAGE_PSE will already be being set on a huge page.
>  * It is expected that code should not try to add _PAGE_PSE to
>  * vma->vm_page_prot, so there shouldn't be the case of inadvertently
>  * setting _PAGE_PAT in a PTE. So the saving grace is that PSE is
>  * *always* set on PMDs that add bits derived from vma->vm_page_prot.
>  */
> 

I could add your comment and resubmit, but my experience from communication 
with audience of this patch tells me that silence means rather no acceptance.

Thanks,
Janusz


