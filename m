Return-Path: <linux-kernel+bounces-36511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B283A217
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FDC281D95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275EF9F5;
	Wed, 24 Jan 2024 06:33:40 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2549628;
	Wed, 24 Jan 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078020; cv=none; b=QszPeBNY/PPHSbVd7Fc4K9TAHLEZz5equ3QgKNXmYgqjwJagn9ty0uqeXMJtshMtqhq6NL2WqLqcAZUKHcpBfQJYF9fxt7cjBhDyY8mU2ON+4rVfcYLgdihOLm3JERRYtCq0rp3DiVoS4yx3yWe9ZBz3rKTPnVfeoGBPz/JhMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078020; c=relaxed/simple;
	bh=SAJHujprC1bLB15iQXfqasMZEBQT8JXQnCKvkhWg3b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJaBOwdyzGpeZ/9//NJ9W4SQYmtHZ4Gvw4itD1FgTmP9CEywViLV208uX69UR5ScBcN2jUxNru7GdA3C0qzO17nyGa+xnEzVSYb2j1JEVr5CMvm2bgNMXLaJ25dAEkspNzWI99ImoAkjhpA6o+sv1Xxhx2YkDC3jbssj3jpgXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W.F6BhX_1706078002;
Received: from 30.221.129.141(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W.F6BhX_1706078002)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 14:33:33 +0800
Message-ID: <47c1b777-6d4e-40ac-9297-61240c126d6a@linux.alibaba.com>
Date: Wed, 24 Jan 2024 14:33:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
 <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
 <1860588f-2246-4dcd-9db5-4ccd7add0f4a@linux.alibaba.com>
 <3c51c969-3884-4104-b38d-570c61525214@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <3c51c969-3884-4104-b38d-570c61525214@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/23 22:03, Alexandra Winter wrote:
> Hello Wen Gu and others,
> 
> I just wanted to let you know that unfortunately both Wenjia and Jan have called in sick and we don't know
> when they will be back at work.
> So I'm sorry but there may be mroe delays in the review of this patchset.
> 
> Kind regards
> Alexandra Winter

Hi Alexandra,

Thank you for the update. Health comes first. Wishing Wenjia and Jan
both make a swift recovery.

Best regards,
Wen Gu

