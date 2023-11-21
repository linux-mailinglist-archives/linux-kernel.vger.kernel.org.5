Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6B7F2955
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjKUJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjKUJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:50:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEF1AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700560206; x=1732096206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2d/tvMIoDvHSQUHPlRsf/csrATiDrGE2RPrh/3LADw=;
  b=DFbjlvAPFdCq2Da1a4hfbc/5BmMtKSy26xiYjKcR5jpuhpwPBORLgGHH
   fL75jK171DqclyidrOE+rKP9JQZeXvqyQFg18qPMl/jWr2JJOmuQlT7Ri
   9NGuXuDO4I+P3MLO+ELlDygIV3D1472xYb+fRn7KPs3QKNLIrBw8QUeRg
   YKrjuTKQTydTXIS1lXDb7d15JD2NU4PGaTd2t9Qkv9phdt8btmOHYyrCY
   bbSJyApg52STIqKelvJFVF5Z1gqrp+1EzLadFxdpOzJMXzENmjdQus9ZY
   +9FjSsMs5tbZnQydZIVMc7Rg3dO2w53PceIlgYZRPdjtL/xLOyl2HrG2K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376840533"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376840533"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766585803"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766585803"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:50:01 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5AEF110A36E; Tue, 21 Nov 2023 12:49:58 +0300 (+03)
Date:   Tue, 21 Nov 2023 12:49:58 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 09/14] x86/tdx: Account shared memory
Message-ID: <20231121094958.sagzaclakdnexd7a@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-10-kirill.shutemov@linux.intel.com>
 <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
 <20231121094219.x5ez6ohzc773viul@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094219.x5ez6ohzc773viul@box.shutemov.name>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:42:20PM +0300, kirill.shutemov@linux.intel.com wrote:
> > That being said, I think perhaps you can separate the /sysfs part as a separate
> > patch because it's not a mandatory part of this series but a nice to have.  Then
> > the /sysfs part can be reviewed separately. 
> 
> Okay, makes sense.

Hm. Without debugfs there's nothing really left in the patch. Accounting
itself is few lines.

I will probably leave it as is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
