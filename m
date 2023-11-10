Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C167E80BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbjKJSRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbjKJSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867906A48;
        Fri, 10 Nov 2023 04:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699620394; x=1731156394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2i9HlXGEJN9GvUqppuVZsijvouhwur5X+0YFasxx/vM=;
  b=jpcILfRQM+H38OflvMX2OdjXOGJMja3v3s/FI2rnC+yaVv3qaxBKp7Ig
   qxw2cAj+gCV1KaAX59qeof8dTpTPHqNnx1GyWfvsXJ5u5WpDAq/EEN+tX
   kVxZh425q+wXZb7tpvyI901KrJNNqv/EmztNNj33U4T8vwoSoW3/4y/91
   /DmEo9l0SPHjNLkLH9v+Tv+qgrZbawb3BtwEN2iOcjgUioZ7CNf0edHj5
   2O4UN+iHEZe79/HGJeKzg4HvIjxDJxhF0tU0VgzW0lSAZyu1JWTY7oVcT
   6q1EpDbgBdmcsv9GUH2g0Wke8jLKAUfmBlFq/dbhugpKZcPFKwjPCL5Be
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454479796"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="454479796"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="880955492"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="880955492"
Received: from amazouz-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.43.76])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:46:28 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3C627103614; Fri, 10 Nov 2023 15:46:26 +0300 (+03)
Date:   Fri, 10 Nov 2023 15:46:26 +0300
From:   kirill.shutemov@linux.intel.com
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Message-ID: <20231110124626.ifq3hqaiqvgpnign@box>
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
 <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 01:27:08PM +0100, Jeremi Piotrowski wrote:
> > Maybe just remove incorrect info and that's it?
> > 
> 
> I disagree, other users and I find the print very useful to see which coco
> platform the kernel is running on and which confidential computing features
> the kernel detected. I'm willing to fix the code to report correct info.

For TDX, we already have "tdx: Guest detected" in dmesg. sme_early_init()
can do something similar.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
