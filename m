Return-Path: <linux-kernel+bounces-52379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7184974F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EA11F22B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1914000;
	Mon,  5 Feb 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdfaQyjQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CA14AA8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127522; cv=none; b=FCWaGzxIJCBorTgot7+r8NrWGGjwl4pp6s6Crx50qqbvnxUmYDXmt0ZDX0QbOvmd7vP2HkOP1iWIunVPykneh8ZRrlAvijgQ8rWhE6lSzxYWsAmkxKpOnJtyBkV10klOexn4iFN8iSXRVmqQrQDbxK28urS5A6L+QxapPdtqL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127522; c=relaxed/simple;
	bh=FvTH7ce4HO+MqDVbYAWd4QDxi89r1l2keNPhU6hTSXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGRAps3MKbF3Y7jBNH2/nQho+zbDjGQBnHXvD8LGLy10FVuVZPX3EVDAzGO7Kegn6gZOPAU3KNuJ9YqQszw24aa3Ljh2dOXk8YqBkizhHse5+TDON7Eu4Qub0lliN1ljKnufzduZu6BaW51yGqGjinFXUDVNpB4PtvhAVwioXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdfaQyjQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707127519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jI4PbEn5bcHDGLMbu+52VQdT8MjOytUlCwJj0kXdfq0=;
	b=LdfaQyjQ2tjeTAD4jBwlS6F8npxJEMVmBc43zZcIl9TdKUw119fQXCUY2XZB8snp8pQ8C6
	KDwSdKrb2HFTOVvIJf49gMrvGimRoBy4+UyQtO/a9jW/HUDjqwieypKltbToOJLbcrH0HI
	KQtWOiIe2bxYgBKmgEf+0WHWHUIGniU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-vi-6BneTMeK4eK95wM457A-1; Mon, 05 Feb 2024 05:05:18 -0500
X-MC-Unique: vi-6BneTMeK4eK95wM457A-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-59a1c8f2f98so868445eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127517; x=1707732317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI4PbEn5bcHDGLMbu+52VQdT8MjOytUlCwJj0kXdfq0=;
        b=gq7ATkQgdFqGowPS8aTRDoUgVGa/upcBwKVQKBXiULd/DS5KLpQq66AlqFoaXTxl4h
         0Iw3H6OFShEq5pF5BXP7PYY4ByR4Q8Nyv4gwsL/pzX9w95FzkIIQzpuCSkm2bMP91NEx
         4xaA30rMGTKE8rURBzzmghC+WjjDmnFqXAUt639AiPFo24EMi/hQW325jefA8WmZ3SfR
         n4JDC/KrjaZUVn48/dsid2VTAZIJX5VcHxxIcatblJLK6V9xnl2s2FDEmX4OIS5bTWCF
         kH4n7ShxlfUhesWVb0QHfBzpUS1NV+rscGDSmscDLzxJK3gscMZBcIRU6M8gjMGCnw+5
         rNKQ==
X-Gm-Message-State: AOJu0YwEbqilY6J28vx4n+0oaF/r7NeyEG67YLvTAHSMH2N1F9vPatvB
	1PW1hPFu7Co/W4xctwQgpouR7utJ1C5Zl9qLcIqgYcl+Teo/1PDzHuDpsrOQHtxh59Vgbq7iFRY
	qjJyqNua9HZ0IlmEHRdORRAYRrOk6AmRfFDBa9IEoweVCcxh+Gq9R5pgc5W+iGw==
X-Received: by 2002:a05:6358:7f05:b0:178:8c44:aa8b with SMTP id p5-20020a0563587f0500b001788c44aa8bmr11609006rwn.3.1707127517662;
        Mon, 05 Feb 2024 02:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiFWsiQYdb+lDxJj9dP1Ofli+cct1oipaMqfiulBEkAd5tnxRnsurpAwy4aMkIYd4YQ/WWQQ==
X-Received: by 2002:a05:6358:7f05:b0:178:8c44:aa8b with SMTP id p5-20020a0563587f0500b001788c44aa8bmr11608992rwn.3.1707127517378;
        Mon, 05 Feb 2024 02:05:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWoh+GzuRpjT9/ChYsEcK+q66hd4k8A3L/hx8CrGu0JVnDMkwpxykxZvzLQm56gLNHyyW2QTFnYegJxMsbcIVEXxSfXKKkWFO2nSjmi1/GPommUPYVDwDhPiiERdZpNku0MKXfJPD+LZq3Huot7R9CzYHxOgBN/+jWfnVymDFMMLyV3b2ftw/Z9fst/RoIahjBqxzjK59flIllJIPhksB8/CkqDPhUVsg==
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r9-20020aa78449000000b006e050c8f22bsm230160pfn.207.2024.02.05.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:05:16 -0800 (PST)
Date: Mon, 5 Feb 2024 18:05:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore
 imbalance
Message-ID: <ZcCyzrUhXSlhKyqC@x1n>
References: <20240202064332.9403-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202064332.9403-1-shahuang@redhat.com>

Shaoqin, Sean,

Apologies for a late comment.  I'm trying to remember what I wrote..

On Fri, Feb 02, 2024 at 01:43:32AM -0500, Shaoqin Huang wrote:
> Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
> the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
> at the end of each dirty-ring test. It can cause two cases:

As a possible alternative, would it work if we simply reset all the sems
for each run?  Then we don't care about the leftovers.  E.g. sem_destroy()
at the end of run_test(), then always init to 0 at entry.

-- 
Peter Xu


