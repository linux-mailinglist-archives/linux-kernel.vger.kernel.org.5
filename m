Return-Path: <linux-kernel+bounces-75861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443685EFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E91C21042
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2871755A;
	Thu, 22 Feb 2024 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlZsiqoy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8428EF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572950; cv=none; b=W7OM8ft4cYmipLgP7voFuYNPsQ0UUJoDbdKGB47/ftlkowdXVeP41HPPZbblyytJ3hShdYUn/yt05VudFKTonzfPafkBnj3M0T2NIww3jgIy1Or4yDZdSfUvQk0SpODJYZJYDPtF/yLGpROAw+TTC+2kAodlSVHXfnl+eTP29SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572950; c=relaxed/simple;
	bh=HSxScKbzztXZB5YaKXB2CHicE/jR2ReMfL/oei6pYmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5vlxgR16ICBfbgbnVf7XD8hPIBIeF9l3XoS/WpyIonwU916f15yr3aS7ZoM+YRRtY0OudCtty0jyD71zhGq9JV25ZyUrNPalqdcKStfKJUPSDxBw3iaAkBACjH0tX5H0IxCjOQC1cXDg6Yq6ZgyNTV0p4Zzis5GNHD+bhaLoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XlZsiqoy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k2qqGakj6suncR5yFTplOvwhI9MQ07qi3BIxDZ0n86Y=; b=XlZsiqoyvBGd+rE9mW8Fd2Bby3
	sjmex3EpRfExrk/r+40NGtN49fo3fE9AREhgffMlFj5ghpupNJrD9TIwhHtaW5Pi+FluHzRCSiGF8
	d/nVuqN2zQsVN3gKV5scRxFNXrAJjdAROVffaY+raUGFZYd5hS0vRSPCYPKRIDdezxdcD0M2rsFJV
	/yuJh+E2eKRLAul0dnCigD4O1pZx2dXSGZr//5vg/s5rFjpY+YJLnxXaC6kckkfcxwDyycoUl3isR
	nfA796cBiFDJaqut3yRrMDtZQBxKtUDwjwWGZPt1yTx1P6QZ/zwhabYErmbHb5SPo5D436ZCDzzTC
	H/jJ6UPw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rczs9-00000002TJz-215C;
	Thu, 22 Feb 2024 03:35:45 +0000
Date: Thu, 22 Feb 2024 03:35:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH v2 2/5] hugetlb: Move vm_struct declaration to the top of
 hugetlb_fault()
Message-ID: <ZdbBEc9d6WiCsQHl@casper.infradead.org>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221234732.187629-3-vishal.moola@gmail.com>

On Wed, Feb 21, 2024 at 03:47:29PM -0800, Vishal Moola (Oracle) wrote:
> hugetlb_fault() currently defines a vm_struct to pass to the generic

s/vm_struct/vm_fault/ (both this line and Subject:)

> handle_userfault() function. We can move this definition to the top of
> hugetlb_fault() so that it can be used throughout the rest of the
> hugetlb fault path.
> 
> This will help cleanup a number of excess variables and function
> arguments throughout the stack. Also, since vm_fault already has space
> to store the page offset, use that instead and get rid of idx.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

