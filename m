Return-Path: <linux-kernel+bounces-42279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927D83FEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEE62819CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE864E1CE;
	Mon, 29 Jan 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZqSzo3D4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844914D5BC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512940; cv=none; b=sPj1jz7hSnYvysoeRagcnPqAbjnABCBWsn09DnCGTbyPGFoV4G7yWze5ODsW0YD0QWWn5iIVhWdo8wdWzCXNUQEoATqCUbu/FvHaHw7jBDsEnedfu1rCODuJdnDTJ4KQyPiIuhDJZE1tg0kUNzDfprfnwfLYEF3SofP12yVgzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512940; c=relaxed/simple;
	bh=pOeBpfnIGTyAcSL/FQR58BXAk2dTUWrcGwza6diBqqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5dvt/8fjVXRnwS7vBVjTexsKk8r5KvriDOcMZJpqv/5IFIu2Z1jiBT2Jr2+TqnEP7xp/Nt4G49hvGEDVFzyKZx0VX7p7inq4u+7/PjIcBe5rnK0oAZI2Vhp/BzKo/UsijUoHq+23j2431/YbeBNBCn6PL5oOd8eS1LsYQ6794I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZqSzo3D4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so5780785e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706512936; x=1707117736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrgnZOGulcP9tuVmCHC1ajU+ERsd9Badipl3nQjKaNo=;
        b=ZqSzo3D4q/txo/BFmkHYXsv+bsUXiovUDrBdj5kbx45WjLxSLLflhbrkeHbj9spUTT
         VazYrftokXg6Zepoo75luFk4eucEaPAsgYiBfErGfe3Vim3dE5xES4AnyNv0/82AnG3p
         OxKtlBUZqDvB8sRef7alfuPpUV+61OtfhH5O8irCXVqdQo5Fn64dU9AhhSDNnRJKZ60q
         wfnFvTBZ56ebx4k9nVVwh6SHwzqwyEuSWmSRLpfHAU/P8O50oo++hGNJyihFG059krTd
         lCZqFONEMlghfd019mpBoGDxGAFihuvKrXQbCjcNiNH127fqZZ7vgd/d8a9U+xjtKds6
         97Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706512936; x=1707117736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrgnZOGulcP9tuVmCHC1ajU+ERsd9Badipl3nQjKaNo=;
        b=OhNMUP4v/PKNPFlUlGmYn9LxIOIouwiwNmw4ZwtHenNM0lWFWBfIkiCUmk2pqBVAOc
         jKrRQwIhIKzMytF7avGq9oPL/mI9Op2guz61GO8wrCvJGr76KFphXOzEQBlgb8tGEffz
         aIDxCrA9nxlZahhvqppIP9LUmnMmHzNC3rez2ExTQXEYIpTEvzIOxaWSWJ7O3dJony49
         wHjOSeNrBIxwJHS3zeVLBhxODwfaT7w4mj3vreJnk9Cf6S0ImsEaDnUmWJK3Sg67x9Om
         hQS1RfBiHJoKTaiyc6Dt+XDaazJXiMPQC4LqPYNvScIK2afWYO/2SVnlkUJd4TiNFs7a
         0XOw==
X-Gm-Message-State: AOJu0YzXCxkIwhaGvWT++qoiYqQkuF9ISOx6f/fRpoq06rY+TdxhnMF4
	lGwas8IDQfewIG80ZHYRmTxqKvxICpoIhOykeUOss248Nlb7YuC9GKWR8L4N5sA=
X-Google-Smtp-Source: AGHT+IHZDgIWhUn6PpGqUdNjpy0qgdACWGR/C6o14VWBOR70fiJGdJK2I9E3loxNce3mWT4UwH+kIg==
X-Received: by 2002:a05:600c:4f50:b0:40e:93b4:25ef with SMTP id m16-20020a05600c4f5000b0040e93b425efmr5101615wmq.26.1706512935752;
        Sun, 28 Jan 2024 23:22:15 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:cd6b:e8a3:8a4d:4601? ([2a10:bac0:b000:7588:cd6b:e8a3:8a4d:4601])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d69d2000000b003393457afc2sm7224289wrw.95.2024.01.28.23.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 23:22:15 -0800 (PST)
Message-ID: <fed13d3d-c87c-4e5c-9451-779200c35a1c@suse.com>
Date: Mon, 29 Jan 2024 09:22:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 09/16] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-10-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240124125557.493675-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24.01.24 г. 14:55 ч., Kirill A. Shutemov wrote:
> AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
> This is done by allocating pages normally from the buddy allocator and
> then converting them to shared using set_memory_decrypted().
> 
> On kexec, the second kernel is unaware of which memory has been
> converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
> memory as private is fatal.
> 
> Therefore, the memory state must be reset to its original state before
> starting the new kernel with kexec.
> 
> The process of converting shared memory back to private occurs in two
> steps:
> 
> - enc_kexec_stop_conversion() stops new conversions.
> 
> - enc_kexec_unshare_mem() unshares all existing shared memory, reverting
>    it back to private.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

