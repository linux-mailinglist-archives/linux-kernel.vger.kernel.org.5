Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16C87F48EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjKVO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKVO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:29:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557419D;
        Wed, 22 Nov 2023 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700663359; x=1732199359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BFl13xeC7OE11pBxBT1ZHjb6Yh6uZMtqWKK7X350nBU=;
  b=kGNNK8zLM1ZRFIGAYL+/Gr7pCjlu8BhGbol0PQtpOcoggBeWpK+j9/YE
   WSExscuL4HAspMB4KtXnfz/KzxD+8w2xwhep9TSbEI44/skFTHXrE/dzo
   iw/4934kNAADSKZLArJg/LU1ODt9qD8pzOzdI7clBxksPCUvUw58qb7dd
   2/W4Q07fTn6ziWk1OP0TdzLNlQopAXWsEYZoDkp5F0XMDX3Uqf+GjAQf2
   muOGvURhBsYROYob/wJaW5jwv0c7fsUEK2Zk5Wtgoy/vAEacFjO9GLwaD
   MYvF/M/mhZRal2m96bpdHNQwVLsSp4V2b1QK7gVJdPGkFeYjaREE3SYh0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10724610"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="10724610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 06:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837430258"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="837430258"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2023 06:29:15 -0800
Date:   Wed, 22 Nov 2023 22:27:22 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paul Durrant <paul@xen.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/15] KVM: pfncache: include page offset in uhva and
 use it consistently
Message-ID: <ZV4PyvTBOohiRyLS@yilunxu-OptiPlex-7050>
References: <20231121180223.12484-1-paul@xen.org>
 <20231121180223.12484-8-paul@xen.org>
 <ZV3Bwghwz63LmgMu@yilunxu-OptiPlex-7050>
 <b6b864e500cbb38f76739fcfb4dcc6e9c6705d0b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6b864e500cbb38f76739fcfb4dcc6e9c6705d0b.camel@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:12:18AM +0000, David Woodhouse wrote:
> On Wed, 2023-11-22 at 16:54 +0800, Xu Yilun wrote:
> > 
> > > @@ -259,13 +258,25 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
> > >                         ret = -EFAULT;
> > >                         goto out;
> > >                 }
> > > +
> > > +               hva_change = true;
> > > +       } else {
> > > +               /*
> > > +                * No need to do any re-mapping if the only thing that has
> > > +                * changed is the page offset. Just page align it to allow the
> > > +                * new offset to be added in.
> > 
> > I don't understand how the uhva('s offset) could be changed when both gpa and
> > slot are not changed. Maybe I have no knowledge of xen, but in later
> > patch you said your uhva would never change...
> 
> It doesn't change on a normal refresh with kvm_gpc_refresh(), which is
> just for revalidation after memslot changes or MMU invalidation.
> 
> But it can change if the gpc is being reinitialized with a new address
> (perhaps because the guest has made another hypercall to set the
> address, etc.)
> 
> That new address could happen to be in the *same* page as the previous

In this case, the lower bits of new gpa should be different to gpc->gpa,
so will hit "if (gpc->gpa != gpa ...)" branch.

And I see this comment is deleted in v9, which makes sense to me.

Thanks,
Yilun

> one. In fact the xen_shinfo_test explicitly tests that case, IIRC.
> 
> And kvm_gpc_activate() also happens to use __kvm_gpc_refresh()
> internally.


