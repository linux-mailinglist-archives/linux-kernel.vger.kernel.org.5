Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE32D7BDFE6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377176AbjJINfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377169AbjJINfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:35:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F599
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696858515; x=1728394515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a8KWFLu3eVLALOO0s2Gfw3D3r4t41MgJmAmOQhK1GqY=;
  b=RwcbvQX4vTxV2SjYxjaf1K0WLu5sdFnpBIlX9CZKO27ZTULr68Ku1gnB
   iWC8xj9LCPKk0fb9Yj2xNkpfMGEaloWdSQHu2GVRKHU1EIm/1++7te0xS
   raINBpBiD3oUFQ1XYGW/Zp2RhaXG6yDimMXi5D72O6RrVUVzWIez4pT+i
   G8XClAWM9IH4fivWPvAAo8hFE1ZRMxHldeY+qO+AiWmYete7o27QeR5f7
   HjVWxWDfT8utAkZHI4rWhi6CTOi5nz1M89TZV33bxlB0EK7I9Da+5qu54
   DLXwKuyb53AruBjenTb83AMoym1ttgZWABcQCzm/mSfqT09ZwvHakvgcR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448332827"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="448332827"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000209164"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="1000209164"
Received: from ahuge-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.233])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:35:03 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6EDC110A196; Mon,  9 Oct 2023 16:35:00 +0300 (+03)
Date:   Mon, 9 Oct 2023 16:35:00 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231009133500.su4ylwpbnaiyln4d@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <ZSJpzw2e7KgtJAZy@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSJpzw2e7KgtJAZy@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 04:35:27PM +0800, Baoquan He wrote:
> On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> > TDX guests allocate shared buffers to perform I/O. It is done by
> > allocating pages normally from the buddy allocator and converting them
> > to shared with set_memory_decrypted().
> > 
> > The target kernel has no idea what memory is converted this way. It only
>       ~~~~~~~~~~~~~
> > sees E820_TYPE_RAM.
> 
> I finally realized it means the 2nd kernel of kexec rebooting. Maybe we
> can call it 2nd kernel always, it works for both kexec and kdump
> jumping. 

Okay. Will fix. I am new to kexec and I don't know proper terminology :)

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
