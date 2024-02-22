Return-Path: <linux-kernel+bounces-76776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A83285FC69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FF4285866
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED214D441;
	Thu, 22 Feb 2024 15:32:13 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688D14A0BD;
	Thu, 22 Feb 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615932; cv=none; b=CnvlOm9D+M5ZfOVEoWOmmINm8Wf0XXmEB0MTAQ+M1fL76e6rlE1+WcACiQCaxNFYMUu0h9ghXeAbgASqOn4XZIfSo6U7FI8DJrH6f7VZTnQijivaAe00LrNsX9VhPvO0gHaPxIYwomgLh5WSwKbe/4/08LzjJNfcHqn3/xNDCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615932; c=relaxed/simple;
	bh=zp6ewqKzMeueLqcQxskeWDpot5mn9z6JuOK2H3+/S5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPrieSlPFhkva5JUs8N0UqCuJczV/bl0Ya3ddmVxfYooppmUCC8Vroy44B0dANnvHRpRc/gbuK15IYpl9Emj74FerGj6dY+qMqcY5PO83/xVXHQyaYqAnIaUzZInnalz8QD18wC2WJkaH9w3vpDUeyO+MrUacbIZK6wWzgU9bz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3C43B61E5FE01;
	Thu, 22 Feb 2024 16:30:56 +0100 (CET)
Message-ID: <1f5f15cd-a0ed-47d0-ba5c-e1beb953b92b@molgen.mpg.de>
Date: Thu, 22 Feb 2024 16:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH md-6.9 00/10] md/raid1: refactor read_balance() and some
 minor fix
To: Paul E Luse <paul.e.luse@intel.com>, Kuai Yu <yukuai1@huaweicloud.com>
Cc: Paul E Luse <paul.e.luse@linux.intel.com>, song@kernel.org,
 neilb@suse.com, shli@fb.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 Kuai Yu <yukuai3@huawei.com>
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <34b04a5f-7ef8-4e00-b1c6-c4e692281499@molgen.mpg.de>
 <0f2a89e7-fa2c-fe83-bcb7-cfc449c5a721@huaweicloud.com>
 <6BE93F19-AF6B-4E05-ABFC-24FC7DF97524@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <6BE93F19-AF6B-4E05-ABFC-24FC7DF97524@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paul, dear Kuai


Am 22.02.24 um 14:04 schrieb Luse, Paul E:

>> On Feb 22, 2024, at 2:08 AM, Yu Kuai <yukuai1@huaweicloud.com> wrote:

>> 在 2024/02/22 16:40, Paul Menzel 写道:
>>> Is there a change in performance with the current patch set? Is
>>> radi1 well enough covered by the test suite?
>> 
>> Yes, there are no performance degradation, and mdadm tests passed.
>> And Paul Luse also ran fio mixed workload w/data integrity and it
>> passes.
> 
> Kuai is correct, in my original perf improvement patch I included
> lots of results.  For this set where we just refactored I checked
> performance to assure we didn't go downhill but didn't save the
> results as deltas were in the noise.  After this series lands we will
> look at introducing performance improvements again and at that time
> results from a full performance sweep will be included.
> 
> For data integrity, 1 and 2 disk mirrors were ran overnight w/fio and
> crcr32 check - no issues.
> 
> To assure other code paths execute as they did before was a little
> trickier without a unit test framework but for those cases I did
> modify/un-modify the code several times to follow various code paths
> and assure they're working as expected (ie bad blocks, etc)
Thank you very much for the elaborate response.

In our infrastructure, we often notice things improve, but we sometimes 
also have the “feeling” that things get worse. As IO is so complex, I 
find it always helpful to exactly note down the test setup and the run 
tests. So thank you for responding.


Kind regards,

Paul

