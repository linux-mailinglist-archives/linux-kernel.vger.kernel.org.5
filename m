Return-Path: <linux-kernel+bounces-6213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F88195FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327252857A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C15567D;
	Wed, 20 Dec 2023 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CP5SS0u5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDA20FC;
	Wed, 20 Dec 2023 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703033553; x=1734569553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ihFJyqQ2ix/Npm5ZpqxasGwhfpg78Kg+weGzieTxe8=;
  b=CP5SS0u5Hamt33CNDs+VwVTBjTcN1pZBfaSuYb17l3cpb9D4IlEgu2nI
   hpGhIG/j9HCu41TUB8lIqHI7J9kueNm3pyFS6xiBXzelLA9WOl0g65UB0
   SOlwUifg2A1BEkhBSt8RnWLJeuUkdnhHIa2YKuo7keWHTU1q0/fhJTmAV
   LIWGSJEA58xfAmDaccopy7UswRyMGR/bfdY1BFnlWDWvnnu1lZZzYB7a+
   KBlRbf47NdxtPuk+2g0pjKJl4zr9Z3aR+9tGsl1L/i2WDk0dIRkJLTTob
   HCu9CGtD8yryEtiPB8/JGH6FgsKe3X+SWR5b6dIY0uFu1X8tEkIJtjAF/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2566084"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="2566084"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="842073028"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="842073028"
Received: from lveltman-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.252])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:51:59 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 9AD0310A43B; Wed, 20 Dec 2023 03:51:56 +0300 (+03)
Date: Wed, 20 Dec 2023 03:51:56 +0300
From: kirill.shutemov@linux.intel.com
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
	netdev@vger.kernel.org, richardcochran@gmail.com,
	linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
	zackr@vmware.com, linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
	akaher@vmware.com, jsipek@vmware.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH v3 2/6] x86/vmware: Introduce vmware_hypercall API
Message-ID: <20231220005156.2rymnxu5bv6wdwlx@box.shutemov.name>
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
 <20231219215751.9445-3-alexey.makhalov@broadcom.com>
 <20231219232023.u4dyuvbzbh565grk@box.shutemov.name>
 <75eed318-2d22-429d-ab95-80610ba82934@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75eed318-2d22-429d-ab95-80610ba82934@broadcom.com>

On Tue, Dec 19, 2023 at 04:17:40PM -0800, Alexey Makhalov wrote:
> 
> 
> On 12/19/23 3:20 PM, kirill.shutemov@linux.intel.com wrote:
> > On Tue, Dec 19, 2023 at 01:57:47PM -0800, Alexey Makhalov wrote:
> > > +static inline
> > > +unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
> > ...
> > > +static inline
> > > +unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
> > > +				uint32_t *out1, uint32_t *out2)
> > ...
> > > +static inline
> > > +unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
> > > +				uint32_t *out1, uint32_t *out2,
> > > +				uint32_t *out3)
> > ...
> > > +static inline
> > > +unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
> > > +				unsigned long in3, unsigned long in4,
> > > +				unsigned long in5, uint32_t *out2)
> > ...
> > > +static inline
> > > +unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
> > > +				unsigned long in3, uint32_t *out2,
> > > +				uint32_t *out3, uint32_t *out4,
> > > +				uint32_t *out5)
> > ...
> > > +static inline
> > > +unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
> > > +				unsigned long in3, unsigned long in4,
> > > +				unsigned long in5, uint32_t *out1,
> > > +				uint32_t *out2, uint32_t *out3)
> > 
> > Naming is weird. The number in the name doesn't help much as there seems
> > no system on how many of the parameters are ins and outs.
> 
> There was internal discussion on hypercall API naming. One of proposals was
> using 2 digits - number of input and number of output arguments.
> And it definitely looked weird. So, we agreed to have just single number  -
> total number of arguments excluding cmd.

Have you considered naming them by number of input parameters? Number of
output parameters as demanded by users.

So vmware_hypercall4() will become vmware_hypercall1() and current
vmware_hypercall1() and vmware_hypercall3() will go away.

It is still awful, but /maybe/ better that this, I donno.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

