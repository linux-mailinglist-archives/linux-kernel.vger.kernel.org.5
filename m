Return-Path: <linux-kernel+bounces-43538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D737F841544
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5ED1F21713
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8DD159589;
	Mon, 29 Jan 2024 21:55:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8594153BC1;
	Mon, 29 Jan 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565335; cv=none; b=qR3RGQf6wBKF4Yo6H9v4yIz4mZC36uWOFTxWwa9rQJD93TerV3l+wZqaDuXacY9NasnD8CLTpNV2vaEFgDdQ3TJccAhIaGLvG8RS/k6iRPx5WxZkfkh8zVhTwa8RB9dmI6fKvOhBLHnrKzLyLXe4okMJpyey3PU6UNP64wMP+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565335; c=relaxed/simple;
	bh=LwpdwWjfn8pn6umFZf8cgWtzSTXpwBVw1pHvwYkuXYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euAyhllvjRU8mH7XTE9IAQoLc+os5WeWWbDDqgnXGj0byp4CiWAayOIZvX7f1ScZEooEVI8vrhQp2U2WiP7KZ1xEyhdi2stBDyJbHya26vUrlCNCI+iIW4iPNBz+0oJZ2shbIA+18Jt4PVqOzBwhXB5iqUyub+RusJ6gUFvsbH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D87AC433F1;
	Mon, 29 Jan 2024 21:55:33 +0000 (UTC)
Date: Mon, 29 Jan 2024 16:55:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129165543.5468039a@gandalf.local.home>
In-Reply-To: <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 12:51:59 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [0001-tracefs-remove-stale-update_gid-code.patch  text/x-patch (2612 bytes)] 

Oh, I already applied this and even sent you a pull request with it.

  https://lore.kernel.org/all/20240128223151.2dad6599@rorschach.local.home/

-- Steve

