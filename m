Return-Path: <kasan-dev+bncBDT2NE7U5UFRBRNFU2YAMGQEXO2RWQA@googlegroups.com>
X-Original-To: lists+kasan-dev@lfdr.de
Delivered-To: lists+kasan-dev@lfdr.de
Received: from mail-wm1-x33a.google.com (mail-wm1-x33a.google.com [IPv6:2a00:1450:4864:20::33a])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC389338F
	for <lists+kasan-dev@lfdr.de>; Sun, 31 Mar 2024 18:43:50 +0200 (CEST)
Received: by mail-wm1-x33a.google.com with SMTP id 5b1f17b1804b1-4147ddecd52sf16562635e9.0
        for <lists+kasan-dev@lfdr.de>; Sun, 31 Mar 2024 09:43:50 -0700 (PDT)
ARC-Seal: i=3; a=rsa-sha256; t=1711903430; cv=pass;
        d=google.com; s=arc-20160816;
        b=Vz+FObYCeOKBnW1KfG6JfvY5rZlXSZG6t00kstBvJZvMwxGiwtRug7XdC34r32Wsg9
         fyybQ2uKGzJbdwOl7/Q9xQ1n+rCwjDdBeasfZ6Kou3suM45EdEeRLPtUf79NqOyWCiXq
         TYdPt6EVIjCb9i3wlH8y8dRNIAhJFh5Dv2bieW7PIinygD3R1aKd49We0nJNPmZTOuUY
         9v3/t9zik1yyO4gXdANy995VGgA/nWzGb8WzSHLj7VnfcOTt71lvUKK1pRNCL5u2qg6q
         zwZs2t61empkyu+jo/6btLGNw9b4RJk5ACEyhEH/Fak6fGD1kwHiQvJ6bKCXgInInFKt
         V1aw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:list-unsubscribe:list-subscribe
         :list-id:precedence:dkim-filter:dkim-filter:sender:dkim-signature;
        bh=+8EwgtrG94oY58QGzvJgMPm1+64UyjWZdtYfNRSUDJQ=;
        fh=CJlXbuZwklOwhIpX808owiis9ADMhpD4CsKRIngFytk=;
        b=LH25v7MXyeHAi3Qs6mQRLLa+WL2rFuIIRj8Ebi4aF3aZSFT+zoI10QCgCKMA5vB5Or
         ZNEvqKQzF0fNXoL6vf35O+Wu0syJVNw4SPXU3owJb6XG9f1jIOsQMK6V1bvHC54EeS9A
         L69IcmcGeYRhG198+r9tgWclAizcfNqC1ukJRid/tnNp7tLUUmw4gUlraFOuiwJqqwxF
         MEot0t3Yx0dFdj4/Itg37i0tCsgK2IhfHKoYdsWZTAta7zqN7Liq2rtpSe7UO16ua/iA
         2M5MElD6pbWlDXzU5cp8TpQlMRqCY0tmfuaDwcX3if8077hqjhHPaQvTtOtKKm7XsGov
         2Itg==;
        darn=lfdr.de
ARC-Authentication-Results: i=3; gmr-mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=bxcemWO2;
       arc=pass (i=1 dkim=pass dkdomain=kernel.org);
       spf=softfail (google.com: domain of transitioning masahiroy@kernel.org does not designate 62.96.220.36 as permitted sender) smtp.mailfrom=masahiroy@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20230601; t=1711903430; x=1712508230; darn=lfdr.de;
        h=x-original-authentication-results:x-original-sender
         :content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:list-unsubscribe:list-subscribe
         :list-id:precedence:dkim-filter:dkim-filter:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8EwgtrG94oY58QGzvJgMPm1+64UyjWZdtYfNRSUDJQ=;
        b=WVU5fhmrXp0ubv8stmtwIi4Ejw2SBfVRC7kfie1j99Y8TMvfloTubGtoncueh8KwYB
         Pwz/K2tD1C7qoxtjATc6fyKt8Ssj/8F6MvBCrnRYKg1N3ORT03Yp7muFQpVt/NU62WLr
         wc/WKGfD5t019cBlKNDPTzUOQ8lmuw0PDbqqZXlNbu9SoWnGEPevVlByawtNO4vrIIQw
         CmQqKVXRE6ApyQ2VyL98MLAsN5oSqe5BxCgvGvyYEAfJD1zb5Sze/+kXJdWfBFRuZpGS
         Rm31v+ZjGGrJRHh5dEnVXMeWp0jCORfk3Pk5Pee4dDjEeYQhY/kuu/TKe/pVyP+2V36e
         2N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711903430; x=1712508230;
        h=x-original-authentication-results:x-original-sender
         :content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:list-unsubscribe:list-subscribe
         :list-id:precedence:dkim-filter:dkim-filter:x-beenthere
         :x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8EwgtrG94oY58QGzvJgMPm1+64UyjWZdtYfNRSUDJQ=;
        b=NHp+eBavvhTRC08Zqb/FPVbMNhDVxIXIKPrqJSwfZiDaXK5vadwj/PPGn+kD5imkMr
         baI/NIt5e08cl/EmcgMkfBOWis3AKhqbuOrLMapKWLn48aSW9pkSE9JmQTbJgzvLv5J0
         E7Nwh0Bpx4cqk7Ugsbis26EDJdlmwgAwivH6ykMQbvo91cMPJgLaBAMZplhV6VhobdJU
         Lh0RG+j2I8urAw+8vmMdagktmHIDLG/ak19s63G3Z3dRPpP6Emxl6vjFe/h6CQFayqpP
         fycRd3bY/WOrJrDwtRAH8H5KgCeJd7Ib4vrWUYxYca/lTEPsSlHFSRCsJr9kx6sFLsTM
         RlMQ==
Sender: kasan-dev@googlegroups.com
X-Forwarded-Encrypted: i=3; AJvYcCU4oS5B5mhRgi8I+NsgI8CWpCIN5GO110oihFR2jxbcR0eBw2F/W012XZMZFolBnIKi40d/+vf4+B/Q+/eN3WWoyIPrvoN0CA==
X-Gm-Message-State: AOJu0Yy0RzyC2pfSpzUWtD6rmNlPRLG1Ls/pNEVWcf8768DH1I6YY5Hq
	07dLOYPIRP7/mni8qX/oS/abzDXndp/wt8925fcqcii9/MR0ApUt
X-Google-Smtp-Source: AGHT+IEykeK4mWX1szvXAL+P5PJykLcW9xs+3c66lDH8nJ4TuCDv/YYPiDaXgvzitMvjvX3ConzhWw==
X-Received: by 2002:a05:600c:310c:b0:415:6125:9cfb with SMTP id g12-20020a05600c310c00b0041561259cfbmr1411573wmo.17.1711903429652;
        Sun, 31 Mar 2024 09:43:49 -0700 (PDT)
X-BeenThere: kasan-dev@googlegroups.com
Received: by 2002:a05:600c:4ed2:b0:415:4379:d37d with SMTP id
 g18-20020a05600c4ed200b004154379d37dls869774wmq.1.-pod-prod-00-eu; Sun, 31
 Mar 2024 09:43:47 -0700 (PDT)
X-Forwarded-Encrypted: i=3; AJvYcCU6MWM4VP0zSVWnHVtLspOA397bZ2SL6XMOSpcYvbSq9HMir6bRSAlrKztolcFYWPkhXGbclPuL4YvVd8iPPtsVMGmOzY9rHlpxjA==
X-Received: by 2002:a05:600c:4e94:b0:413:fdc2:d9da with SMTP id f20-20020a05600c4e9400b00413fdc2d9damr6124082wmq.12.1711903427475;
        Sun, 31 Mar 2024 09:43:47 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1711903427; cv=pass;
        d=google.com; s=arc-20160816;
        b=CFBejsWBhT+2jug5nj7I7v8Z1XaUyz4k/X7mK/31wYTj8fKOB2WjqeMF/5BTMM1JKy
         Jkd+Lkldep1jQlhqJ+GX7oZ4jU5JB2EIwhafeOL2SlACHiwZwHAjTKvue91bdxtmi3ZN
         0LqsQdlNvT1OPSfN4ouJRrVsFwfBUZFUR6gp7GCnkIYvJECrBf3k0/eaZqNqCFbtO9qf
         Ko9uiGvHTQWkygM1l4Lm4HygRZbjNK9sBG0mFjeCbZY+9GLnrbTQUqFLj78izQb5EipI
         i4No8ZSenGlvy/aLjEZWvVe6uf1rlNf+0LQqjmxIXfUyVXtylkJozx68WFfV+xnZ3jmB
         Giaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:list-unsubscribe:list-subscribe
         :list-id:precedence:dkim-signature:dkim-filter:dkim-filter;
        bh=CjRZqXH4O9NIrKGuArot+5i7bibdSXDsEAYiGs/Hmz8=;
        fh=ZhkcRBV2GCAetYNRCtrJpTa/leoKQAVhHSCRnenO26Y=;
        b=gL4CT1+yzctwQJRmdYs1ygAVn0X7kny6g8WqMXYHD5xermhMXlIWNLGFljC0/pRyWY
         moPxA48D0vGtaCgaVkePpOBONZokm/BQYA6+Pj69l1vb9ejRnuL0EBv+vBvjBhvOUDYl
         egjg8xpoNqJCJgp9Xy5IytXOLDti316v+0EbcrE2ls6i1LrnxpefSxzhHNClFhMHcKq2
         gdQCQXEgyJ7s6dwrYVMrKg2TbRfsArRzBaBo9yhHxzH/nl+DQwE+zM7NQo8DKQ4sdy8f
         vxRKclmzscLcEMQKkQB1K2m+MupbKgXEON2lJM5U1ADt5w3gt6jMIqhxvLjhO1zkdJXO
         fNJA==;
        dara=google.com
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=bxcemWO2;
       arc=pass (i=1 dkim=pass dkdomain=kernel.org);
       spf=softfail (google.com: domain of transitioning masahiroy@kernel.org does not designate 62.96.220.36 as permitted sender) smtp.mailfrom=masahiroy@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com. [62.96.220.36])
        by gmr-mx.google.com with ESMTPS id m9-20020a05600c3b0900b0041545b0c138si259090wms.1.2024.03.31.09.43.47
        for <kasan-dev@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2024 09:43:47 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning masahiroy@kernel.org does not designate 62.96.220.36 as permitted sender) client-ip=62.96.220.36;
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3BA3A208B8;
	Sun, 31 Mar 2024 18:43:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34EuZz4vuIOM; Sun, 31 Mar 2024 18:43:46 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 758F8208D1;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 758F8208D1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 679EA800061;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:45 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:24 +0000
X-sender: <linux-kernel+bounces-125902-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAv2UFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAEoAAADligAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 20070
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125902-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 75CFF2025D
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837989; cv=none; b=WSn1iK9Ec9mmuxtAYMjNuo01o9xo3uU9jSGU2dzwaCB4OP3A7ZklY+Si9jkGS8mryS17qGqmz6fVSGJay5Ajvs8xZK3/bKWJduQ7TSYo3X1m/kHZI+Tti2GKNOcbA3Xz9Rh1lUGJbFc1xKW684fSgWUeP2XTiOcSfXR/0pHgSyU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837989; c=relaxed/simple;
	bh=wWXFZPTscxJeW0asxEFwp355Ey119yMRyA/FK3awRE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9BOU8/JE6UcLwLWYfzIP7Zig9kJRZ6/pTtECcIB/h+IG/9qyLa0bx4mCa70gqzJ9/0cJFLqfoX3YzlsunJpiuDBAFAXbcj5Fm9kmi2RvrVymjrOXaTjGJEnjrYw5onqTazuqQd6x1WKn+rZEUfohMU/2O4vWH/J2//yeuQoH4Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxcemWO2; arc=none smtp.client-ip=10.30.226.201
X-Forwarded-Encrypted: i=1; AJvYcCXCCERucJ1U44sXj5ev0CbhRNGY3JN3EhDMYNzumMFq+sUSPksYr/N7GaJKASFSr/ml/AJe+QZt4C6pmp1CFpyxs01neVoaUbM8BvhmnhqHvjCm3q120wdoni/WeXntXmLbXVu4uO16l84H
X-Received: by 2002:ac2:5a4b:0:b0:513:d234:e8c1 with SMTP id
 r11-20020ac25a4b000000b00513d234e8c1mr2020997lfn.28.1711837987085; Sat, 30
 Mar 2024 15:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com> <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com> <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
 <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com> <20240326202548.GLZgMvTGpPfQcs2cQ_@fat_crate.local>
In-Reply-To: <20240326202548.GLZgMvTGpPfQcs2cQ_@fat_crate.local>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 31 Mar 2024 07:32:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
Message-ID: <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries
To: Borislav Petkov <bp@alien8.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	Marco Elver <elver@google.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, 
	David Kaplan <David.Kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Original-Sender: masahiroy@kernel.org
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@kernel.org header.s=k20201202 header.b=bxcemWO2;       arc=pass
 (i=1 dkim=pass dkdomain=kernel.org);       spf=softfail (google.com: domain
 of transitioning masahiroy@kernel.org does not designate 62.96.220.36 as
 permitted sender) smtp.mailfrom=masahiroy@kernel.org;       dmarc=pass
 (p=NONE sp=NONE dis=NONE) header.from=kernel.org

On Wed, Mar 27, 2024 at 5:26=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Mar 26, 2024 at 08:33:31PM +0100, Marco Elver wrote:
> > I think just removing instrumentation from the mod.c files is very reas=
onable.
>
> Thanks!
>
> @Masahiro: pls send this to Linus now as the commit which adds the
> warning is in 6.9 so we should make sure we release it with all issues
> fixed.
>
> Thx.
>
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 26 Mar 2024 21:11:01 +0100
>
> When KCSAN and CONSTRUCTORS are enabled, one can trigger the
>
>   "Unpatched return thunk in use. This should not happen!"
>
> catch-all warning.
>
> Usually, when objtool runs on the .o objects, it does generate a section
> .return_sites which contains all offsets in the objects to the return
> thunks of the functions present there. Those return thunks then get
> patched at runtime by the alternatives.
>
> KCSAN and CONSTRUCTORS add this to the the object file's .text.startup
> section:
>
>   -------------------
>   Disassembly of section .text.startup:
>
>   ...
>
>   0000000000000010 <_sub_I_00099_0>:
>     10:   f3 0f 1e fa             endbr64
>     14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
>                           15: R_X86_64_PLT32      __tsan_init-0x4
>     19:   e9 00 00 00 00          jmp    1e <__UNIQUE_ID___addressable_cr=
yptd_alloc_aead349+0x6>
>                           1a: R_X86_64_PLT32      __x86_return_thunk-0x4
>   -------------------
>
> which, if it is built as a module goes through the intermediary stage of
> creating a <module>.mod.c file which, when translated, receives a second
> constructor:
>
>   -------------------
>   Disassembly of section .text.startup:
>
>   0000000000000010 <_sub_I_00099_0>:
>     10:   f3 0f 1e fa             endbr64
>     14:   e8 00 00 00 00          call   19 <_sub_I_00099_0+0x9>
>                           15: R_X86_64_PLT32      __tsan_init-0x4
>     19:   e9 00 00 00 00          jmp    1e <_sub_I_00099_0+0xe>
>                           1a: R_X86_64_PLT32      __x86_return_thunk-0x4
>
>   ...
>
>   0000000000000030 <_sub_I_00099_0>:
>     30:   f3 0f 1e fa             endbr64
>     34:   e8 00 00 00 00          call   39 <_sub_I_00099_0+0x9>
>                           35: R_X86_64_PLT32      __tsan_init-0x4
>     39:   e9 00 00 00 00          jmp    3e <__ksymtab_cryptd_alloc_ahash=
+0x2>
>                           3a: R_X86_64_PLT32      __x86_return_thunk-0x4
>   -------------------
>
> in the .ko file.
>
> Objtool has run already so that second constructor's return thunk cannot
> be added to the .return_sites section and thus the return thunk remains
> unpatched and the warning rightfully fires.
>
> Drop KCSAN flags from the mod.c generation stage as those constructors
> do not contain data races one would be interested about.
>
> Debugged together with David Kaplan <David.Kaplan@amd.com> and Nikolay
> Borisov <nik.borisov@suse.com>.
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/0851a207-7143-417e-be31-8bf2b3afb57d@molg=
en.mpg.de
> ---
>  scripts/Makefile.modfinal | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 8568d256d6fb..79fcf2731686 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -23,7 +23,7 @@ modname =3D $(notdir $(@:.mod.o=3D))
>  part-of-module =3D y
>
>  quiet_cmd_cc_o_c =3D CC [M]  $@
> -      cmd_cc_o_c =3D $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), =
$(c_flags)) -c -o $@ $<
> +      cmd_cc_o_c =3D $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $=
(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<
>
>  %.mod.o: %.mod.c FORCE
>         $(call if_changed_dep,cc_o_c)
> --
> 2.43.0
>
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



I applied.

I fixed the typo "the the" and replaced Link: with Closes:
to address the following checkpatch warnings:





WARNING: Possible repeated word: 'the'
#18:
KCSAN and CONSTRUCTORS add this to the the object file's .text.startup



WARNING: Reported-by: should be immediately followed by Closes: with a
URL to the report
#70:
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>






Instead of filter-out, you could add
KCSAN_SANITIZE :=3D n
to scripts/Makefile.modfinal because
it is the reason why KCSAN_SANITIZE exists.

But, that is not a big deal.
GCOV flag is also filtered away instead of
GCOV_PROFILE :=3D n


I will probably use a different approach later.



--=20
Best Regards
Masahiro Yamada

--=20
You received this message because you are subscribed to the Google Groups "=
kasan-dev" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to kasan-dev+unsubscribe@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
kasan-dev/CAK7LNASkpxRQHn2HqRbc01CCFK%3DU0DV607Bbr9QA9xDYhjcwyA%40mail.gmai=
l.com.
