Return-Path: <linux-kernel+bounces-81488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D5867691
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66301F2AC90
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117F12881A;
	Mon, 26 Feb 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o98Mo/78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4D128363;
	Mon, 26 Feb 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954182; cv=none; b=VoSM7JMgd6+NCddvA1cCjxdOcBxueENDEnLLHrGg3dou2Q8kIobj5FfoWSv+qGXcLxRX5BfD/NuNdZ2gHyB0x0aVAQ1pbhXr3pP9klYAk2mAK4aCfSB1iomK4Eimb7OB7rBh0YSAKOteSS8JmZ0E7Unh0FDoGduvNE/Sk8iy42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954182; c=relaxed/simple;
	bh=67jJEXxyLq9p2Ef/4B1PzCLF2zQY+FmX1wTG8Gq5oXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj4UIFg43iRXGvcYC+pf497zXffb3rh6sORkvbLlKgfPtk8i8/Hj4NQgEdKLt6cbrBz2V7sVgGgtqAW/7WTCDIYhWSaQJa2D8BQ9H3zgUwi6E5c7qpXtzJS7pMkmOxauapol4W8ALxzhm/ahVUn86bjC21zkPCT/Ua5Td7URJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o98Mo/78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4CAC433F1;
	Mon, 26 Feb 2024 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708954182;
	bh=67jJEXxyLq9p2Ef/4B1PzCLF2zQY+FmX1wTG8Gq5oXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o98Mo/78L3E7sA77ucBISa4JtTv2jdikLLb0VUxng7vucJvL8JcQeWlkUskMHgAxF
	 THupOv/r8Y5Elk/G4hB2rW1NgQZySrafB3w2YOuGyZfJGibJEm0tXrHpyD5SLQ5W3j
	 2HaXeNBuPkdVlRLeai8qrhhrmRz0Thwvl1YXOn0k=
Date: Mon, 26 Feb 2024 14:29:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
	stable@vger.kernel.org, alexandre.chartre@oracle.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] objtool: is_fentry_call() crashes if call has no
 destination
Message-ID: <2024022656-anemia-slacked-e1d4@gregkh>
References: <20240226094925.95835-1-qirui.001@bytedance.com>
 <20240226094925.95835-2-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094925.95835-2-qirui.001@bytedance.com>

On Mon, Feb 26, 2024 at 05:49:23PM +0800, Rui Qi wrote:
> From: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> commit 87cf61fe848ca8ddf091548671e168f52e8a718e upstream.
> 
> Fix is_fentry_call() so that it works if a call has no destination
> set (call_dest). This needs to be done in order to support intra-
> function calls.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Link: https://lkml.kernel.org/r/20200414103618.12657-2-alexandre.chartre@oracle.com

When you forward a patch on for inclusion, you too have to sign off on
it.

Please do so for all of these commits.

And we recieved a few different copies of this series, please resend a
v2 series so we know which one is the correct one to review.

thanks,

greg k-h

