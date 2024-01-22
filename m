Return-Path: <linux-kernel+bounces-32308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544098359D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80CFB23B00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3231879;
	Mon, 22 Jan 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r0xzqVpn"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298741849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895009; cv=none; b=TQMYs2iyvJxxaJ9Q3cenYBNKw+vYqOFxR9+g7WXVwbnSA1uieN5CBOedf0hthrQcElxa1vNkPM1rQX0F9XuHeYq8eQozJFvLfOBT+67BPhdr7joniL4pyXE8Pt0h8LeHYa+yhzmWYLXM/nrrgGkbckrbAIDfmYo7GYcTLTz6Fqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895009; c=relaxed/simple;
	bh=Zav3JLtbksYkb7oLMEt+OT5Quf0+iKX5pRsreBbhiYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY9NDmOa95cD/4nD3OCObgzmfQlHvGAT6FWQZXStfdxd/2I/xo+Wgv0DteI4ZB+PzDoR6mpOjUHAKyLSw6pdveTNZ/+C3zkfN9rsiyPOo3P3V+6WuSUp5FwFLU6G2X2iED+C0gBjYNzDffuMOA1e6HhPA2AjP4NPm7bvn/zOFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r0xzqVpn; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24976e6b-caae-4355-87df-5c8fc9ccc1f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705895004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zav3JLtbksYkb7oLMEt+OT5Quf0+iKX5pRsreBbhiYQ=;
	b=r0xzqVpnw1U8TznkDevK3lrHWiDfxMHmbk3Ew3bOPDYt1Eg1MgZ1gGxWNyKLdt7OxilZL7
	mwuHIldsUyPPNCVGI2AjXVTZnP32m3IBHqOP6RtG2+7cvYn87j8H40kGjaU7C7ZJuSt1E1
	ipApGQldih2B1HpNwTHucW7AZhidfFU=
Date: Mon, 22 Jan 2024 11:43:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/7] hugetlb: split hugetlb_hstate_alloc_pages
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-3-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240118123911.88833-3-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/18 20:39, Gang Li wrote:
> 1G and 2M huge pages have different allocation and initialization logic,
> which leads to subtle differences in parallelization. Therefore, it is
> appropriate to split hugetlb_hstate_alloc_pages into gigantic and
> non-gigantic.
>
> This patch has no functional changes.
>
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


