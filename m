Return-Path: <linux-kernel+bounces-121572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660FD88E9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C41F36DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD412F380;
	Wed, 27 Mar 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkSyUHW/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620B59B71;
	Wed, 27 Mar 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554527; cv=none; b=m4h8/Ywyo2k0VfYWlVtPdK8rfeP+uQYFOXrSh7McVxECtgwpPBW1UBlcKCSU/yS+F5kUg69/c2OobLOr3gFszLywierVQOx+BUu9rENO4WXN9cPnDC2ifiIQAK+aVbqLpdeywAal5/oV+9YW61FZaedZpkH2/k5J19zIImZzYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554527; c=relaxed/simple;
	bh=/Fy+XebLi84xhsuIn0Baks2bdrJHrKjSXbeknmduzQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1yre8lcxQ1uqC980iO9uUckDi1ZkUavBm4WLgcM4zHSgXEhDttd0B+KvGeyjhrEwkznWf3UGyQrS2RtZu+Zc8trdyIp60RCjs0j8oRAN60qnHHSeIN6/1DBWJz2RPvPAnxYuMOsiK8atrVoVqHf7yOKvZ7n5/i/D665bzeMef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkSyUHW/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711554526; x=1743090526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Fy+XebLi84xhsuIn0Baks2bdrJHrKjSXbeknmduzQQ=;
  b=kkSyUHW/2PYK1GRO1HK04wjlFtJoeWO6hQScOxYolLGEAsxqsuURWqVh
   TAjj80i9Nnq/z1qdR8Y42vtSL7nhyJFaWuRO4zxps2JM612FrdnT7HO3O
   kHC3G/bxygHwUmGVHwllr6VBgP1aUPFc303MfQ73Ah9DDj8BlNN64wPwb
   UyUvowuF6nua91zFW8vLFQr0d5Lm05WJTVXT4LUbGRWN/g5yNxTkri1Eq
   kB82A2Sx5CFPaFcYftIvyRcEDcLC5XAk10+9nlRAAWm3Tl1yMzz16si3o
   4WKMtqVx2K3jDP5Sz4xHVF8R7LbFN+kIHaudo1pUlr12/FGZkorDgI60E
   Q==;
X-CSE-ConnectionGUID: 1l8k0xYFS+mLAK9NhKsaxA==
X-CSE-MsgGUID: whvq8QYyTk+YYMitxoeVmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24119406"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24119406"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="914916637"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="914916637"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:48:35 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpVVe-0000000Gjzz-2WQr;
	Wed, 27 Mar 2024 17:48:14 +0200
Date: Wed, 27 Mar 2024 17:47:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 02/21] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZgQ_rP5KnMfL-0b2@smile.fi.intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327152358.2368467-3-aleksander.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 04:23:39PM +0100, Alexander Lobakin wrote:
> From: Alexander Potapenko <glider@google.com>
> 
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.
> 
> Two new performance tests, test_bitmap_read_perf() and
> test_bitmap_write_perf(), can be used to assess future performance
> improvements of bitmap_read() and bitmap_write():
> 
> [    0.431119][    T1] test_bitmap: Time spent in test_bitmap_read_perf:	615253
> [    0.433197][    T1] test_bitmap: Time spent in test_bitmap_write_perf:	916313
> 
> (numbers from a Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz machine running
> QEMU).
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>

This is a bit strange.
Can you explain the SoB chain in this patch and similar which have Yury's SoB?

> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

-- 
With Best Regards,
Andy Shevchenko



