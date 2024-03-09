Return-Path: <linux-kernel+bounces-97753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D877876EF2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A3EB2148A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCA2033A;
	Sat,  9 Mar 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W0sZ8yKg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050B208A9;
	Sat,  9 Mar 2024 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709954617; cv=none; b=dPVOPHtw7EEqg84Ccrnx0uNPiPuF4voprXL0Z4Uot3CSInV+SA6Z5tP1YCo+ffZJf/XCtKm9hMlRimrq0Ae5v5/qhFX9V4VCTMJ/8JpyOQka0C4SwPriNM5Tv7mE6Ts/YKGkpHmyDfpRjRLisifjK7YzILwyPpsMzDhxk7SV9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709954617; c=relaxed/simple;
	bh=bSwSfWYlj9F7+5cVfSd2Y34uxjt9xC2p8EkDBAvcXVc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a/dFi5IwCXKRgt4WnNiHiC2ZrvZJn2Lkc76WwoOoggV5TN9YWB962xJg12kQ2EDLMDo2aSnsGrHt93aSFm5a4jT3rNFIQzdGjUBeZo7mQ1AuYsPNQhwAsPMbCJaqwUQEO5DZUHS3TcElwIky8aOmQP96PM8/QSuMMTbFPMkDskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W0sZ8yKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1983BC433F1;
	Sat,  9 Mar 2024 03:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709954616;
	bh=bSwSfWYlj9F7+5cVfSd2Y34uxjt9xC2p8EkDBAvcXVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W0sZ8yKgVOMnY3zF8BvGAaQCSuCbkb6zj46ry8OzVPGsV0oWBesXhsp7pVHkTLEPN
	 Zp0QW6McgLgRuK3FiP3Kg3MqPqAU3DmFSC+mWPZAvQeb1x/2BfuyGhOKyElRpWF1tl
	 qJB/nvoFCrMM6ns8p1TYqvrYVmBckvkUgodQ/HiU=
Date: Fri, 8 Mar 2024 19:23:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: herbert@gondor.apana.org.au, chriscli@google.com, chrisl@kernel.org,
 ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com,
 vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>,
 davem@davemloft.net, hannes@cmpxchg.org, linux-crypto@vger.kernel.org,
 linux-mm@kvack.org, zhouchengming@bytedance.com, nphamcs@gmail.com,
 yosryahmed@google.com
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not
 sleepable
Message-Id: <20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
In-Reply-To: <CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
References: <20240222081135.173040-1-21cnbao@gmail.com>
	<CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 8 Mar 2024 19:57:38 +0800 Barry Song <21cnbao@gmail.com> wrote:

> Hi Andrew,
> 
> On Thu, Feb 22, 2024 at 4:11 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > In zswap, if we use zsmalloc, we cannot sleep while we map the
> > compressed memory, so we copy it to a temporary buffer. By
> > knowing the alg won't sleep can help zswap to avoid the
> > memcpy.
> > Thus we introduce an API in crypto to expose if acomp is async,
> > and zswap can use it to decide if it can remove copying to the
> > tmp buffer.
> >
> > -v6:
> >  * add acked-by of Herbert, Thanks!
> >  * remove patch 3/3 from the series, as that one will go
> >    through crypto
> 
> Can you please pull this into mm-tree? This used to have 3 patches.
> 
> 3/3 was separated according to Herbert's requirements and has
> been in a crypto tree.
> crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=77292bb8ca
> 
> Two drivers fixes(patch 1 needs) have also been in crypto tree:
> crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=db8ac88385
> 
> crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=30dd94dba35
> 
> So it should be quite safe to pull this series into mm-tree now.

But this zswap chage requires the presence of the other patches, yes?

So the mm.git tree alone will be buggy?  And if mm.git merges ahead of
the other trees, there will be a window where mainline will be buggy?

If so, I think it wuold be better to merge the zswap patch in the next
merge window.


