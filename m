Return-Path: <linux-kernel+bounces-100737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42A879C87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40B61F216EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66464142657;
	Tue, 12 Mar 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ssdzl1tc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A37D406
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273682; cv=none; b=KAxiTz9rMXxvmCgXTxRF/6k1R+9tT6FAJtsy6j1nvP/0lijUTtLvYpxJpTjeYS7y0qQTmIbbRGqzFuCqp+4iIOa+j28jHzH+xe62YUxjCSaPlN5Y6vaofReUIMzEZrxxLfSjOQMcxX5VpBL99ZffPX2SuqNEKGd2n5WUmENejps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273682; c=relaxed/simple;
	bh=0a8n08WPCW1Zky1uteVZ0stAKm5h/96u1j8Uh3AQSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueyg6oOM0/vmfjt7M5+ACRNAF7snfCOoN43wnVYTKrwQqBCx0ePqq5gOn5iNmWSTY2WVSJ0ExvhDd1KzGCPkPbKOfCiHu5ZPFOpKQxeMj1Rcr8voRB8ofxM9UbWKbYwPQzd0SiisAvwtn0T+Dv7GRVRZkUHVRzhf3/7eXFJiin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ssdzl1tc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710273680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sq8Q7APw4DcVkqWc+oejv1fuFkz+jT1GPn/e6E4W0Yk=;
	b=Ssdzl1tcJyX3A5Ni+bh5+qjHz6HBHNM5e1zo3guh50e8sMRROo6pMGe0W7hb4lVouv/L7Q
	oaR3ZJRPvVvHS3CWjWMJXlTSldoW7PWoi0MzCRufktfh/mQvA8OkqN/AANS0tm6S3sRl4Y
	c18n03dEieLWj6cYsGVc1YpXN4J59ao=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-_UKF141UMwaesL5cKyYTSQ-1; Tue, 12 Mar 2024 16:01:18 -0400
X-MC-Unique: _UKF141UMwaesL5cKyYTSQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42ef59a624fso4362771cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273677; x=1710878477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq8Q7APw4DcVkqWc+oejv1fuFkz+jT1GPn/e6E4W0Yk=;
        b=cbTQnTs4CPCFwr1QHDeD/cx1aYloFcesAj8WCbuNdkxqk5bq6zOMmYYvI+7XphrEGf
         WPbc3BLK7D8Hdsd/NLybXmz9kiY2W0KIAkluA674vQFg+UUD1J3HIliuuFYYFPTTNM4j
         V40LGCksH64dNRxcLPWlruuG1sIrolG+7xfeu6rLrj1Y+LQpZAxLJ6VZpWkyX7T0AT3h
         tmikJfl+9fzN/XsrotkuhZAu8GFWuZoxSdG8nMQhxybp1iVoIUSyzvzOk2cbW0PuqhS+
         vg9swKhjcFsftJZ+Yd8Ir9XitkhgjrKclJckX8lpAMW6GDJwAO7+atwn9SopbLHHmUzY
         KFHA==
X-Forwarded-Encrypted: i=1; AJvYcCVIMPzAXbXhnUk/QEsekWKr0VQ2JqQZQ+L8TxoL4XdEHOWAyoPxyZIU7sZNdQRNdczpbNziEcn630gREAJNW8IFsyr2wEkTz0OySsxv
X-Gm-Message-State: AOJu0Yz4L1FZ95701gj68PD8G9aUUimG+qSsTyi9iW1sna7m+RekR4hF
	rmFRPYmM2qg3ag0Sa621R3z3S6iwhzLtt6W4hVC92LR/QABfi1/i92Q1m+OsjlmN4fdiIGqyu4r
	ou1vO/elicR9GZV2x8vOR4u8hVuLAqf6/cS0Rhc5lynftubDG5zi+wrbMQ3sSww==
X-Received: by 2002:a05:620a:2715:b0:788:79d3:402e with SMTP id b21-20020a05620a271500b0078879d3402emr3492044qkp.7.1710273677507;
        Tue, 12 Mar 2024 13:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFci8LJ7emFKeNaMhqM4be32i5qK2b8ngNE0xIpit/UyC+7KzN+KAk6ieS3wmiUOL3/zXkrQ==
X-Received: by 2002:a05:620a:2715:b0:788:79d3:402e with SMTP id b21-20020a05620a271500b0078879d3402emr3492030qkp.7.1710273677131;
        Tue, 12 Mar 2024 13:01:17 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a12f200b007882915ca34sm3977850qkl.40.2024.03.12.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:01:16 -0700 (PDT)
Date: Tue, 12 Mar 2024 16:01:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 00/13] mm/treewide: Remove pXd_huge() API
Message-ID: <ZfC0ioxUrCK5sX1k@x1n>
References: <20240306104147.193052-1-peterx@redhat.com>
 <f9b786bf-27d9-4e16-b8d2-2a2666d917df@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9b786bf-27d9-4e16-b8d2-2a2666d917df@csgroup.eu>

Hi, Christophe,

On Mon, Mar 11, 2024 at 09:58:47AM +0000, Christophe Leroy wrote:
> Hi Peter, and nice job you are doing in cleaning up things around _huge 
> stuff.

Thanks.  I appreciate your help along the way on Power.

> 
> One thing that might be worth looking at also at some point is the mess 
> around pmd_clear_huge() and pud_clear_huge().
> 
> I tried to clean things up with commit c742199a014d ("mm/pgtable: add 
> stubs for {pmd/pub}_{set/clear}_huge") but it was reverted because of 
> arm64 by commit d8a719059b9d ("Revert "mm/pgtable: add stubs for 
> {pmd/pub}_{set/clear}_huge"")
> 
> So now powerpc/8xx has to implement pmd_clear_huge() and 
> pud_clear_huge() allthough 8xx page hierarchy only has 2 levels.

Those are so far out of my radar, as my focus right now is still more on
hugetlbfs relevant side of things, while kernel mappings are not yet
directly involved in hugetlbfs, even though they're still huge mappings.

It's a pity to know that broke arm and got reverted, as that looks like a
good thing to clean it up if ever possible.  I tend to agree with you that
it seems for 3lvl we should define pgd_huge*() instead of pud_huge*(), so
that it looks like the only way to provide such a treewide clean API is to
properly define those APIs for aarch64, and define different pud helpers
for either 3/4 levels.  But I confess I don't think I fully digested all
the bits.

Thanks,

-- 
Peter Xu


