Return-Path: <linux-kernel+bounces-141329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F78A1CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF828758B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F33840860;
	Thu, 11 Apr 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQVGkZgS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA5D51D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853418; cv=none; b=mXOANUl9w5PcPDQLKxcTMZe7dpxdLXxlBVhonn8Cufmp4TZ5cb7M7dBElybSeMtlFwzrJ4bf75MbsLTX3z9lzcbxDyXvQKoaScIcM4YKPx7+83qxB/IGVWfDh4fjxRRUwp2MgaKmGkhTkD7rCopw0aguwke3REuxGhxun733aE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853418; c=relaxed/simple;
	bh=eEnELQu/2XIAOlCbzp6DMkHDaPwjiIZG7X1SIcnqdFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J023AjJhooZPFc4373kNd059LEcy2WQMahZ7nUTGSdRS8eBiXc5fOFKmuAweJefOenKUTWadGkjxsnZnucnsZjfJTxyZyVidEGGaO8KDzhmswcMnIXT76al8OnNPMOsfPG/SrNBDsrCnYEgBJyTuDMRybiacya/1q/Xl5IVdiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQVGkZgS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712853415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6YFASrEU85zMIDQiOjC5J+NUp/1bDDTGCw3PXWonwBs=;
	b=LQVGkZgSuLn5Pgqn/nnSDztw9Bccy82OQDLn1zp/ZNlC/2dt8Slfx322jXTgO+6MFyKCqW
	l/RokHrSVkw7gjWG+9yV6rqJhI7avui/M6y2iI7p9Cw5pAV22OYbrUcAp/0kqNI+scKeBP
	rD3NTS0k8r4t+18W0ofc3DKry3xrkJA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-w-KGhA-pO86P5H7vy-g0Tg-1; Thu, 11 Apr 2024 12:36:54 -0400
X-MC-Unique: w-KGhA-pO86P5H7vy-g0Tg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-417de05587cso157155e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853413; x=1713458213;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YFASrEU85zMIDQiOjC5J+NUp/1bDDTGCw3PXWonwBs=;
        b=Wydnf8fn94Ee1Ym71A8uxFZFIOzLbO9YvKvdlMBfX8hVryOVwplP0S2wkUO6WSSqRB
         MWlxpsYmowHgai2W3OmvBQPx/yjPbTRXd83Nn2L1aNSb8GPk0ZkWBxlDwflH+kQuBVZn
         tK6HGor/nzmQX0Q2znOFsDg7YY8WEL4NN5y/7vyNtMYfD5B/tBgocn4+LD0eg4RQW4v9
         gmyvs7s6fP6jbYQOKZvvxtVHMf4nppCp316PZ/wdwEiI/kyMFpRvzvNi3nujx6HjvDXD
         L3kFLGhbE5r6n9KU5+mpa0nAr95sItw6EPhy0iSVwrXisLRWJLylrb255bRe1eZiQCFF
         Q3Tw==
X-Gm-Message-State: AOJu0YzHKf3GpEENUBpGApegtprnXjcd9rXTYvrIEvN2DlGXo4WjEMT7
	L0JDGUVNu4ZClgfCBPHoLEKGBRmqCnCtEe5ha7CDfh93ZPPNW7KEkKkHYq+ZwL23peiBHMiVbZE
	XZ0y6ltK8du7GfIP25MRmxu5L3N58nqrLu0iiPPX5YnUb1crsVwYXHeq9fYd50Q==
X-Received: by 2002:a05:600c:3d0f:b0:417:e6e6:a314 with SMTP id bh15-20020a05600c3d0f00b00417e6e6a314mr243598wmb.14.1712853413127;
        Thu, 11 Apr 2024 09:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbaWB9D3JRarQhAsn4Sdpn9QmWPYXlw2wvO4ybww8LysTvw9biDfSoAJOPEVMBJKknWx91ig==
X-Received: by 2002:a05:600c:3d0f:b0:417:e6e6:a314 with SMTP id bh15-20020a05600c3d0f00b00417e6e6a314mr243584wmb.14.1712853412807;
        Thu, 11 Apr 2024 09:36:52 -0700 (PDT)
Received: from [192.168.1.174] ([151.81.71.210])
        by smtp.googlemail.com with ESMTPSA id n3-20020a05600c4f8300b0041627ab1554sm6003674wmq.22.2024.04.11.09.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:36:52 -0700 (PDT)
Message-ID: <bd8e7f8b-532f-4372-a3fd-69893e359b42@redhat.com>
Date: Thu, 11 Apr 2024 18:36:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: x86: Advertise PCID based on hardware support
 (with an asterisk)
To: Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Xi Ruoyao <xry111@xry111.site>
References: <20240411163130.1809713-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240411163130.1809713-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 18:31, Sean Christopherson wrote:
> Force set a synthetic feature, GUEST_PCID, if PCID can be safely used in
> virtual machines, even if the kernel itself disables PCID support, and
> advertise PCID support in KVM if GUEST_PCID is set.
> 
> When running on a CPU that is affected by Intel's "Global INVLPG" erratum,
> which does NOT affect VMX non-root mode, it is safe to virtualize PCID for
> KVM guests, even though it is not safe for the kernel itself to enable PCID.
> Ditto for if the kernel disables PCID because CR4.PGE isn't supported.

But the guest would not use it if the f/m/s matches, right?  If the 
advantage is basically not splitting the migration pool, is that a 
concern for the affected Alder Lake/Gracemont/Raptor Lake processors?

Paolo


