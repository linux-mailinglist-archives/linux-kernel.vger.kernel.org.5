Return-Path: <linux-kernel+bounces-40224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A735683DCB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD245B2500E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F51C68F;
	Fri, 26 Jan 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yp/CFcUx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C8134A6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280417; cv=none; b=SynqwxbWbhHWtmL2xPAVqU18FpMfyhwL/ErVRAhOpHvz7k2yRPknLeJ2tZR7lOVzqurNu4m32hnl1rY9UKrnf6asDHeJAYd7maMSsyWJoxM1ZG0Jcal/2pqkXCPIG/r7yNwsvPWwjEvHx95xR4yxAjL1werhPjrCxZDyCC7UMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280417; c=relaxed/simple;
	bh=W/FdB88dbo4Ofig9JphpMVHHe94m8b1+hdrjMoRC/H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MssVj79Uk3SF6qVnI6R8NzCTzrQwb9G2jw6C1VkXc4H6K+GSGix5KcnjvkmdW3SZOnU9bpCR3ugsPpmeHz/ql/b3ajlPaAW1YmdprCgx5tWac6vgAdPyDlNw7c37b1jRvIhFriNHnHgSbSYIRsRztZEjeBG0/iDxCbrkAZA1Lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yp/CFcUx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ade380b9fso595568f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706280413; x=1706885213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwKl7KA16kSrc3QBUn+TdenGDtEm5u8vFzJscSXHTTY=;
        b=Yp/CFcUxkz0yT1b9rPh1vhuouStDf6hceu4d9tuBIml6lRs8uGr35B1ZQHfZwdjFBX
         AeZbLH3enQaGc2JrB7ZKLQrp0zNCXWWhNsxsTHRkVfcyCdl0W9RFwtzjFPUId7YvL0X3
         tEQ2P2Bjn8nYIhV4gRCBhaft1WOEPLCdbqNR1M8SpgMJC7fxrC9k0PbcniFZVBEdp0Gx
         YFzzFX98qRPOutT36yyHIQeEhVS1EAYnMlRNEsw6VABEOtpLpCZuf0wWzKvd4oIQZ+DH
         5iOfV+iUBYdFsEYMJOxFOB94V/flwNTQSK6nK6Qw+5hnxA8+SNkbU/VVDdOmDQKPKx+I
         YUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280413; x=1706885213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwKl7KA16kSrc3QBUn+TdenGDtEm5u8vFzJscSXHTTY=;
        b=UzFSPG2h82S+/Iz5gSKAtFBEQxngnVRSo/mVvGc31x33pxrbJJrhcejnujvCvyJazH
         6N9eMYgIDchrqrXT45Z7adktWnBLckK5VesoWL3glPOsd99P05fTEQZ7qeWpm3rzaXSQ
         MCWjKOu5l6GVlhRHSqADUP0uaj3YjXX3vEsayvlJ6nzTMiNLOtyT823AM4bgD6ankE/H
         CT6lMaiLOylvcm9eYNF3TaW36A0yzezK4KVMmfpbHY9MEH0SNubzIkZa6bb23p1mjQ1v
         diSkgq20/LvPWjoPd83tx2xw9ZuNH2sM0KZYEK904PsqtI/JiLHH1oln/JAXnmKzwcxu
         G72w==
X-Gm-Message-State: AOJu0YwrwVy6ALJ1Ic+HEV+KpEjCrtncskOuF301E4x5ah7obHXfmfOp
	GkhgMbioSXP2MRkauz6naQaZOmI/c+H0vbA48vMFTGk8ORud/kntDsPYTOVJ+Qc=
X-Google-Smtp-Source: AGHT+IG3veE69nenUkhE2SVXbzrVU0L/Do3gd+wEYCsuXJnu1R0yOSVv6LwLj/j5xNSNy2+GDv7Ukg==
X-Received: by 2002:adf:e3c6:0:b0:339:611b:bcb4 with SMTP id k6-20020adfe3c6000000b00339611bbcb4mr568107wrm.117.1706280412721;
        Fri, 26 Jan 2024 06:46:52 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7589:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id n11-20020a056000170b00b00337d6db207dsm1437927wrc.30.2024.01.26.06.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:46:52 -0800 (PST)
Message-ID: <6afe76be-90a7-4cf7-8c6c-23e6a14f8116@suse.com>
Date: Fri, 26 Jan 2024 16:46:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Randomness on confidential computing platforms
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
 Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.01.24 г. 15:42 ч., Kirill A. Shutemov wrote:
> 4. Exit to the host/VMM with an error indication after a Confidential
>     Computing Guest failed to obtain random input from RDRAND/RDSEED
>     instructions after reasonable number of retries. This option allows
>     host/VMM to take some correction action for cases when the load on
>     RDRAND/RDSEED instructions has been put by another actor, i.e. the
>     other guest VM. The exit to host/VMM in such cases can be made
>     transparent for the Confidential Computing Guest in the TDX case with
>     the assistance of the TDX module component.

But is this really a viable solution in the face of malicious VMM? It 
assumes that if the VMM is signaled that randomness has been exhausted 
it will try to rectify it, what if such a signal can instead be 
repurposed for malicious purposes? Could it perhaps be used as some sort 
of a side channel attack ?

