Return-Path: <linux-kernel+bounces-37599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819183B25E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E25B1C2235B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5B132C34;
	Wed, 24 Jan 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3cEaQD9"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE17CF3F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125121; cv=none; b=JTPrvxY6d37vWDUAoAfBSUBCiZhwCe+bNF3Tk+y3GkkAKDSlDzzh154sq8aUYCoGb/UiJPoAPsVBD9He9dIvaSWKZQtOz6qXuMtWnOrL6hyQ3yBhylJVJBI/fKwU94RjUn8ZBYz/Krw5d1Gt4nGkPu8kHz0EUwuKFUsD9XNWgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125121; c=relaxed/simple;
	bh=+k9OWczvUGMnN/2XaNeNiKTVBPX1lRZnbBn3wZPoj5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k6xusydhTCpjahVN07myx8O+SBisXdm8DSUmrxMAO48b8Sh21c2KbpNnaRZpd0i1mPTXdphKivnuBBRgcftgTGpJBVoCnLtf1U+XqqO4C8fntL1A0QKJ5Uw/q+eHs/1FUIa4fLFvxli+5BLhtkPu78qd09bqqrJWQe9s877xRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3cEaQD9; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dec4b7b680so3622074a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706125119; x=1706729919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uD5n5CYMyoxmSF0veZJBcYhXMJ89+GcCRIw+PVWIrPM=;
        b=j3cEaQD9BELKZvfpW5Hdv1PO3cR+TuFqQ7wc0gnvo8WVE9419N+D71ChB+r7tvDCJP
         D3i1TwWdSz2sXDu21p0dFNFbxFettO8OZckfJfIopSPL50p5jJaGYXtDpb/FqR7kWTdU
         18BddQivJOUx/N4xs+fIm+ptrlwJ9rGMAA7a5D88rrtKC+MUF9EYqNVlR+FD4hAZhz31
         aOzyl/+esxUnsS3jsRIRAqsZ6texXXNe9c5TUYAN6ale+ePwMZe8SuaXLfub+Evx3I29
         k0VREI8w6+Om+KkTPsj39e0O9CDzghx2pG/n2NY9E/bnUrqs1x4hpTlbeCChZT4nsw4u
         W0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125119; x=1706729919;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uD5n5CYMyoxmSF0veZJBcYhXMJ89+GcCRIw+PVWIrPM=;
        b=gQbL65Gddsd/RqDDopLoXO87M73qBHAxaxxOZpeqX1/Upm14Iy3xRFArExtXhNu3+i
         9gPf1mztiYLD2X2ctloi1+gG0xzmMH4pzMqZBn3DY6VPb7eSbgdRsTPm+2YNv3emMU9i
         990m47vwFYHZCZXvXyV2uUr7e/IkODUuaSYUL+ePc+4Yyjs4NqujQWe4+u//pBC3AUDC
         yzrUo9E1qQDTSVpjd9fLHL6K4hl6bfUJlxM2GSHNlzdUG8K+uV6ya7KMITu8rZ1iq3c9
         7bAt10mKVO3iAUYg0YErEvqNJx+FEX+eqBZfzYAew54/Wan/B7bCZhCB18kbRbInJ9oQ
         vtKA==
X-Gm-Message-State: AOJu0YzuG2Ab/WFraw7sInbCne5UkFHO8tcwk/w9xFURQ/JV2TfMQVmG
	jZ5Q8NvM3Q6tJXf//oRX2TBnzX8O4n7btLnvtG2dTvRubj3nqtjyBNVIkyj6
X-Google-Smtp-Source: AGHT+IEZKGQQ8NRnyHbwJDoSiUbCjNKBhT+6Y+poRPh8R25KQHYVof+7qR8X3Eln7HX7ElULtRgQWw==
X-Received: by 2002:a9d:620b:0:b0:6db:bcb5:a070 with SMTP id g11-20020a9d620b000000b006dbbcb5a070mr1971227otj.62.1706125119005;
        Wed, 24 Jan 2024 11:38:39 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id w10-20020a9d77ca000000b006ddda12a747sm2695692otl.70.2024.01.24.11.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:38:38 -0800 (PST)
Message-ID: <7c2451ad-2d6d-4517-9373-0f5d58f2cfad@gmail.com>
Date: Wed, 24 Jan 2024 13:38:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/22/2024 3:13 AM, Sagi Grimberg wrote:
> 
> 
> On 1/18/24 23:03, Stuart Hayes wrote:
>> Use async function calls to make namespace scanning happen in parallel.
>>
>> Without the patch, NVME namespaces are scanned serially, so it can take a
>> long time for all of a controller's namespaces to become available,
>> especially with a slower (TCP) interface with large number of namespaces.
>>
>> The time it took for all namespaces to show up after connecting (via TCP)
>> to a controller with 1002 namespaces was measured:
>>
>> network latency   without patch   with patch
>>       0                 6s            1s
>>      50ms             210s           10s
>>     100ms             417s           18s
>>
> 
> Impressive speedup. Not a very common use-case though...
> 
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>
>> -- 
>> V2: remove module param to enable/disable async scanning
>>      add scan time measurements to commit message
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0af612387083..069350f85b83 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2014, Intel Corporation.
>>    */
>> +#include <linux/async.h>
>>   #include <linux/blkdev.h>
>>   #include <linux/blk-mq.h>
>>   #include <linux/blk-integrity.h>
>> @@ -3812,12 +3813,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>>           nvme_ns_remove(ns);
>>   }
>> -static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> +/*
>> + * struct nvme_scan_state - keeps track of controller & NSIDs to scan
>> + * @ctrl:    Controller on which namespaces are being scanned
>> + * @count:    Next NSID to scan (for sequential scan), or
>> + *        Index of next NSID to scan in ns_list (for list scan)
>> + * @ns_list:    pointer to list of NSIDs to scan (NULL if sequential scan)
>> + */
>> +struct nvme_scan_state {
>> +    struct nvme_ctrl *ctrl;
>> +    atomic_t count;
>> +    __le32 *ns_list;
>> +};
>> +
>> +static void nvme_scan_ns(void *data, async_cookie_t cookie)
> 
> I think its better to call it nvme_scan_ns_async to indicate what
> it is.
> 
>>   {
>> -    struct nvme_ns_info info = { .nsid = nsid };
>> +    struct nvme_ns_info info = {};
>> +    struct nvme_scan_state *scan_state;
>> +    struct nvme_ctrl *ctrl;
>> +    u32 nsid;
>>       struct nvme_ns *ns;
>>       int ret;
>> +    scan_state = data;
>> +    ctrl = scan_state->ctrl;
> 
> I think these assignments can be done on the declaration.
> 
>> +    nsid = (u32)atomic_fetch_add(1, &scan_state->count);
>> +    /*
>> +     * get NSID from list (if scanning from a list, not sequentially)
>> +     */
>> +    if (scan_state->ns_list)
>> +        nsid = le32_to_cpu(scan_state->ns_list[nsid]);
>> +
> 
> This is awkward. ns_list passed in optionally.
> How about we limit this change to only operate on nvme_scan_ns_list?
> If the controller is old or quirked to support only a sequential scan
> it does not benefit from a parallel scan. I doubt that these controllers
> are likely to expose a large number of namespaces anyways.
> 
>> +    info.nsid = nsid;
>>       if (nvme_identify_ns_descs(ctrl, &info))
>>           return;
>> @@ -3881,11 +3908,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>       __le32 *ns_list;
>>       u32 prev = 0;
>>       int ret = 0, i;
>> +    ASYNC_DOMAIN(domain);
>> +    struct nvme_scan_state scan_state;
>>       ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>>       if (!ns_list)
>>           return -ENOMEM;
>> +    scan_state.ctrl = ctrl;
>> +    scan_state.ns_list = ns_list;
> 
> Is there a need to have a local ns_list variable here?
> 
>>       for (;;) {
>>           struct nvme_command cmd = {
>>               .identify.opcode    = nvme_admin_identify,
>> @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>               goto free;
>>           }
>> +        /*
>> +         * scan list starting at list offset 0
>> +         */
>> +        atomic_set(&scan_state.count, 0);
>>           for (i = 0; i < nr_entries; i++) {
>>               u32 nsid = le32_to_cpu(ns_list[i]);
>>               if (!nsid)    /* end of the list? */
>>                   goto out;
>> -            nvme_scan_ns(ctrl, nsid);
>> +            async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>>               while (++prev < nsid)
>>                   nvme_ns_remove_by_nsid(ctrl, prev);
>>           }
>> +        async_synchronize_full_domain(&domain);
>>       }
>>    out:
>>       nvme_remove_invalid_namespaces(ctrl, prev);
> 
> Is it a good idea to remove the invalid namespaces before synchronizing
> the async scans?
> 
>>    free:
>> +    async_synchronize_full_domain(&domain);
>>       kfree(ns_list);
>>       return ret;
>>   }
>> @@ -3922,14 +3959,23 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
>>   {
>>       struct nvme_id_ctrl *id;
>>       u32 nn, i;
>> +    ASYNC_DOMAIN(domain);
>> +    struct nvme_scan_state scan_state;
>>       if (nvme_identify_ctrl(ctrl, &id))
>>           return;
>>       nn = le32_to_cpu(id->nn);
>>       kfree(id);
>> +    scan_state.ctrl = ctrl;
>> +    /*
>> +     * scan sequentially starting at NSID 1
>> +     */
>> +    atomic_set(&scan_state.count, 1);
>> +    scan_state.ns_list = NULL;
>>       for (i = 1; i <= nn; i++)
>> -        nvme_scan_ns(ctrl, i);
>> +        async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>> +    async_synchronize_full_domain(&domain);
>>       nvme_remove_invalid_namespaces(ctrl, nn);
>>   }
> 
> I think we need a blktest for this. ns scanning has been notorious when
> running simultaneously with controller reset/reconnect/remove
> sequences... Ideally a test with a larger number of namespaces to
> exercise the code.
> 
> Also, make sure that blktest suite does not complain about anything
> else.

Thank you for the feedback on the patch, I agree with it.

I'm not sure how to implement a blktest suite for this, though.  I can look into it.

