Return-Path: <linux-kernel+bounces-132022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C4898EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6586B1C28542
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E2133991;
	Thu,  4 Apr 2024 19:18:50 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB513119B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258329; cv=none; b=U0NZEn6DC54ETWsLyTFRsbVn90+v5Gl0gjbPeMKuQ8GaHkoGlELfgjuOifISQaVEGWPEPTdHQOoxkBDE6oF0k83yAXIJZrKqlIaY1ujLX+yh3DqsnSvXcRHW/xwy37CJPv/WDd/Zcrrdc3PYVeVidzOUirYjLRqGO6PSVtkHycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258329; c=relaxed/simple;
	bh=DRsq6B7gNf90bJWvlcjXsjCsytFzxuTCVa12StodvOA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EDt/iFOdYacOLAa4nmomZBQHyzj7/d+dQc38n8fUmfeDYL/21/F+RuoScNt7NI7FrzlWVygB2eVsGZRcQIf+Co0ZZW/tIW9/9ergxb43E52qXonKKZcO9RevX8nm08gwvQ+70Jp628sPBri0AX4fy6ZylBFb18+FWbUH18c78CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 172CA40A89; Thu,  4 Apr 2024 12:12:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1506940A86;
	Thu,  4 Apr 2024 12:12:11 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:12:11 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Ming Yang <yangming73@huawei.com>
cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    zhangliang5@huawei.com, wangzhigang17@huawei.com, liushixin2@huawei.com, 
    alex.chen@huawei.com, pengyi.pengyi@huawei.com, xiqi2@huawei.com
Subject: Re: [PATCH] slub: fix slub segmentation
In-Reply-To: <20240402031025.1097-1-yangming73@huawei.com>
Message-ID: <56193a2c-dadb-108d-4eaf-0a923fc4912b@linux.com>
References: <20240402031025.1097-1-yangming73@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 2 Apr 2024, Ming Yang wrote:

> The key point of above allocation flow is: the slab should be alloced
> from the partial of other node first, instead of the buddy system of
> other node directly.


If you use GFP_THISNODE then you will trigger a reclaim pass on the remote 
node. That could generate a performance regression.

We already support this kind of behavior via the node_reclaim / 
zone_reclaiom setting in procfs. Please use that.

The remote buildup of the partial pages can be addressed by changing the 
remote_node_defrag_ratio in the slabs. This will make slub scan remote 
nodes for partial slabs before going into the page allocator.



