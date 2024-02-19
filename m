Return-Path: <linux-kernel+bounces-71804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4655C85AAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A15D1F21B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4120481B5;
	Mon, 19 Feb 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zi1U53C3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3247F79
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366730; cv=none; b=MnPGrbF+eAjM9P7X/JnDX/OFJjmCzGUiPbO0CNEV/XjLZ79JWz1V+n4/83KPNdt40CQWyAYkPYU9hHj7P+AdXRCK1sg8Lca++Utuuqdewx2IQTew8b1brYJAUnrGD6mdO92VlqghCqLzD8Aym5J5pqYjQOGftKf1W3435Ss0se4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366730; c=relaxed/simple;
	bh=9qzal9oXOdJy6yA/NlBiSPMSuNQ7Zfu32zOuPiTA7NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJumyAJKffMsIYB8QnpjQcyS8sDHvP2/gQRSciOMu/nHNzFYMLe6u4h1dLjMY4F1mQWu8nrf6xjNewTTIDU4eevzUtVt/e58S3XZN4aGjwn3pppSYWT26kWxP/+Qjj+eNiqaIsTMoupgQ6wLKjBbJb4533LsqhG83uTuTYMwO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zi1U53C3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708366728; x=1739902728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qzal9oXOdJy6yA/NlBiSPMSuNQ7Zfu32zOuPiTA7NE=;
  b=Zi1U53C3Ql1/JG/7z+HGStcZ82KX6S1Ogz+cJ8CG0fJmTmhrMT1nP8Xm
   59Cx94qGa1K3oYLKWyVHHIVSwmF6ix2Z69dtBWUkq2zNno0NAnggtEFBK
   CPq9rqmXUQvYOklNNfLO4JuSpUulh+SPpw6EBq/ou1eybwZ9ckvKFRFj7
   rXdQCkwAKi48jzhJl9IoxDZDZG+KDJhZOARJUQfn11DBLt/aVorrmM3Gx
   6H9RGVvSJkcVINrCaeBKcfsfRTSTID0YZLEWDOkpNk8TyJPsRuo2OGaY1
   /79vQokpFn+hMZImhVi2xx75fVDIbgdOjG+2YDNUW+ncdPiG586PA+HR2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19988238"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19988238"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 10:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9257053"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 10:18:45 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8F86A11F819;
	Mon, 19 Feb 2024 20:18:41 +0200 (EET)
Date: Mon, 19 Feb 2024 18:18:41 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mei: vsc: Call wake_up() and event handler in a
 workqueue
Message-ID: <ZdObgUMqtMIZzIhV@kekkonen.localdomain>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
 <20240212094618.344921-2-sakari.ailus@linux.intel.com>
 <MW5PR11MB5787CBE779AE23D84847EBB48D522@MW5PR11MB5787.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5787CBE779AE23D84847EBB48D522@MW5PR11MB5787.namprd11.prod.outlook.com>

Hi Wentong,

On Sun, Feb 18, 2024 at 01:23:30AM +0000, Wu, Wentong wrote:
> Hi Sakari,
> 
> Thanks, and sorry for the late response because I'm in vacation this week.

No worries and thanks for the review.

> 
> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > The event handler, in this case that of mei_vsc_event_cb() of platform-vsc.c,
> > is called from a threaded interrupt handler in uninterruptible context.
> 
> But why this thread is uninterruptible?
> 
> https://github.com/torvalds/linux/blob/master/kernel/irq/manage.c#L1294
> 
> https://lwn.net/Articles/302043/

I guess I sent this too hastily. You can indeed sleep there.

Moving wake_up() to the threaded handler should thus be enough. I'll send
v2.

-- 
Regards,

Sakari Ailus

