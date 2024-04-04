Return-Path: <linux-kernel+bounces-132086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF9898F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981ACB25C25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C260B134CF8;
	Thu,  4 Apr 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFmmIKZW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44372134435
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261766; cv=none; b=DUg6fmzastPwAKlBrdRHovSjCj1Kg+pEfL7fJxZIdL9NgxPm0DZv441pnVfQF1GmgedFjdqQK+VHfsJDEd4UPNZ3B5ebDTNxKI/E+yXfU3MCnSaEbmTAHm+lISl0NI3P7+C8sbJsqzLcn1yH4l6rN2Y1quKVzKWOYQUQLViY/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261766; c=relaxed/simple;
	bh=floD30aBPyvO8hNl2E4E96lwKDi9VqAaeDk0vZxQj3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUX3+CXGMb61Izi2FgAmma/0KCrjxYZiDRR7S/cGrXqmU7YIGX5CZodnDDwS25hBStiX3e0ZiuJ/LpGzWKuZlUdggRp/SVxzRgcTjAynpMJW8Ej/Mot8u/zKwdHj0pufPjKJ9Z6qQQye9dvvQu9z3z9ZAOaOI8a+3TFd3zif2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFmmIKZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712261764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RdASCm5rInkIsrW4zTlCbNwubozCW4fyVxPIqvzCcr0=;
	b=OFmmIKZW1TsXAF/6+WoUqjSnGXYbUetAhMA97Xb15xa73gzXE94oHyTmpxkdKtpWc7DQMF
	nIAwEZ2q5mhrOFM2mNtFREA7PgIar6MNan4VotIDhNbIMA4w72m7Mq089j4fX8SVG28/po
	gbzy1PFRtBm4EZx0u0TBxq8c2iyjuNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-KEHpzKNbOValpjzS9SGMSQ-1; Thu, 04 Apr 2024 16:16:00 -0400
X-MC-Unique: KEHpzKNbOValpjzS9SGMSQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4162b93067dso3800875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261759; x=1712866559;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdASCm5rInkIsrW4zTlCbNwubozCW4fyVxPIqvzCcr0=;
        b=aST+AHTcdSO1kTaLLTSTMth/K5XHvkdDSZhzSEgDKNJruFBrri0KSQew0Yg6RMhWYV
         zSJRaZPOsLI4vNNo1ZSkn+r9ZmOrmFlYqWA3yM2/GN3N2EXibuw/XJptUtgvp4M3oa/+
         RArPTm0m8NjxCiZukzzeUjt+0gPr4zh7lgh4UikcKJT5HXNx3cfUW031x2uRPpAXIZWo
         u+Bu/T+rDgVfA3Vi+TmJ7vLMIpBzlWwiX0qhqb6TYPowadCaVmOvVdOF8VjYtNfAEQdr
         Nd2S5KFlOVZQnECDb8TBn3gm4ELUlwKUVI3q6YboL3dS15rAEMJ1sqnkwO8AvNUMTX/m
         T3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXGXfqcU3vCbws3RxsWp+WZ60K8lqR1BqZDfQnZmlbIzJ63RVFcbo/CxSZymAM1QRISTNQ2EbSmY5uXsxZ0ClQlEifBwMmWHtdzj+3/
X-Gm-Message-State: AOJu0YwObmPyjDK5DIIxc72f4Dflttyx1TKIHwqkjBGl0WwdTZ6TWAVO
	CQZ8YINVTQ6N/rNmMIfwyyavDbX0UddF0p0Ac4mci47lOyxJLH4qRSgm1AjIkzTFJQfg0s5g8E0
	66TAC3G6UYJhnwb9dHI9z3fu82lv08zrEfo5EuGMsUHPRqP5xkUdoJnRFh+PnvA==
X-Received: by 2002:a05:600c:35d5:b0:415:6dae:78a3 with SMTP id r21-20020a05600c35d500b004156dae78a3mr2757317wmq.3.1712261759718;
        Thu, 04 Apr 2024 13:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhiSB24fjo6wao9YzES4fu7qA37g9glD3mytpJ4QoUd8Awck6W+sIJ0ncWaObtTWn4sigcqg==
X-Received: by 2002:a05:600c:35d5:b0:415:6dae:78a3 with SMTP id r21-20020a05600c35d500b004156dae78a3mr2757294wmq.3.1712261759276;
        Thu, 04 Apr 2024 13:15:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b004162c25d54bsm1673474wmo.3.2024.04.04.13.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:15:58 -0700 (PDT)
Message-ID: <adce9a6f-fccf-4c9b-8ca3-3140a6a3d326@redhat.com>
Date: Thu, 4 Apr 2024 22:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
To: Suren Baghdasaryan <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com,
 aarcange@redhat.com, peterx@redhat.com, zhengqi.arch@bytedance.com,
 kaleshsingh@google.com, ngeoffray@google.com
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org>
 <CAJuCfpHvb5Jt6J1P9aHVdRWYUHmBL1edfp7QHn=jF88gJRD7RA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpHvb5Jt6J1P9aHVdRWYUHmBL1edfp7QHn=jF88gJRD7RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.04.24 22:07, Suren Baghdasaryan wrote:
> On Thu, Apr 4, 2024 at 10:21 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
>>> -             folio_move_anon_rmap(src_folio, dst_vma);
>>> -             WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
>>> -
>>>                src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
>>>                /* Folio got pinned from under us. Put it back and fail the move. */
>>>                if (folio_maybe_dma_pinned(src_folio)) {
>>> @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
>>>                        goto unlock_ptls;
>>>                }
>>>
>>> +             folio_move_anon_rmap(src_folio, dst_vma);
>>> +             WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
>>> +
>>
>> This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
>> we need to use WRITE_ONCE?  Who's looking at folio->index without
>> holding the folio lock?
> 
> Indeed that seems to be unnecessary here. Both here and in
> move_present_pte() we are holding folio lock while moving the page. I
> must have just blindly copied that from Andrea's original patch [1].

Agreed, I don't think it is required for ->index. (I also don't spot any 
corresponding READ_ONCE)

-- 
Cheers,

David / dhildenb


