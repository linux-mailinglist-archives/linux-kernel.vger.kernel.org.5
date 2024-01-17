Return-Path: <linux-kernel+bounces-28423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166D82FE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7493F28C5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035EA290E;
	Wed, 17 Jan 2024 01:23:37 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A2B4217D9;
	Wed, 17 Jan 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705454616; cv=none; b=iWrXhCoayIaelFngiU8wFdOcLh3hOjF5aPjCqz0lzES6aCCSsrK7dyCsPsDQQXVHMmupeVKrIbKxr6w/t4KtGtLz6+iuTqwW0P/H7I6Rgg433lBpZu6ReyU8jGROoX8FwWIbDjvz+PO+PxPgun3Ma97i3eThBrs6FGimt+GcqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705454616; c=relaxed/simple;
	bh=Vmx397rnKN9dTE4JxoTDlJ1QfqShVG2owgUaAVsdmhs=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:X-MD-Sfrom:X-MD-SrcIP:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=E+Nl+GpLjT71YvWgKbeEXu4PFAoKbAz6MDbKPsqph1485hzr59421/soKx38Jpg3mJ3VEjqo2/+p4piJbLF3KzFXBfcHwQpMZfF4Pr3nXZGS22u3K9C9kQtavP8Dx0g6yZVLb9f8acCV2VrB48Ga1u3BBnHQo07/7R+I4D1hjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id CA73D607F2347;
	Wed, 17 Jan 2024 09:23:02 +0800 (CST)
Message-ID: <1847a959-b8a1-29e9-c87e-036709586d1a@nfschina.com>
Date: Wed, 17 Jan 2024 09:23:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ocfs2: remove useless code in ocfs2_try_to_merge_extent
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <20240116120926.3bfa87253bf5af5090bd78bd@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/17 04:09, Andrew Morton wrote:
> On Fri, 12 Jan 2024 12:26:40 +0800 Su Hui <suhui@nfschina.com> wrote:
>
>> Clang static checker warning: Value stored to 'rec' is never read.
>> Remove this useless code to silent this warning.
>>
>> --- a/fs/ocfs2/alloc.c
>> +++ b/fs/ocfs2/alloc.c
>> @@ -3743,8 +3743,6 @@ static int ocfs2_try_to_merge_extent(handle_t *handle,
>>   			goto out;
>>   		}
>>   
>> -		rec = &el->l_recs[split_index];
>> -
>>   		/*
>>   		 * Note that we don't pass split_rec here on purpose -
>>   		 * we've merged it into the rec already.
> Then:
>
> 		ret = ocfs2_merge_rec_left(path, handle, et, rec,
> 					   dealloc, split_index);
>
> and ocfs2_merge_rec_left() almost immediately dereferences `rec'.
>
> So this looks quite wrong to me.
>
Oh, really sorry for the noise.
This patch is wrong.

Su Hui


