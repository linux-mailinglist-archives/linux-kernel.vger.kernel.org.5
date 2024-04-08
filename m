Return-Path: <linux-kernel+bounces-136013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AC89CEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA531F24AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B8146A9A;
	Mon,  8 Apr 2024 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M7fOAl5u"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3603D0BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618454; cv=none; b=Mdw6HzYUNlilIE1cF59yeOcBBX1L6QGqX8jwGd7WL5r87fUsF+HOSjLKa1r3ua5fPFzYSrw5359p2dsHRxxAPzdBGjzIOhSTqI10nsYgpaqkNd8gJmUnX3j3Pv7T+LPeRuc99KLTy8lkrbPSVwlJNqG/fAQrptUMY9SjkEUAK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618454; c=relaxed/simple;
	bh=BLt5f+1qIAx8BHBjO0LYcgqwVT2V6hjMS5A/BihlKf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khUqnAjzbLzUA9AKa37IvYFTswRcS05UwDnO7yPMEFfnpCbHqYFp7mY/itQDeLMyD3D9Y+K7FcZ/rFvfFRHDCvs3JcgIPz9ui6ZEnGIj9pi0O7H9q1OKyNDv/+dQKob6nB6Vd6Fpyxn0jtcwc9bz9mUEMbtofkKb/XM5TVfbq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M7fOAl5u; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712618443; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gKF6T1PMxNOtjkiYvov25COpWDikgrZJeztTw2nxS8c=;
	b=M7fOAl5uGOfA7jvK2RGflFL0MJ0ubfWztNBEfIRxCJw+nAXG6JOyJnRpZDhQItYn5VERxhL313C3J+k0pyEKGc2iJ3vEmmRXZvhx5HoSfU0HjDnrvtiq3gGlXHAH2rPu9J8MwTERehRYfBR/bNMg6Gfp2vTDrWcbcsmDYD5tMj8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4CRDJX_1712618439;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4CRDJX_1712618439)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 07:20:42 +0800
Message-ID: <c94a62ab-00ff-46cb-b338-6c2a6258ba5f@linux.alibaba.com>
Date: Tue, 9 Apr 2024 07:20:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
To: Sandeep Dhavale <dhavale@google.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
 syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20240408215231.3376659-1-dhavale@google.com>
 <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
 <CAB=BE-Rk_Rxd6aNP99m=tSMt4-tNH4xKru8f1QeOF5fzd8-Mtg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-Rk_Rxd6aNP99m=tSMt4-tNH4xKru8f1QeOF5fzd8-Mtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/9 07:05, Sandeep Dhavale wrote:
>>
>> Thanks for catching this, since the original patch is
>> for next upstream cycle, may I fold this fix in the
>> original patch?
>>
> Hi Gao,
> Sounds good. As the fix is simple, it makes sense to fold it into the
> original one.
> 
> Thanks,
> Sandeep.

Thanks, folded.

Thanks,
Gao Xiang

