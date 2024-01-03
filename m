Return-Path: <linux-kernel+bounces-15515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2461822CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6A285941
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09819461;
	Wed,  3 Jan 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDMfLmqr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486619458;
	Wed,  3 Jan 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704284749; x=1735820749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NZPFuLqIaZYxF8kzjwORU+cPOyFb8rBNMttLqHxoyI=;
  b=UDMfLmqrSvJ7f4Xfhg+a6pdId2N+iIJ76n+VkfdQVd2LdvWHWTNLpXu1
   Z+T08AoSiE7mwNTeznB4hWiJpfBCFn4aHGbPV0iWLX1iWwg2aF6vbegFu
   VG2GP2BQRYCkc7IMp2N+7V9NO9bGAllSK7tRDxn5McW1wdcewW7N/pW+/
   WIEZvyxkwTGvDuVuetvklHiAkBUx7dNLwehTFs18429srWHdL+XWLQeul
   joSWkPZwcUxeowXu9jpLdziPJLeOwv3YNVlvUsrNMTOdMX5Z42jXR7t1K
   HEj55mVknwVEg9em94cqojKy7POQrnPqakvSdKe3xpdsp8VUlSPxpceCR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4085305"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4085305"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 04:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="783498077"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="783498077"
Received: from sharadav-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.36.97])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 04:25:42 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id C10E610A567; Wed,  3 Jan 2024 15:25:39 +0300 (+03)
Date: Wed, 3 Jan 2024 15:25:39 +0300
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
Subject: Re: [PATCH v4 6/6] x86/vmware: Add TDX hypercall support
Message-ID: <20240103122539.agoq7647bzwcgjep@box.shutemov.name>
References: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
 <20231228192421.29894-7-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228192421.29894-7-alexey.makhalov@broadcom.com>

On Thu, Dec 28, 2023 at 11:24:21AM -0800, Alexey Makhalov wrote:
> From: Alexey Makhalov <amakhalov@vmware.com>
> 
> VMware hypercalls use I/O port, VMCALL or VMMCALL instructions.
> Add __tdx_hypercall path to support TDX guests.
> 
> No change in high bandwidth hypercalls, as only low bandwidth
> ones are supported for TDX guests.
> 
> Co-developed-by: Tim Merrifield <timothym@vmware.com>
> Signed-off-by: Tim Merrifield <timothym@vmware.com>
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> Reviewed-by: Nadav Amit <namit@vmware.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

