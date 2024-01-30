Return-Path: <linux-kernel+bounces-43778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4788418C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCDA283E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C3364C1;
	Tue, 30 Jan 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hqBEtson"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485F364A3;
	Tue, 30 Jan 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580500; cv=none; b=oRTvJLrJvG6lY91/hWV9zG9zooN0v0JZwlo9lSl5a6kDMNmavKJmMpxrnjbC7/DGXHl9I8TmPP/BMTcTMvQ7uJA4ngkv7JLhF2mDP/CViAsj9gaCzVA0TU4BIKBgMgcuv8cKt/Rckn1AaY7JGgYwkVOQ7eiZuYDO9P6IGOSd0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580500; c=relaxed/simple;
	bh=gwghMWsyJ5olqhnWSLRVCP36AA0Xr3Ue0iwR9NP8FVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTY31GoYg8XdI6TBqLYoGVRx70D+3sheSRTH9iVUlNmfOBlyHTp78vtWrV+DLOxzk65EEVdTAoTWg1GO950W1Q3jUBv/RPFiBjzaYsHFax96bLB7M/sMKD6Jr8HDBDZ+n/fAzhvFC6zPH7pyYxYfvWT2SwVDdHuAOOic7wb3ZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hqBEtson; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gwghMWsyJ5olqhnWSLRVCP36AA0Xr3Ue0iwR9NP8FVM=; b=hqBEtsonsPSXn88C4Vxe0aMmvk
	CGsD5wSPNAtFbTxmp52M6VOyPzYctpGrSWrtc5BEkP5df37aHIz+p9Wgbzle2X8mc5OapP3nr2Wmf
	I1WdaHzLqDfy2KyINOw302a5gK5nm4g0rMjvQem0yeaid036DxDBB32rhtgDghLTK9HaPGCOpRJ9g
	wt6uPnZZl9qe13VThwyuTutKeVR5+nVyqUvM+FBFsM2nK+V/0bQqgrHS8Y9kRmqGPvRFxYAt/nIPf
	oefOvwIr3M86Nt6/hGBmIJO/2fWg9iKZIxbm28vsCGIkaIqlpHzmWiYYISv4nkunnkEuNKGg4v78b
	sWm2dihw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUdXl-000wk2-2i;
	Tue, 30 Jan 2024 02:08:09 +0000
Date: Tue, 30 Jan 2024 02:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240130020809.GK2087318@ZenIV>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
 <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 28, 2024 at 08:36:12PM -0800, Linus Torvalds wrote:

[snip]

apologies for being MIA on that, will post tomorrow morning once I get some
sleep...

