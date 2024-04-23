Return-Path: <linux-kernel+bounces-154416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23A88ADBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9DE282AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ACC17753;
	Tue, 23 Apr 2024 02:17:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB710949
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838625; cv=none; b=YNymRaEOvbsoKuDAcOeIO8mowbj+SBxJKCoAJPFSqRzbuAANZm5Sdr7bFHnM5WQUdwD9vl5D4upnO9spt5boesB2qMVoixIKDUSKYzzc6pxtAnacyf2dk+4dUZ0RpDXHF0Fk9K+KIhCvsW6k9mqmrI//eFmwS/IlkkKu2B5E9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838625; c=relaxed/simple;
	bh=5ysTMKHeHEPNPsU9UhvdWt+UtNAlM07+Q+HOP5hWwjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1F72VoZ/cf1bPil8W5bqwg6bREHcAkdaHb35uPMrRWiUwblACPwDY1kHYXO0idBElmcz1BGS+il7pKCS3xV+iQrjg0NBeBsgWbGK6F4+C3zBFWZ1mkqesF+miUquMg4wj05lulDOwsfIKzbiKJJjUzus0QzZSb1YEuKp4/1t58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VNlzP0Bf3zvQ1n
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:13:53 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id E79D318006B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:16:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:16:52 +0800
Message-ID: <12f4d203-615b-0937-857e-ef0a478cd183@huawei.com>
Date: Tue, 23 Apr 2024 10:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] genirq: Reuse irq_is_nmi()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240417085616.3785647-1-ruanjinjie@huawei.com>
 <87r0exun6e.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87r0exun6e.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/4/23 5:01, Thomas Gleixner wrote:
> On Wed, Apr 17 2024 at 16:56, Jinjie Ruan wrote:
>>  
>> +static bool __maybe_unused irq_is_nmi(struct irq_desc *desc)
> 
> Seriously? What's wrong with static inline?

Use "static bool" has follwoing warning:

kernel/irq/internals.h:283:13: warning: ‘irq_is_nmi’ defined but not
used [-Wunused-function]
  283 | static bool irq_is_nmi(struct irq_desc *desc)

But us "static inline bool" is ok.

I'll change it to inline, thank you very much!
> 

