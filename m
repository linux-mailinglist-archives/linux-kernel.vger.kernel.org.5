Return-Path: <linux-kernel+bounces-77704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C23486093B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F382865C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E98C8DD;
	Fri, 23 Feb 2024 03:11:13 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B0C2C4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657873; cv=none; b=GJTcgGOij1s9u76+K4gXNFpNuZNueWsUEnyiRzAImG9iQLOOxH1BD/hFtdiB8uce/RK6s3S/RMOpOlI0A3VP0OrpQgXhT/njaL1WUrlZiy0voKNwFN/A+PiaZy+s7FaEOxqGuH2JWkXZzpaVYxNlyY776QEZ32/Yq28OTykyThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657873; c=relaxed/simple;
	bh=B6x7M7JVh+smHCLEe58/rOR0eGKmDzIpuoOKG5lhbbE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m6SsJ35LjhArWRdDCbnaCrs4PsdYmYmpyEtphTVsss/uuOE8MJyzDv9aA1Wf6mPe/YQuqTn8jeFWkC518u4zfzPNyoe9KS8xX4GKQfRK1HbY5mMjDSLWnrfAs8r4twsdcwhCj+UkAWaYZvKAt/UQ8e2Q/9IOQGVjKAakySCfTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 13F5840AA8; Thu, 22 Feb 2024 19:02:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1321A40788;
	Thu, 22 Feb 2024 19:02:58 -0800 (PST)
Date: Thu, 22 Feb 2024 19:02:58 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
    Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in
 get_slabinfo()
In-Reply-To: <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
Message-ID: <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com> <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com> <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz> <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 22 Feb 2024, Chengming Zhou wrote:

> Anyway, I put the code below for discussion...

Can we guestimate the free objects based on the number of partial slabs. 
That number is available.

How accurate need the accounting be? We also have fuzzy accounting in the 
VM counters.

