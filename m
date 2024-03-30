Return-Path: <linux-kernel+bounces-125879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC1892D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9129A1C2165B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755E482E1;
	Sat, 30 Mar 2024 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl6eELnV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D63D0C4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711832146; cv=none; b=C/Uoz8ls9WpT0iB75EzBB7Y4/ZBENN752frdmq51IBXPAulyngVaLmXihLLBtmSG81Lq81HxOFcoTtU+Jrw1pB66x/anqI+KsBc5n4S2Vgl03m+APsfx9Vla9vKXqPUWcwU31nkLvs5RDarbYdQQxKonYozjZhqMDMG5nHwrMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711832146; c=relaxed/simple;
	bh=z7TmabSrZt9asoh9147M/NyurNg5SlDymoLAfpK3VzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ah8UJf7cVO2a9bWfd3z4DPw95PO+dgRuGRw7Rkgh56MqwZwr2bOa47Qp4vLuGSXNC+jMnv9G/wnzV6LsMBqRmYHG01kXTs3KSbmp53pY1f42tRZgHHUy8+kWPWKc3EKP78zQzFppOlW0iLj5/TTp7Q0rPP2baQK94YewCfQkTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl6eELnV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711832144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jyi6SED43RWjiHARW2FnY3B2JhkS1d2lHNCRYyCsMcg=;
	b=hl6eELnV0t7CvxcVkDU/ihH+xSbaVr3a1Ryu2cp8yTwlDXYVlvf4JZNv0aSBSyfLIO/W8I
	4qijzh02FFkamT+YlxopeY3ykUQh4UvZ8dNV8pmrJZ9i1Xmdcp7qGBAQJLCrawF7NbT4J8
	MB0nW2/Jbb5eNzBRk1WL854Hks4hK1k=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-xORCa7RHOH2ZtuBevMk7qw-1; Sat, 30 Mar 2024 16:55:42 -0400
X-MC-Unique: xORCa7RHOH2ZtuBevMk7qw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d6d3815f9bso29366631fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711832141; x=1712436941;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyi6SED43RWjiHARW2FnY3B2JhkS1d2lHNCRYyCsMcg=;
        b=C4v76pBXfE88ufSZORkP5H0CTuV5J0VcQX19xKMDawd2LFRSvKfCHt7F4lbzQVg0wf
         lJWtFvD31otuQbyiPnCx/7ZDllr8zhPQOzwPZWHxMenBYu9TMfTdtRn3aiRrCykrzI2Q
         ut93LUOeci3OQ2fzuHBtmAb91/AT44MnMbGMC15rRMbMlS9AlW+0GeeZCJ7Tbfa0N+g+
         53c31hac/EPLg8vFgu7QO78agynMHDkILhSHmekEDkjziLbHdJaydgHbwGrTHD7oKLPJ
         id6EnGYAaBcpBkH9y3+IJFzuF1rgSBypDEAW291FQOrjm6oS/stO2GkjFOyLl8YsX0Ty
         UWCg==
X-Forwarded-Encrypted: i=1; AJvYcCVyJrjeI5RI9HX92i24y+4u1tN/dwv8f86S9K6v9fG4NnISTotVjZXTy0hImiQ6qGY1hnl3E0K9dVAgq8WLgpT2XVzcXXvKw5fuOPX/
X-Gm-Message-State: AOJu0YweZ7hdKUO8SLPiW8B4cpbGoNi++Lez5Wdf85KmXOHS4qe0W5Qs
	HuGdmTIF9tSMN4h+w93VDi/tMnyIOM4Qs/aYl79oNNi0/+RjEmk/xYLhe9sIRX3knHL+nL78l0s
	RlZJcMcZ/BA4dy6fDIGD+qCYQL8xMqrCAE5wCcXK4PeaR74ZmQ3O+zbkpBWbQtw==
X-Received: by 2002:a2e:3307:0:b0:2d8:1096:6913 with SMTP id d7-20020a2e3307000000b002d810966913mr136890ljc.20.1711832141162;
        Sat, 30 Mar 2024 13:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3w4cwAv4h4Eb58plOtyeNT/FqmpU2M4qH41wQ1IThyW9pWf1IBmQXNxSRhgLNhjfSlLWhkg==
X-Received: by 2002:a2e:3307:0:b0:2d8:1096:6913 with SMTP id d7-20020a2e3307000000b002d810966913mr136864ljc.20.1711832140682;
        Sat, 30 Mar 2024 13:55:40 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.49.219])
        by smtp.googlemail.com with ESMTPSA id 17-20020a170906301100b00a45c9945251sm3414724ejz.192.2024.03.30.13.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 13:55:40 -0700 (PDT)
Message-ID: <37941671-9ece-4078-b308-b185579e8d7a@redhat.com>
Date: Sat, 30 Mar 2024 21:55:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/29] KVM: SEV: Add support to handle RMP nested page
 faults
To: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc: linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de,
 thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com,
 vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
 dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
 peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
 rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
 vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
 tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
 nikunj.dadhania@amd.com, pankaj.gupta@amd.com, liam.merwick@oracle.com,
 Brijesh Singh <brijesh.singh@amd.com>
References: <20240329225835.400662-1-michael.roth@amd.com>
 <20240329225835.400662-18-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240329225835.400662-18-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 23:58, Michael Roth wrote:
> +	if (rmp_level == PG_LEVEL_4K) {
> +		pr_debug_ratelimited("%s: Spurious RMP fault for GPA 0x%llx, error_code 0x%llx",
> +				     __func__, gpa, error_code);
> +		goto out;
> +	}
> +
> +	pr_debug_ratelimited("%s: Splitting 2M RMP entry for GPA 0x%llx, error_code 0x%llx",
> +			     __func__, gpa, error_code);
> +	ret = snp_rmptable_psmash(pfn);
> +	if (ret && ret != PSMASH_FAIL_INUSE) {
> +		/*
> +		 * Look it up again. If it's 4K now then the PSMASH may have raced with
> +		 * another process and the issue has already resolved itself.
> +		 */
> +		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) && assigned &&
> +		    rmp_level == PG_LEVEL_4K) {
> +			pr_debug_ratelimited("%s: PSMASH for GPA 0x%llx failed with ret %d due to potential race",
> +					     __func__, gpa, ret);
> +			goto out;
> +		}

Please change these pr_debug_ratelimited() to just a single trace point 
after the call to snp_rmptable_psmash().

Paolo


