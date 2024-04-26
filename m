Return-Path: <linux-kernel+bounces-159691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90288B3242
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239E01F22AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CD13C9B2;
	Fri, 26 Apr 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+J07EHz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8713C9A1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119970; cv=none; b=udBFT6MIKfv5r0Eg/xINGm1IRd9Pr9KAOZhJyH1PHlU9+2uKOiHlTeRKSdSi8OWe3AxdLSLLVoHe2Z3DLYiAFhjnsOY4PoPCZKnwqY5DMZQTq9kJConjwbnD2B2dmyZ0ZRJB7fQw3ZEx7UzwPibcumkF2uR9Sl1feg7FEXAAIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119970; c=relaxed/simple;
	bh=eAcXh6MWTBgk/DBW1PztqeJpAdDnPIMufYtS8coBBF0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZetCE9lFz2HbHT3kdCzJriQY4HGQWK+eP5+ZHVgtNXUT1c8QteTKyhyDCc20RHp/ESZFd+Cp367vCxWnU4//KQKH1V8AhfGAoboyXnc+n37ixpwK+4Ow5L5GrusQhWyMPk+h2iSX38wo+FdAFGcFMnGOX2j2kayk4AGF0RDaRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+J07EHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714119968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZdkIjJq2xIRc8PPw+YxjD8Fs9hCG5DMG8X/r9X3LUVs=;
	b=c+J07EHzfqplrdO3osSVmzN5Zh/h728jeLX5xgPAODgahhLMnvd6PPQ0Lb5s8AAzwRVxMg
	jPsRiBdW2r7mH8f8TCiQ1nv0DrVyRph7IDpzmGolvpfaTwKI1shh2B4DPSU1mkuu/Sg70Z
	DtRh0mXo92Momca79BjuH0qFsLGSteY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-AO3CZifzNVS3y1xLXwkVgg-1; Fri, 26 Apr 2024 04:26:06 -0400
X-MC-Unique: AO3CZifzNVS3y1xLXwkVgg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3455cbdea2cso1203721f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119965; x=1714724765;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZdkIjJq2xIRc8PPw+YxjD8Fs9hCG5DMG8X/r9X3LUVs=;
        b=XV8Ez5c2VAuMsj0unk09Wg60BdzvpNuXBgiC4m9gA6dbCkAJ+4jnebxxXeeA/jcQtO
         mG+zEBUZFb22TvVpvqnJqNlsMjNBNpWQVVjFk5Xgno8SNBMC/P+wvkmCaGdTPbW50nCV
         oXo1/venvMi2uELSgSJBhSmdVZTnpG0ov444NzPsTOunLXFV5mjZACXXKBBkeZCwJ4eY
         GbaNlISR64KTgbANH5jWmyyKCbvRZGwRQouUHE+8sLsUyL4n4EUC023f5mZ97mZivYDN
         fjOfY89BEu6eRV/VeizpNqU8hcAVuJ/KZrPNVH3K1gRLsF/WLzEmv18N+iyB1gJFPtbk
         /5og==
X-Forwarded-Encrypted: i=1; AJvYcCVXwPKf09y7Z8FeIm75F7O+DDeqbJaOvl/SNgHFxxiDfjczTcoafyXf31lHA4RO4tc76apOrdAJjHaFPpf24znY3BRY0GJ+vA1ML55d
X-Gm-Message-State: AOJu0Yy3g3UG8hv5SbwmGYLSlQbqXEqXQGivrfHIm0WGkJz6/POK9nCv
	6BnF7F9D9jyw+9MOTJs+4B25iGObt9ozF3LU8Gv1rgwn52VFD7wM95MQWXxRya4GERIvr8DQDqn
	Tnzn4fyF3TAJfcTlwl4yBk21wxnUjyXdWXJmBNi7EvNjvf8d5vq5xtDPIEGoQcg==
X-Received: by 2002:adf:fc4b:0:b0:346:46cf:9f78 with SMTP id e11-20020adffc4b000000b0034646cf9f78mr3978222wrs.26.1714119964917;
        Fri, 26 Apr 2024 01:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH926cHiwi9wnqEh8e6FeTm/M5kLf5sY9GO+FxYRi2XWj6CJghFA9/LsXSFr0/4+Ga0FiypmQ==
X-Received: by 2002:adf:fc4b:0:b0:346:46cf:9f78 with SMTP id e11-20020adffc4b000000b0034646cf9f78mr3978196wrs.26.1714119964458;
        Fri, 26 Apr 2024 01:26:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0041a0f3d92c7sm20392506wmq.2.2024.04.26.01.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 01:26:04 -0700 (PDT)
Message-ID: <7c233278-1006-4449-81b2-d473b18a66ca@redhat.com>
Date: Fri, 26 Apr 2024 10:26:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
From: David Hildenbrand <david@redhat.com>
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240425211136.486184-1-zi.yan@sent.com>
 <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> @@ -1553,9 +1557,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>                    * page of the folio is unmapped and at least one page
>                    * is still mapped.
>                    */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
> +                   list_empty(&folio->_deferred_list) && partially_mapped)
> +                       deferred_split_folio(folio);

And now I realize that we can then even drop the folio_test_large(folio) 
check here!

-- 
Cheers,

David / dhildenb


