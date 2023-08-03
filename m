Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C858076E746
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjHCLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjHCLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:47:41 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E03A1B2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691063260; x=1722599260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NECvDcbl4RY3HoONUpgHbSjVbKKlVEed2eIkDFxsnN4=;
  b=WctlWWcJrcjO4Fg4FD+oyU6DQ/ljW3QcZxQW+IoqmnauYHeR5yOFGiAu
   Ab0Uo2WCyKnU4kVGVTni8nO7m7fuNyVfPMVK0wJAaQrS3MZql2fuk0dby
   4CkmwDOHDJiTT8kxxFBVHtinnkIdYCv4B4G6+UNtUXQb8KqZem7EysQxT
   EPa5iFkbFthI/WeDudOnsnrWdmytZvAJFgPSeUgUyYnYx/cnUDlBUtgy5
   YelJyorzzpuCZi0kZb1dtab+PegeK4RvW4YRx6CJcm83Lnf6rSf378nUd
   C67PecC8P7t2009C55whAAkKZ1ku/WR1WoeB1e99dBJtuBpqGJ9b4uvgx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354767736"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354767736"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732726385"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="732726385"
Received: from gvarshne-mobl2.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.63.106])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:47:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1F176109FCF; Thu,  3 Aug 2023 14:47:34 +0300 (+03)
Date:   Thu, 3 Aug 2023 14:47:34 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Message-ID: <20230803114734.nclbrrahhjbypdzd@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
 <20230727163630.gcsczhebozgf2tsu@box.shutemov.name>
 <6374fd1aa1e2ff4777eab2421cfc439d259cc603.camel@intel.com>
 <20230803105810.xljd2sjqittqey2w@box.shutemov.name>
 <1d402ce98cdcf71098783e7fe584bbf477e47eb9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d402ce98cdcf71098783e7fe584bbf477e47eb9.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:35:48AM +0000, Huang, Kai wrote:
> Btw, should I say something like below in the changelog to justify this
> additional logic:
> 
> 	Also use R10/R11 as input registers too to make the input/output 
> 	registers symmetric, although currently no TDCALL/SEAMCALL use
> 	them as input registers.
> 
> ?

LGTM.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
