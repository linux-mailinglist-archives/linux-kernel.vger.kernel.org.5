Return-Path: <linux-kernel+bounces-90101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DBF86FA60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE672815D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA512B6B;
	Mon,  4 Mar 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAT8eJWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266E125D9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535512; cv=none; b=XOin0qK+LXjh/nIgzCG5ctV1tlRRtqjnPAl2TToeC5yQP1JLTRDrcr4bqL4y163mWW5Sbz2zyIx5XaIX8V8ekGQogWoAm5RMpZgoOPnVXnKB9cXnwO9rNdOqcN+zBH//LRpJKeI3AHCsOGTieuYd+jA665V0vI/mB9wSXnNV+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535512; c=relaxed/simple;
	bh=pCHXV/s88VE05KHiAtDUcDWj2C6kZNCANXL4c+tdvNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMLfTXZnbg/4Zgt1GQ1eRLIjcCUT0XaqcHWMucOfu5ZkQEsYf9DLyTpfYfZWEPOi+53ztJ7A//Z6XRnq0G8QtXXOBl4flmHqoOtuW50LxYWJiSy6SrzFS4zm7u57xZ3uXCNSnpq/Vzng9cSwzvSZYeKUUxDJTUcl14cTPgIP2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAT8eJWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8B3C433C7;
	Mon,  4 Mar 2024 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709535511;
	bh=pCHXV/s88VE05KHiAtDUcDWj2C6kZNCANXL4c+tdvNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eAT8eJWePJd0jK8Q2ixYVlvIpvbeeLUFoFy/sPTywGp9Q9vA+7LVcfX852wftPuwt
	 MCzTGMA3XXTTiCtMvzdJtShw5uz7C3mlwqC+2li4cNz8sAXfqo6g7vhltuNVKX+zHI
	 G6D1sVk3N4SeMME7KilqGabeYxTc3/y3FBBO68N6l7IezvBwRyl49B5I6ENlcQbQVL
	 T++ovo7BFzwcTa3jmK7C3Ib8e3sdcSRbl4Ot6eof2/A9rXto3fTz1Ll3XLKByaLCYw
	 8CDZEFzigrcusaCgFK1iRGuP6PkmTq9GlQqcw95+itOVqVIcbH26w6aQ9e+ipONRqg
	 LADpyzp2BriQw==
Message-ID: <0b1ebda7-cf70-47bc-9d31-129eb895ae9f@kernel.org>
Date: Mon, 4 Mar 2024 12:28:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
To: Michael Ellerman <mpe@ellerman.id.au>, Joel Savitz <jsavitz@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, Gonzalo Siero <gsierohu@redhat.com>
References: <20240301203023.2197451-1-jsavitz@redhat.com>
 <87cysdfsef.fsf@mail.lhotse>
Content-Language: en-US
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
In-Reply-To: <87cysdfsef.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/24 4:53 AM, Michael Ellerman wrote:
> Hi Joel,
> 
> Joel Savitz <jsavitz@redhat.com> writes:
>> On 64-bit powerpc, usage of a non-16MB-aligned value for the mem= kernel
>> cmdline parameter results in a system hang at boot.
> 
> Can you give us any more details on that? It might be a bug we can fix.
> 
>> For example, using 'mem=4198400K' will always reproduce this issue.
>>
>> This patch fixes the problem by aligning any argument to mem= to 16MB
>> corresponding with the large page size on powerpc.
> 
> The large page size depends on the MMU, with Radix it's 2MB or 1GB. So
> depending on what's happening 16MB may not be enough.
> 
> What system are you testing on?
> 

htab_bolt_mapping should have aligned things to a lower value that is 16MB aligned.

	/* Carefully map only the possible range */
	vaddr = ALIGN(vstart, step);
	paddr = ALIGN(pstart, step);
	vend  = ALIGN_DOWN(vend, step);



-aneesh


