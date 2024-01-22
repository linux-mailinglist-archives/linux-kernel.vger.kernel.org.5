Return-Path: <linux-kernel+bounces-33856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3E836F98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830111F308CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B14482E4;
	Mon, 22 Jan 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVG2mqUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE5481DE;
	Mon, 22 Jan 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945655; cv=none; b=nu3TntiUsLi8XKL3zpkdsLDlcrdMzgjECErbFNPxX6dmetcWLAYmpw3uG5WyTPCavJSmaG/veB6F4lE6CljPLNbXJ0DED+htaHXVX8JzXhuX/Uns/lDNr5NRfakTo49MWG5dklknl/PIAaSGDB+ZtH7kFFW9nyjOU6hjyZaqRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945655; c=relaxed/simple;
	bh=z12o7RQes1O6L0VjQgUTb29206GAnD7Za+zHeRVZVaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxweJojrGdVD/7Lv3RecN0FFxBe5ngIBQmrCN8JYscAm/3YegCJ6tJPdgaKwoVTmpFKfxqEAqQwruCq41BhLSRx+0viLYy6TxlVi4EFGMsG06fM+n390mwwlpn2rBcjK7h4lDUAuwL2sRE+ks2Da+Zk0yIIUBnA3QeIwL7Flrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVG2mqUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B8C433F1;
	Mon, 22 Jan 2024 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945654;
	bh=z12o7RQes1O6L0VjQgUTb29206GAnD7Za+zHeRVZVaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVG2mqUijYFmXj/u+GtcZDAD/0Vak6pF9RCtZNgdN2zYg4AJsSX+8goJhDSGLqRN3
	 hGQogNaXI5L+DhnEP8rMI8d8/Sf6K7CZjD6TUk9ro6NyfKt0wXqrTuqaWxYTrMEPQM
	 lbWoIjFUgTcQ3l+AaRr4LI25aU9bqeksIwW6lQB8=
Date: Mon, 22 Jan 2024 09:47:33 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH 5.10/5.15 1/1] kprobes: Fix to handle forcibly
 unoptimized kprobes on freeing_list
Message-ID: <2024012224-clatter-siren-ac3d@gregkh>
References: <20240122113031.301202-1-pchelkin@ispras.ru>
 <20240122113031.301202-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122113031.301202-2-pchelkin@ispras.ru>

On Mon, Jan 22, 2024 at 02:30:31PM +0300, Fedor Pchelkin wrote:
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> 
> commit 4fbd2f83fda0ca44a2ec6421ca3508b355b31858 upstream.
> 
> Since forcibly unoptimized kprobes will be put on the freeing_list directly
> in the unoptimize_kprobe(), do_unoptimize_kprobes() must continue to check
> the freeing_list even if unoptimizing_list is empty.
> 
> This bug can happen if a kprobe is put in an instruction which is in the
> middle of the jump-replaced instruction sequence of an optprobe, *and* the
> optprobe is recently unregistered and queued on unoptimizing_list.
> In this case, the optprobe will be unoptimized forcibly (means immediately)
> and put it into the freeing_list, expecting the optprobe will be handled in
> do_unoptimize_kprobe().
> But if there is no other optprobes on the unoptimizing_list, current code
> returns from the do_unoptimize_kprobe() soon and does not handle the
> optprobe which is on the freeing_list. Then the optprobe will hit the
> WARN_ON_ONCE() in the do_free_cleaned_kprobes(), because it is not handled
> in the latter loop of the do_unoptimize_kprobe().
> 
> To solve this issue, do not return from do_unoptimize_kprobes() immediately
> even if unoptimizing_list is empty.
> 
> Moreover, this change affects another case. kill_optimized_kprobes() expects
> kprobe_optimizer() will just free the optprobe on freeing_list.
> So I changed it to just do list_move() to freeing_list if optprobes are on
> unoptimizing list. And the do_unoptimize_kprobe() will skip
> arch_disarm_kprobe() if the probe on freeing_list has gone flag.
> 
> Link: https://lore.kernel.org/all/Y8URdIfVr3pq2X8w@xpf.sh.intel.com/
> Link: https://lore.kernel.org/all/167448024501.3253718.13037333683110512967.stgit@devnote3/
> 
> Fixes: e4add247789e ("kprobes: Fix optimize_kprobe()/unoptimize_kprobe() cancellation logic")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> [fp: adjust comment conflict regarding commit 223a76b268c9 ("kprobes: Fix
>  coding style issues")]
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  kernel/kprobes.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Now queued up, thanks.

greg k-h

