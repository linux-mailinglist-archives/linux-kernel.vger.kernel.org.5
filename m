Return-Path: <linux-kernel+bounces-23503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2282ADAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BBC1C227DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4C15493;
	Thu, 11 Jan 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug8d0jJ9"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A0156C8;
	Thu, 11 Jan 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704973092; x=1736509092;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z1ttDXrYTv+Sve/f2vZWawOKbHHb4+tnEe1pfr93vWw=;
  b=Ug8d0jJ9XHd1lRGtVWDI3ilJKPxx6DZHW0tqEeVbjnMSDw8lXF2ArJ20
   oaV/fe2AjhfUA8tFFkHDCQvCYn1I/H+Jvuzq5Bdzo/IcFEdbXCV2VLx0Q
   Dqyy3DehdxKCd1t6b7hQ4tqqI4aBvmHMSduwnv2Pi/1SCcEBSjI1hI6jn
   F8XQBtem4+TdJiMq4gwHx6SR9PuCNy16OYnecPBPeKqEOCwu6WSftYH+x
   in6ERmt59PVSeFMFg3j6v1ADErCHA1E4VufqI6Gv9GSUJ+f2R4K/orLCC
   qz6yJyJNi/br9NFNzeKyzQH/6SxoNBs2y2R2eUZ6t+oMcGz3G7XUj3cWs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="395965665"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="395965665"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1029514569"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029514569"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.201])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:38:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jan 2024 13:38:04 +0200 (EET)
To: Michael Pratt <mcpratt@pm.me>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 RESEND] serial: 8250: Set fifo timeout with
 uart_fifo_timeout()
In-Reply-To: <sxGlnHaZVt4mMgmwzplgzx0bwPOv0MaG8us_UlJg2n6QajwaUgqi876d6ctZZrpkAQBLv7iJ2h2sQ4VOdOk16QHDp_D5AJCYpxPXKbBKrFA=@pm.me>
Message-ID: <d096c04d-581e-2216-4b1d-b4fd1f659a64@linux.intel.com>
References: <20240111002056.28205-1-mcpratt@pm.me> <2024011125-stiffness-mutilated-75bb@gregkh> <sxGlnHaZVt4mMgmwzplgzx0bwPOv0MaG8us_UlJg2n6QajwaUgqi876d6ctZZrpkAQBLv7iJ2h2sQ4VOdOk16QHDp_D5AJCYpxPXKbBKrFA=@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Jan 2024, Michael Pratt wrote:

> 
> 
> On Thursday, January 11th, 2024 at 01:52, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jan 11, 2024 at 12:27:07AM +0000, Michael Pratt wrote:
> > 
> > > Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> 
> This is the commit that made the issue present itself.
> 
> I'm not sure whether it's right to say that this "fixes" that commit
> since it only caused the issue indirectly, and the diff for this patch
> doesn't touch any lines that the other commit touched, and the method
> I'm using to fix the issue was not available at the time, and also that
> for high baud rates like 115200 everything is still fine...
> (the 10 ms timeout is as old as the tree)
> 
> If that's enough for a "Fixes" tag then go ahead (or tell me to add it),
> but maybe a "Ref" tag would be enough?
> 
> You can see the other thread linked for more discussion on that point if you like...

Besides Fixes tags, you can add dependency information for stable folks 
with Cc tag using the format described in 
Documentation/process/stable-kernel-rules.rst

-- 
 i.


> > > reworked functions for basic 8250 and 16550 type serial devices
> > > in order to enable and use the internal FIFO device for buffering,
> > > however the default timeout of 10 ms remained, which is proving
> > > to be insufficient for low baud rates like 9600, causing data overrun.
> > > 
> > > Unforunately, that commit was written and accepted just before commit
> > > 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> > > which introduced the frame_time member of the uart_port struct
> > > in order to store the amount of time it takes to send one UART frame
> > > relative to the baud rate and other serial port configuration,
> > > and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> > > which established function uart_fifo_timeout() in order to
> > > calculate a reasonable timeout to wait for all frames
> > > in the FIFO device to flush before writing data again
> > > using the now stored frame_time value and size of the buffer.
> > > 
> > > Fix this by using the new function to calculate the timeout
> > > whenever the buffer is larger than 1 byte (unknown port default).
> > > 
> > > Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
> > > 
> > > Signed-off-by: Michael Pratt mcpratt@pm.me
> > > ---
> > > v1 thread: https://lore.kernel.org/linux-serial/20231125063552.517-1-mcpratt@pm.me/
> > 
> > 
> > What commit id does this fix?
> > 
> > thanks,
> > 
> > greg k-h
> 
> --
> MCP
> 

