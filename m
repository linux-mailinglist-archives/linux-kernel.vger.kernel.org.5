Return-Path: <linux-kernel+bounces-123659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E5C890C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A3B214DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27313A884;
	Thu, 28 Mar 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Juk/qcjE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970D52F62;
	Thu, 28 Mar 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660325; cv=none; b=SMoXZTj8Ke8nKnvz2ixM8XgiiS0w3REYdfAy3sg4HaAZ3T9ARjxHJNLdcTFjBrdFS3qVmUTPm/q9zJh2LZI9r05jPKuK2kmDelHTh8O3XTtYR1jQHH9xOLv9GeNMAf2cjv9i5JydSw/ABzBSBEeaK5qjpw71hkQ8M20QlnDOnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660325; c=relaxed/simple;
	bh=yngr6HDotAuV0LR72q3d5ZVpN+T8z4EOF6b3Ti3s9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY64ovDjoSTcTkqRivJWQaIY9xGXvOyF8GbpLH7TDBhVDM93fCrhRwFYGWH7EaegOqYGCzUvedSV01XJDG3lvA0vp3J2FoS8EdK3IOgzvMFtCS1ccN0dKJag5qQhT4YKRYj2lQqY3A10GR9BaVEIAvMuVBSC3MYwz37LSeNtz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Juk/qcjE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711660324; x=1743196324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yngr6HDotAuV0LR72q3d5ZVpN+T8z4EOF6b3Ti3s9X0=;
  b=Juk/qcjEv3HR2WRYWmo/665+1TVIy3eBI8SbNzNjZXl/ylu9XwdeY9kB
   K/ejLKbDjD0Ob06JS2PNEvgZGHtpKlRPeaV2h6lct2ye/zo304k5AMKg9
   5Rh+2BjXbqATdTksRBlkRCAYiqz+IqRbh8ZJL+2J1HZLVbgfjpoG7nu8I
   vJt7m7mhjXWTXfye/7u9dRHY9dMDRJKY+HVEmwrjgdZeIIk1NJZJ2nSW5
   dwodLgVHqOQyrcX/X6YSh7NPjGndJm8f4klwRK9x2m5yJ75dDCirPjPAp
   mTJFzZDS0VDoUxpc5GORzSpPljilmwd3ainOl1IQS+dEQQiE6UrwnIvBv
   g==;
X-CSE-ConnectionGUID: oYlcoPYVQhGJLYRmckojEA==
X-CSE-MsgGUID: z6hH4Fr8TwGQUeMwLs3agg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6955602"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6955602"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16805142"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:12:03 -0700
Date: Thu, 28 Mar 2024 14:12:02 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
	Sean Christopherson <seanjc@google.com>,
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>,
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com,
	isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v19 092/130] KVM: TDX: Implement interrupt injection
Message-ID: <20240328211202.GT2444378@ls.amr.corp.intel.com>
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <b2d9539b23f155b95864db3eacce55e0e24eed4d.1708933498.git.isaku.yamahata@intel.com>
 <ZgVM2kJTx1p4BjbM@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgVM2kJTx1p4BjbM@chao-email>

On Thu, Mar 28, 2024 at 06:56:26PM +0800,
Chao Gao <chao.gao@intel.com> wrote:

> >@@ -848,6 +853,12 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu)
> > 
> > 	trace_kvm_entry(vcpu);
> > 
> >+	if (pi_test_on(&tdx->pi_desc)) {
> >+		apic->send_IPI_self(POSTED_INTR_VECTOR);
> >+
> >+		kvm_wait_lapic_expire(vcpu);
> 
> it seems the APIC timer change was inadvertently included.

Oops. Thanks for catching it.
-- 
Isaku Yamahata <isaku.yamahata@intel.com>

