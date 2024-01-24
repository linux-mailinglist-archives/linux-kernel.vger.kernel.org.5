Return-Path: <linux-kernel+bounces-36530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7783A28F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFB31F2548F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31A1640B;
	Wed, 24 Jan 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ccXBI1cM"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95910795
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079809; cv=none; b=D92pFuQMHOXWspdt3gq6Cd6Hjm73VXbFQRml6G23ocjazTNrisnmiGUxA06KPjWhnZsZoL1w7FFcwK/lCpkVrtT295BMU+dtFA6BNyeG79FsKKTGSw2NrTAuDZHGuunb3ZZ5TEeGx6wRaSTg1iQH/HZFgiZpNZc2kgvuk8Yscvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079809; c=relaxed/simple;
	bh=P19nx0w9knko/JVFAMwr4eRsuGvuoHIsDKUWA+RaEUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEASjHYsc80h3HSl5HW0qVed+vq4dun2rUPkGsg5argwVZuSaLFd+tTpxKgG5BVCFdIAdRivvA1lyuasodPqmbh1AYkLMv3cRO7L7MSYUjWrLycbboVbx1H15lczz0fXtunCH8yrXundnF6TGCVz0AJ3mKY8d4GX+oPDNjU8hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ccXBI1cM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e59c8e4c-c416-4026-9ab9-ee55edafd4b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706079804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HVP16o1VtXDA7W9OZNwq3dT+EsNFJe/EB2vPP8VZRM=;
	b=ccXBI1cM3RgoCTV66lUC3XI2f9ilnUOAyO5eHsoD2RskZr6BZipluQmDZutMDOzM9Tl9YL
	3E8DjOCDvljN0mPiMgBErH1linpiUX9Ch3B3Ggij+N+IrJ0eFTGsXM4juNPCV8FKfEiyta
	I+l098X1/g44btaBFjEnItvBkxNl6BY=
Date: Wed, 24 Jan 2024 15:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
To: Prakash Sangappa <prakash.sangappa@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: mike.kravetz@oracle.com, akpm@linux-foundation.org
References: <1706040282-12388-1-git-send-email-prakash.sangappa@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1706040282-12388-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/24 04:04, Prakash Sangappa wrote:
> For shared memory of type SHM_HUGETLB, hugetlb pages are reserved in
> shmget() call. If SHM_NORESERVE flags is specified then the hugetlb
> pages are not reserved. However when the shared memory is attached
> with the shmat() call the hugetlb pages are getting reserved incorrectly
> for SHM_HUGETLB shared memory created with SHM_NORESERVE which is a bug.
>
> -------------------------------
> Following test shows the issue.
>
> $cat shmhtb.c
>
> int main()
> {
> 	int shmflags = 0660 | IPC_CREAT | SHM_HUGETLB | SHM_NORESERVE;
> 	int shmid;
>
> 	shmid = shmget(SKEY, SHMSZ, shmflags);
> 	if (shmid < 0)
> 	{
> 		printf("shmat: shmget() failed, %d\n", errno);
> 		return 1;
> 	}
> 	printf("After shmget()\n");
> 	system("cat /proc/meminfo | grep -i hugepages_");
>
> 	shmat(shmid, NULL, 0);
> 	printf("\nAfter shmat()\n");
> 	system("cat /proc/meminfo | grep -i hugepages_");
>
> 	shmctl(shmid, IPC_RMID, NULL);
> 	return 0;
> }
>
>   #sysctl -w vm.nr_hugepages=20
>   #./shmhtb
>
> After shmget()
> HugePages_Total:      20
> HugePages_Free:       20
> HugePages_Rsvd:        0
> HugePages_Surp:        0
>
> After shmat()
> HugePages_Total:      20
> HugePages_Free:       20
> HugePages_Rsvd:        5 <--
> HugePages_Surp:        0
> --------------------------------
>
> Fix is to ensure that hugetlb pages are not reserved for SHM_HUGETLB shared
> memory in the shmat() call.
> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>

BTW, it is better to add a Fixes tag to specify which commit
that this commit aims to fix.

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

