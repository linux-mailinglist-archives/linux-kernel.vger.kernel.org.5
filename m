Return-Path: <linux-kernel+bounces-121485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7908688E9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484F1B2B37D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241ED13A3F9;
	Wed, 27 Mar 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZqwBLxsr"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739313A3EF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552358; cv=none; b=DPHzPK4NMntRX5y+i0r59Nna26Stv9krjjW6GgDsKhc4sqWIKX9ToC1hMpkljOO9UL5sTUOfnz4Fqt80h1yHPr6TF9oFk0NObf/9N1gwd5at6Np5lBLPZN4ku8lnkIo+R49sRFZ+7AZF9C2UJPwtBf6gQGj9d0viFJlzwvnp6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552358; c=relaxed/simple;
	bh=bk6V3Tph/BTikIMlnsHClFRVc8U6mY/3tucdVLV08Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7afMgX2Z0DnewZb39fdJMwmJHXcbJVN2C4e2i1LZPAxpWoWp34cxfZbuZ8PxOXBbyX0/Avo0+FOvWD8IyGV4VC8qgdI8uLf/EJPhTwGWqx5DfXi0jmhj7JCe2Inu/KkkdQZLHTc5SdOalSc+Cv9OEMRtUG/C6j4b6JRPgyJrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZqwBLxsr; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c8ad87b2acso184683439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711552356; x=1712157156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuoTzi8rOFJ87iK0QDMAtmZ0NUzmHRlY2Wibz55w4qg=;
        b=ZqwBLxsrjFDOHipeXM8xoNGRg0mjQlJK8aiBHCLjEUbFmckaCcA8KiBNn+ddUBkWLK
         dHBlzXwRQsWCZL7QmB2pHeK3BgBSRVSzIBkV3Uox4rKf/ulCFlsJi1tqE8NEgBIZEVCO
         kiLdbdn0cd/P2hbxLlwmybe87f9PA2j8WQn0ejNKGNyyu5Eqclk6QMOWvRePausWoIZN
         vpi7+7zA3f9bydC0VyyPetTuGbb8RKlcm8SqE6sQZ05vh5rIJqXc/1+HPhltSwaCODy1
         Cr+imflIBNStjMoTlnOq4UaLKaTrfvENkT2Wzi1MSX1QoWFsT6P1kSfkWttgR+p2+Pml
         Uc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552356; x=1712157156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuoTzi8rOFJ87iK0QDMAtmZ0NUzmHRlY2Wibz55w4qg=;
        b=ctn4hx2S4f5QB+dKGN5+fNRaXJP1WtpdEVRY/oGAJO2TEtk/2DqBMJxnpfbbNCgThT
         z7+fntNFXk/DHLfwmH7LffrdWtrm2LV3F89eV4ra863g/Sf9EmIUAuoRcL53ueJNl+3X
         zu+KBmDVqJlB4aHJ7u1XForVWaNzpUuLCccYFEDMh+lI0VEq3rjgNK6/WzLi4gjTKbA8
         TDBXTOqHPRGqPpNZSLAkUjjeHTAexP+kFeM5xoKexbmMCwzY/LmzNtCGTqv1P/tlcTIz
         biADmZD60G8qv56ByBWpmSHd8C7wMi4YDigFzrlr3OGV7eaCUO887wcpQ4WCGQ93mzAn
         riRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaX1olrtqDfcWL2nBuzaFYMAv3jdSwhB6fDSVRg5Nm50VQsPdWC1zkAcPB7cR47ebuHn+9pOAlgzdwtRxovdLJ3yy7cH2uLY+ZlCuA
X-Gm-Message-State: AOJu0YwZwM9b4Z6B6cqc7/+s138JU4WNd47tqrmNakzSEbWZ6ZbVagSG
	ZCfHrFog6CG8tGXm3csdlmq6KbxL+JQT8RJ0TruZrJMZsLvojV+I77XsO6gin/o=
X-Google-Smtp-Source: AGHT+IGqFH7jy6vdiT/UHr/bx2+JznqAw0ftyUqt4N09oQx6Vx2n3f1L96q65Y0mwHXiMutMid6ZNQ==
X-Received: by 2002:a5e:9903:0:b0:7d0:676a:d0ec with SMTP id t3-20020a5e9903000000b007d0676ad0ecmr486405ioj.0.1711552356161;
        Wed, 27 Mar 2024 08:12:36 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id n15-20020a6b410f000000b007d0445ac470sm2603214ioa.29.2024.03.27.08.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:12:35 -0700 (PDT)
Message-ID: <198af54d-10da-4320-9623-85dfb102f5de@sifive.com>
Date: Wed, 27 Mar 2024 10:12:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] riscv: Simplify text patching loops
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?J0Jqw7ZybiBUw7ZwZWwn?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-5-samuel.holland@sifive.com>
 <874je4fvxl.fsf@all.your.base.are.belong.to.us>
 <cb89b03b34d6403685297f95924524a7@AcuMS.aculab.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <cb89b03b34d6403685297f95924524a7@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 2024-02-19 4:13 PM, David Laight wrote:
> ...
>>> -	while (patched < len && !ret) {
>>> -		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
>>> -		ret = __patch_insn_set(addr + patched, c, size);
>>> +	while (len && !ret) {
>>> +		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
> 
> Does that need to be min_t()?
> Both arguments seem to be unsigned.
> (Did it even ever need to be?)

You're right, this never needed min_t(). I'll update this for v2.

Regards,
Samuel


