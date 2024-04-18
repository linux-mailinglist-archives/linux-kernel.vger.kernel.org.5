Return-Path: <linux-kernel+bounces-150015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90408A9919
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064081C20D58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD115EFD2;
	Thu, 18 Apr 2024 11:54:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901015E7FA;
	Thu, 18 Apr 2024 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441259; cv=none; b=f8Fp4Bb1yTQ3aOAhdE9e+bro9zEKDCPBu7mZf8kGA/5gdprVjbm0cC1aR45IJr2hu8yNoZCD0P0BTeiKUL1I0gIMUkZFM7JnKnNZ0rzF+fyXXH6N4XsN5I1OBEWXZNmdRZkr5reD3H44C4xuTxpelJl73nlleCuG6WKwhfuXA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441259; c=relaxed/simple;
	bh=CG4gMAT/u+dqzVOE7SFDWH6+kKzOmYoWtiKUTwuXNGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xtd0QMW5aD3Sn4OOyxeRn1XzUeC6nB0Uzg6qYHULoFAEGVDbNzuFcL59fHyU+XLnlpfG88q3r2RiIlYAzA/n9lUPh24/qQ72DKsvFNHIidn1Na1gdr2O5RJ2IY+5FHUpUa2yaPrqRfsu+kepXoZpU/Tppxle7cXg5np3q5ewfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKx1m0VDDzwSdL;
	Thu, 18 Apr 2024 19:51:08 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C358180080;
	Thu, 18 Apr 2024 19:54:12 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 19:54:11 +0800
Message-ID: <442a67cb-8f1c-f6ac-98c1-ef97db52d5a2@huawei.com>
Date: Thu, 18 Apr 2024 19:54:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] pinctrl: devicetree: fix refcount leak in
 pinctrl_dt_to_map()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: <linus.walleij@linaro.org>, <dan.carpenter@linaro.org>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>
References: <20240418113459.4182749-1-zengheng4@huawei.com>
 <ZiEGzuVzV_fV52DR@smile.fi.intel.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <ZiEGzuVzV_fV52DR@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)


在 2024/4/18 19:41, Andy Shevchenko 写道:
> On Thu, Apr 18, 2024 at 07:34:59PM +0800, Zeng Heng wrote:
>> If we fail to allocate propname buffer, we need to drop the reference
>> count we just took, otherwise it will lead reference leak. Here the
>> error exit path is modified to jump to the err label and call
>> pinctrl_dt_free_maps() which would drop the counter.
>>
>> In the meantime, if it is found that the property 'pinctrl-0' is not
>> present, ENODEV is returned and also jump to the err label and call the
>> free function, in case the Smatch tool complains.
>> ---
> You forgot a changelog, but I think this needs to be a followup.

Oops, the resend patch would come soon.


Thanks,

Zeng Heng


