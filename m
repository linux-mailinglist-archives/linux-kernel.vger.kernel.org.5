Return-Path: <linux-kernel+bounces-84624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20A86A921
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648E01F2556D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF72562E;
	Wed, 28 Feb 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T6fWye/2"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A325556
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106059; cv=none; b=TrTt79PW4dVJozFbRN9sOzAE+qe+ZofT6jn1n2GWNGpB9iBW1m5C/7nbaUnAgDqyxUoCzgHZiJXXOB1W3zftmLFYBseuCPAGrEnyMMicL1M9H6AHMzAsMELaxOsTmonXKwNg7+A7X0p8+dx9cDxkPJTVGW30VfwlrUH9LODHkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106059; c=relaxed/simple;
	bh=lo6m6tXWEfJ2nxsrwHJrqorsV92359uQ/KjzKW830e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0JoHX8dXTmfKelwplhZn9f26ODf9326ziF8Bf704InFKb/HSseSnDQC3P0zLBZuOemlwhhFquCYyFOO1D46HS/IhRoSa/cFeLty2/X2qCa1QfpWlxqRFjTjlX9i3L9AMmKuZ0R7RwBGRDmadas77ka7TYS0p4h3JkCExJsX3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T6fWye/2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709106054; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QzFPt3NoCOtJ/fXrg8BCzAMZrCiNDZ1q9/ZHkgsaUvo=;
	b=T6fWye/2SnDarkPO0HwLetf2iXhkJ5llclG4N3mY+QeSTI0oAzCfD0gdJ8K+cMw0h7qIaR/uoVvlixpgA8WGR8RzUCE2mwru0eP8J/OTHmeuruXDV54RJd5kc62Fb//yWOHBwSwiptzYwn5WX9dQOkhSUTIxF0LRYaqh0JhAs1I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1P0G.J_1709106010;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1P0G.J_1709106010)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 15:40:53 +0800
Message-ID: <937a077a-4f12-4fdb-9dc7-adee7b2129c8@linux.alibaba.com>
Date: Wed, 28 Feb 2024 15:40:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: record the migration reason for struct
 migration_target_control
To: Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <d05fb0f1fea466334f44ea7b4d73a54b6c35cdc5.1709041586.git.baolin.wang@linux.alibaba.com>
 <Zd37c1z_pDdU3Wsx@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zd37c1z_pDdU3Wsx@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/27 23:10, Oscar Salvador wrote:
> On Tue, Feb 27, 2024 at 09:52:25PM +0800, Baolin Wang wrote:
>> To support different hugetlb allocation strategies during hugetlb migration
>> based on various migration reasons, recording the migration reason for the
>> migration_target_control structure as a preparation.
> 
> "... record the migration reason in the migration_target_control
> structure..." ?

Sure, will do.

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.

