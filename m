Return-Path: <linux-kernel+bounces-118554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6729288BC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989371C2D12F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB554BF0;
	Tue, 26 Mar 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA28UCZf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5B548F1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442012; cv=none; b=Sqxo0pHXDSZ1TL/ibLcyeW+/cBlwThUTumvMcaobMalQn+nI8A0g/Y/zJnyIQZ/rtbeKx69w/Ecdh/86cdbRwrx786jeUH6HBNmFVoxEaP5Cnb5IvXZEqwCEr9zoDJSN9UOBcP6y4KGS4OJYv9SO9/e0LBXlhNGNBGx5D11lHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442012; c=relaxed/simple;
	bh=6zeoSahOhvKcfe3tLZx3C8WD5UHvAts/40hAXVrjdkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGOMTrRAbjHoWEQlqOH5WD7v4FWBVX8INzZGSc1SKRvjCsIokBWWwKDt9eNlzr1kvbfEtxAvl2JWDD3XvGEQxfWJ+qltE18w92U82voofXznzu5lPYcBwAq/jJqxPaTZU8La64qMM+4S359x1GUVDWo/BopzhWJ6fnlvuNdl1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA28UCZf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4148f00fa66so2770195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711442009; x=1712046809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyReadztiNYhjf4mOaaDyd5cW+HZXSffA6TTQkELG7U=;
        b=TA28UCZfnvMDEqNg4pfa+zBKfa1hDsa8y4A7eLX7X0KTH4VVIBZdHMDIPtxrE5NxXz
         gHiPwYKYnOgfTPNdtuo1RVOnBRX+xZw3MRTKfgSFYyzBOsD4KUcInl/IDG9fCYfvsNYa
         FtQliaKeSRYe2adn8kh367/iyuITLORDstd41DKWqj5MdhQxeijdP4uaVgxuYMPBz9c8
         ruTpGTss0piQhzInka8Cx6jbA3J+gDTeGSISzIyx6n6lgY/5hT+NKev/zvH6HSXmsC+J
         oA+JZgsIT+dpvbLadN+v2eajk3otxrj9VzKKTllQcwg6u/CV3QaVh5t1ax9HN66bMgBx
         p4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711442009; x=1712046809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyReadztiNYhjf4mOaaDyd5cW+HZXSffA6TTQkELG7U=;
        b=nhtIdvOW4uDw1LJjTTDxOg3ma135PYugPgLCkhy9dYXtFuv58wYfnB4gMrb3iYZT21
         TNnv9QaR2CMzEDk6++foHJkC9ijE88QLAEFu/+J/k003FdLR1psIXReVAx9PwL6ERMSw
         +Jno6uMplzDrIpE3hCFRxmoVQCL390IIkjeboU4IoeDHzni+tJz4a6pyKF18Ty01Kng3
         FZANDahLBMxYukFd4fBJAdTtUB2lN3MYCK4v2Msn340kqLuq1L+OAWDmNwW7zH40S4EX
         SVWyrh59tmF34OYSQ9iPXKXxdF3iPZ4Z4zF6urt2PgBhJ8qX0Af2zumvT+cGJbrr3x0D
         XJmw==
X-Forwarded-Encrypted: i=1; AJvYcCXO3olqYg7QVrYE/jHJ4OE65ZTOAB69D0ph0FyEoBeI9QiEOFESZda5a9hl+APK4FVtHBopQPA75CQKU1J8+LmYtB8l2IIonkxKO8C2
X-Gm-Message-State: AOJu0Ywn1ZvaIHt9WcGVK1VoCU73EfFSMNQM5xFOIInbrMJera4r8LI0
	hTbdppp8bPnhByPj/a1jEsyS9xDH8oBplW+8xag1WoCHKwemsguW
X-Google-Smtp-Source: AGHT+IGe/H7uGJpPfItdaEKmFG3qI74BSCeCvlOUtguH+50pCLSbUAekuapcayL/TrWpRTDKkLD5GA==
X-Received: by 2002:a05:600c:1553:b0:414:8e02:e441 with SMTP id f19-20020a05600c155300b004148e02e441mr1116601wmg.13.1711442008633;
        Tue, 26 Mar 2024 01:33:28 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0041408e16e6bsm10932841wmq.25.2024.03.26.01.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:33:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:33:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org,
	Wupeng Ma <mawupeng1@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-ID: <ZgKIVogEUEnUMgpF@gmail.com>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>


* David Hildenbrand <david@redhat.com> wrote:

> On 12.03.24 20:22, Matthew Wilcox wrote:
> > On Tue, Mar 12, 2024 at 07:11:18PM +0100, David Hildenbrand wrote:
> > > PAT handling won't do the right thing in COW mappings: the first PTE
> > > (or, in fact, all PTEs) can be replaced during write faults to point at
> > > anon folios. Reliably recovering the correct PFN and cachemode using
> > > follow_phys() from PTEs will not work in COW mappings.
> > 
> > I guess the first question is: Why do we want to support COW mappings 
> > of VM_PAT areas?  What breaks if we just disallow it?
> 
> Well, that was my first approach. Then I decided to be less radical (IOW 
> make my life easier by breaking less user space) and "fix it" with 
> minimal effort.
> 
> Chances of breaking some weird user space is possible, although I believe 
> for most such mappings MAP_PRIVATE doesn't make too much sense sense.
> 
> Nasty COW support for VM_PFNMAP mappings dates back forever. So does PAT 
> support.
> 
> I can try finding digging through some possible user space users 
> tomorrow.

I'd much prefer restricting VM_PAT areas than expanding support. Could we 
try the trivial restriction approach first, and only go with your original 
patch if that fails?

Thanks,

	Ingo

