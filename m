Return-Path: <linux-kernel+bounces-141368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89E8A1D57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5D228784D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626250A6E;
	Thu, 11 Apr 2024 17:02:29 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9B4F890
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854948; cv=none; b=UaE1yKsrlvLrGvtzOiEuVdzFrnVWvcXGS+FCcbrl9Y7q2DjekWiNpiXmPKE5RqcAs5QU6CoDoD48f4s2GnrIdGluH6c0DIMvct94v27ztsIKTGDV7e23UaRI3RelPO3dGDzCKvGQORCh007Dkmp8y9N5lVNtwU8K0nxZZs/gjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854948; c=relaxed/simple;
	bh=00DQECQXdaUNwZeH1OIGhM3KW5MBwRDfGE0qR2vQptQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jmYp5LYNHHpo6FrvaVUQfKJ3ZU8E5tlSYCsMqoTq0sAfb+h3Um5q/U6NvCM4KC3B5tJ6P5yE0DYt0FnGR3WP5As/eYA2KNMJxPd6Ds/b6bUOaJFWEgnadVWO0qQTtFJUUdjoK8NTKlF/xqT/SSq/zoID2llD8UB1rTOAD7kQU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id B958240AFA; Thu, 11 Apr 2024 10:02:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B8AED40A90;
	Thu, 11 Apr 2024 10:02:25 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:02:25 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, penberg@kernel.org, 
    rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    vbabka@suse.cz, junxiao.bi@oracle.com
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
In-Reply-To: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
Message-ID: <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Apr 2024, Jianfeng Wang wrote:

> So, the fix is to limit the number of slabs to scan in
> count_partial(), and output an approximated result if the list is too
> long. Default to 10000 which should be enough for most sane cases.


That is a creative approach. The problem though is that objects on the 
partial lists are kind of sorted. The partial slabs with only a few 
objects available are at the start of the list so that allocations cause 
them to be removed from the partial list fast. Full slabs do not need to 
be tracked on any list.

The partial slabs with few objects are put at the end of the partial list 
in the hope that the few objects remaining will also be freed which would 
allow the freeing of the slab folio.

So the object density may be higher at the beginning of the list.

kmem_cache_shrink() will explicitly sort the partial lists to put the 
partial pages in that order.

Can you run some tests showing the difference between the estimation and 
the real count?


