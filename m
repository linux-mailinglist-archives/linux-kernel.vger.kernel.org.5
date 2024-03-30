Return-Path: <linux-kernel+bounces-125835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8DC892CE8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910621C21661
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D9481C7;
	Sat, 30 Mar 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJxlrezF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7317D2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830040; cv=none; b=j8ZjrtdzsYhKpDdjONaD4TPHHwOgokOHY1Cp0kFO43yRgVYRXy0ERnfA3M8NhJqYGHRwhhO1pB8Un3Cef1XwzN+LBMThhwd3bstqZQkTyJlzmKONXkFyxbRH3+pvUPAhigIytBJso6gQQmwu+0FxWNxMY9guYJJ6DTs8edXcU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830040; c=relaxed/simple;
	bh=oxdPWe+ybLFjcrHDDH17LDCwEaRt9Ub+u4pYIQ6Evnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bS5ayRFpvJlxFDoZ6ctI8/oc7atgd3xdTPyb56e+fUo7Pr05G9nHh9Ssk6KXEQTRhE//UMSKk6GZZBhyKR7chKzNqoMPrZkcCqLmCdPbKKYm9mc31I3xXCBXcgK3/0TCZnUa32LuXxV4GI2sRlww0aJ8dIw/9PdYOOaPwlVwZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJxlrezF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711830037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zjsXt6/XI2fGcxfOy299lQeB6mbSKKFDwTLuof4Ifvg=;
	b=cJxlrezFLPUF/ZXZDSMIqdoKyY11f9Ikp926n+TXEs/0UUTUxRH243Ldb5ZOKT6gGbbuQl
	uhtIq01XALr0j+p9lHl99BARTSy2GvYo9uv0o2l5ozukLs2XsyxNFxWPvB51vPDT/lUn/f
	LA524MkvsYVCN8rNBgjO33UIl68yfmM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-BhtogDkZO4ulZ-M8MacVng-1; Sat, 30 Mar 2024 16:20:33 -0400
X-MC-Unique: BhtogDkZO4ulZ-M8MacVng-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4e49d250b6so37458366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830032; x=1712434832;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjsXt6/XI2fGcxfOy299lQeB6mbSKKFDwTLuof4Ifvg=;
        b=qR0pDCeTemqAT5TgeHNmawBL+FcLj/E8KIqCQfveCs+EHuzXczICUALJ5AYnvx/J3t
         NwmcMa9BUfTdS5eK5TEcy/cZPlx4qx2GLTHt5lJ5tQZPsDVvbjmNvX3VrVL/ESWsnI0y
         ZiPZLagjQOFTDQ/v9f0HPEHDszUntfqJfaR1vUM04QrJeyGFOIm5OeLU08SsO5rthkCy
         QbJHNaGKvNLaYifBYuOPXbr1Ea6Zi6YEh4RT2BcRtk9jJ0Sc5CpLiY2ebqhEpLMgrtIK
         HVvc5rZx1ExmTDJ8WvEqKuxzKKj3eGlO6lyWliaSU4QlK/6OgBQMVasKsaPbNIEkf/uD
         RTyg==
X-Forwarded-Encrypted: i=1; AJvYcCWhsbCrLSsRRpteygmP+Ye9O3NfIro+/ERlK6O9oh6meudQVdTL5cqEfJ3OUFm8iusYo35bSn0P14ISrXmfsp2FUvIrx0MugoiPz+oI
X-Gm-Message-State: AOJu0Yx90iu1v7/o375CXje0mTjw5P0mwtIi3BhXKGJNcCovoptBjbpS
	cWGjs8anX0Fx7VGvXxptV9/8lZgBslCYdFLxolMNfXAqDTTPuqDHMkEbusAbHhRyBUPh+NAyxGl
	GXqDU4ScSufRYcwhc+OY6d1oXulCXvavn4hOFq1djWicVE5Tgok0CxGFpCsxPFA==
X-Received: by 2002:a17:907:77cb:b0:a46:8c9f:f783 with SMTP id kz11-20020a17090777cb00b00a468c9ff783mr3882536ejc.67.1711830032704;
        Sat, 30 Mar 2024 13:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwEafgXikWAWtw1l42yL+gRcN9KYUDKlUA2NmDTs4b3edtP1dqIWZjSciSUbc7uQ5J6ws3jw==
X-Received: by 2002:a17:907:77cb:b0:a46:8c9f:f783 with SMTP id kz11-20020a17090777cb00b00a468c9ff783mr3882522ejc.67.1711830032343;
        Sat, 30 Mar 2024 13:20:32 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.49.219])
        by smtp.googlemail.com with ESMTPSA id xc4-20020a170907074400b00a4e5ab88803sm274929ejb.183.2024.03.30.13.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 13:20:31 -0700 (PDT)
Message-ID: <9507220f-1552-4105-93e4-9485dc9500c8@redhat.com>
Date: Sat, 30 Mar 2024 21:20:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/29] KVM: SEV: Add KVM_SEV_SNP_LAUNCH_START command
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
 <20240329225835.400662-11-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240329225835.400662-11-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 23:58, Michael Roth wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> KVM_SEV_SNP_LAUNCH_START begins the launch process for an SEV-SNP guest.
> The command initializes a cryptographic digest context used to construct
> the measurement of the guest. Other commands can then at that point be
> used to load/encrypt data into the guest's initial launch image.

Does KVM_SEV_LAUNCH_START fail for SNP guests, or should we take care of 
forbidding it?

> +	if (params.policy & SNP_POLICY_MASK_SINGLE_SOCKET) {
> +		pr_debug("SEV-SNP hypervisor does not support limiting guests to a single socket.");
> +		return -EINVAL;
> +	}
> +
> +	if (!(params.policy & SNP_POLICY_MASK_SMT)) {
> +		pr_debug("SEV-SNP hypervisor does not support limiting guests to a single SMT thread.");
> +		return -EINVAL;
> +	}

Since you're forbidding some bits, KVM should also check that undefined 
bits (63:25) are zero.

Also what about checking that the major version is equal to the one that 
KVM supports?  From the docs it's not even clear what ABI version they 
document (QEMU uses 0).

Otherwise looks good.

Paolo


