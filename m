Return-Path: <linux-kernel+bounces-51316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF0D848951
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A6B281D2F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794B168DA;
	Sat,  3 Feb 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0Q6cJ4s"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226D16436
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706999235; cv=none; b=YP1lTUYAvbsk/QXnRYvtZW3zOTJ4mJzkVBUTeyx6UDMQ9sEEDiPmwYwWPw8g2+dAfGd5QVG5yanTrob4+gvEoCe+No7We9PiQ4vyWgXhvaAD6KffJwaiif9URvdADPAwYp9yO3xxlEobY3e2Chreis81yFIQg1gjDiUSUpbtQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706999235; c=relaxed/simple;
	bh=aahhH/EVTyCGj2vPjj00iOsqui8LSXEZU/AjnDeMmV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a51mzNBzlAqAUPX8/p6xNGkdPqJaPXyLrpPaIRPjyPm5AZQB/Mqdxduk4MLG7tHOXbcRuTK8JQI35/wdLNtzvfkF2eIfEEm6pA/yOd2I7Xjv6NUVD3mfl3ayGDTyRZt7WxHNiFRCZyhxi+6cbV84HS4H7ZKSykU5uyPeIVIvd8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0Q6cJ4s; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 3 Feb 2024 14:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706999230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k36R5UvzRPlrw/DQ0hgA6MvLeuxxDoXMOSsEOQMkqGY=;
	b=Y0Q6cJ4sMvlntRaHHNrMEuzR8PdJnVFjqNXoAeWY0ZHZ85WWe7PTTOBYj0jTUToge1hdk+
	yayBlCurOdjKsqGcQP1i05CKEF3ItKTpUSElXRxcSOXUIvBMnqqZR4jRVz89W+ksG8PUlV
	5JIKcHITTUIWnZrEbGqgrsADtBWqLRU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix GUEST_PRINTF() format warnings in
 ARM code
Message-ID: <Zb69ryhz_mDw9UK4@linux.dev>
References: <20240202234603.366925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202234603.366925-1-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 02, 2024 at 03:46:03PM -0800, Sean Christopherson wrote:
> Fix a pile of -Wformat warnings in the KVM ARM selftests code, almost all
> of which are benign "long" versus "long long" issues (selftests are 64-bit
> only, and the guest printf code treats "ll" the same as "l").  The code
> itself isn't problematic, but the warnings make it impossible to build ARM
> selftests with -Werror, which does detect real issues from time to time.
> 
> Opportunistically have GUEST_ASSERT_BITMAP_REG() interpret set_expected,
> which is a bool, as an unsigned decimal value, i.e. have it print '0' or
> '1' instead of '0x0' or '0x1'.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

This all looks good to me. Just want to confirm before applying: you're
not planning any other patches that'll go through your tree that depend
on this right?

Figured not since you sent it separately, but just want to be sure.

-- 
Thanks,
Oliver

