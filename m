Return-Path: <linux-kernel+bounces-96359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD1875AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684F5B20F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2F3EA93;
	Thu,  7 Mar 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7GWCUzk"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212E3D3B9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853279; cv=none; b=RX5mB83WwnH/7o9QAAb+YP2NMLr8iAcQixHokxxXE3eH0xm5OMrIuWFuYIJa3mL8RO9TtvKgAXVbDCW6Ju+ol6TIMpqCzTdr/7kDOphmJLGLL7Fae2rEuQryK+EM4ZGkM7C3ufS/NZ+AsQFxLlxv2RtwQljG1309KdFE3bbXSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853279; c=relaxed/simple;
	bh=QYJo+Yke5aJlMyfjbI6hljoXPME1FT1iFFjSRBsn6L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5X8JwCVdC5/vf7CAIrHSkJ3IZdzgT4fCjorxcaf4agRscz47HkFObXcWDjb4EEsCyynULa1YL5h5Q9ETmG6btc1G3sBCYXuB9YiJEkYTyTYQXhKD7n5qlft3fEC49FMMJs2PNfKCTzOGm6i5b43UoaDfRsjZQILPP69sEAGApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7GWCUzk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbe7e51f91so20165ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709853277; x=1710458077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyHz5TUXyOD1YYJGciS81G7bMq+Rvo+w+wxmkrHlg0A=;
        b=W7GWCUzk+UVIYp54fKN85Wp1THw35W0g/NPlls+rsl81STxGEIf6T3ipGRyVun7ri8
         7dY1TnCnMY0tOwAmw3miaw8ZaaPCRMLfB9WhfB17MC9OqUFOyOhkhd56xZwFc5+G7Hkp
         1QK09VqELjMQB25cX0rLCPKzOGQ1wQ3tA3b5XpfqML/3RxvMd0bnTRLLMlzIbzac2NDr
         DJ7BhHaH3EnOOudDChlTGa/hTY4DPRknhZjZmvkCmj+Xs0xqwq2HAMgpTzm/Wvvu2F9U
         rRWDBWMHBH9wlqJNucJHF8/2qcWBAe6VTH69ky3TsryNHBLijtmkWkSkcpRDPTlNaA97
         RW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709853277; x=1710458077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyHz5TUXyOD1YYJGciS81G7bMq+Rvo+w+wxmkrHlg0A=;
        b=qI+uJasRyG6L4WzsRyZ7T571PD5Sl4L5PYMhqQ/uttGEorQhj3N+dAN2TsHvp5kPdG
         ArEYwFosst4C9RfGOndcZIpxKB9L54v7pDLfCdUYe2hO2Ci/n7utmui/d3ip75LHXTiK
         NN0m2my33xmq/IfpnbltDe7maoCR86kIGrJkmlCOXCOWikrplPj7oGzlkH4cvFyoaTjr
         ecxwIMHYEDJaMO9LbC257YXWj2vDdUGsJPrWJvHDcZY75Wu/w8JPJ/Yz9VerC8d5R1En
         xiQwifBSCGsaQ1Z0t+PP+ZzU4DlFgWth50oMtI3tUpSeTzL/lOE0i11uCEW3YKyqcs2G
         EgaA==
X-Forwarded-Encrypted: i=1; AJvYcCVaE9ZSEHS5aA6Qb5tPZGjbNJ3uUq4zubsmCP3se2eTDg1V0iaw5G8kE/PL2M1ilHcRqTvyQcaznLErtPcYZUELtzDGnV+InpmAkiLI
X-Gm-Message-State: AOJu0Yx3pfChn92rWAus06hXyD9WwpnnDrh4dU7z+361aC2SNymBji3X
	ISKCnnTjNEmb19jsl15Z9LI2KTXqLKlMVnqi3QNMo9eSOkg+Vrak7k5ZsZWTGlkPNtL1sDxMrGw
	yX7MzXffXkFcRcdcfB/vVN196EqugLE+1kkJP
X-Google-Smtp-Source: AGHT+IHmq5z9toYklx1GlpLQpMXFJGljcoilQ+NBPL1CrlBG4w85r1U+OFXGEhdm0PRb+dv/vG668caiuSxZqMoAiOE=
X-Received: by 2002:a17:902:da8e:b0:1d9:907f:635a with SMTP id
 j14-20020a170902da8e00b001d9907f635amr349396plx.13.1709853277038; Thu, 07 Mar
 2024 15:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201005720.235639-1-babu.moger@amd.com> <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com> <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com> <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com> <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com> <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com> <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com> <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com> <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
 <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com> <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
 <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
In-Reply-To: <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 7 Mar 2024 15:14:25 -0800
Message-ID: <CALPaoChcJq5zoPchB2j0aM+nZpQe1xoo7w2QQUjtH+c58Yyxag@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, James Morse <james.morse@arm.com>, corbet@lwn.net, 
	fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Mar 7, 2024 at 2:53=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 3/7/2024 2:33 PM, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Thu, Mar 7, 2024 at 12:41=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> I understood the proposed interface appeared to focus on one use case
> >> while the goal is to find an interface to support all requirements.
> >> With this proposed interface it it possible to make large scale change=
s
> >> with a single sysfs write.
> >
> > Ok I see you requested[1] one such example earlier.
> >
> > From what I've read, is this what you had in mind of reassigning 32
> > counters from the first 16 groups to the next?
> >
> > I had found that it's hard to get a single write() syscall out of a
> > string containing newlines, so I'm using one explicit call:
>
> Apologies but this is not clear to me, could you please elaborate?
>
> If you are referring to testing via shell you can try ANSI-C Quoting like=
:
>         echo -n $'c1/m1/00=3D_\nc2/m2/00=3D_\n'

The echo command uses buffered output through printf() and
putchar()[1]. The behavior of the buffering seems to be a write() call
after each newline, causing the kernel to see the request below as 32
individual commands.

>
> >
> > write([mbm_assign_control fd],
> > "/c1/m1/00=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;09=3D_;=
10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
> > "/c1/m2/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;=
09=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
> > "/c1/m3/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;=
09=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
> > [...]
> > "/c1/m14/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_=
;09=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
> > "/c1/m15/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_=
;09=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
> > "/c1/m16/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dl=
t;08=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
> > "/c1/m17/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dl=
t;08=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
> > "/c1/m18/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dl=
t;08=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
> > [...]
> > "/c1/m30/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dl=
t;08=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
> > "/c1/m31/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dl=
t;08=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n",
> > size);
>
> (so far no "/" needed as prefix)
>
> We could also consider some syntax to mean "all domains". For example,
> if no domain given then it can mean "all domains"?
> So, your example could possibly also be accomplished with a
>
>         c1/m1/=3D_\nc1/m2/=3D_\nc1/m3/=3D_\n [...] c1/m16/=3Dlt\nc1/m17/=
=3Dlt\nc1/m18/=3D_\n [...]
>
> Any thoughts?

Yes, that would be helpful. The AMD implementations we use typically
have 16 domains or more.

Thanks!
-Peter

[1] https://git.savannah.gnu.org/cgit/bash.git/tree/builtins/echo.def

