Return-Path: <linux-kernel+bounces-125637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC08929E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25C21F219F7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA3BE5B;
	Sat, 30 Mar 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jc93oTzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D718BE4A;
	Sat, 30 Mar 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789955; cv=none; b=FRiMn/ar1OErN/TwHlrM3T5RgZUpCHmoC4o3wppsC4byr9zfTQgJc9ARIvUD4cXa5t6OxczCI7dcD4XEFkQHRsaJTfoqfhojLLo7y3SpoIQdFJ9k//3UX1iYdnP7l7L8mP+e7Yzg+iJTo8N9a7G44YL94tROIHW26Vwn/mXs/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789955; c=relaxed/simple;
	bh=jzqu+nCzBGkiGSJEi1GM4Qmn/uIbNiavD6zRP6mXd0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/epib2+C8mHKK8ot3mlRNkPdpBZKyoZxKb1KdT10xY6etu/3Yvtd785ztb1owJHeD+MkUyKzoMBHpcjuu+/2BW1HcC1jM43ekUNzYQ05OsSRJSR2JnnxrU4ZXlkFVq31JuUY0kn+repTUfyn4Eb7XKrmF55dP+I3ImTdtcKzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jc93oTzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48152C433F1;
	Sat, 30 Mar 2024 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711789955;
	bh=jzqu+nCzBGkiGSJEi1GM4Qmn/uIbNiavD6zRP6mXd0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jc93oTzQHnf/tqm8pAbU1d2/OQCtTzW4NWl1J7Oic+lZpNUfbKPSU9GgH560Q82Ec
	 7pZxeySC88QxynAxXjqdbbaH7iYjLncIuMgWKOoy/NlTeDhiZXX72B6/EuBDJ/n5mB
	 hA2kyNsZ5wjA7ZdDWPe6Mcu69GxoX0YfmKZwtAmg=
Date: Sat, 30 Mar 2024 10:12:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Liu Shixin <liushixin2@huawei.com>, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH stable-5.10] mm/memory-failure: fix an incorrect use of
 tail pages
Message-ID: <2024033024-unusable-secret-6872@gregkh>
References: <20240307124841.2838010-1-liushixin2@huawei.com>
 <026db58d-feea-8191-616a-3e6dca592786@huawei.com>
 <ZgD2EvkzS1Uz5wy6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgD2EvkzS1Uz5wy6@casper.infradead.org>

On Mon, Mar 25, 2024 at 03:57:06AM +0000, Matthew Wilcox wrote:
> On Mon, Mar 25, 2024 at 11:36:49AM +0800, Liu Shixin wrote:
> > Hi,
> > 
> > After backport commit c79c5a0a00a9 ("mm/memory-failure: check the mapcount of the precise page"),
> > 
> > I got an error message as written on the patch. The problem can be fixed by the patch or just revert.
> > 
> > Now I prefer to revert because I think it is related to folio and no impact in stable, or maybe I'm wrong.
> 
> I checked out what is going wrong here, and Liu Shixin is correct.
> 
> Commit c79c5a0a00a9 was incorrectly backported to v5.10 and
> commit 70168fdc743b changees the page passed to try_to_unmap().
> It now passes the tail page, and should always have passed hpage.
> Please apply the patch below to v5.10 (and any other trees that
> c79c5a0a00a9 got backported to).

All now queued up,t hanks.

greg k-h

