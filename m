Return-Path: <linux-kernel+bounces-139362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9A8A01E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169C4288614
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3011836DE;
	Wed, 10 Apr 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NepN2zhm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD728FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784206; cv=none; b=KCEut/S/mVflQ1NMOZFlbuHe9XWHuV+WncGKCdK2x7sdxWSZEe5Jf6divBX5bMqEFVlVlyVxW9lGR4vp763j8tqEvpvhJ/qhKUtN4Ax47g9ynCNh8QAXBtl81RqpjLePvQF0F4EIuGLDGluRQA3XSENGEkHm6cJDSjS9ADdjWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784206; c=relaxed/simple;
	bh=6gbqM1x6yfDqEibPZt4e1q4Pr5aFp6QA6R+nn1CeV60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrA3js3kHhvYjS4aihDWy9fz/U72WRNrgkMicmJDlMwe4rfGts8Gmhdke8Hy36yFAkjRGPZGQmNzb6hWDXcUVq2qFF0Ah941JrBBk45eNVJgDutjcGEeBWo0JJ1Jr5BPjINroxGMEFkFkLy1A/p4loz2Rf3WJN3J8ZN6TBJ3Uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NepN2zhm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712784203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoAvr6OirKnLqDVqGLt8HEe3e6i9iuTzmNSvvLDk/bk=;
	b=NepN2zhmvnLE48b/VbxPQLfgrR5lnshMIqjly+iN3nBoAbsBR5aJLiO+bGg1rzJe+coXMB
	gJQkPyiFs1s8+iNbI+ee5rozX1qRxU2RzjUD2dbHP3ZCTZ1riciscY3uxSGd6mKwssPsRf
	M2Tn2U6YDJjtnpHG8Ik5RF103/GMIvA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-JjR8NQ7rPsC58qe1BJ02mg-1; Wed, 10 Apr 2024 17:23:21 -0400
X-MC-Unique: JjR8NQ7rPsC58qe1BJ02mg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-434ed2e412fso8004821cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712784201; x=1713389001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoAvr6OirKnLqDVqGLt8HEe3e6i9iuTzmNSvvLDk/bk=;
        b=QJ6R7xoQoRVW/INxAU54U+vosC9CWNq0cyz0du9LnbFi4tI5vIHiwJ6TAgYNPNagKm
         HjrnrbqoZT1KvygWTVJjbANQUqRS4g9LduWHyJOAmUQY/sBNrlXhKAWhuMkFzt59LYN2
         eJrtMVq9U49dhb4cXO61jhorAR/6Na4KDbtC/v9+mgr3u7sMEybhQWEt6qKlqyVSALUF
         CjwborwVRD9ZQ8RgexhgmNmmy9wlNS5oQ0l8aA0BNIj2esbGl4dK3Wu13lFwfqnOjZD0
         +j/FqiL+eLh/HydRjNKynPoIA5RUWtgQT2PYg1SvubPMF6roZ8hj/f0DHbYVP5Aw2mZp
         c65A==
X-Gm-Message-State: AOJu0YzYUNgSvQSQaSYQNuGnIaEb5AOV4/FsdX1Xb/7kDSKhGg2QVJr9
	ofOSdgIR2GIDxegjhWvA8mV3HeUbZP72YaeyUpAr0DQXAzfMYDPFKWlI8rw++66xoA7gl7OmEjP
	wl5Udq0QiqX2j8UvShzrdVWOcvtFRZydQUUSKlngFZd2+H087WRxEaWzQ1NZpt0UU/JkLrg==
X-Received: by 2002:a05:6214:404:b0:699:eee:f0d5 with SMTP id z4-20020a056214040400b006990eeef0d5mr4040864qvx.1.1712784200897;
        Wed, 10 Apr 2024 14:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFevpA3x2tyTQdi7o2oOvWy9oK9LBRvmHXFoC0vnjFqtbj3aNfUrR7kVtPCN1eKjPHrnB8rQ==
X-Received: by 2002:a05:6214:404:b0:699:eee:f0d5 with SMTP id z4-20020a056214040400b006990eeef0d5mr4040837qvx.1.1712784200210;
        Wed, 10 Apr 2024 14:23:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e11-20020ad4442b000000b00690fd3f6e3esm28978qvt.104.2024.04.10.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:23:19 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:23:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhcDRmyYkMGPgs4F@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <Zhb2BWntckP3ZhDc@casper.infradead.org>
 <Zhb6B8UsidEEbFu3@x1n>
 <ZhcAVYVFSdX5Binc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhcAVYVFSdX5Binc@casper.infradead.org>

On Wed, Apr 10, 2024 at 10:10:45PM +0100, Matthew Wilcox wrote:
> > I can do some tests later today or tomorrow. Any suggestion you have on
> > amplifying such effect that you have concern with?
> 
> 8 socket NUMA system, 800MB text segment, 10,000 threads.  No, I'm not
> joking, that's a real customer workload.

Well, I believe you, but even with this, that's a total of 800MB memory on
a giant moster system... probably just to fault in once.

And even before we talk about that into details.. we're talking about such
giant program running acorss hundreds of cores with hundreds of MB text,
then... hasn't the program developer already considered mlockall() at the
entry of the program?  Wouldn't that greatly beneficial already with
whatever granule of locks that a future fault would take?

-- 
Peter Xu


