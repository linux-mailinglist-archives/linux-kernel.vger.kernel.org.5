Return-Path: <linux-kernel+bounces-38072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CF83BAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3C81C224EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E1125B2;
	Thu, 25 Jan 2024 07:30:41 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7204310A24;
	Thu, 25 Jan 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167840; cv=none; b=bC3X8y63iEJM7eOfd6P1hUrms0oinPIX5Rr6UhJuPQGaxab+FfbZ12kEz/1+v5ZKe7OGfVbBzxPZvra7SlSOON+QLCMk7C1H0Naew3+7lX6ORkuWBMuA0WRzmjphNTYMjNMSNFH26aMCw75x2rwKACGvgVhsUFXlrtIlMgYGIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167840; c=relaxed/simple;
	bh=zezz4fsplqfGvnQtgvPm8PerG232C9kn1Lbh9s3RA7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=i9ZiaaYelPZ1xYNAw0rLj8i1kUHOyxpWuYQ5XfDTlKUukdStg7mUqyTisgIXgsW4iWYdgMKp2IlBBwll6sNLDQFdfmGx7bZw9GUvUGSO+NkYHDrcHp5kSBbFkljtdfTXxYmk9Ckf96C3YDeOp6Gr7mX48iFmuRR+jglK7rQUQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 480B9608638A0;
	Thu, 25 Jan 2024 15:30:15 +0800 (CST)
Message-ID: <699a33f7-2584-8d64-3a5c-668088f0dea4@nfschina.com>
Date: Thu, 25 Jan 2024 15:30:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] HID: hidraw: fix a problem of memory leak in
 hidraw_release()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, mail@karthek.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <76300deb-f532-4d74-a97a-4cd321ae8f41@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/25 15:11, Dan Carpenter wrote:
> On Thu, Jan 25, 2024 at 02:32:26PM +0800, Su Hui wrote:
>> 'struct hidraw_list' is a circular queue whose head can be smaller than
>> tail. Using 'list->tail != list->head' to release all memory that should
>> be released.
>>
>> Fixes: a5623a203cff ("HID: hidraw: fix memory leak in hidraw_release()")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
> This is very clever.  How did you find that?  Was it through static
> analysis or just review?  Perhaps using syzkaller?
Hi,

I just met this bug on a real machine and found this problem by 
reviewing the code.

>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> I imagine we could write a checker heuristic to identify ->tail and
> ->head struct members and then complain if they were ever used in a <
> or > comparison.

I can't agree any more, great idea!

Su Hui


