Return-Path: <linux-kernel+bounces-56621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B230284CCC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D561F22466
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D17CF38;
	Wed,  7 Feb 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmqWNc40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A47C099;
	Wed,  7 Feb 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316121; cv=none; b=T1m1DLDP1uzT5+JoNXDRo5E2LapvnYVb6pItem5z72cYWZ9J7GC1BDEDugZdXc9nu7Gl9E48w3j0/XvTRyZXV7c8glJDcRs4JJ6+JZWMCQKYlCYuAd/1wNw5+QQZsAS73ZCx9Oel4M2oh6TuvWaeq6ofg1O1cXdD8rXHyB0dgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316121; c=relaxed/simple;
	bh=T09NH+K9OB+5cBRVizzfGFKyrC8gvkvf+GGOCbIop6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8FiCKUwvibbtF2fhmV646ayu4Zw7HLDQ/2vEV19JQc9rH9kONAY0cuEBNzG2yMg/kMD4MTUPsLIFFkHcGDBgDAmLn6Drzjq4mRqbtvf5DVgvF45yz2zbDAymHfipfTl7D9/BIoliFA64SdmrTBZO7OylrC1XlD2SfIJesfXwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmqWNc40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFE9C433F1;
	Wed,  7 Feb 2024 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707316120;
	bh=T09NH+K9OB+5cBRVizzfGFKyrC8gvkvf+GGOCbIop6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmqWNc40Wn8O+g2p5nCZRDdlHBgUdcSN7gF43458D1PwN4svHHFHuP4QEf4/DOw4N
	 28bSY1wFrKHOe+iQOF23kKamdoiGMrpHVxGnPbcEDLsQ+EqCyGbgpVa9q0aKGUNe2W
	 i85cJohoGvsPpsKdkgyAmG2P95AmsgLCk5+Hh2rMnlcTuiEsYCByfR5I3EtVvO+KHq
	 1//9zynIJFJo++t4TXcmsStuLflTh0Oosv9wtTAfA95mwV+vq4qYXkHsUJ+Er+2L3H
	 yt+CJIZEXJ6lb40ggUy18ZfMdtfttrThzsAVcNCpQqPiLhN1Oa3kPUDUrlwItdctEA
	 DKBWg1W75H6kg==
Date: Wed, 7 Feb 2024 15:28:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] sched/vtime: do not include <asm/vtime.h> header
Message-ID: <ZcOTlZwYo1n4-myD@localhost.localdomain>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <2402f44309e1c9705501bdc9b798e8fe6d73f905.1706470223.git.agordeev@linux.ibm.com>
 <ZcLBAKMJ5Vbbm2Ln@localhost.localdomain>
 <ZcOP6bm0ekxDUVk6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcOP6bm0ekxDUVk6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

Le Wed, Feb 07, 2024 at 03:12:57PM +0100, Alexander Gordeev a écrit :
> On Wed, Feb 07, 2024 at 12:30:08AM +0100, Frederic Weisbecker wrote:
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thank you for the review, Frederic!
> 
> The Heiko comment is valid and I would add this chunk in v2:
> 
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -6,5 +6,4 @@ generic-y += agp.h
>  generic-y += kvm_types.h
>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
> -generic-y += vtime.h
>  generic-y += early_ioremap.h
> 
> Would you keep your Reviewed-by?

Sure!

