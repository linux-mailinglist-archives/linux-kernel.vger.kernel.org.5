Return-Path: <linux-kernel+bounces-72542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E285B4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AAD1F21886
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D545C616;
	Tue, 20 Feb 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ+u7iKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914205C5F9;
	Tue, 20 Feb 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417490; cv=none; b=IWo/hhQW05lDT8mZDj7qC7Y8rnJSHdORNIu2DvteHeylp47cs8oHwbKS4+1r8rKufa3RO7sO4HwZafa9LjfQM1C+GJqoRGW3qfR9l7k40QtsM838CkkGfOfRg7JIJgo0udfv15PaW6AEINVvLgUNg9EFuNz3M0f9nKe0n1m9Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417490; c=relaxed/simple;
	bh=o7IhKXDzwH+CSSEaHA40a69Pk3oXdDwj9C4S5J5Ncmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNz8V73Sv8+IdQ3F9k8A3781fHVzZNgfmaMuATa289gfGi/XhulcMtvJBv6FdtKiFh6l5f8kfoLGQgjqZnXqIvknBhZp2NXSmonAvWWrTAWVP8ZWU7qdVcrf3Cl2err/NHX5CSsEoAkKb9pXGLPKg298xI4fHdDbMeLr2ZfiesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ+u7iKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD151C43399;
	Tue, 20 Feb 2024 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417490;
	bh=o7IhKXDzwH+CSSEaHA40a69Pk3oXdDwj9C4S5J5Ncmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQ+u7iKRqijmTFoTEmptfvIprnx9ryUDSI3kw8AifYGxDlkufqMcNPB9PC/iCD1i8
	 DFun1qkoL3q6Co5UCEFCNDr32LL+IVWIq7RV7TP7aqW/Aqf5xfiUnOZmHZ0wnpVi4L
	 70oCtuZ764e6jUThAzjQ3oP8slxFQShh8VuL8oUML8cl3V3ZQlHbknEI4UXSaPEUS9
	 T4mhSGD/QtZy+nHiqiRpga8LdHo0jjNYWutCdwXXtXmq62roWyFRcT+hqnbA8jeyNT
	 f1d5XoHHhRIYgUwoP04wBO4uvhIjgTswbsbhgLPftMYq7Fu5BWnzrR2N44EfgRnr6I
	 ZOg1wEDGuKmKA==
Date: Tue, 20 Feb 2024 08:24:44 +0000
From: Lee Jones <lee@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: James Bottomley <jejb@linux.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <20240220082444.GH10170@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
 <20240208102939.GF689448@google.com>
 <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
 <20240219152312.GD10170@google.com>
 <202402191328.8E1A325@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402191328.8E1A325@keescook>

On Mon, 19 Feb 2024, Kees Cook wrote:

> On Mon, Feb 19, 2024 at 03:23:12PM +0000, Lee Jones wrote:
> > Adding this to checkpatch is a good idea.
> 
> Yeah, please do. You can look at the "strncpy -> strscpy" check that is
> already in there for an example.
> 
> > 
> > What if we also take Kees's suggestion and hit all of these found in
> > SCSI in one patch to keep the churn down to a minimum?
> 
> We don't have to focus on SCSI even. At the end of the next -rc1, I can

When I've conducted similar work before, I've taken it subsystem by
subsystem.  However, if you're happy to co-ordinate with the big penguin
et al. and get them all with a treewide patch, please go for it.

> send a tree-wide patch (from Coccinelle) that'll convert all snprintf()
> uses that don't check a return value into scnprintf(). For example,
> this seems to do the trick:
> 
> @scnprintf depends on !(file in "tools") && !(file in "samples")@
> @@
> 
> -snprintf
> +scnprintf
>  (...);
> 
> 
> Results in:
> 
>  2252 files changed, 4795 insertions(+), 4795 deletions(-)

Super!

-- 
Lee Jones [李琼斯]

