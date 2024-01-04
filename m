Return-Path: <linux-kernel+bounces-16834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBA82449E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62B71C2214E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B757B249FF;
	Thu,  4 Jan 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFl2+x7Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89F23758
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704380749; x=1735916749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTNWC7v3qXqODsfpzwcE3CQHUSZdjh7Vh3v7ScwF4/k=;
  b=MFl2+x7QUSR2RvUrn7XUORnrLdHCwH/1gbtFjGRaBpaB+7tt4GpfDqdX
   12t3OOFrK9inWkp0hnk/5kL2q71/BEpBnxQW1Sn3kU6h9nemPBSCZFiy7
   nxn9lX9g8YU2JB9FRoo/G2ioiF8kNAbI6mUq+aIN/LFpW7EpMNKrRExQY
   RTrFzuzpls52umFhD6QKmV2UZLIQf3J8B4T9zGxPDBDjQTWyZ+V5NLX0H
   /V7iZ8v+C+mlxgNaaxZpscgTQixmlfgfb0k9F1sUXqPQXbeSdaWX2lsxK
   PrhxBYdvWPuGeKSZ5mDgVRZJukq8I2+BQ8VEQqN9l3UGaCmalka3uC2KI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="428428932"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="428428932"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 07:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1111783591"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1111783591"
Received: from dekblom-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.36.199])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 07:05:28 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8AC2A10A57B; Thu,  4 Jan 2024 18:05:26 +0300 (+03)
Date: Thu, 4 Jan 2024 18:05:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCHv4 05/14] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
Message-ID: <20240104150526.52vbu4gownp7jm3i@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com>
 <20231211231035.743cesujphsp5eve@box.shutemov.name>
 <ZXnoWuaXvRkJjlDK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnoWuaXvRkJjlDK@google.com>

On Wed, Dec 13, 2023 at 09:22:34AM -0800, Sean Christopherson wrote:
> On Tue, Dec 12, 2023, Kirill A. Shutemov wrote:
> > On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> > > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > > present in the VM. It leads to write to a MSR that doesn't exist on some
> > > configurations, namely in TDX guest:
> > > 
> > > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > > 
> > > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > > features.
> > > 
> > > Do not disable kvmclock if it was not enabled.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > 
> > Paolo, Sean, any chance you can get it in through KVM tree while the rest
> > of kexec patchset is pending? The problem is visible on normal reboot too.
> 
> Paolo is going to grab this (possibly for 6.7-rc?).  I'll keep this tagged on my
> end in case that doesn't happen "soon".

Sean, any update on this?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

