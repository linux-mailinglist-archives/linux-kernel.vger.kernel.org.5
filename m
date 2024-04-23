Return-Path: <linux-kernel+bounces-156016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FC8AFCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C80D1C2237C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E497C53800;
	Tue, 23 Apr 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WncLzLUg"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6753373
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915262; cv=none; b=Tr6308otXDc+Z1wv8Rt/cvreGV3/NzN6f5Wv8JXAdillcPzJU7UAoZw8vH6di+dTRjAdZ6kBdtO9Qs2Wr1eE0kiKXBZ/OVfL3uWeKPs4y3aBul7ERf7it9suHg+ShlbpkrfQ3wEVnTdGUKEHJictv/qyL/Q7h8jYmVp+q2vsR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915262; c=relaxed/simple;
	bh=i91iXa+v2Fvr881hXTJGQYY2QecwMN8qY6taP3UcQGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WRGvFnedSSYJWYwqOCae3K7WjJhWg6yRIlwhI81JwfiZcE3c4GkAoHwf34kdm8nlvXDqLnWfeiKhlbKoYbZljuB9wT1LeHyP9Xv2BhFO6pSs0Q22iezcGzJOicaNfi8PV4nvYCU9fkUWD6QgLCWyKAbnoDVATkR1tm9mVVwBdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WncLzLUg; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713915256; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9Gxowe4obBcWj3O95wnWmGmXXcjuigIjukpVqtM1i1k=;
	b=WncLzLUgti+koitKU+Hn1nLxjLo6sdYPlccDNLqD2MQ8Ua2EWWy6G99gKD0eExVFwgwLvpL+ET+vVLb7Mssks7nApgsfsCWRVg0sDWHXFMjudG/ZCEZRkQR9wGXIXKjDLNyaeu72736UTI0K+VNCvkivFG85Trj/N2pK+jiKF3I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W5ACaKE_1713915254;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5ACaKE_1713915254)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 07:34:15 +0800
Message-ID: <4ac3f6e8-9801-473e-85e0-405a4283dc2a@linux.alibaba.com>
Date: Wed, 24 Apr 2024 07:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible
 code in z_erofs_get_gbuf
To: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000035775f0615b72d01@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000035775f0615b72d01@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/10 13:19, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:


#syz invalid

Since
https://lore.kernel.org/r/20240408215231.3376659-1-dhavale@google.com
has been folded into the original patch and this issue is only in -next.

Thanks,
Gao Xiang

