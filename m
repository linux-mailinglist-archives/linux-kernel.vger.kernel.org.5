Return-Path: <linux-kernel+bounces-83965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC8686A0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6E11F23C63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1431914A0BE;
	Tue, 27 Feb 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R65UT8oM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE02D60B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064391; cv=none; b=M1OGlD/RTfeIrGwgAq3Nnj5Dazvi9vxbc/cO15PQLu9Lj7pzTh7+clnXEQ6042M+oGrSrunN7wI7EKTSoPRPL3nwpYBXJrHgdrigMH0XBqkMdIKnB43DCxtQRFv954RiGQh+ntg+iWmbUePHtvNURuxgtcL8OXtI5snUZksBTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064391; c=relaxed/simple;
	bh=d9xLwO7g+4iyBmG+rDlHh3o1ro7B0g6XOQxfQO0bh5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuzaibO2IRefSnkvocZkDWzZCF0gvqvdb7/KO0vEl0l7uP+9db5h2HIOWmxsxjytYfOiC7PHk9sPy69jj/O+TVx1EpEkvc5NirqUP72AWjkoUQZqJVbXz3LdUDOeQXPGB7VZTixcGCoBZ+5Up649LAP1mC1UDheIChs90GOzyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R65UT8oM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc929e5d99so39055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709064389; x=1709669189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ/hnz7jNJ+BokDp//ndsV+GCXe8JmWh6tNQWgFFeig=;
        b=R65UT8oMqITAmOZ3YZa9j7lRSQFCGu8GjAJSsX9/g2j4E5JYKeXCugOmH1IJYZTZlu
         7n+6SozwcBV3c5ORqieGFmcqkssJ776uptr3P0ZupVRdV+X2tWOvKhFDZFVWRNba5aDp
         ZzLWsXbXHjkv/FeMwwhA1hKxnBC/vV8UFFCaJRRDTY3ohalDAv8Zxh/LSMgFHUAmiYKf
         MA/88VX+8gLUptNAyU3ZL6gJSLfAMsNo6U1vDd4ACHNQc3509U7fJr8qe8tr1Uq0IDxw
         w33GWJcWt4WxoA6+YQBmjih6S59KXBsG+bLFBYCieb0O6YIFV9kzQVrdXLN5MMk8UT3r
         QVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709064389; x=1709669189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ/hnz7jNJ+BokDp//ndsV+GCXe8JmWh6tNQWgFFeig=;
        b=s07RAGSZWaG/MjaZo1HuS3nb3f8oir1btU6oKclvmb45V3Frfc3kqp4i1Bj+j4e8Qi
         P8NxMXX6Wgx2O+oqRGkymqsctZIGjr/LgTInrJytDPXA7eTYM1PLq4rpxVsA2ue80sSA
         jZhCDVk2AXjm0yBJY8lozLYze/bSTSwKQB5eTC7JgjfmARVqZiEp1ELNQ4D8X1sIvPq4
         Bqbj45WKuMvkXeNiBQK7GkSJ47zK4fEQtobSwuu/aLiphiG9lfsq2k8wvAgUCZ5Rlfw5
         OSq1qIYjyV1uVVd4L4z6Le522FK0PwZ/CIsp5iphWTgnfIXqN3x4RUhZfMk9aZAPbvgV
         DSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7kiNkvbp3thjHkUomEG2UmKYRllEdOx2jOb7bBc+8sMls1jesIIgJ+M+jbLly8LTJhRYR+YOoEQyv0egq6qB2xmbEk8Q0ctoSbH82
X-Gm-Message-State: AOJu0YxabOT3vBMgZY5O9gE2jFUo15e4qzZSvl2QuRNejTiJZy88y3+0
	kxwJM5hppn0BcRv0fonplNF5bBUOQzA7IaB3iJU6CdlJkGZBJfV8ji7nqYcp2AZ3k7dBk7dahfF
	8/A3X9Rni8LDtpgsc46l+ScKjNUutITZT0hx/
X-Google-Smtp-Source: AGHT+IGPSiHUWAXJzZUtiKvTlohGh+wZMdBVE1DHNnrIL3SSOhb+4j7pbG6cTOpTpL6+2w9JNdhm2WEFiFR7tLuxLyw=
X-Received: by 2002:a17:903:3385:b0:1db:9fed:c591 with SMTP id
 kb5-20020a170903338500b001db9fedc591mr343160plb.22.1709064388879; Tue, 27 Feb
 2024 12:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com> <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com> <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com> <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com> <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <CALPaoCgxSAWPYGcmnZZS7M31M+gMJQ-vWd+Q5Zn1Y548bxi2Kw@mail.gmail.com> <db9a87b8-40e5-419c-b36e-400f380892a0@amd.com>
In-Reply-To: <db9a87b8-40e5-419c-b36e-400f380892a0@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 27 Feb 2024 12:06:17 -0800
Message-ID: <CALPaoChiVXWz6ObQsLZudNo+ammmPnf_iLvvETDswzwY0n0rQQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, corbet@lwn.net, 
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

Hi Babu,

On Tue, Feb 27, 2024 at 11:37=E2=80=AFAM Moger, Babu <babu.moger@amd.com> w=
rote:
> On 2/27/24 12:26, Peter Newman wrote:
> > On Tue, Feb 27, 2024 at 10:12=E2=80=AFAM Moger, Babu <babu.moger@amd.co=
m> wrote:
> >>
> >> On 2/26/24 15:20, Reinette Chatre wrote:
> >>>
> >>> For example, if I understand correctly, theoretically, when ABMC is e=
nabled then
> >>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me =
why r->num_rmid
> >>> is not unsigned, tbd if number of directories may also be limited by =
kernfs).
> >>> User space could theoretically create more monitor groups than the nu=
mber of
> >>> rmids that a resource claims to support using current upstream enumer=
ation.
> >>
> >> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only=
 11
> >> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
> >> more than this limit(r->num_rmid).
> >>
> >> In case of ABMC, h/w uses another counter(mbm_assignable_counters) wit=
h
> >> RMID to assign the monitoring. So, assignment limit is
> >> mbm_assignable_counters. The number of mon groups limit is still r->nu=
m_rmid.
> >
> > That is not entirely true. As long as you don't need to maintain
> > bandwidth counts for unassigned monitoring groups, there's no need to
> > allocate a HW RMID to a monitoring group.
>
> We don't need to allocate a h/w counter for unassigned group.
> My proposal is to allocate h/w counter only if user requests a assignment=
.
>  The limit for assigned events at time is mbm_assignable_counters(32 righ=
t
> now).

I said "RMID", not "counter". The point is, the main purpose served by
the RMID in an unassigned mongroup is providing a unique value to
write into the task_struct to indicate group membership.

>
> >
> > In my soft-ABMC prototype, where a limited number of HW RMIDs are
> > allocated to assigned monitoring groups, I was forced to replace the
> > HW RMID value stored in the task_struct to a pointer to the struct
> > mongroup, since the RMID value assigned to the mongroup would
> > frequently change, resulting in excessive walks down the tasklist to
> > find all of the tasks using the previous value.
> >
> > However, the number of hardware monitor group identifiers supported
> > (i.e., RMID, PARTID:PMG) is usually high enough that I don't think
> > there's much motivation to support unlimited monitoring groups. In
> > both soft-RMID and soft-ABMC, I didn't bother supporting more groups
> > than num_rmids, because the number was large enough.
>
> What is soft-ABMC?

It's the term I'm using to describe[1] the approach of using the
monitor assignment interface to allocate a small number of RMIDs to
monitoring groups.

-Peter

[1] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-=
cY5SvWQBg@mail.gmail.com/

