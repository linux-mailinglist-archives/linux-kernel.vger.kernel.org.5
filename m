Return-Path: <linux-kernel+bounces-167205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60CF8BA596
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30B51C21BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB51CA9C;
	Fri,  3 May 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="McdLShCY"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6EF1BF31
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706141; cv=none; b=QfmlEQn79y4z3IehJks2vJ9FDaczUD0flixSv3sYHt4SJf/FqvjDKOs3rh6vL1lA57NTjXvhqW5zxoWlqb33jNYAE7w14C61B7kcLH2RhkZ9Sp4lnJ4o9Y/6FjCegx2G4BaHmc5E6x2dFGyeSyhIKRp7MCqDzkJX4dDGf8Bp0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706141; c=relaxed/simple;
	bh=MXocKZDLZWja688de5gaJhOAfAuzW9dJi6b06eCcMlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYHFxc25Zud59n5sd4kbkAMdXbWoeTycPPL/BQNaxpuTyDVxTVO3hnqK4ivLZcOhGSQ8pg8vIRNXCQ/2AALCbHg4TxvUNwJRB4C7L9HprEUfPM6w+qzzF0e8XzJTpTJtxmUm0piRYFYyOjjKGellpGW7NLePixjbR59JUIghL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=McdLShCY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4433EtkY032537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 23:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714706099; bh=NAqoULF99IJZLWZbdS/0WDOtUiZwYwO7FwxqIEARW9o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=McdLShCY+4nSQ/9AnagG/HjzZwTfLkbMnFAZk1OvJbC1gWkxj6PtyEocW0pW89iPw
	 B/vomUxiqjgnK3UoGyKHLGbFp+tFWir5bqyrR5WRBHLuAQvQjyqiiIKSAwP9ealtyk
	 OPEskfk6BfZ7W5s+/MAKfghpzTpOa2uG7pJTBwMeN+Y55BUFXAkI23Yatdp8bvOIKy
	 WBqXLVup1oe2g932mMndqoevprX3vwSZ58xpqiMKKcVNSFhB/PbNWaV6hJsv7aXPE3
	 arLQidyqISHH2j7LpueYpKtSB8SV/tYxfDeFOrwfAvdk2mh1dztpzEuhthiZKwJRSu
	 SB4ILQWTHfpQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A515515C02BB; Thu,  2 May 2024 23:14:55 -0400 (EDT)
Date: Thu, 2 May 2024 23:14:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v4 0/9] ext4: avoid sysfs variables overflow causing
 BUG_ON/SOOB
Message-ID: <20240503031455.GF1743554@mit.edu>
References: <20240319113325.3110393-1-libaokun1@huawei.com>
 <985285f6-973b-30d5-4742-29cf5e8c0e27@huaweicloud.com>
 <8cf61cfc-8717-ee33-c94f-959212ce9c85@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf61cfc-8717-ee33-c94f-959212ce9c85@huaweicloud.com>

On Fri, May 03, 2024 at 10:03:04AM +0800, Baokun Li wrote:
> Hi Ted,
> 
> Would you consider merging in this patchset in the current merge
> window? I would appreciate it if you could.

Yes, in fact it's next on my review list.  I've been working through
the patches on ext4's patchwork site roughly in chronological order
(focusing first on fixes and those that have been reviewed by other
folks).

Cheers,

					- Ted

