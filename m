Return-Path: <linux-kernel+bounces-127762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5777895096
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B641F2492C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076CD5D74E;
	Tue,  2 Apr 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGV+36fn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2E60269
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054609; cv=none; b=qOA1frWUAWSsJc4kY8zk3oNwlYfdX7D5ZCFX+Iq3ATG1wLGmU37iqkZ/HSXyH/qF3uBY4M8i1ipBgVM4EWlER53HBeZf3SXfs/pkMrOiZC/XUYcC28bHfzteJKRK1LVN6/PlJoTVVGPwNONqxAnS1SuU4R/MHcNeLuaaL4sDgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054609; c=relaxed/simple;
	bh=fKRSn6OTpYTwDiXglUiSZaV70EbN2npGP5nKTGVQyC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYJJhptbKJnIkMBBYjA3n1HyyGLY7pgS35apdh2E8F1BflPlIP/MQgBvHfqp15nyMvVNDTJkmus8zuuk4b5xAbTF8KVGaADkfvAHrevoRKx9fH6bwnmIPraavwi1mK+ZEa3hFxIWaYm4+AuLyX+yEMSshTO0lMHEm4SYCpJJlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGV+36fn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712054605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/zBpNACLXUrqP92by+X1aP2sLL3r5R2IUOWqrDEJp1g=;
	b=UGV+36fn/BJEAmARLTJxrP0fLgX6v9keWStHUpAiPVuMeqpGG9Udwon/ze4DTvvmMQr4nb
	5Jg9HAIOfqscsrznh82O3P2hhhpUXgFvx39hSu9RioECPJ/ujX7HZITTXYSSt2fIetFi7h
	/4LqF9fCi0wjJLTgI/izFS74idGchtI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-sCNBYJkbObyARRiLONF5bw-1; Tue, 02 Apr 2024 06:43:24 -0400
X-MC-Unique: sCNBYJkbObyARRiLONF5bw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed483c2ecso2507860f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054603; x=1712659403;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/zBpNACLXUrqP92by+X1aP2sLL3r5R2IUOWqrDEJp1g=;
        b=SAJrWVxbsJ4kQ8A4skNYbXnEOOq5W+C3I1Y1u9I2OgZmdu1XUSYvA9W1XW1DXlO3kw
         3C7zky7rHVzC7+I6ACASIX1tK7ADB9Mj6I6cRFiqP7l6JRw3JExQEbBiJlwhmDXCxwkb
         s9NFLdbnxssjwaPUfNSqU6eV5Vgkenq/hEmBBRhfDZF79i81lhvf+7HLhea0frL9Utwd
         SqoEWXBi7V+DYbcUGDW01QqYzFPDpk3WK7HQyeixYPDW+1f/QqAszjyJoo8rsDHW+k9B
         k4J8o567n4L1pUrJu3cJ49mVaIeIObh96wujPGkXGyJSBqDF5Vf5fCraNFmZSUqn8Hzj
         nRkQ==
X-Gm-Message-State: AOJu0YwGxQCyTuE5CdHR5JHmVQvwuZVdeEGIygjH9tq5yvD6pYfktz6c
	j2T07HSpWh6qCoj9kPkYScAtfJAOKtLHyzYn/3Ko0oqr983ggbJAIYpZPMq/vS+EFRVfIF2qapj
	yr5vZOnvnbnJ40l1xOEFNtIGSsNPmpG/ZFhOLpew5F7hIlvJZCInDOqxb8zJoNw==
X-Received: by 2002:a05:6000:a88:b0:341:bff9:2e4f with SMTP id dh8-20020a0560000a8800b00341bff92e4fmr8755269wrb.44.1712054603366;
        Tue, 02 Apr 2024 03:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMjSHZUX7iIjKevMw2JKGtsNyP/yuvCusbIVuPhi0qT6T+AUonf5RaUivG/+/DpAKEAfumkg==
X-Received: by 2002:a05:6000:a88:b0:341:bff9:2e4f with SMTP id dh8-20020a0560000a8800b00341bff92e4fmr8755250wrb.44.1712054602910;
        Tue, 02 Apr 2024 03:43:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c732:e600:4982:2903:710f:f20a? (p200300cbc732e60049822903710ff20a.dip0.t-ipconnect.de. [2003:cb:c732:e600:4982:2903:710f:f20a])
        by smtp.gmail.com with ESMTPSA id a9-20020a056000050900b00341d7596ec0sm13783274wrf.15.2024.04.02.03.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 03:43:22 -0700 (PDT)
Message-ID: <8118eabf-de9c-41a7-9892-3a1a5bd2071c@redhat.com>
Date: Tue, 2 Apr 2024 12:43:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: init_mlocked_on_free_v3
To: York Jasper Niebuhr <yjnworkstation@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org
References: <20240329145605.149917-1-yjnworkstation@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240329145605.149917-1-yjnworkstation@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.03.24 15:56, York Jasper Niebuhr wrote:
> Implements the "init_mlocked_on_free" boot option. When this boot option
> is enabled, any mlock'ed pages are zeroed on free. If
> the pages are munlock'ed beforehand, no initialization takes place.
> This boot option is meant to combat the performance hit of
> "init_on_free" as reported in commit 6471384af2a6 ("mm: security:
> introduce init_on_alloc=1 and init_on_free=1 boot options"). With
> "init_mlocked_on_free=1" only relevant data is freed while everything
> else is left untouched by the kernel. Correspondingly, this patch
> introduces no performance hit for unmapping non-mlock'ed memory. The
> unmapping overhead for purely mlocked memory was measured to be
> approximately 13%. Realistically, most systems mlock only a fraction of
> the total memory so the real-world system overhead should be close to
> zero.
> 
> Optimally, userspace programs clear any key material or other
> confidential memory before exit and munlock the according memory
> regions. If a program crashes, userspace key managers fail to do this
> job. Accordingly, no munlock operations are performed so the data is
> caught and zeroed by the kernel. Should the program not crash, all
> memory will ideally be munlocked so no overhead is caused.
> 
> CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON can be set to enable
> "init_mlocked_on_free" by default.
> 
> Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>

I'm not convinced that this is the right approach.

You seem to be focused on "don't leak secrets stored in user space 
somewhere else". Well, and assuming that no other users on such systems 
use mlock() for a different purpose where the additional clearing will 
just be overhead.

In general, I'm not a fan of any such kernel cmdline options. Really, we 
want to handle memory that stores secrets always in a sane way.

Note that in the meantime, we do have secretmem for that purpose, which 
primary use case -- in contrast to mlock -- is to store secrets.

I now that "teach user space to use secretmem" is not a good answer, but 
further emphasizing "mlock means storing secrets" feels wrong.

Also note that your patch won't handle all cases: mlocked folios can be 
migrated in memory. But there is no such code that handles freeing of 
the source page during migration, so you could still leak memory at 
least there ...

(I was briefly thinking about a VMA option, independent of mlock, to 
achieve that. But likely just using secretmem might be the better 
long-term approach)

-- 
Cheers,

David / dhildenb


