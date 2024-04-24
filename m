Return-Path: <linux-kernel+bounces-157251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E48B0F20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF111F231BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3B15B54C;
	Wed, 24 Apr 2024 15:52:53 +0000 (UTC)
Received: from mail-m12824.netease.com (mail-m12824.netease.com [103.209.128.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C11422AF;
	Wed, 24 Apr 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973972; cv=none; b=aQoS/t/eF4oSymBar1BGn/3S/FB7iqiiIchXFj83Osme9Eeo+MHsLScYKVpQeDfacejtb3ybTgswEJeLUh/25Isf8+wTVt5/gythGeIxQornJ7Q3X62wY9dnQJy+MfqTlYG4BSolo3b5V4XY+ld/R0esNwA8jL2AIW7z6Srl8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973972; c=relaxed/simple;
	bh=qOuZ/FKAj56jtkFL4SdM4vCiYPbiiMS+JV1peJ4ZbiY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s6/e9+UX1HQUzlpJ7kL1v1dZEPMgmRMqWH5e/CpeJEIFUkLaHhDXrpsaw5NaVAsPXSCGaIUZ4mr+QJdbtpJbPnKktsMbCWAD7uuBy8HuDBFdBFOCefCamNyjuVjx7lA06KSAbmAKfGvpEuKZEByIrV1CEkQebeAhTB3lQXAIpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.209.128.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C5A03860120;
	Wed, 24 Apr 2024 16:43:48 +0800 (CST)
Subject: Re: [PATCH 2/7] cbd: introduce cbd_transport
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-3-dongsheng.yang@easystack.cn>
 <780f3ccd-5112-4948-81c3-3144c6779503@nvidia.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <7ec61a75-79ec-94db-ebf9-58679c85edeb@easystack.cn>
Date: Wed, 24 Apr 2024 16:43:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <780f3ccd-5112-4948-81c3-3144c6779503@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTE1LVkxISElJGE9MSkJDH1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f0f467de2023ckunmc5a03860120
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Iww6Ojc1ThACPToJAgMC
	LxpPFChVSlVKTEpIQk9DSUlCTk9JVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT09NSjcG



在 2024/4/24 星期三 下午 12:08, Chaitanya Kulkarni 写道:
>> +static ssize_t cbd_myhost_show(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       char *buf)
>> +{
>> +	struct cbd_transport *cbdt;
>> +	struct cbd_host *host;
>> +
>> +	cbdt = container_of(dev, struct cbd_transport, device);
>> +
>> +	host = cbdt->host;
>> +	if (!host)
>> +		return 0;
>> +
>> +	return sprintf(buf, "%d\n", host->host_id);
> 
> snprintf() ?

IMO, it will only print a decimal unsigned int, so it shouldn't overflow 
the buffer.
> 
>> +}
>> +
>> +static DEVICE_ATTR(my_host_id, 0400, cbd_myhost_show, NULL);
>> +
>> +enum {
> 
> [...]
> 
>> +
>> +static ssize_t cbd_adm_store(struct device *dev,
>> +				 struct device_attribute *attr,
>> +				 const char *ubuf,
>> +				 size_t size)
>> +{
>> +	int ret;
>> +	char *buf;
>> +	struct cbd_adm_options opts = { 0 };
>> +	struct cbd_transport *cbdt;
>> +
> 
> reverse tree order that matches rest of your code ?

Agreed,
> 
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	cbdt = container_of(dev, struct cbd_transport, device);
>> +
>> +	buf = kmemdup(ubuf, size + 1, GFP_KERNEL);
>> +	if (IS_ERR(buf)) {
>> +		pr_err("failed to dup buf for adm option: %d", (int)PTR_ERR(buf));
>> +		return PTR_ERR(buf);
>> +	}
>> +	buf[size] = '\0';
>> +	ret = parse_adm_options(cbdt, buf, &opts);
>> +	if (ret < 0) {
>> +		kfree(buf);
>> +		return ret;
>> +	}
>> +	kfree(buf);
>> +
> 
> standard format is using goto out and having only on kfree()
> at the end of the function ...

Okey, having a unified error handling path is a good idea, and it's 
suitable here as well, thanx.
> 
>> +	switch (opts.op) {
>> +	case CBDT_ADM_OP_B_START:
>> +		break;
>> +	case CBDT_ADM_OP_B_STOP:
>> +		break;
>> +	case CBDT_ADM_OP_B_CLEAR:
>> +		break;
>> +	case CBDT_ADM_OP_DEV_START:
>> +		break;
>> +	case CBDT_ADM_OP_DEV_STOP:
>> +		break;
>> +	default:
>> +		pr_err("invalid op: %d\n", opts.op);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return size;
>> +}
>> +
> 
> [...]
> 
>> +static struct cbd_transport *cbdt_alloc(void)
>> +{
>> +	struct cbd_transport *cbdt;
>> +	int ret;
>> +
>> +	cbdt = kzalloc(sizeof(struct cbd_transport), GFP_KERNEL);
>> +	if (!cbdt) {
>> +		return NULL;
>> +	}
> 
> no braces needed for single statements in if ... applies rest of
> the code ...

thanx, Iwill remove unnecessary braces next version.
> 
> -ck
> 
> 

