Return-Path: <linux-kernel+bounces-158097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8795D8B1B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D323FB24578
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34346A355;
	Thu, 25 Apr 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iv3CTpNL"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B05FBB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028711; cv=none; b=Q1Mxce3ENrX/Skiw/tM6czTPbvACbHAfPdwkGVJBfn7/WjH2rIZh8zd8O4PVhufnmEJIlSrJK8BqZebKaZlqjD0iN0wBx/PGsnK7IKNknUspgZyi52EORaIL//A9XMWKVelXcym38F2x9ZZ28dc7sD+1IbZVFapD5W4ozWREEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028711; c=relaxed/simple;
	bh=Q82aLPQcq35nz4gQjtuhvBs57kevUJgzH3StIVIcI8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8q6CkRUVtha9qJHp2gi6oovL3eIrJU1ree4HSEhMtVWLntAveSpoE10atisYx3YDCCWNCyLw7Yysrj1d5J9hrVsl6YKKqohbQ7iYgo44hMZlaHPIW+WquMvrUynZgJNVYxgmkzpCrVWJzdzYyUmJJ9vkhIxRhEPi+21OawOHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iv3CTpNL; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714028700; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yYfps7OKpOUNR5eXImP0Swff4s72jJ84UEFKATOq5m0=;
	b=iv3CTpNLHw2RchjMeAwByckuJkyqiErR6YGGMmewUjOX/ZAj72JVIQRp/ZrgUQC85OiAefUvkVtVqKc2GNRHhFWXuGSilqNC3g+MqFE/ye7iJXMJRwnSkLCIBCkXcuJZderPHrJ3BigN9oFkln4Aa5oOFOU1FWyAYJrVSaJfre0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5EX3sp_1714028697;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5EX3sp_1714028697)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 15:04:58 +0800
Message-ID: <c054ea77-25a5-410c-bb2c-08fd23df9a92@linux.alibaba.com>
Date: Thu, 25 Apr 2024 15:04:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm: memory: extend finish_fault() to support
 large folio
To: Lance Yang <ioworker0@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
 hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, ying.huang@intel.com, ziy@nvidia.com
References: <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
 <20240423083951.1380-1-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240423083951.1380-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/23 16:39, Lance Yang wrote:
> Hey Baolin,
> 
> [...]
> @@ -4727,9 +4725,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> [...]
> 
> The mm counters have been moved from updating out of set_pte_range(), so we
> we may need to rebase against Kefeng's patch[1].

Yes, I did not rebase on the new mm-unstable branch, and I will do so 
for the next formal patch set. Thanks.

