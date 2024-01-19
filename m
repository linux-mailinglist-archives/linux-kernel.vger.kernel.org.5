Return-Path: <linux-kernel+bounces-31289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FF832BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F136A287B10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202A56455;
	Fri, 19 Jan 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jeT5TYDa"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA854F84
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676071; cv=none; b=JaqQxQrJs71oXb+2zA5BXf46rerEfkgbXzB2aiSME/1pIfXm7X+2nIRHgsmlMRAaXIlw9H4OnYgS80OECb2oSX1MmKOGHHt1xNjfh9hdYjAbs+h5mXt3meiOMMleIJ6BwjbpXBVpA/XyGIR5i1ppgjJLNR6bdgC/ITDpV/n9h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676071; c=relaxed/simple;
	bh=4yHIPIsRM+7ue0n2BdvcB1oXqKrqWvTmxWww/XwOPh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXo3wlpRh4u61lSwusqJvgGdOkmPA5GNdcwQaVPoPkSRkb+qHrMSLa4szdhkmTe70zQgXFKURt3j8NArIC6yI10tj1gL6YQJmPtM4kG3pYmCzQ6gqnGHtoz2KBnED1dyXpfh9fv0YvrkYdPuCsPn8RJuAF8SeVigmJLPvA4PmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jeT5TYDa; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2aeb7d61-5080-4089-b789-765399db74c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705676067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqsslxIEMoApitxXr/jCsu5JyE/pWRxqwJQndEwBNxg=;
	b=jeT5TYDa4WRfHh4yMTzZwdLf9kbdfdoaPY3/aBxVXcCzn7dnwo3nKeiLIdGzNtfFhxj0rW
	aDY8uIJ1DGD3sIk20xaJ/bcYDK0pqdyxogfoVfzIsCnrl/GsdgXa/S4BST+KayxUfywkkd
	cac3sPvodXoskwFwLcwlphMTcBZewbA=
Date: Fri, 19 Jan 2024 23:04:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/7] padata: dispatch works on different nodes
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-4-gang.li@linux.dev>
 <10f26c5c-760d-4f1b-abdc-8508971236ed@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <10f26c5c-760d-4f1b-abdc-8508971236ed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/19 10:59, Muchun Song wrote:
> On 2024/1/18 20:39, Gang Li wrote:
>> --- a/kernel/padata.c
>> +++ b/kernel/padata.c
>> @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct 
>> padata_mt_job *job)
>>       struct padata_work my_work, *pw;
>>       struct padata_mt_job_state ps;
>>       LIST_HEAD(works);
>> -    int nworks;
>> +    int nworks, nid;
>> +    static atomic_t last_used_nid = ATOMIC_INIT(0);
> last_used_nid is only used during boot time so it could be
> __init_data. Otherwise, LGTM.
> 
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> 

OK, thanks.

