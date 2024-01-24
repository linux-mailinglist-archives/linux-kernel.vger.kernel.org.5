Return-Path: <linux-kernel+bounces-36551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1A83A2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF4F1F218BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C05168C7;
	Wed, 24 Jan 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dLBPMyj7"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5D1642B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081728; cv=none; b=pTSFQJDNh+kwsU64a5o2rKleRZeMs5ZnVM/D+lISmi8Vev2mOvaCxPXSibAr8EqmnueMTC47zptelSyQlYwVc1NvB3xqDzElOEP89xAJns2i5TX9kiyX+EdwSZiEWc+Ho27hzrGkPBp5G4oCjwz7kfymQVmtdRMiQrnrYB5FHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081728; c=relaxed/simple;
	bh=pe373ULx0QIbZ2wz/kyrD6hJNYP9myR3nkR8aE1ahgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJgC5qS/3rZ1IpyKYHZrCgPeG5pUAVtV035hc0EfdlSQziQeL6pSTjb89gG7/CtDHSu2TIn2mj8agyGW4D8xXnOGBRZvo+G69ygGtDc8OVgL0L9WVQ4giUuMZ1iLr+CnUN4A2UdcaUQfjuYuy8+3YL5KHCy51Or6znov6cRBiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dLBPMyj7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dd9f4c0809so286359b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706081726; x=1706686526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrYIexCVj3lzhdPHs2GVu+eB/KVIh/KA/cEwlOXWa5Y=;
        b=dLBPMyj7bqq3RWq5VuFFLDCbMsCYlGL7++fyANwxnvrocsOXhasZ4u7m6gFEQasfoC
         fGx1ULG7JAqBD6bKz5VeIzX+Xo2i4anl7ibmKco4QZd/k8fmyAh0H0OABGitru0ht6v7
         Xdg6nyS2bHY75OTwDG5d4GhjxybD0+uitzJtb0yBy+E+NkpzuoqpSteKTUbWGEWX1fO0
         WxCyCz5sa4c4mQSOE2y/dgDefGNFyxJmXzt6sJAyYJji8H2iNJYClAVX8Ry1/VcXRrzG
         O/6CGF4tZc7stpPDSvEbqp4dXENTWK7x+EXCmyMEz/EHiVpAbvaHVPN4WCmHFEo8Bqaw
         l0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081726; x=1706686526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrYIexCVj3lzhdPHs2GVu+eB/KVIh/KA/cEwlOXWa5Y=;
        b=f9g1hLfUKSf8wRLPtkBD9iqhlsmaSqJkJtftVryY85g3E5c2y3Q+TlQ1UumCrvT7ok
         786uFoYK8dGTWTXnp/NDlreFuF+BVVzHAeeXZJWJSKtBczrOAFSUEj08ZnsukKuenqEs
         q5Tb8Nt2j7Dkh3O5VJW9s00D8iQu/8eCZrQlkjJKFWza8jGYjaxdGzX2kY7XMqjEGr2Y
         CkWJ5SWfODSqol+aWuHsH77Mu7cf5dyVhG30CK7UOIVFdB+0hoyyYu7oPhQaSi4FBnt1
         m7s5vay+I05wI7VQUuzzrv+B3KWg+Jhg4RvQMB13WDSzf6Db/sEoXgPT3r3lpveaAXRQ
         dHpQ==
X-Gm-Message-State: AOJu0Yy9J8OFN2h3JCvC2tlHW0aLRcjcBkoTzdhVrvZCX5tSSiPGGKKG
	Tvwdm2YaYOq03ojVjRDXfjGF/yiMRW6dJ9sEFeM+RLsSWStskJFC8G0AfOgBJWs=
X-Google-Smtp-Source: AGHT+IGANFpffkj8tc/P+jpEtAje5dviG98IqRAe0TQSVQXLPD2xpinmlx/2k3Q0UO2Wql2Lixq82A==
X-Received: by 2002:a05:6a00:ad1:b0:6da:d27b:7c52 with SMTP id c17-20020a056a000ad100b006dad27b7c52mr9084585pfl.53.1706081725994;
        Tue, 23 Jan 2024 23:35:25 -0800 (PST)
Received: from [10.255.203.131] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ei29-20020a056a0080dd00b006d9ae6fe867sm13051948pfb.110.2024.01.23.23.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:35:25 -0800 (PST)
Message-ID: <305078e5-b31e-43ed-825d-7b634c9c9f58@bytedance.com>
Date: Wed, 24 Jan 2024 15:34:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: zswap: remove unnecessary trees cleanups in
 zswap_swapoff()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240124045113.415378-1-yosryahmed@google.com>
 <20240124045113.415378-3-yosryahmed@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240124045113.415378-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/24 12:51, Yosry Ahmed wrote:
> During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> called for all swap entries before zswap_swapoff() is called. This means
> that all zswap entries should already be removed from the tree. Simplify
> zswap_swapoff() by removing the trees cleanup code, and leave an
> assertion in its place.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Looks good to me, thanks!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index dcdd5ecfedb09..78df16d307aa8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1808,19 +1808,9 @@ void zswap_swapoff(int type)
>  	if (!trees)
>  		return;
>  
> -	for (i = 0; i < nr_zswap_trees[type]; i++) {
> -		struct zswap_tree *tree = trees + i;
> -		struct zswap_entry *entry, *n;
> -
> -		/* walk the tree and free everything */
> -		spin_lock(&tree->lock);
> -		rbtree_postorder_for_each_entry_safe(entry, n,
> -						     &tree->rbroot,
> -						     rbnode)
> -			zswap_free_entry(entry);
> -		tree->rbroot = RB_ROOT;
> -		spin_unlock(&tree->lock);
> -	}
> +	/* try_to_unuse() invalidated all the entries already */
> +	for (i = 0; i < nr_zswap_trees[type]; i++)
> +		WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
>  
>  	kvfree(trees);
>  	nr_zswap_trees[type] = 0;

