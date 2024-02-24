Return-Path: <linux-kernel+bounces-79710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B78625AE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D643D1F229F8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6177A4502F;
	Sat, 24 Feb 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="fVG0LxTL"
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD017BDC
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.18.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708786837; cv=none; b=KMoYPnPxAMwd0YprLB5ow3zhxPv+txTiAfYszO1GscFviAdveMKI3vrvNs2zBxjm5GJoKkUvmkTxL5gw6QRROafQB83ItMCVWs8SH9HpBAvchQy7Fx1yRZbDMWfvpEu824MrXXjD/nSo7vBHJwTACI9jY1UT69H5kWYZIwKyUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708786837; c=relaxed/simple;
	bh=WnPfoEPG87AaGPB6iSpNqf40lMylW619jF/qaOGxOic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ig6rPgjAN7A2Ad3bkRv73P7wr0MJrHGwm39voLkzN1S6a8Np0ZRmCHuSo/zFKTZrth6FQJtyKV3cG57mA9wgOqN3Gc2iWgvzb734+PhzqcC+16I+ylYA6hLxT14YDUdF4V3izlT1cnv0+M+cxcYIc5PAoGSTmidwzhgZficNUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alarsen.net; spf=pass smtp.mailfrom=alarsen.net; dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b=fVG0LxTL; arc=none smtp.client-ip=144.76.18.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alarsen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alarsen.net
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:b46e:3f6f:a331:4dfd])
	by joe.alarsen.net (Postfix) with ESMTPS id 6C03B182599;
	Sat, 24 Feb 2024 15:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1708786349; bh=oAUN5IeIkG33rzVC158vqDGlErRFCue3Y458T7ha7kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVG0LxTL0yTcfhSZsLqTKPERlwufF21pH2T1zaVMQEKZylE33NC+Ogp/wxV3WCMSi
	 RLf7SCokuP279WdsFSYbo+FxZ3nlf4WDxvisloeO++dRerey+/Ol0qZt4CDCN0ICrx
	 OClTyIfMZsKYH8JzTx36gvwDs8DlaKufi9NXtVoU=
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTPS id 519854C0;
	Sat, 24 Feb 2024 15:52:29 +0100 (CET)
From: Anders Larsen <al@alarsen.net>
To: chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev, Xiongwei.Song@windriver.com, chengming.zhou@linux.dev, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] qnx4: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 15:52:29 +0100
Message-ID: <13608929.uLZWGnKmhe@oscar>
In-Reply-To: <20240224135056.830013-1-chengming.zhou@linux.dev>
References: <20240224135056.830013-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On 2024-02-24 14:50 chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/qnx4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 6eb9bb369b57..d7a77040e42f 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -359,7 +359,7 @@ static int init_inodecache(void)
>  	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
>  					     sizeof(struct qnx4_inode_info),
>  					     0, (SLAB_RECLAIM_ACCOUNT|
> -						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +						SLAB_ACCOUNT),
>  					     init_once);
>  	if (qnx4_inode_cachep == NULL)
>  		return -ENOMEM;

Acked-by: Anders Larsen <al@alarsen.net>



