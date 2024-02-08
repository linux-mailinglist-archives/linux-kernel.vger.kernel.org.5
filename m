Return-Path: <linux-kernel+bounces-57315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C284D6EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F29B21F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD892594;
	Thu,  8 Feb 2024 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="osKux0YI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1144C70
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350904; cv=none; b=dxqINc6JMqQNKb/A/KxHmsl3zZDtFt5uQEV5yzwLpDlykOrnBZXrDbe+c1DNrmNhtT+tHwwtkv5UzmPM0baKRmtwuZIaJLTMCEG5z629Hzn/++jaguUGJ9nJ8WtPXzJmYIekr9MuH1CfMa99ckpor/NjsCYQLJzpA1xjYCXZPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350904; c=relaxed/simple;
	bh=zpFL9tuc+VckuTDiG9NM15A9S+EbfXl30c0elvw5tTM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r8AXYKaamPKCQSvmYMW0Ntyym3K/DPzFTifTc0PFpwVq4F46543tp8wUXU99JUOAijcPWUPyeX0FASjakafv1Tp4zPbbzZbOfCeXzHrZtbslfq4krFBnDG4eByTEeWeblzM/+tuPBW5iQRTCTyysMH88KYwrapuVN/TD7mUhVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=osKux0YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC73C433C7;
	Thu,  8 Feb 2024 00:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707350903;
	bh=zpFL9tuc+VckuTDiG9NM15A9S+EbfXl30c0elvw5tTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=osKux0YIteV3Jlbv7wlzFCk3jUqr8BjkFANBLBePHJdbgi1La88MZKOHhp/PHu3kA
	 dll2N1SW5QC14Adl5a4trJNJDWvhX85ucdeJQcJKXYvm0W2gGiZPVWO57HsmVnIKKY
	 SOnn6r1fzBe/0v6v7xBXO98JckBHMVlZCsjEmW8E=
Date: Wed, 7 Feb 2024 16:08:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, alexandru.elisei@arm.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/cma: Add sysfs file 'release_pages_success'
Message-Id: <20240207160822.c061cc98d6ffd2ab1ecac38a@linux-foundation.org>
In-Reply-To: <8d9f2950-6805-481f-a5e7-e5ea45128fb5@arm.com>
References: <20240206045731.472759-1-anshuman.khandual@arm.com>
	<20240206093857.d834af4f96d643c53e29e02d@linux-foundation.org>
	<8d9f2950-6805-481f-a5e7-e5ea45128fb5@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 10:04:31 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> > The changelog doesn't explain why Linux needs this feature.  The value
> > to our users.  Perhaps that info is buried in the link which is buried
> > below the ^---$, but as this is the most important part of a changelog,
> > it really should be spelled out here, completely and carefully please.
> 
> Does this look better ?
> 
> mm/cma: Add sysfs file 'release_pages_success'
> 
> This adds the following new sysfs file tracking the number of successfully
> released pages from a given CMA heap area. This file will be available via
> CONFIG_CMA_SYSFS and help in determining active CMA pages available on the
> CMA heap area. This adds a new 'nr_pages_released' (CONFIG_CMA_SYSFS) into
> 'struct cma' which gets updated during cma_release().
> 
> /sys/kernel/mm/cma/<cma-heap-area>/release_pages_success
> 
> After this change, an user will be able to find active CMA pages available
> in a given CMA heap area via the following method.
> 
> Active pages = alloc_pages_success - release_pages_success
> 
> That's valuable information for both software designers, and system admins
> as it allows them to tune the number of CMA pages available in the system.
> This increases user visibility for allocated CMA area and its utilization.

yup, thanks.  I added the patch with the above for a changelog.

