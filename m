Return-Path: <linux-kernel+bounces-96155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0D8757CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C25B239F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CDF137C54;
	Thu,  7 Mar 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wnsVQwjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC3137C40
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841746; cv=none; b=jTlOh0WcULfI2gHHkao5UNP/vUmWGBO9sI5IZV1BTfFFmtCO0Bw17HVVMD1NknKl1Rmldm73jaXfZigF8kOmNYjNJOKVi8/wg8143ye2tu3qI2VWWxJTjjwkwVXOrQCc3uNWQolyBvgZFlVBJ8hjWLD/rdkUAYGweh/c/XoixvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841746; c=relaxed/simple;
	bh=QbobZIm6vzGL9mxcMfH8aT0PgqTNhtb1r9nMruHiV+s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M8rx/GwBDrMNpRcj/QNbXjHwk3ySMnbXQvM0lNmG/sRB2hGO5zuZ6UBflzbpJ9aG2w6vOYzl9mIbzR9ldBQ+jMu4lDKoVT7A2kjsiRFnOqfxZkqSfEL5Eamb69fhKsh8kkRzT2luUD+Kw+3Tmbym87BoofuFGrLFaVZNw8ExSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wnsVQwjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6AFC433C7;
	Thu,  7 Mar 2024 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709841745;
	bh=QbobZIm6vzGL9mxcMfH8aT0PgqTNhtb1r9nMruHiV+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wnsVQwjISTY26rsce3Mp51KQ9qVjmObeUi7hVcXKuWEu+cPGKv153v4mf+bBGr7qd
	 knIISBKOVKQxMviHSCqE1UoUndxCJqzPDBfx7h3VuAMpmubswxI0u58JUi8tWPg1o2
	 mGb337V5oD3l6TjJNsWMcdYue0YK+Kis9Rht+Nlo=
Date: Thu, 7 Mar 2024 12:02:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Zi Yan <zi.yan@sent.com>, linux-mm@kvack.org, Dan Carpenter
 <dan.carpenter@linaro.org>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>, Yu
 Zhao <yuzhao@google.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/huge_memory: check new folio order when split a
 folio
Message-Id: <20240307120224.0e627784a13cff1121048ae4@linux-foundation.org>
In-Reply-To: <20240307181854.138928-1-zi.yan@sent.com>
References: <20240307181854.138928-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 13:18:53 -0500 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> A folio can only be split into lower orders. Check new_order to make sure
> it is smaller than input folio order.

It isn't clear what's being fixed here.  Presumably something is
passing in such folios, but what and where and why and what are the
effects?

Might it be that these folios are being caused by the debugfs
interface?  Or something else?

So I'll add it, but I do think more information and context would
improve the patch, please.  Suitable Reported-by:, Closes: and Link:
tags, perhaps.


