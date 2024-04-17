Return-Path: <linux-kernel+bounces-149266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9548A8E52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D2C2841B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2280112C819;
	Wed, 17 Apr 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tl53NRU0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312F171A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390466; cv=none; b=klJDxQ8vNLjDvK8uYZk8MrV74GLZqAfEfXiIieUe4VmKauNb7B9ZnMqxJ946eyqhSrWgbRxwFuzdKe4q3Gaj8GDb8MfteteahYS7P/s31Tmp6NhoGV86XqxpbJPaL90LzxkduTf0yfhalW6grMVupJmt40mdjGRiUGUXDv34C2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390466; c=relaxed/simple;
	bh=/1sce9yrIU5eu34X2C0OsJ/X5/pYQ4mRDqN3t9ehA7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO3Yr/0VvzLKgwC5XFzpWnE9syxrGy8bKtXYYm6KZsK/A0VYdMxspExiqA8YXwDsiwNSqdEz+ZPfMS0tBgKD3RzIPVYYf3K2I2zgUnwH1ocQ05FP590Hf6JUrjdScdTJoViJjiA7Evrjg+HuVDo5mhqIUJr1ZWAQhjhJuvQp+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tl53NRU0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713390464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwmCErE/xwbeT8z31rMz6ID2aSBqGQpPtWnNtAkGcUg=;
	b=Tl53NRU0gs41hOQpjFHBj9Ax+ih/qGemwEL5sQc1N5saqBHd8Z33tGxUILInMuubbfuDUc
	UbRQHyZNrYIK2h9eWaXCB4vB1vvQAv++ueE1m0GuTXI083uWEBBis/njQJdsLvFYmnoBYc
	JYoGHcF9OrnTHDb17PVsOA8rIWT4dYU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696--epCW743MLKPnnq3_ddOcQ-1; Wed, 17 Apr 2024 17:47:42 -0400
X-MC-Unique: -epCW743MLKPnnq3_ddOcQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343c7fa0dd5so120365f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713390461; x=1713995261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwmCErE/xwbeT8z31rMz6ID2aSBqGQpPtWnNtAkGcUg=;
        b=b58XBq2q+KZWGMuQy3k1bHbJL/IlXIYcSqM8AkHJQb3G6Dn7jiQhIlsovI2qV7E5rG
         aFkaaq+VSueXNoL4UaTctvFzEklgA3SyK1Y/JNBkmk4cKDHTesfZ0x4jREJG2tf0aFOW
         hTnKtypMMRIpIJhw9ZkhAfMrtCKFTeGuS7tJFLmHj/cA/Lxco6qDPTfTsuL6++8Oi8Ff
         SNkYwyhewYhGMSZx6rs1CUjUcz1oWZQPCQJWhX784UST6avCLT9jo42BXPQi3K1iY05D
         qMfot52BeAF8Y5DUBGCxKPwF7tVRDAdMwFFec1tFZKw5sQQm3eQCM28JQcBa9VrHEy9o
         CmyQ==
X-Gm-Message-State: AOJu0YyjAdSPzmkThSuVHy+b0Yf4AbNa8A1bdG4xCgqgrqoagHr9i5iJ
	ypIMCEo2hbTX1kc416PCUyPQsccZHwXGZWMD6FDDXiyaz1fleimDpjX+IWs20TmSQVV9UTy0+d+
	Wa4y8a7trP/btyA3VWH13LOjTa9vVEAg+jIAVHLj9WAWtdXcAU9ERbcalC9WOw3RKqNiDq7LnZF
	UPxyy/MmG29pJn3LceaQiQ5mi+X2Xpo8xLZrYH
X-Received: by 2002:a5d:4990:0:b0:347:6f8e:a61e with SMTP id r16-20020a5d4990000000b003476f8ea61emr306266wrq.25.1713390461599;
        Wed, 17 Apr 2024 14:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfkYJ21lCmvE4ptWxsKBO6HxYnhgaSS/GZt13KX4C5q9PCEiQKSZ9v1A5ID7b0yfnwg9T/wgynUMDdvYCXDIk=
X-Received: by 2002:a5d:4990:0:b0:347:6f8e:a61e with SMTP id
 r16-20020a5d4990000000b003476f8ea61emr306259wrq.25.1713390461258; Wed, 17 Apr
 2024 14:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-6-pbonzini@redhat.com>
 <ZiA-DQi52hroCSZ8@google.com> <ZiBAcfoIY3z_ARSF@google.com>
In-Reply-To: <ZiBAcfoIY3z_ARSF@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 23:47:16 +0200
Message-ID: <CABgObfaFaSGmrfX+veWf_E3kp7ghRjxmiVQRC=Bmv0Z8stWRrg@mail.gmail.com>
Subject: Re: [PATCH 5/7] KVM: x86/mmu: Introduce kvm_tdp_map_page() to
 populate guest memory
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:34=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Wed, Apr 17, 2024, Sean Christopherson wrote:
> > On Wed, Apr 17, 2024, Paolo Bonzini wrote:
> > > +   case RET_PF_EMULATE:
> > > +           return -EINVAL;
>
> Almost forgot.  EINVAL on emulation is weird.  I don't know that any retu=
rn code
> is going to be "good", but I think just about anything is better than EIN=
VAL,
> e.g. arguably this could be -EBUSY since retrying after creating a memslo=
t would
> succeed.

Then I guess -ENOENT?

Paolo


