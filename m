Return-Path: <linux-kernel+bounces-154879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88398AE262
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162171C21A37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27112D527;
	Tue, 23 Apr 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kbO8dBSx"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C9481D1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868671; cv=none; b=PoH9JWXR47eOY4h1dDkw+/yJdhPtRn/n4KBcxHcmyybYsStFKLkrBCWBnPZVgqq6wmmJAKURHmE1Q4xkW+CVOKyC+ccZ4Y1WtrRwIMAuPhrqhDU6ZTLzQsi/BeZV6iXFEL4dGszlouaecrrPe64ZUeCL9KeMHhV1L1YkUuMEW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868671; c=relaxed/simple;
	bh=qgMUuzaktOkVsHPFOcCpokEnOqdIAKFflr3m387+uz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWD303kYl/u6r5j8dKxpJaJwuZMv7oDWlEVgzrZZ1RWLA77QHGTJcVEbpFSKRc9MigV/hB1tHBRDnNo+hOtnuF3WsRQ4Ox1Mkuz2GtJ01woEBmzVdAzsHKjE0qKLFqPobKX/X8cOzCqawXcjQcdgDtSDLo7hZbtQpLczOccYLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kbO8dBSx; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713868665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WRh2i7VaiPuKG/rd8719h0hISkyFOp0dscoxCokq5BU=;
	b=kbO8dBSx2SZ+wv3S27ygTuLHbf0/p/RXii+p6ebJ3A7/w56NHuPj92dCD0cMdPKqNbxIADGGfG+tgJ5pW042aHAVY1FGN1NiW+f4tCtR+2PRE1i5gkYevK+PYJTSM9iigI3bM3ZsfJVdWUJUu5xmXKp+LAdy7DDAk+Y4nVqVqWQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W592.ia_1713868662;
Received: from 30.97.48.197(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W592.ia_1713868662)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 18:37:44 +0800
Message-ID: <be205197-91c8-4937-bfce-5ae5520128ea@linux.alibaba.com>
Date: Tue, 23 Apr 2024 18:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240419123611.947084-2-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/19 20:36, Baokun Li wrote:
> Instead of allocating the erofs_sb_info in fill_super() allocate it during
> erofs_init_fs_context() and ensure that erofs can always have the info
> available during erofs_kill_sb(). After this erofs_fs_context is no longer
> needed, replace ctx with sbi, no functional changes.
> 
> Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks, it looks good to me, let's see how it behaves after applying
to -next.

Thanks,
Gao Xiang

