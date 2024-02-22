Return-Path: <linux-kernel+bounces-75739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFE85EE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142981F234BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8210A1D;
	Thu, 22 Feb 2024 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XRsRf3h1"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EC290E;
	Thu, 22 Feb 2024 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562574; cv=none; b=ogtfoCbvuz6gqD/RAFAyR2Ahq4zzbChvKO9NuP8c5u/GCtMgGhBbe5/+ytmuFQDcTjIrUa9ly2TppYQzQYAOF3h/FzRWPH2N92pzEvLSV/Pi3J+rq+GyjsKXorF5x8dVilfaBAMM7V8YaDkbiwbl41BkXy2veXdEr2LlI7sBPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562574; c=relaxed/simple;
	bh=XElSFnnAK4/2BauxNxlIJOy+CLSVH6//ipTSu2hNyKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5sfxqBvoLZ8GbAhWDJ2jgfSahPor2Q51VEz/5NaMQhwi9Hqbtcoo7ihvr5vh3JASdARRmPVSqWGcqnw6oOOuhjNrkMOljOTx/SdvaJxCx4HD32EV4KnuG9m2huUTofCJHKs4oxe/Vko1SDMUbYDtS/s4GoK6cjaPLBKn7T5phQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XRsRf3h1; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708562568; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bc767eLSlzPgendXABGin4+FYXyl7PNu++RDaun+rLo=;
	b=XRsRf3h1cCKksr+NRWNkw2cLqsqBJcwntM+02YfFEDYxeRX5s7ddN6BBkRsMf8I1OSmflOMQKHFWwtm2gSM/Li5lukRyP9yuO/2/PwlNEfEr/jRGcWaqiDGfHbqIVvkeQf9d4PKSBtjPpvqr9hiW0JVJE9bUgk5vdNAGmvqcceY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1.6KSP_1708562566;
Received: from 192.168.71.128(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1.6KSP_1708562566)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 08:42:47 +0800
Message-ID: <85099656-4d7c-4992-a149-0942ebbea1d1@linux.alibaba.com>
Date: Thu, 22 Feb 2024 08:42:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix refcount on the metabuf used for inode
 lookup
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: quic_wenjieli@quicinc.com, stable@vger.kernel.org,
 kernel-team@android.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240221210348.3667795-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240221210348.3667795-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/22 05:03, Sandeep Dhavale wrote:
> In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
> we do not assign the target metabuf. This causes the caller
> erofs_namei()'s erofs_put_metabuf() at the end to be not effective
> leaving the refcount on the page.
> As the page from metabuf (buf->page) is never put, such page cannot be
> migrated or reclaimed. Fix it now by putting the metabuf from
> previous loop and assigning the current metabuf to target before
> returning so caller erofs_namei() can do the final put as it was
> intended.
> 
> Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

