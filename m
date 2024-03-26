Return-Path: <linux-kernel+bounces-119196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C188C56A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8A1C62A77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB9513C3E8;
	Tue, 26 Mar 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGyhhm8U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92183763E6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464067; cv=none; b=JW+gtgwFNedf/55EPScj5bdh0wZMVmLGejLEB0dz4UCLRf7jOh5j1uKU7oi4ObPOU5cPwAclr2RW2EQx9XGb8Lfd8rePz5EInMdN6SsP10jog5PlORh+HG8V7t4xjZYQQGmSXBH5W2moHJEcORKVnYhg9ird1MokTM2aWzBoH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464067; c=relaxed/simple;
	bh=Xppa6CV0HLfckPVMV8bTEk6yGO0xhJtUZzkAo69EJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF8vPlXQzlyoBfInA5udGSBrgfh/lnUj9rQsSeteEElYGvQUaZTUe9VSI1gaDsSEqLOXVfiAEywNNuPg5rcTR3rOETJFp6IWTfWrDfRfdMHNaLD2x+o81rbdmZnz4L0cvAnft9bMjUq9ltIT5+hWUk35G7JVclgcNoKaLhofyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGyhhm8U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711464065; x=1743000065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xppa6CV0HLfckPVMV8bTEk6yGO0xhJtUZzkAo69EJjs=;
  b=fGyhhm8UAQ2Wd3Za4W1bg1q6DCikL94IXroCI+NFg2FHF29doGr6ZhMP
   2/CJFR6gZZsrJQ6ogyfm7vzANb0vIeNUutUPQuPnAflq8nq8wSgvYk8BE
   i2q6Z8A9+9HUluxLMnYlyY7Yd1ErAqLL0NMp1n0un8iv1zKDMZPWfJSwR
   zjpJeDmVyQNWLh4dhklJSwat4I0naEBYp4slaVSAURM5dXfQeefzibqE5
   3hAl9VgIAmt/c3zaOhO7P7jequC/KZXYlwzVmBfU1v77/a+wa9uuBfxC4
   xxNZtbq/BQOr3m1SZznZp2tmaMsWPzB93OoEER1N7FKLcFeWFcyj9bATu
   g==;
X-CSE-ConnectionGUID: 7PnIYszMRKmIFt4Jjms30g==
X-CSE-MsgGUID: LWSDPzLFSdeoh/0pLz67uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="28997581"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="28997581"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882242"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882242"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:41:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp7z3-0000000GKQw-0bLz;
	Tue, 26 Mar 2024 16:41:01 +0200
Date: Tue, 26 Mar 2024 16:41:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mateusz K <mateusz.kaduk@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgLefFQanbq-ozKM@smile.fi.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 11:06:38AM +0100, Mateusz K wrote:
> I tried the patch that changes PCI_IRQ_LEGACY into PCI_IRQ_ALL_TYPES
> and it seems I get some other error now
> 
> [    1.477341] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
> [    1.477466] intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
> [    1.477468] intel-lpss 0000:00:15.0: PCI INT A: not connected
> [    1.477488] intel-lpss 0000:00:15.0: probe with driver intel-lpss
> failed with error -2147483648
> [    1.489572] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
> [    1.489688] intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
> [    1.489689] intel-lpss 0000:00:15.2: PCI INT C: not connected
> [    1.489715] intel-lpss 0000:00:15.2: probe with driver intel-lpss
> failed with error -2147483648
> [    1.501886] intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
> [    1.502034] intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
> [    1.502036] intel-lpss 0000:00:19.0: PCI INT A: not connected
> [    1.502067] intel-lpss 0000:00:19.0: probe with driver intel-lpss
> failed with error -2147483648
> [    1.514288] intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
> [    1.514535] intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
> [    1.514538] intel-lpss 0000:00:19.1: PCI INT B: not connected
> [    1.514570] intel-lpss 0000:00:19.1: probe with driver intel-lpss
> failed with error -2147483648
> [    1.526291] intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
> [    1.526555] intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
> [    1.526557] intel-lpss 0000:00:1e.0: PCI INT A: not connected
> [    1.526604] intel-lpss 0000:00:1e.0: probe with driver intel-lpss
> failed with error -2147483648
> [    1.538130] intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
> [    1.538233] intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
> [    1.538235] intel-lpss 0000:00:1e.3: PCI INT D: not connected
> [    1.538253] intel-lpss 0000:00:1e.3: probe with driver intel-lpss
> failed with error -2147483648

Hmm... I have a unique board to test :-)
Let's revert it then.

Bjorn, in such case your tree should keep conversion one.

Lee, do you prefer a revert or can you simply drop this from the queue?

-- 
With Best Regards,
Andy Shevchenko



