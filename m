Return-Path: <linux-kernel+bounces-103990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A9A87C789
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B2E282423
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B28BEE;
	Fri, 15 Mar 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ih+a+xQC"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82C79D3;
	Fri, 15 Mar 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469974; cv=none; b=FpLbu0GdgEjIAA3YzTbb+B8421M1NhNYKtMQnW9hR0nwqKWF8K3KRZYDiyvtLu8GpzOqEnWfLh1R1RVG2DMFy2DaAxUDMM83m7qH7i4br4YC5r9j1gfxGi25rpjq16tvLccr/+qaBOdxV00g+fCPqg4EsJJsUFfQYlLijwxHxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469974; c=relaxed/simple;
	bh=9j14obn7LJhO8DocmOfVRGauUW8ZOKLXG5D4pRwAFBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKLdNXtVCV2VYneta2nWFxauwHXP+xjOokPsXqZ+K7ByFNDI5n/OyyghMXY6R1n8UFr3AM26+H4IQH2sRtx32pbvJPmFPrbM6dQVehSRgKufCkz4fwRzDbPhZR1LHzJ9wdv8tY0ldV4S01QleT+TaduQ3NwhtDN4yYIbgEwa73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ih+a+xQC; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710469963; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uWppkp/CDYn1IU8SGxz0loaKDXyaJFyU0HWPRcBekZI=;
	b=Ih+a+xQC/wzNtKFtMAd6uzxbbpp1KtFPmyxhsxW+QPHKrPBqRL5RZLxkWb1O7h/7jUAFdZWfoy8KGxKUzfCbR6U6XweEwIl/kmtero5oueZOr/XAV/pUoc1TS3qtMqsoZumc4TnvstwHabw7K1hk4EKl6CgERrtfaNzd9rPKI2s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W2UXABh_1710469953;
Received: from 30.221.148.72(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W2UXABh_1710469953)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 10:32:41 +0800
Message-ID: <143ea675-97e5-42ab-b8e6-55b2675294c3@linux.alibaba.com>
Date: Fri, 15 Mar 2024 10:32:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] net: provides dim profile fine-tuning channels
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Tal Gilboa <talgi@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Breno Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
 <20240314114955.71ada20c@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240314114955.71ada20c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/15 上午2:49, Jakub Kicinski 写道:
> On Thu, 14 Mar 2024 21:09:31 +0800 Heng Qi wrote:
>> The NetDIM library provides excellent acceleration for many modern
>> network cards. However, the default profiles of DIM limits its maximum
>> capabilities for different NICs, so providing a channel through which
>> the NIC can be custom configured is necessary.
> Given that DIM is currently enabled and disable via ethtool
> why are you putting the API is sysfs and ops in ndo?

Hi Jakub,

Thank you for reaching out. We're flexible regarding configuration 
methods and are
open to using either sysfs or ethtool, depending on what's most 
appropriate for the task at hand.

If the ethtool is favored, I am happy to proceed with it!

Best regards,
Heng


