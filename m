Return-Path: <linux-kernel+bounces-102368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219C87B13F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8976A1F22DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C776039;
	Wed, 13 Mar 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoziBgYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B142AA7;
	Wed, 13 Mar 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354764; cv=none; b=ds8RDaqJ6BLDkxCA1NbLw2o/Kp0r3svLAEkf3Q20kfUD6O6DP25rgSEUyK2inSJXdk3fCEzLk7kJKDfophqtCPpqnOjlGLL2nj6KaOt03a8r28hlGl7Ay6T7s3yPVpRThYC4claxTfV2Wv1fgazAMBdZGd8o7pZ+UVm7X4dQksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354764; c=relaxed/simple;
	bh=7bbeKEyXP4bImwkZfVwF74dZRe/jDTDlJuGL78hlPCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfTv7TWL6O4N3yzT+27pIayxB5nMFEZk2XUwYAVoWOLJCjMfAkFq86CnlcGUgSkQPxilr5EpiSQc6tKDwYPbJnyPJZsuE0H9H3j4DuogWFD7pXbulyPuIHPcfqtxZNN+mg+LAoZJwsB5GMViNRPSkSYExEg5M1eqiP8a+N72Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoziBgYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D127C433F1;
	Wed, 13 Mar 2024 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710354763;
	bh=7bbeKEyXP4bImwkZfVwF74dZRe/jDTDlJuGL78hlPCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoziBgYteqPBeqc6SeGMTi/uh+P8AuzIF+5Qa8dVcCYcH7ypaLtoidoYLKp8v/iHS
	 TWmDvw2E8bAC4cizpzT/PadvpovB9qD1H5lfQxuajyt+edVKyvH9e+1ILbEiKCvBO0
	 kPtaCKNBaHxksLriBty4sc6NhjBmQJ/WHE72AbFtUPduZMIYrtKV5olSnSms2C9O+F
	 Oiil3a5BQT+Uuhc8ZtEEo+bqmbNB9UBXtt+/oJ1mam5h22Xh8V+TXSubgUPHBlY/EG
	 qf1HJKsVlnNWjjITNGK9/DjE3qV4JLVadrW3/O+12KORNOdxG3jo9iAOfRo9oWCfKX
	 FDEWTjcpLQVgw==
Date: Wed, 13 Mar 2024 14:32:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6 07/60] mm: migrate: convert
 numamigrate_isolate_page() to numamigrate_isolate_folio()
Message-ID: <ZfHxScqrHeuXwESN@sashalap>
References: <20240313163707.615000-1-sashal@kernel.org>
 <20240313163707.615000-8-sashal@kernel.org>
 <7571ccc0-2192-6b90-83c8-7e4bcefe5de5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7571ccc0-2192-6b90-83c8-7e4bcefe5de5@google.com>

On Wed, Mar 13, 2024 at 10:32:26AM -0700, Hugh Dickins wrote:
>On Wed, 13 Mar 2024, Sasha Levin wrote:
>
>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
>> [ Upstream commit 2ac9e99f3b21b2864305fbfba4bae5913274c409 ]
>>
>> Rename numamigrate_isolate_page() to numamigrate_isolate_folio(), then
>> make it takes a folio and use folio API to save compound_head() calls.
>>
>> Link: https://lkml.kernel.org/r/20230913095131.2426871-4-wangkefeng.wang@huawei.com
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")
>
>No it is not: that one is appropriate to include, this one is not.

Yeah that's fair - I'll rework the backport of 2774f256e7c0 to remove
these dependencies.

Thanks for reviewing!

-- 
Thanks,
Sasha

