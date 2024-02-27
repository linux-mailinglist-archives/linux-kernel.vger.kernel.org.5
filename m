Return-Path: <linux-kernel+bounces-83531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACF8869B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D99B2A2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C6146915;
	Tue, 27 Feb 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xwhl5sOk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220214601A;
	Tue, 27 Feb 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048721; cv=none; b=XL838n2TE2lK78jQGZbLIRn4KjYJuwgo9qXvZ40dPSNvzrj8sdw6VPUJ/TV9pOsi/f5uZTXZieEq+O2xZxLoa/cdQ2+ZGXf4djfUeN0i+8BFfK6V8NJSJ4jsNhtI41qrBgl6taGB1aRK7/vqdSEnfhyqsd3+dbesVHiO91yoRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048721; c=relaxed/simple;
	bh=8hBNTU43wvhAs0bfGYgavDjJs4CnkkSY+xwfEC/5nvw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XUm5t5x/+UF7IFXZKaFg7BMN5ExxinFXYG1d85GvdhbWFfKCDFrW5Ecq1AI/MaLdc/5qu4OoWFvWs/M1j/iyX0wtfS99QW8yakpvAAglQV6zNB6q/pruyW3cH/Q5AMAVcEf2P6aA1vd1sYkrQ47aqim/XcAvKtqVhxs9gl21erU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xwhl5sOk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709048719; x=1740584719;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8hBNTU43wvhAs0bfGYgavDjJs4CnkkSY+xwfEC/5nvw=;
  b=Xwhl5sOk2VTEG7qJTkjGNMHd/Oarzp1j+O4i0O2RlHRxRKbLj5cQwP8g
   gHHlWqgNFYWzFy0DA34hP2xKFH4jlV4h4ibiF0XMWafxR8NTjTZ0UJPMo
   6L5B+v6TqHYR8qaKoJGEoUECHPeait84mkPV2oFutZ2QEDG8J8bs11Ew1
   QNgO8b9+VubBGvoJc1g0ei2Jvz6XS+89YN7PAVO3X/xtk8bxSj6RhLi2O
   Dfy0lTxos2YpO6wjhrTLREqnBxseXhKr5mEp4/qVh/jxr7gqGWvUpf20I
   QxXQrytiKoFbRuEroUYkrBAfFPgYPo4u2o6lImV1bwkt9DPMveuwMe1OI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14103877"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14103877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 07:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="37899541"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 07:45:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 17:45:11 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>, Shyam-sundar.S-k@amd.com
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] platform/x86/amd/pmf: Fix possible out-of-bound
 memory accesses
In-Reply-To: <20240227145500.299683-2-W_Armin@gmx.de>
Message-ID: <2dd63b5b-cf60-9f28-55b3-35eab537dc9b@linux.intel.com>
References: <20240227145500.299683-1-W_Armin@gmx.de> <20240227145500.299683-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Shyam & Armin,

Shyam, please take a look at the question below.

On Tue, 27 Feb 2024, Armin Wolf wrote:

> The length of the policy buffer is not validated before accessing it,
> which means that multiple out-of-bounds memory accesses can occur.
> 
> This is especially bad since userspace can load policy binaries over
> debugfs.

> +	if (dev->policy_sz < POLICY_COOKIE_LEN + sizeof(length))
> +		return -EINVAL;
> +
>  	cookie = *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
>  	length = *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);

This starts to feel like adding a struct for the header(?) would be better
course of action here as then one could compare against sizeof(*header) 
and avoid all those casts (IMO, just access the header fields directly 
w/o the local variables).

Shyam, do you think a struct makes sense here? There's some header in 
this policy, right?


There are more thing to address here...

1) amd_pmf_start_policy_engine() function returns -EINVAL & res that is 
   TA_PMF_* which inconsistent in type of the return value

2) Once 1) is fixed, the caller shadowing the return code can be fixed as 
   well:
        ret = amd_pmf_start_policy_engine(dev);
        if (ret)
                return -EINVAL;


-- 
 i.



