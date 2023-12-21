Return-Path: <linux-kernel+bounces-9154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AAF81C1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8720288D96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69977995E;
	Thu, 21 Dec 2023 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J8Gnd+0L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407379948;
	Thu, 21 Dec 2023 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ysJ1nRhQ8xLtmwMxQM54I2ikdSeFGYHpjXOSTY91G18=; b=J8Gnd+0L4FdQ46ayKLbY8F1mRr
	stnhlQXCh44liIcKVvKA+RviYLAg4Pm1mRS11Q+WdWI7W4MT+uictfzcIR4/QKaveSlGhSmbS6ZQt
	VTxy+JnaQm3o1bHDi0uDT/85SetX4L62gJJ5ZxB/Q6A1k9kIJkH2fx149ZY3zmDWLTUdFDH1FO/2X
	IVxnjvfbIV6qJLexwrkQZl8Z9U9UnJY0sGDE131rNKnLVaIr4poY6BXIyvA+Ltp1uDNc7mLADGxNl
	FQ/84Zsd8Gva9Hbd0NqHcR54EmJOAjDIJmohL6jefF2txFePiS5VQX7kdOr7OpAcxZJnkSV4NL/p6
	ko0Iy1wQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSDh-004Ous-0x;
	Thu, 21 Dec 2023 23:12:49 +0000
Message-ID: <cc5c5ceb-cb07-4fb3-95f0-c114dd12a755@infradead.org>
Date: Thu, 21 Dec 2023 15:12:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, corbet@lwn.net,
 jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 anandakumar.balasubramaniam@sony.com,
 Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
References: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
 <2023122144-enlarged-maggot-493a@gregkh>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2023122144-enlarged-maggot-493a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 08:52, Greg KH wrote:
> On Thu, Dec 21, 2023 at 07:09:53PM +0530, Sreenath Vijayan wrote:
>> When terminal is unresponsive, one cannot use dmesg to view kernel
>> ring buffer messages. Also, syslog services may be disabled,
>> to check them after a reboot, especially on embedded systems.
>> In this scenario, dump the kernel ring buffer messages via sysrq
>> by pressing sysrq+D.
>>
>> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
>> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
>> ---
>>  Documentation/admin-guide/sysrq.rst |  2 ++
>>  drivers/tty/sysrq.c                 | 43 ++++++++++++++++++++++++++++-
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
>> index 2f2e5bd440f9..464c4e138b9d 100644
>> --- a/Documentation/admin-guide/sysrq.rst
>> +++ b/Documentation/admin-guide/sysrq.rst
>> @@ -161,6 +161,8 @@ Command	    Function
>>              will be printed to your console. (``0``, for example would make
>>              it so that only emergency messages like PANICs or OOPSes would
>>              make it to your console.)
>> +
>> +``D``	    Dump the kernel ring buffer
>>  =========== ===================================================================
> 
> Nit, this doesn't line up anymore :(

Yes, that will cause a docs build warning.

Also, can you be more explicit about which ring buffer this patch
is referring to, please.


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

