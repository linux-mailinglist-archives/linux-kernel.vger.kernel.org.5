Return-Path: <linux-kernel+bounces-90449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A586FF4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280852849AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C1374E0;
	Mon,  4 Mar 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a65Q4K6n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691336B02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548947; cv=none; b=kIf083hO79HensstfYjPzpp4rg25aXnHlz/NyNWSSwnxkP2NXBWBcHZzvp7AnZ8kVwSTNIpL3r7GABpiLs1BYUyhGWZXJFOvvbEjVl80V4q8rPoYktVWk65usjO092J1gcNNS6z3uugHAFRONe6BYTqH5DTgrn+AXSlqdxS0GHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548947; c=relaxed/simple;
	bh=r3ul6PGNYof50/R5Ayjtl8Den5KT5SDwEijToqmquco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXXR0GviLdx5xxxUPk1/epgTLYF4mhHvxMKmCUlfuWTk817RtA+mt6K17dbwNO3eET/VA5S4ow2TLKbr5F8pOixRihXBp4RVjALfk+CmEEgeHhP/yxqMWgu9bxb3RLxhD3NRkxCyZ9CaVkFaaJKVLkXAera25/kIaey7XnfW6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a65Q4K6n; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709548945; x=1741084945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3ul6PGNYof50/R5Ayjtl8Den5KT5SDwEijToqmquco=;
  b=a65Q4K6nh6FOqCJtshyFeoULQTOoq9iGWg0VD9/2V+FwjWVxKL8lh2K6
   SKIWQwH6/xou4rmkj2y6SZcfXAVuazYH1oVwqnAB9prpCnkU1v9UYqvQy
   pDdayu0g0wA1f4E3bKZK6FpBncdF5SpstDU+uxu5P34xc5m/EY+ygBk3t
   InZk9J9hb0JBu1151Mn43/iWQzgOP4CszrDoD2bmiao8geugbJ9W3EMBj
   riIkPJw7UdkKPQDsAwrDbrT/1UTdjUnEHesv86vZBY9uO6wGXDRWbmvLm
   bGOnIUpcy8Zvn9ibfMfA8mnnEScc33K8LK9g/yUw7wDC0p4+KLOw4vJuV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26498303"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="26498303"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 02:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9021933"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 02:42:22 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id AD0D111F8B1;
	Mon,  4 Mar 2024 12:42:18 +0200 (EET)
Date: Mon, 4 Mar 2024 10:42:18 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mei: vsc: Call wake_up() in the threaded IRQ
 handler
Message-ID: <ZeWlinaMxeNiVhMv@kekkonen.localdomain>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-2-sakari.ailus@linux.intel.com>
 <MW5PR11MB5787E314C6DDA3D37FC1992F8D582@MW5PR11MB5787.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5787E314C6DDA3D37FC1992F8D582@MW5PR11MB5787.namprd11.prod.outlook.com>

Hi Wentong,

On Wed, Feb 28, 2024 at 08:19:04AM +0000, Wu, Wentong wrote:
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
> > wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT. This leads to
> > sleeping in atomic context.
> > 
> > Move the wake_up() call to the threaded IRQ handler vsc_tp_thread_isr()
> > where it can be safely called.
> > 
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>

Thanks!

I dug a little bit deeper and it seems the lockdep warning this patch fixes
is something we can safely ignore, see
<URL:https://wiki.archlinux.org/title/Realtime_kernel_patchset#How_does_the_realtime_patch_work>.
My apologies for the noise.

The two other patches in the set are still unaffected by this.

-- 
Regards,

Sakari Ailus

