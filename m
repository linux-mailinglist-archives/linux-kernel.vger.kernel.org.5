Return-Path: <linux-kernel+bounces-157752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC238B1553
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8741C21FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5EC157492;
	Wed, 24 Apr 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFrygewd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65015747E;
	Wed, 24 Apr 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995445; cv=none; b=ZhT5pKjtYkz3s+aFIobIvysgYyJw6qqvaewHtRltEQPbg1K6kUaF8sx0a5kF6K3wcgEVW/o5cjxn1XmS0mKjex+IP+rhfs9aEfZG9uhMZl80WGuFvb2B+1H12OBfQR1XkVtCgf8d2EokxCF36ctqMmM3CXl3CdXO21500Fn7VzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995445; c=relaxed/simple;
	bh=V1amWpZY8vykBiXYDi7oosr0+oJ0Di6hNW14BZEqcdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRPqummhN+Q1RdqNrkkNJinPnqv/lH6SGTS1CMCGr3GpKP03In8JqHOL/teFtG5JpiPxE9JV16XnePz62rofK2uBme0vZb5aNdS3Lp0hAy8AGywmR6/dvlTwzOx34z5nQim6j4Td2eGXHrND0tZqOIv33vvvBVkdu1uFMobjHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFrygewd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155DFC2BD11;
	Wed, 24 Apr 2024 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713995445;
	bh=V1amWpZY8vykBiXYDi7oosr0+oJ0Di6hNW14BZEqcdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFrygewdaAl+dA9kc9noio0QC9oJBMJiPRHGUN82W0m8iahrZQq651uWNbtpnR2UX
	 xV3Ijb8cRMqTqYA9XGm7cpdjOopd8U3TFKNsmNAeGZ3wE0caPhgSp4XeBfSco25NRh
	 FRQ7YhOVVBEqQL5MsTyYJMOrjwts1fp8bruf2eXA=
Date: Wed, 24 Apr 2024 14:50:36 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: CVE-2023-52575: x86/srso: Fix SBPB enablement for
 spec_rstack_overflow=off
Message-ID: <2024042413-cartridge-caption-c667@gregkh>
References: <2024030256-CVE-2023-52575-34bf@gregkh>
 <7c1dda50-2155-4b3c-8a87-b8669b077b30@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c1dda50-2155-4b3c-8a87-b8669b077b30@suse.com>

On Mon, Apr 22, 2024 at 01:00:18PM +0200, Nikolay Borisov wrote:
> 
> 
> On 2.03.24 г. 23:00 ч., Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
> > 
> > If the user has requested no SRSO mitigation, other mitigations can use
> > the lighter-weight SBPB instead of IBPB.
> > 
> > The Linux kernel CVE team has assigned CVE-2023-52575 to this issue.
> 
> I'd like to dispute this as this isn't a CVE but a mere performance
> optimization in case spec_rstack_overflow is disabled. Without this patch in
> case spec_rstack_overflow is disabled the kernel will simply use the heavier
> ibpb but that won't have effect on correctness.

You are right, our fault.  I'll go reject this CVE now, thanks for the
review!

greg k-h

