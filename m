Return-Path: <linux-kernel+bounces-137672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946189E5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B9E1F222A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB61586D5;
	Tue,  9 Apr 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="le6yobmN"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D4433A6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702481; cv=none; b=FBA+QuAMlR17S/yc5rbeR5lP62icY44CPGBetJA7gM+AiQZTwGFMZOXR1RBFOeIOV6+t0zyONY1YY4757JDlq7nwTyIsunAMjKrRsmSXAwbxM29DFx1/Myc1qpoMFQz5Jv/hYOsJSFoWJxOxz7YUZ9s0G8rjt0jBGpibbMZDD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702481; c=relaxed/simple;
	bh=3NhGzvOWJu8inKax2x217roNis9rN/Ham5KfaPA0/Q4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=mWIj0dmfklLTGwsoV2k3eFwCyWQdvCTcRK/DqAJBG5xqb84IJvWRdYLGAr13h1TPXCufKy+h7HHXIk3DK5AjNltO7y7VeEjld8lzIT2Eth1hfy0vyloAx0bnrewQoDOd08SOCX31DffCThYBFbPUJbMyO3ajD6BrAAUc9KBhkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=le6yobmN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso5127135b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1712702479; x=1713307279; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NhGzvOWJu8inKax2x217roNis9rN/Ham5KfaPA0/Q4=;
        b=le6yobmNKIk7IcTrMR7Yh1AwzfvsJdsn82Viz0c1EC3SmHM/Rx+55n58Ug4HFiHvP+
         mvLXPVPbToE1zLeMe7C1+f/FOd9XTiMtbuVNSEvBLoed+MtHbbtgyIThSBoEWKXyGwVF
         K7zRAWYmoqkOjBvgpPSaPytSO9wvKW7kAwOeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702479; x=1713307279;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NhGzvOWJu8inKax2x217roNis9rN/Ham5KfaPA0/Q4=;
        b=Sv0b9Tw2ddHTASuApWZYTswSReN7a+DBdj/ACks1saQhzLr/NKvBDtoU1rAhgthR1x
         alghdP5r+rMa+jDG5J4Tem8CP50bqDhk5/63AJWZvjR5lxYp7szGSOA3RPbofN0ym12T
         T0YfEUV+3ldYfiCWyUwinvKIcyoAs9srPrl2Xw4lBA1lCk9oc/o+M4gcA8K9NbWupTsM
         VxF8e3nvA926rfggh5cLSEasyYB8Yo/wQHcL60dA5dJhZKbG0GV6RsPX3dkuteOLY5OX
         5cKa78Xtr7feEbrEwvhkgx+Bs5UwTk/CTCGab8zocAZAd4G2A1y4k5xyPgKY7mFCMOuj
         zkKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+2C/ysZ1Cbgdd2t/w0stimUPMSrYPANw/964Wyk2s/xnWZegWB6YQ2oEFhL4G0DtoGFPbS9+E6hUKesfQ6wDCEe9uGcffQ9S9mE/q
X-Gm-Message-State: AOJu0YzDqvWeO4GScYbNs4zmO5Er5npUep57xbbT/tXFcOye4iB7TE2B
	J/c9VTT1d8XasXYKMwgedXo3sC1WHBXwqtx0COPQv89/C1opPPB7TEZsw73D3nw=
X-Google-Smtp-Source: AGHT+IGf7AyQcGgtDnxdEc6zeyqopRNu0tZWpw/6iFI0a7xHNGrXDfFFZjth8bXqtf7pRwJfL78atg==
X-Received: by 2002:a05:6a21:1a9:b0:1a3:ae75:d6f5 with SMTP id le41-20020a056a2101a900b001a3ae75d6f5mr1505619pzb.20.1712702479019;
        Tue, 09 Apr 2024 15:41:19 -0700 (PDT)
Received: from smtpclient.apple ([103.98.78.154])
        by smtp.gmail.com with ESMTPSA id g26-20020aa79f1a000000b006ecee8c8c0fsm7200440pfr.176.2024.04.09.15.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 15:41:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map pstore consistently
Date: Wed, 10 Apr 2024 04:11:05 +0530
Message-Id: <9F1B6537-F0BF-46E1-92A2-92C082DDB573@joelfernandes.org>
References: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
Cc: Kees Cook <keescook@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>, wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
In-Reply-To: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
To: "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (21D61)



> On Apr 10, 2024, at 3:55=E2=80=AFAM, Luck, Tony <tony.luck@intel.com> wrot=
e:
>=20
> =EF=BB=BF
>>=20
>>> I forgot to mention that this makes it trivial for any machine that does=
n't
>>> clear memory on soft-reboot, to enable console ramoops (to have access t=
o
>>> the last boot dmesg without needing serial).
>>>=20
>>> I tested this on a couple of my test boxes and on QEMU, and it works rat=
her
>>> well.
>>=20
>> I've long wanted a "stable for this machine and kernel" memory region
>> like this for pstore. It would make testing much easier.
>=20
> Which systems does this work on? I'd assume that servers (and anything
> else with ECC memory) would nuke contents while resetting ECC to clean
> state.

If that were the case universally, then ramoops pstore backend would not wor=
k either?

And yet we get the last kernel logs via the pstore for many years now, on em=
bedded-ish devices.

=46rom my reading, ECC-enabled DRAM is not present on lots of systems and II=
RC, pstore ramoops has its own ECC.

Or did I miss a recent trend with ECC-enabled DRAM?

- Joel



>=20
> -Tony

