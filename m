Return-Path: <linux-kernel+bounces-51668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3B848E18
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF621F216DB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9D224F0;
	Sun,  4 Feb 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSBAphKf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069B22615;
	Sun,  4 Feb 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053660; cv=none; b=Ve9ksQO1oXzASKV2xMV6/nLdrkKLDyTsKr7MJ4NW2nVIUgWs4RMLq+S938xUASGIPqORYzoIb/3y+MgiwuoM5cxjO9RiEbhQVjieK1rQxdrc7IB15KIITQA8RxuwoLZJ9X1SVCflQLysNLf2+Szt2X2coZ4qdWKvJpHqbVTKVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053660; c=relaxed/simple;
	bh=p+n2IigMcDa1LcBAxaNJIM4BE7AzuU5T2jlg4hooDVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dx8ewohCwnVZ4ZsC5QGWMgkO5iGvhcOtwlISoKgHBPWXM3dMOnV8QivMp9j7iYEw8r58LijGnuxLDHIgRyyqpotMkKdxE+ZQvBUzsUan/ge9iM6pr0wZUD2zyFZEdsgXY8Fjmx8tQQR0K5zyeyltVUuzTkdf5ju9L+3Amzu8f0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSBAphKf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29041136f73so2383464a91.0;
        Sun, 04 Feb 2024 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707053653; x=1707658453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhlescoZV6oWQsg7ge5rSYJIAM2J1FGl/RY1F394m0k=;
        b=hSBAphKf8LDm+daCmJRopPDudviplGr1svJfuUgswX+fbJh0kKWFG1+U05OSL5kUEk
         UxYlnLWKuFrIA/b25AsxS62shDfMcvp8tN3QrpBEeN3M45gyBalyx4O9qDaI5iwW5f8I
         iGlc21qz6AaByiswtrkl+ODikMxC1k7UeLKNFwQTZR0Sm/kkOQz3rQvGS69KpUlLGiBS
         2SUktY03sAkh7DZXq4a2EDsafs0PPtW+sqSA76JhlwLn0kASGD2HG4UzYsqaQAdED1Jp
         Xx5q1sNFe0e2aO7SR8nlyOnmUj6nwdBocSEcz1u8DKtKB/SW+5EA61mSAuQWm4UMP3eO
         XcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053653; x=1707658453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhlescoZV6oWQsg7ge5rSYJIAM2J1FGl/RY1F394m0k=;
        b=cMCwXdTwBookRv9wIUKK/rMhyH7rxcEnS7Odhn1yNz0ioRZWXz5dCSDaNjvnC/uV2N
         26J4PqkV4AsSSgl6twfXYHast/10QetR2aum3o+V9kGMhIXT0xNXcht4qPOh9FQAgU06
         wvJRmw76svqdhzpZBmYxeEkFNx5FO0v/xb3md+3X66Bvp9YC0YVRKcHmVEn7sFv88aoB
         zQG1VevnWrCEPboxOyMr0vYZAp+QizMpF4J0EbO0G8qHy4tNAUqub2gNA/Ie+1SPR+Ye
         lJRO64/INEgC7yb3QygiPa9KjxBx2VDBmMkbZZiYdQUHuor/x+hxMaotaUNADtJQU5Ko
         s9TA==
X-Gm-Message-State: AOJu0Yz5Az7QvyEneUWZmyjz5selXG1og7BKEf+gEqU7vaq7p/MB9axW
	oj+Pl/424bAUp6Kw6krU6YczHO5yQPrTialxCQReU7VgmdOryLaP
X-Google-Smtp-Source: AGHT+IFgWmRYrPmH9xLOKYuCIVLpL564LpdW/Xnv2FoNleVXctXdYfwh+g7iuKi/b+UO2sjmOim8og==
X-Received: by 2002:a17:90a:bc89:b0:296:393d:a5fa with SMTP id x9-20020a17090abc8900b00296393da5famr6261154pjr.1.1707053653097;
        Sun, 04 Feb 2024 05:34:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFvFzSJD10dywYejmUvVuqFvL9y6jS8kqrjLeuEGfRzcIENzBESeNIJIB0CqgwJr98qPfH3mUHY0ziSXzYtCgQL1Uxv3G2cducMcza/xQH6Xok6N4tE2f3vimhyvNPe6m0VFvuaseaZPMY0l9RWZu1BBVgmjvME2OXSisu9kCdSGs3px6wzMWznoevxGYsXKMdX+gaijHwg3GXd+0t36wqmSoDhTa7nwfhALiaMpFZxHL1o5MO9LUzV1qXcZzJs9yAUDKF3AXmbQ+kKmqDmUUqvUPcFhz395O05BIybvRuTUqnyRkY7qpOOdG+NByyOBEgk3TlsrgCvuy4txt7ZdnnpD9MibPEt2VyPMmaDaR1SnzpqXSHXA4ofehyLJEuM/52sAHGVjOBTnyM9IErDtwcNiQ/Z97l+U2tsdGZMGfHjyO1mMH60I0/SFVXyjcEBdOzJuS/1mqKq3pwC0Wt
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d94e6a7685sm4530952plk.234.2024.02.04.05.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 05:34:12 -0800 (PST)
Message-ID: <9a114575-3a76-4d58-9770-804e00e0ccdd@gmail.com>
Date: Sun, 4 Feb 2024 20:34:04 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ccp: Fix sev_issue_cmd code block
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Roth <michael.roth@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh
 <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Peter Gonda <pgonda@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240204110604.192024-1-bagasdotme@gmail.com>
 <20240204112626.GBZb90Yl5ps7awXOZT@fat_crate.local>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20240204112626.GBZb90Yl5ps7awXOZT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/24 18:26, Borislav Petkov wrote:
> On Sun, Feb 04, 2024 at 06:06:04PM +0700, Bagas Sanjaya wrote:
>> Stephen Rothwell reports htmldocs warnings when merging tip tree:
>>
>> Documentation/virt/coco/sev-guest.rst:75: WARNING: Inline emphasis start-string without end-string.
>> Documentation/virt/coco/sev-guest.rst:78: WARNING: Inline emphasis start-string without end-string.
>> Documentation/virt/coco/sev-guest.rst:81: WARNING: Inline emphasis start-string without end-string.
>> Documentation/virt/coco/sev-guest.rst:83: WARNING: Definition list ends without a blank line; unexpected unindent.
>>
>> sev_issue_cmd struct code block has unindented block marker, hence above
>> warnings. Fix the marker by appending it instead at the end of preceding
>> paragraph to silence these warnings.
>>
>> Fixes: f5db8841ebe59d ("crypto: ccp: Add the SNP_PLATFORM_STATUS command")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Closes: https://lore.kernel.org/linux-next/20240202145932.31c62fd6@canb.auug.org.au/
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  Documentation/virt/coco/sev-guest.rst | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> https://git.kernel.org/tip/1bfca8d2800ab5ef0dfed335a2a29d1632c99411
> 

Oops, I didn't see that commit when I was submitting. Thanks
anyway.

-- 
An old man doll... just what I always wanted! - Clara


