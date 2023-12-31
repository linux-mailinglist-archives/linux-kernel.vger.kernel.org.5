Return-Path: <linux-kernel+bounces-13647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8A820A52
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D77C2833C5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A556186E;
	Sun, 31 Dec 2023 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN3TBKuf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1317C3;
	Sun, 31 Dec 2023 07:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82230C433C7;
	Sun, 31 Dec 2023 07:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704007605;
	bh=Xq8852Xb36eg5WsYqlpC32gOFgfvjFAbvVIskQcLhSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jN3TBKufjtozxub0tJZ3LOuv6moAvPQloGubavm3XOiAlyTFTss1PWPRwrrBVxdDH
	 QhOuDwNKAbihry9LujRmYI3veXxGxZ1T//eYfno7eNwjuNuoJphU1BD7vvynOiHPRS
	 Jx772r4zV6PL7OUyteIO4mlpXDREKsYT7JbBEQriRT0pjBKfibeyGN+a80jvbTHnce
	 jIKvtFTErUko67cxhh3h7JrfKHDdrucm2E+imrijXTz+YRz0Bj6pavbQbwMSl9/MLz
	 TfwdLKiyAzTandOUzo40Tw1Z43U48U8ofJVdP/zi/XzJ23dkTLMNDEtJaeSP59TD2Q
	 OZiaimYMNs85w==
Date: Sun, 31 Dec 2023 09:26:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	Ingo Molnar <mingo@kernel.org>, regressions@lists.linux.dev,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: Re: [REGRESSION] Platforms supporting SGX fail to kexec due to
 96c6b8f212a ("memblock: report failures when memblock_can_resize is not
 set")
Message-ID: <ZZEXnl3w0K6avYR3@kernel.org>
References: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>

Hi,

On Thu, Dec 28, 2023 at 04:33:49PM -0800, Ashok Raj wrote:
> Hi 
> 
> 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
> 
> Causes kexec failure. Backing out this change, kexec succeeds. Symptom is
> it appears to hang, possibly hung at the panic. Although I have the
> earlyprintk enabled, I don't see any console messages when new kernel
> boots. 
> 
> Also tested turning off CONFIG_X86_SGX, the kernel with this commit
> included also kexec's fine.
> 
> Booting from warm/cold reset has no issues. Only kexec to new kernel with
> this change included and CONFIG_X86_SGX=y causes the kexec failure.

Can you add memblock=debug to the kernel command line and send logs for
normal boot and kexec with CONFIG_X86_SGX=y and e96c6b8f212a reverted?
 
> #regzbot introduced: 96c6b8f212a
> -- 
> Cheers,
> Ashok

-- 
Sincerely yours,
Mike.

