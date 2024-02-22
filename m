Return-Path: <linux-kernel+bounces-76931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20D85FED3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1354D1F2802D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD5154C18;
	Thu, 22 Feb 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XajQmD34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CB14C5AB;
	Thu, 22 Feb 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621893; cv=none; b=eUtb/PRgyzyujKbh7LxHQssre3FiPnmHvIdYxRhVqsDMrR7J6j7B9AEsboESDeHggrtAEUQ7v/wpdZxqpMsXibf/t6SCmTrDdJWHFG/Z8/y4+D+XqOxbR32IsqXb7Kt5WeWbwtlHxchtHZqMilbpapYCbmIg/gtHiNyLdvICf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621893; c=relaxed/simple;
	bh=K0i9HFk6CFL2zhmvdOVUHC2QYPmcZLijnnv2ogVxSGU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g7K0/b3Tz54m/CA/k9aOLosnEDOsgpnwRRRkb4e1BYekWxVL+RvKll0qwlWMzV376mtvzZ3BdXgWlGemwSAXMx9SwAqeD/sjEJYtg9AtLP0pEacE5ikY+6rDlF7FQU+TNdYPHVQ/ts5steakxkc9oRj9EwG76V76tGelYWx1CTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XajQmD34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DE8C43390;
	Thu, 22 Feb 2024 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708621892;
	bh=K0i9HFk6CFL2zhmvdOVUHC2QYPmcZLijnnv2ogVxSGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XajQmD34iYclajNLoZXOYbRQ47eSPFcGaq3DzCrTm75rom0tlAoIp/66pt7zsCKuo
	 G0Jf9nSUOxIfMRbpp1wuBhTwWsGGuSIUVpKCPO+Oe/7LJ2CiXBoi2pF5vHa5uX/9QE
	 Vqp+R439ZIEJO20xyE+dntgxNdBNx+l5EHayAcWg=
Date: Thu, 22 Feb 2024 09:11:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the mm tree
Message-Id: <20240222091131.5a85973927496f49af32123a@linux-foundation.org>
In-Reply-To: <20240222164112.20c5646e@canb.auug.org.au>
References: <20240222164112.20c5646e@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:41:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the kspp tree got conflicts in:
> 
>   scripts/Makefile.lib
>   scripts/Makefile.ubsan
> 
> between commit:
> 
>   1a75e5856b3b ("ubsan: reintroduce signed overflow sanitizer")
> 
> from the mm-unstable branch of the mm tree and commit:
> 
>   557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
> 
> from the kspp tree.

Thanks, I'll drop the mm.git copy.

