Return-Path: <linux-kernel+bounces-153093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E118AC8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0551F21A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930264CF2;
	Mon, 22 Apr 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeFdC5Pa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAF54670
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778413; cv=none; b=p2kPl8e3HCvG/ad6QnTHFygxIrS8NvVshPGv6BbUcX5Cl/b8WjRU4Y+0MXyD/9wFuUkGwPmYRUvFPfFQiRcsolTKzlN6jURIBLiBawXLmE0L6nUapsHBCPS9BItIeNjznOM6Yq94RB/glJZXYpMJMZBYqFyKaLVgfx4+CqRPuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778413; c=relaxed/simple;
	bh=GOFK3216NOXr//LYBMrM3eSHlDTzbrCFB8Ve/vcpgxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUUcciOJbhnY0NT6mTduncDe2kabNndhB1SIhucb1fNHm0Z6rejXuhxjZkFO/aIwXWP4LQ4wAXcQgUblpqlLy6WqhMew/HeK1t8Al785KhKixq1mkq0kiWQNcbmyUwCT3aTzrwhrhNv9KbNgvCZ2UsDSRfLcu8EVK2Dd2iXoc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeFdC5Pa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713778410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jNmMcHHqbadB2TewlY1lynwQ7lt5HmD0hnZgW77LkSk=;
	b=SeFdC5PaxXQJyEw9V+E6NcwZ4/thqhWZJqKPxESFENgQ6xLDM2aGYpMGJwhXocfbVCl/SS
	ueHu0pz+2ImBpkykT3ybnYfmdvZKDVlhhSa4a2SoJNqgn41/3rZZtFNiEDUCrezp+V58Xg
	3yummkCK1ZrQN9qho0m/HDD2EKAUzbM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-1--h7mKMOIKSAprE3xI03w-1; Mon, 22 Apr 2024 05:33:28 -0400
X-MC-Unique: 1--h7mKMOIKSAprE3xI03w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343ee356227so2732041f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778407; x=1714383207;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNmMcHHqbadB2TewlY1lynwQ7lt5HmD0hnZgW77LkSk=;
        b=vVHbLamgUPVFJ3bZjpaiOS1Edu/2SikZmPSMonJteaKYHLBklA+LT0mbatkMNgKwOR
         vvNLAz8Gyd00GzDxE7fzzPShKZhyV8SDZQqbY9Sx7el0eSbDClXc3HB9od5FBiGI3eum
         AsW2P90mC/WrOodO40JaZ1K7qp++wJXKczyV0F+YhMKYBkSmxTsy4DZvlmdVn/C9pgti
         Y31ONBYEFJlKKDCiXpfuXXF5uHQML/b7c/KeQ02ww+uckec1FGZP/tSs2qtoAILwW1nl
         ix8/NzwWlms6rpkEFLpuXHLqxXly0oFskGFhizP/2bhpJOnX8zR7jP1QssO9kg1GYlop
         nuuQ==
X-Gm-Message-State: AOJu0YwZYF+4luDB1a4sYiI8SbmmKdFetUhihFjoYTGAd9ks/WxKPhRE
	CtHPc1jmTfVcYbylXTDlT6DpY8RC0evxbqzwir0fGyEsw3fwtuus717AAF6yG/1fVgLM1mzUhQV
	T0tbgCjmvrkajeJSsJ2klswcgr5ZeMpY8Dmkie0W03bgB22xzFKgRfsb2Mseia+jRgJO7Yw==
X-Received: by 2002:a5d:5711:0:b0:346:ba70:f262 with SMTP id a17-20020a5d5711000000b00346ba70f262mr7194349wrv.14.1713778406937;
        Mon, 22 Apr 2024 02:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpBaSn2r2iCAtFJvANxs0XOzMaoUuzni6bSdgwnUdZGECebZkgc6ReIKdKSkkb6wmF47nUbA==
X-Received: by 2002:a5d:5711:0:b0:346:ba70:f262 with SMTP id a17-20020a5d5711000000b00346ba70f262mr7194331wrv.14.1713778406473;
        Mon, 22 Apr 2024 02:33:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id g4-20020adff3c4000000b00343c1cd5aedsm11508618wrp.52.2024.04.22.02.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:33:26 -0700 (PDT)
Message-ID: <aaeb2611-e096-475c-9055-4e8dd9509b01@redhat.com>
Date: Mon, 22 Apr 2024 11:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] selftests/mm: soft-dirty should fail if a testcase
 fails
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <20240419074344.2643212-6-ryan.roberts@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240419074344.2643212-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 09:43, Ryan Roberts wrote:
> Previously soft-dirty was unconditionally exiting with success, even if
> one of it's testcases failed. Let's fix that so that failure can be
> reported to automated systems properly.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/soft-dirty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index 7dbfa53d93a0..bdfa5d085f00 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -209,5 +209,5 @@ int main(int argc, char **argv)
> 
>   	close(pagemap_fd);
> 
> -	return ksft_exit_pass();
> +	ksft_finished();
>   }
> --
> 2.25.1
> 

Guess that makes sense independent of all the other stuff?

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


