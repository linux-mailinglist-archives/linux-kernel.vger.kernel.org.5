Return-Path: <linux-kernel+bounces-128102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E250895629
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD912877CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0D184FA5;
	Tue,  2 Apr 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9yadMsR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0D8613B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066732; cv=none; b=pd2aepahu3c07eM7uBXlGCvXaN7gyJLReypVEyp24EJIiY7pMX3vwS1JDByRceU0CSyj7MTCtCVLqB77pRx4FsmOn4MUTh7Vb/Q3jiDJ4vx0t/bNZJG/8+4ym4adTLxPu6J53MxrtXOr++lAkXvNrpvJN92zFQwXiSmhwQQFlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066732; c=relaxed/simple;
	bh=VK5h9//LgdEynnQqdnd0KvOvHtDWdqs7iaya5VEtpts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiM6jXX8aet0maTomgeYQftxOJa8QUohcJ7FxzD674UvewdU4BnxY6m6M5f+gGrwOTjdSebcI8Orx4XjpdtPfDr9vX7PtVKKoiKgHZy6qyd29W3VTfZYnDezgDws2y9RMH479+VdKj9U5YLWoZztUiJkT1sh17GLJlYeolaLjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9yadMsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712066728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ANpAMc1eszGl4nFAW226PDhs3q15NgxFXUklMcpDRo=;
	b=V9yadMsRmEYZEszVBmnAgCOMP31T0bVLTICAi3syeNS1B58wdU6dFt9inH91hJXE5OfZ4m
	9QUHoTEELRZ7O0xLZnHLZ5CyQEpCb9f8MN4Ijo145KZm9H25wd8AS3Q8wUTyu2Dwshh6rB
	69zC7N6oCa5NKj38bJgotM0ifCGLKOw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-4fadI4NSP9OC_8i6njQkNw-1; Tue, 02 Apr 2024 10:05:27 -0400
X-MC-Unique: 4fadI4NSP9OC_8i6njQkNw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e6864c33e0so6321756a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066726; x=1712671526;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ANpAMc1eszGl4nFAW226PDhs3q15NgxFXUklMcpDRo=;
        b=WhU/HY4cGGDq8P4+hECL19oXUnfaDJhjM3oWZxmmVHdKfxZpkmXARoQEjnXwKCaL1l
         lSKV0uRt2mv/isRW7wsIzDnigU4SKK69I2FHYYFEfNOah8tH3E3n51UbQmdbsGWnrEbT
         NHgeZBaDGdnMjl4onsTiijqj1+wLwLpe8n+SaQuVPwvIMrDZ/SCYCgzMBMet34gbfwY9
         zuhkGr5seEyxOe4tJ4SG0Xc0w7j0Rusy5Ysp4o+5UxrWj+zf35lSltvTvNRdjc7duf5D
         w5/ShOdonaabHYysQSxnbM84k056UWPGKLfa5Zit3SE8i2pb9l2v63T9LCUoOaqKX7OB
         cqAA==
X-Gm-Message-State: AOJu0Yxx3EXQIWeWORG6vQ5k+yEAS7EjUiOnSyZ0HpAexE47fcCQCQZd
	mmVUzuZbl9Qf5jeOG35TLiXZNwS2qz7fjT/MNFwk1YuduC9Bp54yI27oO/Vy+LRRix8HEkX5ytb
	1QxUTLnKFcucEx7wcMco0IGWzZKYuNnhtUO0eV6UDVn5Hyl+tqQo5/4oBz4cKWQ==
X-Received: by 2002:a05:6830:1305:b0:6e6:ce61:3ee3 with SMTP id p5-20020a056830130500b006e6ce613ee3mr13673311otq.18.1712066726227;
        Tue, 02 Apr 2024 07:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0e3ogVp+zxvLlEV65ZPleONdb8lHys6Pido4t8auh70NKQQ3xCmDKjJbrjHW656l+UKDDdQ==
X-Received: by 2002:a05:6830:1305:b0:6e6:ce61:3ee3 with SMTP id p5-20020a056830130500b006e6ce613ee3mr13673274otq.18.1712066725869;
        Tue, 02 Apr 2024 07:05:25 -0700 (PDT)
Received: from starship.lan ([173.34.154.202])
        by smtp.gmail.com with ESMTPSA id gf15-20020a056214250f00b00691873a7748sm5545187qvb.128.2024.04.02.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:05:25 -0700 (PDT)
Message-ID: <207d6598c8b74161efc38bd18b476ca8626786b1.camel@redhat.com>
Subject: Re: [PATCH] KVM: selftests: fix max_guest_memory_test with more
 that 256 vCPUs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, Shuah
 Khan <shuah@kernel.org>
Date: Tue, 02 Apr 2024 10:05:24 -0400
In-Reply-To: <20240315143507.102629-1-mlevitsk@redhat.com>
References: <20240315143507.102629-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-03-15 at 10:35 -0400, Maxim Levitsky wrote:
> max_guest_memory_test uses ucalls to sync with the host, but
> it also resets the guest RIP back to its initial value in between
> tests stages.
> 
> This makes the guest never reach the code which frees the ucall struct
> and since a fixed pool of 512 ucall structs is used, the test starts
> to fail when more that 256 vCPUs are used.
> 
> Fix that by replacing the manual register reset with a loop in
> the guest code.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  .../testing/selftests/kvm/max_guest_memory_test.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
> index 6628dc4dda89f3c..1a6da7389bf1f5b 100644
> --- a/tools/testing/selftests/kvm/max_guest_memory_test.c
> +++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
> @@ -22,10 +22,11 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
>  {
>  	uint64_t gpa;
>  
> -	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
> -		*((volatile uint64_t *)gpa) = gpa;
> -
> -	GUEST_DONE();
> +	for (;;) {
> +		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
> +			*((volatile uint64_t *)gpa) = gpa;
> +		GUEST_SYNC(0);
> +	}
>  }
>  
>  struct vcpu_info {
> @@ -55,7 +56,7 @@ static void rendezvous_with_boss(void)
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	vcpu_run(vcpu);
> -	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
> +	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
>  }
>  
>  static void *vcpu_worker(void *data)
> @@ -64,17 +65,13 @@ static void *vcpu_worker(void *data)
>  	struct kvm_vcpu *vcpu = info->vcpu;
>  	struct kvm_vm *vm = vcpu->vm;
>  	struct kvm_sregs sregs;
> -	struct kvm_regs regs;
>  
>  	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
>  
> -	/* Snapshot regs before the first run. */
> -	vcpu_regs_get(vcpu, &regs);
>  	rendezvous_with_boss();
>  
>  	run_vcpu(vcpu);
>  	rendezvous_with_boss();
> -	vcpu_regs_set(vcpu, &regs);
>  	vcpu_sregs_get(vcpu, &sregs);
>  #ifdef __x86_64__
>  	/* Toggle CR0.WP to trigger a MMU context reset. */

Kind ping on this patch.

Best regards,
	Maxim Levitsky


