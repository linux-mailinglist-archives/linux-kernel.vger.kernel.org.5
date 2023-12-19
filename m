Return-Path: <linux-kernel+bounces-6088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474481947D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77B41F27166
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5A3D561;
	Tue, 19 Dec 2023 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+PamraM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204D3EA7D;
	Tue, 19 Dec 2023 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703028033; x=1734564033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYTsoLYZOvCUsCGVaoQxTU6za82GcPNPw7Jy1FK3eiE=;
  b=Q+PamraMa/1oIf/uY5c/QjksqS6R2NaLy54INBGaZh/0NY2pTpo9d1TR
   sftVRzQbFnp6EbWISkCu+VP3aw15ByuINqWheSon2hHAVKqQ0/0xObUJJ
   RNBlnzx7sa2A32am59Btmd3han7pyFEKDpgscM733vNZn0hfImqFgw6pq
   nGnT4aWq5Adc1Be7X7gsCaqmx1rfmrj+jui+F5cU3QcvtqmFrHdj42+8h
   s0eVV9I7J0UIHxUm9CcBJ4gbOyL0kvwZ9NP+SLvrrcFQVqJtCWvIwvQld
   QZ8KJDuglILBZPU7MVjA8xh8nrckWnUNF+MJnLk+R2S+DxUERZIHmh9I5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380721075"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380721075"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="805055842"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="805055842"
Received: from lveltman-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.252])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:20:26 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5494010A43B; Wed, 20 Dec 2023 02:20:23 +0300 (+03)
Date: Wed, 20 Dec 2023 02:20:23 +0300
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
Message-ID: <20231219232023.u4dyuvbzbh565grk@box.shutemov.name>
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
 <20231219215751.9445-3-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219215751.9445-3-alexey.makhalov@broadcom.com>

On Tue, Dec 19, 2023 at 01:57:47PM -0800, Alexey Makhalov wrote:
> +static inline
> +unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
...
> +static inline
> +unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
> +				uint32_t *out1, uint32_t *out2)
...
> +static inline
> +unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
> +				uint32_t *out1, uint32_t *out2,
> +				uint32_t *out3)
...
> +static inline
> +unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
> +				unsigned long in3, unsigned long in4,
> +				unsigned long in5, uint32_t *out2)
...
> +static inline
> +unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
> +				unsigned long in3, uint32_t *out2,
> +				uint32_t *out3, uint32_t *out4,
> +				uint32_t *out5)
...
> +static inline
> +unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
> +				unsigned long in3, unsigned long in4,
> +				unsigned long in5, uint32_t *out1,
> +				uint32_t *out2, uint32_t *out3)

Naming is weird. The number in the name doesn't help much as there seems
no system on how many of the parameters are ins and outs.

Why these combinations of ins/outs are supported?

And as an outsider, I'm curious where in2 got lost :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

