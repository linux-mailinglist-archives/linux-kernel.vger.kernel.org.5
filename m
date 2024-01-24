Return-Path: <linux-kernel+bounces-36410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCB83A040
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993681F225D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9583D6FA5;
	Wed, 24 Jan 2024 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SFSoh2Rh"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C7566E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067955; cv=none; b=e/Wtevl6CtwX/nnRnL+YaCdpfqaZJbIuA/AzTDQGMx9MORhJyiJcJlItG/xvGWqJ78XJJpgZPQiK9XHQwVb59yzDnK0T84/gPINTFz1YYTbbXNXRzlYNCBMys6fUMKsZTaK7amnvsD0ZvSOquQ2U1qxe56BQdgLDKjMolLVm9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067955; c=relaxed/simple;
	bh=8dSx4lSqaDAX4b8Gnv4+I9KNc7hdbxwBxY+IpLgeQjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qh3mDkUztvpbpu0fxcdhMZjv/VSIiHbyYk1lcl4pR0cRlWDZyw0bFEoc4uXv0QbdbdKQQAuc5bfRXQrg8JoNw1Sb3lykb/42Mn/QTMFx2cZZ9ROJ5Y4vwtqKsYaevx2e/ei5mOMtrB9VrxWZAQez+IX1AAAsmh3WHTJy6xskS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SFSoh2Rh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f479a5c4-71f7-bd27-7975-104a9c76a45d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706067950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E1jGheheG3ZM1Tb7z2Aj6BvnsCBIRhjOg5678MeZtQ=;
	b=SFSoh2Rh1bwPkTGQpSPACKNWAoGiyh9o4PmVEuTZplErIdaRcb2jTyC1cdK0jC5JRln8I/
	pfnKwffntvVHRVXZ99LIosZTo9iR8yWt1900s9l4f3NSEG/k72mXSwyLI3BngoIDGNXO/s
	peHmb+rXON+w8KCUhSP4IzoiU+1fg6M=
Date: Wed, 24 Jan 2024 11:45:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: simplify vma_merge()
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Suren Baghdasaryan <surenb@google.com>
References: <20240118082312.2801992-1-yajun.deng@linux.dev>
 <20240123160855.k7fhmlb7cfhdel5t@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240123160855.k7fhmlb7cfhdel5t@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/24 00:08, Liam R. Howlett wrote:
> Adding to the Cc list, because it's vma_merge().
>
> * Yajun Deng <yajun.deng@linux.dev> [240118 03:23]:
>> These vma_merge() callers will pass mm, anon_vma and file, they all from
>> vma. There is no need to pass three parameters at the same time.
>>
>> We will find the current vma in vma_merge().
> It sounds like you are adding a search for current to vma_merger(), but
> you are removing that part in your patch, so it's odd to say this here.
>

Okay.

>> If we pass the original vma
>> to vma_merge(), the current vma is actually the original vma or NULL.
> What do you mean original vma?  The source of the anon_vma, vm_mm, etc?
> If so, the 'original' vma could be prev (shifting boundaries in case 4
> and 5 in the comments).  I think "vma that was the source of the
> arguments" would be more clear than "original vma".
>

Okay.

>> So we didn't need to find the current vma with find_vma_intersection().
>>
>> Pass vma to vma_merge(), and add a check to make sure the current vma
>> is an existing vma.
> How could it not be an existing vma?  It is dereferenced, so it exists.
> Do you mean a vma in the vma tree?
It means the current vma is NULL or not.
> I think this is all to say that we can pass through the vma to figure
> out if curr == NULL, or if it's vma directly.
>
Okay.
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   mm/mmap.c | 37 +++++++++++++++++--------------------
>>   1 file changed, 17 insertions(+), 20 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 49d25172eac8..7e00ae4f39e3 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -860,14 +860,16 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>>    *      area is returned, or the function will return NULL
>>    */
>>   static struct vm_area_struct
>> -*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>> -	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
>> -	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
>> -	   pgoff_t pgoff, struct mempolicy *policy,
>> +*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
>> +	   struct vm_area_struct *curr, unsigned long addr, unsigned long end,
>> +	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
>>   	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>>   	   struct anon_vma_name *anon_name)
>>   {
>> -	struct vm_area_struct *curr, *next, *res;
>> +	struct mm_struct *mm = curr->vm_mm;
>> +	struct anon_vma *anon_vma = curr->anon_vma;
>> +	struct file *file = curr->vm_file;
>> +	struct vm_area_struct *next = NULL, *res;
>>   	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>>   	struct vm_area_struct *anon_dup = NULL;
>>   	struct vma_prepare vp;
>> @@ -889,13 +891,12 @@ static struct vm_area_struct
>>   		return NULL;
>>   
>>   	/* Does the input range span an existing VMA? (cases 5 - 8) */
>> -	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>> +	if (prev == curr || addr != curr->vm_start || end > curr->vm_end)
>> +		curr = NULL;
> It would be nice to have comments about what cases this logic covers,
> because reverse engineering it is a pain.  And we have to do it every
> time a change occurs in the function, even when we are the ones who
> wrote the statement.  I think we can all agree that this function is
> painful, but it's improving and thanks for joining.


Okay.

>>   
>>   	if (!curr ||			/* cases 1 - 4 */
>>   	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
>> -		next = vma_lookup(mm, end);
>> -	else
>> -		next = NULL;		/* case 5 */
>> +		next = vma_lookup(mm, end); /* NULL case 5 */
> Ah, maybe put the comment about case 5 being null on a different line.
> I thought you were saying the vma_lookup() will return NULL, not that it
> was initialised as NULL above.  Change the wording to something like
> "case 5 set to NULL above" or "case 5 remains NULL".
>

Okay.

>>   
>>   	if (prev) {
>>   		vma_start = prev->vm_start;
>> @@ -919,7 +920,6 @@ static struct vm_area_struct
>>   
>>   	/* Verify some invariant that must be enforced by the caller. */
>>   	VM_WARN_ON(prev && addr <= prev->vm_start);
>> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> Why did you drop this?  I understand you moved basically all of it to an
> if statement above, but it's still true, right?  Considering the
> trickiness of the function I'd like to keep it if there's no one who
> feels strongly about it.


I don't think we need this. We move this to the front of the function, 
addr, end and curr won't be

changed until then.

>>   	VM_WARN_ON(addr >= end);
>>   
> ...
>
> To increase the chances of actually finding an issue, I would suggest
> splitting this into two patches:
>
> 1. Just passing through vma.
> 2. The logic changes to remove that find_vma_intersection() call.
Okay.
> By the way, what are the performance benefits to this change?  It's not
> without its own risks - this function has caused subtle bugs that
> persisted for several releases in the past and it'd be nice to know what
> we are gaining for the risk.


No, I just found out that the current vma is the source vma. So we don't 
need to find the current

vma with find_vma_intersection().

I think we can add some case about vma_merge() to the LTP project. It 
currently has 5 test cases

about vma, but it doesn't seem to detect the risk of vma_merge().

Link: http://linux-test-project.github.io/

>
> Thanks,
> Liam

