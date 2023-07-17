Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B628E755F98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGQJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGQJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:42:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA819BA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689586939; x=1721122939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mO01ZFkCZty6uHVGdcmYsRXqtJhMKZQf2z1Jb0eiF8Q=;
  b=l1q0O6ocHTXiStZ/THjuYQHaLW0bGdx0vDVNTBl4aFKFhGa+Am5MSJmc
   NXZXqZNw7Fzaqk905E7uXaCfA2ThZnnPgh/bdr0fDzvDkWfWEcPd1eyN+
   2hd9eQyEqsNw0A7V3d+ap571cEhimSYKPGl/QMvdcCXsqP+61WilXbWTl
   vlO1VwU8bzvoJ0pUv5axqjLq94ykCDZko2kbulHKrOszDtdTyuE82xovF
   k7/MHAsRo/Yi8TM9YwOClX3WgPRHdEJuTKUnv7jQgO33WaTomKXy05kDb
   l/8XyN+6anvZyqf2Fgp6zghv2tA3W4yxuHxj2KmtetMmdP6GljpdARL7N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="369440918"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="369440918"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="836822374"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="836822374"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.9.176])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:42:15 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Marek =?ISO-8859-1?Q?Marczykowski=2DG=F3recki?= 
        <marmarek@invisiblethingslab.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page protection modify
 mask
Date:   Mon, 17 Jul 2023 11:42:13 +0200
Message-ID: <21945539.EfDdHjke4D@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230710080519.GAZKu7v2N/eK/jYXPL@fat_crate.local>
References: <20230710073613.8006-2-janusz.krzysztofik@linux.intel.com>
 <20230710080519.GAZKu7v2N/eK/jYXPL@fat_crate.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Monday, 10 July 2023 10:05:19 CEST Borislav Petkov wrote:
> On Mon, Jul 10, 2023 at 09:36:14AM +0200, Janusz Krzysztofik wrote:
> > Assume that adding _PAGE_PAT to _PAGE_CHG_MASK doesn't break pte_modify()
> > and its users, and go for it.  Also, add _PAGE_PAT_LARGE to
> 
> That's my only worry.

Let me remind you that v1 was free of concerns on potential breakage of 
pte_modify().  I can update its commit description as Dave requested and 
resubmit if you confirm that it will be reconsidered as a potential solution.

Thanks,
Janusz

> 
> I'd suggest we queue this but not send it to Linus now. Instead, let it
> cook in linux-next for the whole 6.5 release cycle so that it can get at
> least *some* testing.
> 
> Because if we send it now and something else obscure breaks in a weird
> way in his tree, then we'll have to scramble to fix that too and it'll
> be one helluva mess.
> 
> Dave?
> 
> 




