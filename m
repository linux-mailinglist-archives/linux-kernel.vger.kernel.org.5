Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0E7BDFB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377123AbjJINdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377125AbjJINdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:33:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3729C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696858378; x=1728394378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQiIeN5ST8uGhtT0LhMJYQQaH+STe2BjgqRaOYnAfTw=;
  b=b9iqcUnqbutObW/AHOoYiMSoLUbgCcT09dKNXLIAbH1EY5M3mWRJ8vak
   lbwSjC2CS77CwAHczrNoKAsJkGRnZ7ZLNty9eJ9NzTaFCgwW/6f68lrOG
   HsLMXgkm8GQqtLkcJtEagtg6BbiMceKTZDTpgoCuTHsJfYFqKmNJEGMmt
   ebNd86T4cBJwTXSgtwcubUgDIvyMb2c/87CnKNH0Y8iws1M6d6vVprCCI
   9yOySRqFW75+u7E15uHZIJPibnlv3zCMbaLThb1VmKGFavGvj7SMRSCqu
   izEVGXTEoTMeDCkZDzfh9U0yH9pxKSoDCZaDwXohMd2P1xNkH6qmgu6is
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374473688"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374473688"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="782491307"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="782491307"
Received: from ahuge-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:32:53 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4EAB710A196; Mon,  9 Oct 2023 16:32:51 +0300 (+03)
Date:   Mon, 9 Oct 2023 16:32:51 +0300
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
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <20231009133251.lmdubojesxtwzdyl@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-6-kirill.shutemov@linux.intel.com>
 <2c76fa83b154566e49425e3a7ccc9a268318d63a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c76fa83b154566e49425e3a7ccc9a268318d63a.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:30:55PM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:13 +0300, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX environments.
> 
> Nit: non-TDX-guest environments. ?

Okay, will fix.

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
