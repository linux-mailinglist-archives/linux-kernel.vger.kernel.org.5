Return-Path: <linux-kernel+bounces-90128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870886FABD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D040F2853C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A113FE2;
	Mon,  4 Mar 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibyHUWd5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237B134BF;
	Mon,  4 Mar 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537322; cv=none; b=LRInm3Bv1U1ghixsnsBJ9O7wadgNO5CjAA1QEEB/BvJsxB4UQex4ABvHE/5eDmRcVcRn8+KZoeS+wLbt/mjjE64EjHpvB9O52HiaJ3Vrdtyt2MgBcORM3Zl4r6Dvc4DgHuXgVHHjYmeDhAgEA7zlJS/Q+fEZm7mAqXyTYN13C2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537322; c=relaxed/simple;
	bh=d8cnAMNa1AJJ8FEjNDOypbxGsMMkLSfcBRz4QBDn+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu3kJPUotWbsEOr3sW+G1JA5mqmnEMNnQkRIEWYkKXrWs1nPPbOXJwlgTfww9cqWW67ekOLGeqYGr9KHkdxuGRdAhZumZuBo9IJwwm89GfKViBYzpGlehqy5pKrQ91eBPbVHHfF9uWuQoEkg4ojKfwmlLL9p1G4dDczM96fguKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibyHUWd5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709537320; x=1741073320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8cnAMNa1AJJ8FEjNDOypbxGsMMkLSfcBRz4QBDn+FQ=;
  b=ibyHUWd5S+qC+gzJr+WsIM7iJfsO2Q8iN3t1IZVdTD/yDtR8NJ9pBqjB
   wKXlekidR2WeVpEMStQrzE6BpJwTTrWwt/y+ALnQLI1y/Qz39+wwz5UIn
   14Te5TUbltcEbqOpj8N9aOnXzeyNEhSJKIAvMrx2YLAGK5UewZRB21P5s
   S2vJI+x/Q2K7uRf+MPI3f87OMx3GzEM0pasnBGsmWaGWgYUaciwX9fnmK
   h5/O9KDSWZJGjlLIxy9N/BZpguSaMJeDF3qS6181WLzFBXJdMIhEzBl9a
   9zwh/FFcQWgIpbOAiPGa665sXjzL2WAtJARtc9eXRXTqt9j7RIVcL0VjF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="29436277"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="29436277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="39749624"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:28:37 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 830C411F8B1;
	Mon,  4 Mar 2024 09:28:34 +0200 (EET)
Date: Mon, 4 Mar 2024 07:28:34 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed reserved1/2 fields to prevent kernel-doc warnings
Message-ID: <ZeV4Im9SHmWs0EZM@kekkonen.localdomain>
References: <20240303133223.5506-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303133223.5506-1-prosunofficial@gmail.com>

Hi,

On Sun, Mar 03, 2024 at 07:02:23PM +0530, R SUNDAR wrote:
> ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved1' description in 'ipu3_uapi_acc_param'
> ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved2' description in 'ipu3_uapi_acc_param'
> 
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

Thanks for the patch.

These have been already addressed by commit
dcef3ed5b0d79f89018e31d55cf09f2c2f81392b, same for the other patch.

-- 
Kind regards,

Sakari Ailus

