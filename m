Return-Path: <linux-kernel+bounces-133814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534189A928
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D228316F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10715208B0;
	Sat,  6 Apr 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="RU30JmeZ"
Received: from mail-108-mta3.mxroute.com (mail-108-mta3.mxroute.com [136.175.108.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479F18E02
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712381341; cv=none; b=XZjX4RhKm1fQcHD9RjD5bAmHhYzsdrLbw+Xqe6eg2hQSTzne1D8Z60wi/RsCz6uXCg/STCo7SDGWlnSNrXYf5RFCRL1LFqM6VokHj5qZZPUd//m2F1P3lPNH7DiGRdLvnyPsCEQVZdmtw7PvvS0KZzHP2NtkUVHSa1Z4hOrAoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712381341; c=relaxed/simple;
	bh=XvGGiaKjAp46vAegdWKN0fVnxmrfC1H1J6zN0QKFTrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b18wrU10kKIR7ztROAhRGkeO7L7pLnXngdfB4FaI83Cm0HJG6rU/AbffJza9V9LDmCwaPpNfYXOO1ZkpB5CCF0HxRunrrHUTcqAuOFYjPrTnzlvZpxhlya6E/iepBUffQuiMdvGIiO4JslI7CAm6DoAh/aVmBO1349uTBMGWMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=RU30JmeZ; arc=none smtp.client-ip=136.175.108.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta3.mxroute.com (ZoneMTA) with ESMTPSA id 18eb1dce0660003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 06 Apr 2024 05:23:46 +0000
X-Zone-Loop: 2c23c9c3f44d8386bff19afe2fabfbe4d319e8d0e977
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZmuhkTALxM8lf0cfAvP+7dJ0PJ20DaBe8z1ii1wZ960=; b=RU30JmeZw8NfKZujRbkVuhHZc7
	Wdnson/TB15EBa0BLASqHxyQNxUo4sK/fpaxMJHvihEmZLBTATxOJV2BXo3NfWsttfvLKNJJWHRsE
	CeKtDYAyQP6Ppj2blTGdGqOtuua7XHqeODzZls2nZUb2ZPnnyrjg5+IiMbLf1veOem4ZcIE6FulIa
	cFzdxpC9SCQ77SbyAmHMfGhhZKRZBLnK2b3qt+pu5WL3NOdQhoD4Sx3PAD7JyD1tpsiBRFs/Iw5M2
	WYtRtpD/Nl5uPmjzU7acJ0j6ti7PD2GE0ijqjph2h/9H2Iu3mWHFgIpfSZoj8eNzC+j+RW3r4jlbG
	IjfS1GLw==;
Message-ID: <bbf7c8c3-ca67-43a1-88d0-199cc9299c6d@luigi311.com>
Date: Fri, 5 Apr 2024 23:23:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/25] media: i2c: imx258: Add regulator control
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-6-git@luigi311.com> <Zg2jgmmqw0nXDYcF@duo.ucw.cz>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <Zg2jgmmqw0nXDYcF@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/3/24 12:44, Pavel Machek wrote:
> Hi!
> 
>> The device tree bindings define the relevant regulators for the
>> sensor, so update the driver to request the regulators and control
>> them at the appropriate times.
> 
>> @@ -995,9 +1007,19 @@ static int imx258_power_on(struct device *dev)
>>  	struct imx258 *imx258 = to_imx258(sd);
>>  	int ret;
>>  
>> +	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
>> +				    imx258->supplies);
>> +	if (ret) {
> 
> Will this make it fail for all current users?
> 
> Best regards,
> 								Pavel
> 								

It shouldn't affect current users as this was added in by dave for
a completely different sensor and it still works on my ppp. Looking
at the dmesg for imx258 it does reference the regulators that the
ppp doesnt have but it still works.

