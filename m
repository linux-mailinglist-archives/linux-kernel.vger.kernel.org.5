Return-Path: <linux-kernel+bounces-57711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB9484DCA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A71C26341
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746C6BB59;
	Thu,  8 Feb 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOP6BD18"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFC6BB4B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384006; cv=none; b=klWug3vdXxhYe8UUT1Gu1hKYgfHNH6F6YW0wq+sVv9ZEWCCAJAlm0UlSaAkizqyxLNY46tCEdE8GwGSduxP3wJQZnIpNo9dLL1MxZfhmMVyTgoTsY7CacGQB+fVl+1SuGHdVcBjWX4NpkK+HIEWfAwKJAcmulem7lpn5K7cbV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384006; c=relaxed/simple;
	bh=+uywdEFWirFzKIUpD6+ByT/yg+iiUGbIbtpdl6awkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGcweT9kzYmvFJZUoENATP/FFYwX/P78hXDSlfTQRHSwle3paLK9FzjD2syMENqC8Utd8wz8ww1ApBgDV+YXNA4lilbc8L5KvKMYkJbvSuV19HKMwFCWXo/3txjXJVr3VQJlfuHpMBGTaAfTcdhyngYFPW0nOa8dWbfCwFMB074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOP6BD18; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707384003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfySpqWl1TsOvDzqqREgn2XTm5VZ4qycsTnqTDrC3S0=;
	b=DOP6BD18hmIlieyM51NJwF2i+MfpvKA7h+dwBxc5xUb25PhHY2dw3DIb3g2sW0zDwYMNcy
	FPDFl9RROOZYe/D9Oa8zUTNubfTofk+oKg+2tvZzjrKtEGoYJoJss4GRAAkMi1Bf22cpQ4
	Ymi74YoZ1KViN86tFl/icsfd54Xueao=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-0mXpjo0ZPqSXA07eDs2xrg-1; Thu,
 08 Feb 2024 04:19:59 -0500
X-MC-Unique: 0mXpjo0ZPqSXA07eDs2xrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE1583C23FCC;
	Thu,  8 Feb 2024 09:19:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
	by smtp.corp.redhat.com (Postfix) with SMTP id F273711216;
	Thu,  8 Feb 2024 09:19:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 10:18:43 +0100 (CET)
Date: Thu, 8 Feb 2024 10:18:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Tycho Andersen <tycho@tycho.pizza>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240208091840.GA19801@redhat.com>
References: <20240131132602.GA23641@redhat.com>
 <202402081434.9e1ded3-oliver.sang@intel.com>
 <20240208-empfinden-annalen-da6c77b0fefb@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-empfinden-annalen-da6c77b0fefb@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 02/08, Christian Brauner wrote:
>
> On Thu, Feb 08, 2024 at 03:54:44PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "last_state.load_disk_fail" on:
> > 
> > commit: aa9c201b150f15cf12e8df8af531b2c74ae1a8fc ("[PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for pidfd_open()")
> > url: https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/pidfd-implement-PIDFD_THREAD-flag-for-pidfd_open/20240131-213408
> > base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
> > patch link: https://lore.kernel.org/all/20240131132602.GA23641@redhat.com/
> > patch subject: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for pidfd_open()
> > 
> > in testcase: boot
> > 
> > compiler: gcc-12
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202402081434.9e1ded3-oliver.sang@intel.com
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240208/202402081434.9e1ded3-oliver.sang@intel.com
> > 
> > 
> > as in dmesg in above link:
> > 
> > LKP: ttyS0: 1408: can't load the disk /dev/disk/by-id/ata-SanDisk_SDSSDH3250G_182971800454-part1, skip testing...
> > 
> > we know this should be related with some early issues but we failed to figure
> > out. so here also attached parent dmesg as dmesg-e0ee7b583f.xz FYI.
> 
> I have a hard time seeing how this would be caused by any of Oleg's
> changes. Plus, the merges from the vfs tree linked under "url:" above
> are all pretty out of date?

Yes, the patch under url still has the extra trailing ";" after "if"
so pidfd_prepare() will always fail. Fixed by Tycho.

Oleg.


