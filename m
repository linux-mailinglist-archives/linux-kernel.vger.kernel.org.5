Return-Path: <linux-kernel+bounces-579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C675814333
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC361C2252C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B912E72;
	Fri, 15 Dec 2023 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX1LLfPU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46612E40
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702627431; x=1734163431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UYfWTyZOX+NwD3pTWby1e16s7jSYe1Z1Qk3VR1irHFo=;
  b=OX1LLfPUTjGYWgkEO1a4jBW5Ljh9tpJrYlghHve6VFSNuV6JcxNIzt1+
   rFP6QsIXwB+EwQeihrOS/XcujjdMrpqaSa5atcI45ywKqL/yVQN13Agum
   6izIaHbLJpWKOXPcBKL4m5sUpCj0c5/urzZC+xAwDqXLeNG3rqPucc9xB
   yCQZDxz+UUacqcym17mxZvnTpsReeHQq4Fcm+SIL4uY8KaZ9xJuI7hx6z
   71Lbcq5wUphKzJGsPDCuwGX8OGi+Wv/EbUAW03hRzJOmoO+eFJrcV3vIu
   JlMiqk0J+EF1lvWLf3CMP2XT1g/EDZTb203yR0P1zoSwSXxx2lbzdU5hY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2085181"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="2085181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808887654"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="808887654"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:03:38 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 64FBB11FBF2;
	Fri, 15 Dec 2023 10:03:35 +0200 (EET)
Date: Fri, 15 Dec 2023 08:03:35 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentong Wu <wentong.wu@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] mei: fix vsc dependency
Message-ID: <ZXwIV93OgsXjo99u@kekkonen.localdomain>
References: <20231214183946.109124-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214183946.109124-1-arnd@kernel.org>

Hi Arnd,

On Thu, Dec 14, 2023 at 06:39:31PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_INTEL_MEI_VSC_HW can be set to built-in even with CONFIG_MEI=m,
> but then the driver is not built because Kbuild never enters the
> drivers/misc/mei directory for built-in files, leading to a link
> failure:
> 
> ERROR: modpost: "vsc_tp_reset" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_init" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_xfer" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_need_read" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_intr_enable" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_intr_synchronize" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_intr_disable" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_register_event_cb" [drivers/misc/mei/mei-vsc.ko] undefined!
> 
> Add an explicit dependency on CONFIG_MEI that was apparently missing,
> to ensure the VSC_HW driver cannot be built-in with MEI itself being
> a loadable module.

Well, I don't see why someone would build mei as a module can mei-vsc-hw as
builtin but the actual dependencies don't wouldn't prevent it. How about
instead changing the Makefile in the parent directory so mei directory is
always traversed?

Either way, feel free to add:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus

