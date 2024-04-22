Return-Path: <linux-kernel+bounces-154170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091DB8AD894
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4751F225AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70D1A38FD;
	Mon, 22 Apr 2024 22:57:50 +0000 (UTC)
Received: from mail-m12810.netease.com (mail-m12810.netease.com [103.209.128.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1E1A38EA;
	Mon, 22 Apr 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826670; cv=none; b=EJm0csPMSKp9hCas4yGcSGtth64PwcGpeDewClMZmX5Rc7CQ4HRI7ttNuy6AeckZ4wI4dUcCnjeH0O1d1mE1jN63xWNSXAGZmASeZBemKdX6SlPU5tdg5Nqk1Vj7SiMTzu9ZA7AHz5IunmDkGn6otgSMcFHrlC+GIk9srt4p2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826670; c=relaxed/simple;
	bh=ofIIlMvHg01A9vZLcv0ven24tgHk4ZAaRriZRmpl2IY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jlVKKa4lrRme8SOnbkOsIKx9el4QTqoCj0n2HdTPmzlUl+hJRblENy/0325EwGR53Yr/Ug7XRYlYn9nIE9QQmRBvSWeLvPDL9bITLuzTbQ+Lo7uD1HmYx4XV3k7Lpl8rbvmv+bc8QS4j74xZkF9l6lSw9cNOKBpCpOPptlucApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.209.128.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 20C16860144;
	Tue, 23 Apr 2024 06:41:13 +0800 (CST)
Subject: Re: [PATCH 1/7] block: Init for CBD(CXL Block Device)
To: Randy Dunlap <rdunlap@infradead.org>, dan.j.williams@intel.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-2-dongsheng.yang@easystack.cn>
 <7d24e1fb-520c-4ec2-a6aa-89856092891a@infradead.org>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <dd1df8f1-f80c-5a3a-f804-3e360bfac339@easystack.cn>
Date: Tue, 23 Apr 2024 06:41:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7d24e1fb-520c-4ec2-a6aa-89856092891a@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx5KVk1KTRofGh9KQ0JOQ1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f07f870c6023ckunm20c16860144
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6MQw5TzcrFRMdFkxPLDwu
	CggaCk5VSlVKTEpIQ0lOTUxITEpNVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSU1LSDcG



在 2024/4/23 星期二 上午 2:39, Randy Dunlap 写道:
> Hi,
> 
> On 4/22/24 12:16 AM, Dongsheng Yang wrote:
>> diff --git a/drivers/block/cbd/Kconfig b/drivers/block/cbd/Kconfig
>> new file mode 100644
>> index 000000000000..98b2cbcdf895
>> --- /dev/null
>> +++ b/drivers/block/cbd/Kconfig
>> @@ -0,0 +1,4 @@
>> +config BLK_DEV_CBD
>> +	tristate "CXL Block Device"
>> +	help
>> +	  If unsure say 'm'.
> 
> I think that needs more help text. checkpatch should have said something
> about that...
> 
> And why should someone say 'm' to the config question?
> Will lots of (non-server) computers have CXL block device capability?

Hi,
     Thanx for your review! In this RFC version, I have focused entirely 
on prototype validation and demonstration, so this aspect has evidently 
been overlooked. I will supplement the help text in the next version. Of 
course, this place should be If unsure say "n", not "m".

Thanx
> 
> thanks.
> 

