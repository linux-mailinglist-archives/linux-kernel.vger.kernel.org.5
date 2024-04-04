Return-Path: <linux-kernel+bounces-131240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A75898509
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEBE1F2552B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74A7868B;
	Thu,  4 Apr 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S8MX3Jb8"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEC26AC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226815; cv=none; b=EZIkEtVvMMD9QCXbKMwhGjwMRdT5rJjSDOnOs8YUrJPg3+7JeCyvz9JTyx4aR6cISC6FktlVQMxc7uyHN1uYaGDA/PYNaAWg0jFR7fONjf6bhLaFUqPBacJos9hSXRBnIbGWuG9X6+tydSEw8ZrzXo4sR0IxWtk0EbQEznxNm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226815; c=relaxed/simple;
	bh=taANS0pFnx0FrvL+3Vfun+Vs2ztHPpMenCXXjBFTVnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQSgWU7+8qg5alqXiKI/C3XGO2MabJm71aeu59BqwrJ1qTEbkAspCLl87ucP+sxm0g1Ts/v/clHruEbFvTneQmJpk/Sbxp/W/CJuShgKqRUId5xpHj5fXwMD4B3l5jLPdkqSfsUj/zsZpCsqiTYBMYK61DNdETf8ve7MY7irBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8MX3Jb8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1e6e1d01so605438a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712226812; x=1712831612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nprhaK+Y4soPnmXX5Z5/fOdcoBVk/SC/U1liNLz3dk=;
        b=S8MX3Jb8Ef/6c4PfI0RjP7xeLIvwQ+/h/dmAgL5VKCml9iFXOTf+VAHSPylBj+6fuX
         yB7eHTbhU0sIeUwjputKQhPs7+Dlo1vCIAl5v53arTbpyx2QrpmfDg6G60arlSFjZ4xl
         MmRHHIxTuqRO9yT8EB65VCdOr9zBy53H8Zx2hhAy0P+bVkB3FpktW8Gm4QB6bLe1lDeq
         eYDY40pJdDPV4ASYMg2d1pWzClb1mMqbe9LPkPRoxKufaZun7UicsT2/26b1vyDQeQHy
         bkda6qXyaETqz/0dPATsaOPWkxm473twCZ0/sgmTu5N+FSjG7HF0mN02D4/8uCmR5t0A
         g2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226812; x=1712831612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nprhaK+Y4soPnmXX5Z5/fOdcoBVk/SC/U1liNLz3dk=;
        b=I3T9nwKMwZG7AqOr6iLwy6MVylhR+3XJkhfxZRYLTDaFgPcJEHfeyI9qr2r/rp0VGX
         BXPFw0WgZEHsIzmcKlFNyzGO6JA6PqXINvDlO1JPDNFzgjKa6y2fmjOh4flY/0UOWELn
         YFYJqC5PIflDPPOzjOTi+D78cfUcsw+aBS33jGDqWHgPPZb4VHJL0eWVsRWJUpdI1JEv
         YDeCRxCHDBo/nzvJufvl1dg8mAHXg2gx3RCX+CQzvTEz2w2JfIefgtfZwPcjQ6u7PDJG
         fJ98GPGMdhiMbouxR+LqxOWQ9JQuNP9LqJAGBlp35x8ga66bCOI4FbBj9x5oZ2dtTGUm
         fRGw==
X-Forwarded-Encrypted: i=1; AJvYcCWHx0akTx4AFJ+mD/CyW8ana9v1SxkOOaz04n8kNdgfOiK9SVB35o55pyHk5Bk9ueBppZuqI0luTAsHObhONX03B2R0Aq55FlkAgSOi
X-Gm-Message-State: AOJu0YyYHvBNPWyXb4SgKTde/+aKGhFk/a3vCYHKfAZkK0voJrPdO5B0
	G6B519RFjOJvYwEyYiJ4CYKJCF4n2RCvkz7M2BRXMa0dv2zVpypjYFhK+cieXTI=
X-Google-Smtp-Source: AGHT+IFtAS+XwA0BTekopAetIioLl7wHkCMuYQDhbu67X4/QjYP1QMC8tb5ZGpmUksyPG3vKmrJkZw==
X-Received: by 2002:a50:9ec1:0:b0:56e:3c6:802 with SMTP id a59-20020a509ec1000000b0056e03c60802mr1277757edf.2.1712226811764;
        Thu, 04 Apr 2024 03:33:31 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id fd6-20020a056402388600b0056c53ea5affsm8842085edb.77.2024.04.04.03.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:33:31 -0700 (PDT)
Message-ID: <b248ff79-18c6-4a0f-bfd5-02772f181d33@suse.com>
Date: Thu, 4 Apr 2024 12:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/boot: Explicitly pass NX enabling status
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, bp@alien8.de, kai.huang@intel.com
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153513.76C52354@davehans-spike.ostc.intel.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240403153513.76C52354@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 17:35, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The kernel sometimes needs to mask unsupported bits out of page
> table entries.  It does that with a mask: '__supported_pte_mask'.
> 
> That mask can obviously only contain the No-eXecute bit (_PAGE_NX)
> on hardware where NX is supported.  x86_configure_nx() checks the
> boot CPU's NX support and adjusts the mask appropriately.
> 
> But it doesn't check support directly.  It uses the venerable
> 'boot_cpu_data' which is a software approximation of the actual CPU
> support.  Unfortunately, Xen wants to set up '__supported_pte_mask'
> before 'boot_cpu_data' has been initialized.  It hacks around this
> problem by repeating some of the 'boot_cpu_data' setup *just* for
> NX.
> 
> Have x86_configure_nx() stop consulting 'boot_cpu_data' and move
> the NX detection to the caller.
> 
> No functional change.  That will come later.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


