Return-Path: <linux-kernel+bounces-127231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83596894862
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B504D1C21249
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A88F55;
	Tue,  2 Apr 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQcHond6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5A4C6E;
	Tue,  2 Apr 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016993; cv=none; b=tEL2ApyOb92zjlDxFVN1EsNk7j1KaF8LcbXFw14A16UmNqcD6zLAI9Tu8FdQF0C4DBtVY5KQODFMs3S9SyR3A4xsyJuIhycdtvoGqBZC1TTimg6iw5Ff2oQyU7IemERF38VhVFQSA/cZfAbmNDQOvOUM5MpZx/r6MSkUvwu5wak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016993; c=relaxed/simple;
	bh=HOZtlcs+tBZgNdNWUO+mWam6pkEhyoDsTLqIi26K4Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kw+Hl6liVTs0kIeFzKgGTi+tfv57aIaU4gCy5YPz3z65tbe+BIFvSFfy4Gep/+/tv4RAsvTuOvphJKqhpRLDYmlO2mbE95aXHizQCc2FcZS4NrxMefhQyz+8+k5E6gWewyvEe/KKOhG+lrlS0iTnMzB49SFpoXCkvr8c74G+iFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQcHond6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20942C433C7;
	Tue,  2 Apr 2024 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712016993;
	bh=HOZtlcs+tBZgNdNWUO+mWam6pkEhyoDsTLqIi26K4Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OQcHond6VoT/QHlH+j25KOnWxMzoV9Xb6nobz+34SL785iYoBhP/VRKsHlFt+gh+r
	 /FUrFxDtqsmn2zN4Q8G6JlzINYpGTTVZcsrGNilYIVqi2Xq/OoRwSM5+3uLNtGSMD9
	 Y1j9jZotAzslnclpKYn3FZzJVN5NUdED9MSgqYrjjLEaDQSdj3JCTcuDFOqbLdBmvj
	 4mKLaRPR2Y67Zs1irrMmcrCaL0hk9VY3rniPC9bqJaidux46+GGUqJ6XInmiyWBEpb
	 pb2BvDec8sxYTCkOYRf3ARHjIwHH+5Hz7j1SWesAyss/VGA6Q4Nzy9uPGqpS9Fzi/a
	 xrV370UDlR5ig==
Message-ID: <f02767b9-66e9-43ad-bc81-3a6b40ff852c@kernel.org>
Date: Tue, 2 Apr 2024 09:16:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 linan666@huaweicloud.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mcgrof@kernel.org, hch@lst.de, "yukuai (C)" <yukuai3@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
 <6066205b-bdc8-4434-cc2d-3ce06004ae47@huaweicloud.com>
 <2af548ae-8877-4e8d-8dc2-541b3d6e6330@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2af548ae-8877-4e8d-8dc2-541b3d6e6330@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 02:51, Bart Van Assche wrote:
> On 3/31/24 18:31, Yu Kuai wrote:
>> I was shocked that this patch is still there. This patch is easy and
>> straightforward.
>>
>> LGTM
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>>
>> BTW, Nan, it will be better if you have a reporducer for this.
> Agreed that a reproducer would help. No information is present in the
> patch description about how this issue was detected nor about how it was
> tested. That probably would have encouraged reviewers.

May be submit the reproducer as a blktest case while at it ?

> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research


