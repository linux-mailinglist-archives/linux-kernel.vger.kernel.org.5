Return-Path: <linux-kernel+bounces-107441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B165087FC93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD04282921
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A57E76A;
	Tue, 19 Mar 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfWv/f0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851D4F8A9;
	Tue, 19 Mar 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846596; cv=none; b=s0fo/fMiaGQJnGmY8CIyry14fUnQO0XqCen4bsOYnctkZO1pljTQaibWeq0PgRWh+2n3BYVGaViauZmKf0S1BA00Emj7/EwHW3K+6AHXZrmj3nw8V/XPZPLhQ7PNHcEnUlnxeNIUzEpfV1cNEHlA7NwkWqyDc1V7AYTHXfODuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846596; c=relaxed/simple;
	bh=YoRnH6hNp0gcVun5qckDdtU36lr0TngCn1rZqdcr0to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCoIwDNgszAxVRBsEeHIKsQB48WSjcPXvLDlSYmVR8L39ac0wS1lLQmQOa1UCLq+Tsb33p6tanVt834oqEvOONHJs7q8gJPUnF8EcNdGnSiEcMFITAYQ41dMOa92HDn+fg8xQBMFsB/KLHFUjvV/oN8TOF7U/PlDwKKGIGGQLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfWv/f0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3535C433F1;
	Tue, 19 Mar 2024 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710846596;
	bh=YoRnH6hNp0gcVun5qckDdtU36lr0TngCn1rZqdcr0to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfWv/f0j8qwZFlcmxNdjD9a3bEtjndG565UxbTqUL5ob3OD65/PY5UgCTb050V6dp
	 04qVN8HhnhA+56e2VO50eLm3tYquQHodC8VMlBeLlFtxM6fE+Zvy5udI0eN2HeueSH
	 Zuei6mx8T7uDC3czhPUX1k06RsuDcIegsttoGfFOhdW+IZqjeU3TSuP2N81tTbcAtd
	 8sku41QJ8th7Lp84UV50dRQFW0HVjSsrRRHgbg7MaJv25mMUpZ3apyxFJL9uq8Tag+
	 GvIFCUuSZ2YtdzFnYQ5CQtc+j1EFe1olGdaI6MhiqhAmt5aYTfjEVay+sQVe5rJVYf
	 mxWUIoFq0FwVA==
Date: Tue, 19 Mar 2024 11:09:51 +0000
From: Simon Horman <horms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Yufeng Mo <moyufeng@huawei.com>,
	Huazhong Tan <tanhuazhong@huawei.com>
Subject: Re: [PATCH] net: hns3: tracing: fix hclgevf trace event strings
Message-ID: <20240319110951.GD185808@kernel.org>
References: <20240313093454.3909afe7@gandalf.local.home>
 <8607787b42e80503e0259f41e0bcc2d3ff770355.camel@redhat.com>
 <20240314120027.088e850d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314120027.088e850d@gandalf.local.home>

On Thu, Mar 14, 2024 at 12:00:27PM -0400, Steven Rostedt wrote:
> On Thu, 14 Mar 2024 15:39:28 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On Wed, 2024-03-13 at 09:34 -0400, Steven Rostedt wrote:

..

> > > Fixes: d8355240cf8fb ("net: hns3: add trace event support for PF/VF mailbox")  
> > 
> > checkpactch in strict mode complains the hash is not 12 char long.
> 
> Hmm, I wonder why my git blame gives me 13 characters in the sha. (I cut
> and pasted it from git blame). My git config has:
> 
> [core]  
>         abbrev = 12

I wonder if there is a collusion at 12 chars in your local tree.

..

