Return-Path: <kasan-dev+bncBCP4ZTXNRIFBBE4SU2YAMGQESJHAVHY@googlegroups.com>
X-Original-To: lists+kasan-dev@lfdr.de
Delivered-To: lists+kasan-dev@lfdr.de
Received: from mail-ed1-x53e.google.com (mail-ed1-x53e.google.com [IPv6:2a00:1450:4864:20::53e])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DE893231
	for <lists+kasan-dev@lfdr.de>; Sun, 31 Mar 2024 18:02:28 +0200 (CEST)
Received: by mail-ed1-x53e.google.com with SMTP id 4fb4d7f45d1cf-56bf76d4282sf3660466a12.1
        for <lists+kasan-dev@lfdr.de>; Sun, 31 Mar 2024 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20230601; t=1711900948; x=1712505748; darn=lfdr.de;
        h=x-original-authentication-results:x-original-sender:in-reply-to
         :content-disposition:mime-version:list-unsubscribe:list-subscribe
         :list-id:precedence:references:message-id:subject:cc:to:from:date
         :dkim-filter:dkim-filter:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rel7jZSgyH4iyD8m/BKPudglNkWonEOSdaBN9wEDAZI=;
        b=f/ImLJT/Aw2c3AycYUOzZTkFkdtcAo9oAbgOWZXHhjxcm9Aop08c6Aw9ttgPxGfP0g
         eMdnNNKLdVZ399n+9B/GNNZ/GZ2vUC3z/ccWygx6uAzycRj7TvuEpeIxNLLqwoE1ufTr
         zc6l+8Rt5RdcDS9xFmmUNLWDE0YoBdSSlhc1cbQ2U2FQMxFeBsnMZ9A/qaLNv3kWra4h
         0764yN1RsvJcw+sv7mve6ipXo9zcLcAgaNDAr264VjF97oAYeWz78Wxs6uTgj7j4IHU+
         DIIX1tBXuO4trsE3G3fTuj1bmuviOU0MUDMKokJYbY2DM6Hc6OwPxeHNLHOY2xLJEiHg
         /RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711900948; x=1712505748;
        h=x-original-authentication-results:x-original-sender:in-reply-to
         :content-disposition:mime-version:list-unsubscribe:list-subscribe
         :list-id:precedence:references:message-id:subject:cc:to:from:date
         :dkim-filter:dkim-filter:x-beenthere:x-gm-message-state:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rel7jZSgyH4iyD8m/BKPudglNkWonEOSdaBN9wEDAZI=;
        b=tTbRgv6lQYv+SyiDta4Pq6ARtTgBL6gUpNXvRDSbaR/iLdrGInHI8WHhg/k1iXt+Dj
         GI4g8w+FdirVc02Q+jyWkwsi4RwM2fQXPv/E24p+a4g96x7+Mu3y+ePSdDKQBquLtwy2
         pU97QhgPT5wjPUJc1GEa4KDra6N4Az0HokBKpnBpV8MfPo0VXefvQ8lDzQ+2NcBA0sjd
         3o4cnAcr2/tRIxye2iBAn9hU2XcnRoccs4nmV16RwCW30aUkNeEeKj09XPdE91I0aTWU
         j+GgV2ZSI1q6/GJTxdEu014+RIl/6qV6s6WyQk/wkwmZs5qJHAxsalVOVi/u+gBAefy/
         IO5w==
Sender: kasan-dev@googlegroups.com
X-Forwarded-Encrypted: i=2; AJvYcCXLEMfP+lNEmVisEaEJ90VHEvOSekxOGZOdz9UW0Ax1CPBihRTo+k3Hi5xjybyNpmggTplEKQQ9kdDsMjtBuO7YA09T+zKrJQ==
X-Gm-Message-State: AOJu0YwZGO07BJEDdAGdIhlAvzOBcDgzmxzhLFq6uY09HGLlanfSh2/p
	lnVeNM6jyUNtxsdZ2BooUZHUPYjM2Wn4aXyeGDDeMPm+5IR3o5o7
X-Google-Smtp-Source: AGHT+IEpo8fV1gdgSboci6p4T2vHx4Y02/ZICcQ5AHq04henZi8ic+OtIbCmCw/NmriJ6InoOTOmUw==
X-Received: by 2002:a50:d4d7:0:b0:568:9b14:d6c7 with SMTP id e23-20020a50d4d7000000b005689b14d6c7mr9093825edj.16.1711900947280;
        Sun, 31 Mar 2024 09:02:27 -0700 (PDT)
X-BeenThere: kasan-dev@googlegroups.com
Received: by 2002:a05:6402:2786:b0:56d:c2f1:5714 with SMTP id
 b6-20020a056402278600b0056dc2f15714ls701461ede.0.-pod-prod-00-eu; Sun, 31 Mar
 2024 09:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=2; AJvYcCVvY3y4dfrq1ZKsSVhn5lVcNZvZ9a18ZIAxQxsKlEpcTY8PH0VMENaIonnzDjOgHwMiCkIG17lrsGGaU38GSftnCD0/p8jD5/ofWw==
X-Received: by 2002:a50:bb49:0:b0:568:a5b5:8591 with SMTP id y67-20020a50bb49000000b00568a5b58591mr10460016ede.1.1711900945326;
        Sun, 31 Mar 2024 09:02:25 -0700 (PDT)
Received: from a.mx.secunet.com (a.mx.secunet.com. [62.96.220.36])
        by gmr-mx.google.com with ESMTPS id a8-20020a509b48000000b0056c2ef3a441si477900edj.3.2024.03.31.09.02.25
        for <kasan-dev@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2024 09:02:25 -0700 (PDT)
Received-SPF: fail (google.com: domain of bp@alien8.de does not designate 62.96.220.36 as permitted sender) client-ip=62.96.220.36;
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D9C9A208C6;
	Sun, 31 Mar 2024 18:02:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjxZjgdh6ZWm; Sun, 31 Mar 2024 18:02:23 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4A5BE208C2;
	Sun, 31 Mar 2024 18:02:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4A5BE208C2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 3DBE1800055;
	Sun, 31 Mar 2024 18:02:23 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:23 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:45 +0000
X-sender: <linux-kernel+bounces-125904-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoArV1rGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAFIAAADkigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12221
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125904-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com DE70A2025D
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838917; cv=none; b=RLbMv7/rszEl7x6SX3kGFBqlG+P4O43vEUFFX26tfHpFzW+YHPuUvbNYHT1nhFoC80geNcoEApsB1McQPoFZZ6Vx+X0KAroYd3td/C2nzT1SZRM37Bz50LNerd5AM8b/ldFS0Uv07Ebfc3Ed6560QhYY72dWDu1gBpeldl3DjaY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838917; c=relaxed/simple;
	bh=x2hTAIw5it61iaDhIP8yLgeY+tHv0C2nNMk1Ca0GTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhCUY64wjcZGFSNltxdegfzQbxixyad7oYMDvbdjlLvUhY+VE4J1oURXz8ISbWeu0pBQrxVwPmw0CqoAnG/mphxWOUvocWnoY3BHa5Q8CDJMOiP1RcTNCvLYRvLDb4Hk4Whf+Z5eAhUZadZKSZvEwH4Lr6FPqiNHsgb19y4EvA4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C0B2YKox; arc=none smtp.client-ip=65.109.113.108
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Date: Sat, 30 Mar 2024 23:48:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: [PATCH] kbuild: Disable KCSAN for autogenerated *.mod.c
 intermediaries
Message-ID: <20240330224810.GBZgiWqnW1JZvwzOdK@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
 <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>
 <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
 <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com>
 <20240326202548.GLZgMvTGpPfQcs2cQ_@fat_crate.local>
 <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Original-Sender: bp@alien8.de
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@alien8.de header.s=alien8 header.b=C0B2YKox;       arc=fail
 (signature failed);       spf=fail (google.com: domain of bp@alien8.de does
 not designate 62.96.220.36 as permitted sender) smtp.mailfrom=bp@alien8.de;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alien8.de

On Sun, Mar 31, 2024 at 07:32:30AM +0900, Masahiro Yamada wrote:
> I applied.
> 
> I fixed the typo "the the" and replaced Link: with Closes:
> to address the following checkpatch warnings:

Thanks!

> Instead of filter-out, you could add
> KCSAN_SANITIZE := n
> to scripts/Makefile.modfinal because
> it is the reason why KCSAN_SANITIZE exists.
> 
> But, that is not a big deal.
> GCOV flag is also filtered away instead of
> GCOV_PROFILE := n

Ah, that would've been more readable, yap.
 
> I will probably use a different approach later.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

-- 
You received this message because you are subscribed to the Google Groups "kasan-dev" group.
To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240330224810.GBZgiWqnW1JZvwzOdK%40fat_crate.local.
