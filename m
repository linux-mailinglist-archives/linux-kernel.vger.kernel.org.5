Return-Path: <linux-kernel+bounces-111854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941AE8871C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63E91C20D23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31075FDCB;
	Fri, 22 Mar 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ5rQj1u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D165FDC2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127492; cv=none; b=IL5s4fUYW93LmdCQOCO66HaPUQU3jN83TxplkrgbZgScjAkohViIO3Qx2/iLi5pRDaASdEDL4k7vm62wEaFLlsZBS3K57x4X4i6roKL1oQff9HjKcBp97r/3lFe/GlGRXNXbmUo4xZ+HsT9zdqri5JuGRhNtW8sEUTjCspsl/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127492; c=relaxed/simple;
	bh=iHGBCdeUOleh6Llj4yeDtJASF1MdUQjxFeqCwgqoxL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnPPC5+44pwPIAka77VJMmwxqSzk6D0GUN1Kp8dFbEhZSqKyAucj0sW9aUter5fyeoNaqj+WA8o2sx5UFcvusXlRW2vQfT+vf36s7QasE/Qz2Alx62g7D71WTliunfVhzDyNdHF6DdxrEzJ60s9rLG3oPvpNEzqh95uRJQo+wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJ5rQj1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711127489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fQrPX4jnRbQz0Z6BlUHLzLvPIi2xdS7lfq8y2PCMUC4=;
	b=OJ5rQj1unOg798Qn154sOWL2HEAITdl+6LkgY/4jjB1uI2NQKp/KerjNZeO+J7edg1U/Gp
	t0lbOJFjnpeh1Wnw6DufvhO6i6dtSdpkUPxTIo5F5SLPyTM8uq9OMgS4Da1IWf6dC9ZY4K
	vUAKAXbIyv/hksD97pYP16MgCjKhSDk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-hI9L4X79OVS8PapKAvI5Zw-1; Fri, 22 Mar 2024 13:11:27 -0400
X-MC-Unique: hI9L4X79OVS8PapKAvI5Zw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430b673a96eso26962281cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127487; x=1711732287;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQrPX4jnRbQz0Z6BlUHLzLvPIi2xdS7lfq8y2PCMUC4=;
        b=Gf4anWHMbhrmIt79ECDtfjqEg0l2VQJowg6FiMYUrCJZqrFY1HDL1y33kZ9cQ9KblJ
         LYZH8OZ/xFwzuVCc4kzs/Raibvbz0OSq4EOE83ozOJ/eqTHhjxQEhwZQrC17I958hFMj
         zYsGGRIdWc6VU/EjVi8+o/XyZX5BFemzwXWkgnY/hvtzyCPg57oLR0S93Y26Ah4nvV0C
         k0xwc1cWD8zFvzwjSulrXgiR730DQCNknkPH9HmXiclaJva23TZQecF99iZ45c07L8NQ
         iEE9VQNBu6TeXHmgnTWhdJpOCtb8wk7lWJ8b9DMdX4oaKowG4ZVuzp0uYr6dw9U19m8X
         VY5g==
X-Forwarded-Encrypted: i=1; AJvYcCXI287Mk7tJcmugRzVEckgdS/wXAnO2ZXwfrw0whEblmm8drn6/pvEDZOboMeypxMnQcwoc5lIyZnwSVk6qa1JEyd0FSuXZe6IpumlS
X-Gm-Message-State: AOJu0YyGUVYICjlSvs3h54RVPVnhDhB6YyJQ+t/5PIDoxKQz6RwYZAfb
	1WvXZBNIcdpSu43aqrvE99c6yLGKwRHskfG/CZkKlEQOIZ4JyStJK2o9IlbtCnKpsq0nAvepYYf
	dMBwqoGl0SmynZG86rlm39EM9rrGM/eGPt//g+TNYlSIvON17xsmHbuqLqXrvEpdoaxXu0A==
X-Received: by 2002:a05:622a:14d1:b0:431:1b54:3afe with SMTP id u17-20020a05622a14d100b004311b543afemr125409qtx.65.1711127487420;
        Fri, 22 Mar 2024 10:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL2LbruKrw4VF89eVByALYBnTU832KwvtAtlJZOueQHInjOJrOaE6ziWxOyxTH6FI4kP3Wfw==
X-Received: by 2002:a05:622a:14d1:b0:431:1b54:3afe with SMTP id u17-20020a05622a14d100b004311b543afemr125382qtx.65.1711127487085;
        Fri, 22 Mar 2024 10:11:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id z14-20020a05622a124e00b00430b423f06csm1037035qtx.86.2024.03.22.10.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 10:11:26 -0700 (PDT)
Message-ID: <df87f782-185f-40f7-8745-ab09fe144189@redhat.com>
Date: Fri, 22 Mar 2024 18:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] mm/ksm: use folio in stable_node_dup
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240322083703.232364-1-alexs@kernel.org>
 <20240322083703.232364-6-alexs@kernel.org>
 <Zf2qcH-bDEgLAP7d@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zf2qcH-bDEgLAP7d@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.03.24 16:57, Matthew Wilcox wrote:
> On Fri, Mar 22, 2024 at 04:36:52PM +0800, alexs@kernel.org wrote:
>> -static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
>> -				    struct ksm_stable_node **_stable_node,
>> -				    struct rb_root *root,
>> -				    bool prune_stale_stable_nodes)
>> +static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
>> +			     struct ksm_stable_node **_stable_node,
>> +			     struct rb_root *root,
>> +			     bool prune_stale_stable_nodes)
> 
> Do we really have to go through this void * stage?
> 
> Also, please stop reindenting the arguments.  I tend to just switch to
> two tabs, but lining them up with the opening bracket leads to extra
> churn.  Either leave them alone for the entire series or switch _once_.

I wish the coding style would at least recommend something -- I know, 
different subsystems/files have their own rules. Nowadays, I prefer 2 
tabs as well.

-- 
Cheers,

David / dhildenb


