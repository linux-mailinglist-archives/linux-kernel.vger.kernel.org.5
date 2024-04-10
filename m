Return-Path: <linux-kernel+bounces-139111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771F89FEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32888288BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F87717F36B;
	Wed, 10 Apr 2024 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fakINiiU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10683178CEE;
	Wed, 10 Apr 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770603; cv=none; b=XEP7VaDL6IgMZu0rK/L9qX/75YBu944rIwzvbrpdjV+vQ5F93TSRbLwwkfKHov7vydBWwVXbST1quPdtuPMgp6WvmvJwGj7+H5BbtkJeEm0Ftu/z3qmU0achBjBVhyiU/DYnh9GZwr6KKnhuZax5TElu8dsto2fL2ODEWcXdImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770603; c=relaxed/simple;
	bh=C2Ckdhh6MShRypHTQfGnWVcfvy2wO5tJ+RrOIcXU+GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku2fbVdP9tN/myGy5+f1Nvmq2zNPGwrrTxF/Wq0CiWnfVO/1pT4yJNcQrpk6voQSUZiVbdzzPTA+GUhFYvllrnMuJWEsc7h50qHSsibzDv3Se+UysKrXFV3kjKQkXLGKCXFlG5+nMO+tDwgwL7yn+M27psyjg+sMRerMrcH3UnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fakINiiU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712770602; x=1744306602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C2Ckdhh6MShRypHTQfGnWVcfvy2wO5tJ+RrOIcXU+GE=;
  b=fakINiiUCRSw2Y/efrv454Y2guCzBhEsWkxytKQXg8bFw3gm1WRGftkH
   87jkL0gqVzxXCcM25OxzKyBCKA8Wx9HwO0eGSmcUjsGbE2uBDipzgSOo3
   gt01cUYDw1+l5enazbsUZlkPlLSsquie/hGMmiwG1XuWw7zcqU9uL4Urr
   kKs5b9FuPhXGfZEbipOiH8GXjStDUDdAD9MwYaXP4jjtNRwe4rrurxTaP
   aiKv9/7eP5h2pOJxdPiyqJxjlij3uLTXE7RQyFg9icl2AgPEMs5iznek4
   1/wSu/z2WHtccpbIQsXiV3v6W8NuPM0Y1yLegI6X8OoD67o6yqtm5Ixnp
   A==;
X-CSE-ConnectionGUID: IWfmZtZIT+Owxx28JyCBrw==
X-CSE-MsgGUID: IITQZQWQSMegjxzMIlpJOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8328253"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8328253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915438867"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="915438867"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:36:21 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rubru-000000038N0-3OjI;
	Wed, 10 Apr 2024 20:36:18 +0300
Date: Wed, 10 Apr 2024 20:36:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Felix Fietkau <nbd@nbd.name>, Alexander Couzens <lynxis@fe80.eu>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH wireless-next v1 1/1] wifi: mt76: mt7915: Remove unused
 of_gpio.h
Message-ID: <ZhbOEqO4BIE4q7Vv@smile.fi.intel.com>
References: <20240228200321.3607764-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228200321.3607764-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 10:03:21PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.

What should be done to move this forward?

-- 
With Best Regards,
Andy Shevchenko



