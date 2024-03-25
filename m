Return-Path: <linux-kernel+bounces-117023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BC88A641
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252FE1C3C87A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF47D09F;
	Mon, 25 Mar 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJuj/tSl"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AB6FE05
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370410; cv=none; b=rymA8vWkp4Rx13PBKqkUfRVLuDZkcoognKUx4pc2jkwABwyM3/Vt+JaobWeCc3+iomFcf3+Fv3kPAgYZi2zUXxE0voPp7xfLwGfh3OPG4ZYBg2zax2wsFI+qDEvW/q1Q6T8REJ00HE9fpfXvW0UIaGGm68jh359E44FLwugDANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370410; c=relaxed/simple;
	bh=QW4LBjhW0uNwP+1PboSbSNzA0wriLnh+S83+CUURTbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh15KYoJg1VgttDtLziKiRAMZibj2jmgsSoxt++VJ/e6RpA2l9GfDSW1Gi9UHW5hjPVDUt+N+P1Hz4goGky6Au7G6a4TNTUCxyFGRttACrz0/2tRXvUkx+AZqcLPFy17z5ppu8zwH0ITYt1uxIicasjeq5mtCtpz7bzTW0dzz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJuj/tSl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so853972b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711370408; x=1711975208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XB45BiVabHfmUkxlJuWWQAmoKjnTiH/0tlm2fLhu3cg=;
        b=RJuj/tSlBqGHPZU1/WoEdjNHXIt6OfNY+xx4bcyefptG8TuufMDeH7KvtkKMBHC2fd
         4XbL0E+g9N93f8UuVTN6BTNyvtbLApafuRWIfrvX25PH4wIacqLwnswZTLYAGSdisdLV
         6X5wY1MfRwnAoLENlEL96yVsaVH27QoOyjy/oBulnzAFPqGW32t1k/zNmxEmqeyDn81F
         OU6TuO6zvkCnENCmt+4SwThuqkrnQhnBU1Uxt/6XRmrgzq48Gt+/NHoZc+795DjpwHLq
         AEO6drOYAVARw/MHmSaa4pJUV7tYZFPjN0wCooMN8OKgFnvh7ZiWR2m0l1UVx8WdlLA8
         T4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711370408; x=1711975208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB45BiVabHfmUkxlJuWWQAmoKjnTiH/0tlm2fLhu3cg=;
        b=shscN0guRbYTwHv+HYKor/wzDkOIMsMc+UitwQWs4XcRFsTvUt4uZyt9L4vh4rqM4/
         cGjpDVFgtydlfc64+H6BhxJV3oHE+F+653WvpS3OdY2jGiQlFRTGgffgp/rNPkKZWfy5
         NyrOHc61VTO41cz3CbvkXnJxvKYbn1mh+UM8sWtXQINuOZISVa5tTHR1eKFxpAYk13mZ
         5Pcqcy2L7rfZw4cXg9Ryq+u9kEObJAUTOn/oKpHeZvqevQWkG8T3L/SJKwihOQrsJfXa
         ym06Gw3nmtiOraVSwvlTR1rSzrtQkpl++y4p1vrNK26NE9H8dPbdu1wJKDB/dRh6UM6L
         fklg==
X-Forwarded-Encrypted: i=1; AJvYcCWdXzsJkCdxYWGWBGDNdu0Fmw+9f2eZ5FxyIDfhwgGR/Jq6lxkcn1/O7+7JqTbf882SuOduCIskHJp//6VAbCi43VFPLBXPnBVMopD4
X-Gm-Message-State: AOJu0YyhCeFH32/wSU2Kai/mr+9OHseB07a1TTRlFsr9Hr/Cb401CqAj
	nfI73zhAuVH/0KvIBZuO6lQrFn+uF9VZen5F/pLI02WYDz8F3s7y
X-Google-Smtp-Source: AGHT+IFHWYllbJcf/ZdUOUZMtQeFd025rrAYdRDS/0Bn7CQz5YVRd3TYearEEFInBA4aieBgpoF+rQ==
X-Received: by 2002:a05:6a00:1ad3:b0:6ea:ad5e:54fa with SMTP id f19-20020a056a001ad300b006eaad5e54famr3073383pfv.13.1711370407804;
        Mon, 25 Mar 2024 05:40:07 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b006ea944bb4a8sm4194274pfb.59.2024.03.25.05.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:40:07 -0700 (PDT)
Message-ID: <efd4c141-8c09-4787-b820-aecf2ad02ef5@gmail.com>
Date: Mon, 25 Mar 2024 20:40:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] mm/ksm: use folio_set_stable_node in
 try_to_merge_one_page
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>, david@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240322083703.232364-1-alexs@kernel.org>
 <20240322083703.232364-14-alexs@kernel.org>
 <Zf5OvWFiYjs_ZCF2@casper.infradead.org>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <Zf5OvWFiYjs_ZCF2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/24 11:38 AM, Matthew Wilcox wrote:
> On Fri, Mar 22, 2024 at 04:37:00PM +0800, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> Only single page could be reached where we set stable node after write
>> protect, so use folio converted func to replace page's.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> ---
>>  mm/ksm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 15a78a9bab59..d7c4cc4a0cc1 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1518,7 +1518,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>>  			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
>>  			 * stable_tree_insert() will update stable_node.
>>  			 */
>> -			set_page_stable_node(page, NULL);
>> +			folio_set_stable_node(page_folio(page), NULL);
>>  			mark_page_accessed(page);
> 
> I'd rather you did a conversion of try_to_merge_one_page() instead of
> just this.  It'll be a fun one because you'll have to recalculate the
> folio after calling split_huge_page().

Hi Willy,

Definitely right, the merge series funcs need more careful changes. :)
I'd like to left them for late changes.

Thanks

