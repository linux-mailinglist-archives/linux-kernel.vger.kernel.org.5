Return-Path: <linux-kernel+bounces-155145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4B8AE5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2566283B63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FD7E107;
	Tue, 23 Apr 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Kvs7XDBR"
Received: from out0-213.mail.aliyun.com (out0-213.mail.aliyun.com [140.205.0.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531483CD3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874600; cv=none; b=i7axljhjpCAEWB6cYvTbbcDXkwbJXK2qiP+/rGz6LGOi3bKTK2OcYo7VREvvFYL0aqdLbZNwpI5mhHR6Exq2/SnYnJeGpVkYGB2FtYwde0Ekg8HGLnpg/0ui0+iGs8/37RKgI6HdixAXrsfu8gEVu6dMJSXBCSmmCwhwhmGkNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874600; c=relaxed/simple;
	bh=UFzQ3kWYWHBKaUYKOPY1WkcFren0Bv5aLakJ4HzCXeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqmsxrCn87AcSV+0lMrNgy89qTeCDEi26QFxJW/oD0tZYcLEQMqgXzNeax5VavRXV6eHpHd/OM6FDa2AvIi5d6GH9KS7gXsuAyu/5M5/LpdXpPdoE5P8zob23HM9FwpDeaPeLcPlAoQweuxajdX83TVFsxMS0f5lD0S8TqVVzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Kvs7XDBR; arc=none smtp.client-ip=140.205.0.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713874593; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zGpCGDLM61ejMNOyLJt8CjD5GKhvUW/9uVClM+cy3Nw=;
	b=Kvs7XDBRcsVTErGY3Tl7r59h7TIyoMKdxvV3PjmPP3o1m0CZ/HHdlW4nOvqjIVui/CMB7O83v6XLV13LPWnqPN7Lcebq/PdYQnG7P2ZRF/px/tJ34qLMmA57V82j+fNK0hIAD9sFrwART/nDBX8ns5YLf6NmFBBzWOFZWt4KnkI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.XJXNWHL_1713874275;
Received: from 30.230.91.3(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNWHL_1713874275)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:11:16 +0800
Message-ID: <c2d61760-ca89-49d0-b366-89b3cd76438f@antgroup.com>
Date: Tue, 23 Apr 2024 20:11:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] um: Fix the -Wmissing-prototypes warning for
 __switch_mm
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
 <20240423112457.2409319-3-tiwei.btw@antgroup.com>
 <8134c423c1a7f911cb5ae2f2e8e40e80f2e5270f.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <8134c423c1a7f911cb5ae2f2e8e40e80f2e5270f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 7:29 PM, Johannes Berg wrote:
> On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>>
>> --- a/arch/um/include/shared/skas/mm_id.h
>> +++ b/arch/um/include/shared/skas/mm_id.h
>> @@ -15,4 +15,6 @@ struct mm_id {
>>  	int kill;
>>  };
>>  
>> +extern void __switch_mm(struct mm_id *mm_idp);
>>
> 
> Maybe drop the extern while at it?

Sure, will do. I also prefer to drop the extern.
Thanks for the review! :)

Regards,
Tiwei

