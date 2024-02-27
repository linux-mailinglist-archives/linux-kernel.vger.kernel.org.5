Return-Path: <linux-kernel+bounces-83835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C3869F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8A1C27F29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E31448C7;
	Tue, 27 Feb 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wd0SMEJG"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE9249EB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058406; cv=none; b=oij1SH1R83kyH7m07Z0jf9G7FAijpA4C/3Xy7YUJFvyKyGiExuR397a59lFF8BhI3BxwddnV6rrSXFduYAD1SFMowMqTwFdgoBkRTkAomT6Y3oRcs7ineD7pUT1ANGQfZ2NPOEtZjJLEnXq6tjl1I6hrv0FV3du28fIYUfAO0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058406; c=relaxed/simple;
	bh=DPFonq905yyLK2Tj/ujCOMLw+6BX6JS4fJ8yXU1Ig1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPNwfPv2+ySlYVg+harH5qKSiYAZLhrSa1AeXPAmuzFZbTRDUyA3NqW4fqD5G1kBcJnA8Muf6ltNI89jPZv/7OwbirNUaaYeyeKA9MKRzJ96FXiAn6q155BXMbSsW+8HJnFjcqa7H4XWeOVOvFsxRDhjR5L03S4D+Wly0zY/Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wd0SMEJG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so17441cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709058404; x=1709663204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPFonq905yyLK2Tj/ujCOMLw+6BX6JS4fJ8yXU1Ig1M=;
        b=wd0SMEJGS7iKwQ6zM5YklxdhM4CU/gMya350Irc/y2Aka8IpcImDIYLWS5OAbE1fLu
         xQ0XDCxxv5cBRnz7sK/W5dltj0CuYWzErKPbBWnywYcz1czP/iWe14ui1kVHKaQGoCEy
         gqQZYSUGnn1Ju6pPhy4AaWjFiVRafxmM2F6zvvSoUe5UgkhGkEOxXAgXN2OSuvVUQetf
         6zWhi88oLdodvOloE2kB13i6VQHjpWm1IuoauHvMYYPCnXr192R3TD2G6CzvUGQLy3L/
         FW2cwpDHBeyxM5v4kwDTP5h2YijgqFG91BWaRcGgaFoJgooFo+U82qklWerXW99I/eMX
         2o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058404; x=1709663204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPFonq905yyLK2Tj/ujCOMLw+6BX6JS4fJ8yXU1Ig1M=;
        b=v7V9ogz8+nGgOnmCGPB1NsqAcFby8pF7ETxyb5LMoy3TK3gm82ksBwuW4wDGX1JR7N
         A38hijvxXKjUHqXfE0zX+nH5CRFrnHq3v5+R0qDseJxb4HHPkkSo+WbtrL2cOtbXVUw2
         g800s3trDjG6Z1IsCggwRiQTe85FI+QPjsN0DjqtzU3I1JPIeK5K4KNpvRwAbt+FPThn
         OKVvCP3NTfxWUwXV+YoHxhfuSF5Y+xr9WgGZdYbc1crksG3oxu+FkZsduMNeHkkW+LsK
         MkyYs7XBqVK3cHnuveXB6YIZfRYYtcw5nh06VBLqOG1CiAU1txuMNvl3y6OGB6DZVkks
         Tciw==
X-Forwarded-Encrypted: i=1; AJvYcCWYEk5GeuElkyjherEhr++HEenvf+J1POZYUOCyzDuGaaS8Cs8ts/HLIHB4OguXEDahmY7OfrxOkZ/LNNZAw67UL3+lr/h67MWWlqCR
X-Gm-Message-State: AOJu0Yx/w7QeiheQOc8STYN4Ux7yBNZ5W3GKAL7XjGJGxN3ihJuR7AXr
	kzgZr9VaJuXu1cZxG7zLAbQNdxXp0jpvon1FmCWnwgVySVN+xpdTEPHaJ8UwoZ6A3R5RtUMjaqU
	bcKApNcUV4fqh6up6bjbCNCrb3GfOm+E62IgP
X-Google-Smtp-Source: AGHT+IFf1ss8vs+iGe1sB+8r4oQ30VmGM2hD18Sc4fCMrxUtrPtK3ae+1eVgSnDUvqGK4rMq/0f/X+xyYtZ7yrvxTxE=
X-Received: by 2002:ac8:7f42:0:b0:42e:7b12:9688 with SMTP id
 g2-20020ac87f42000000b0042e7b129688mr307667qtk.17.1709058404169; Tue, 27 Feb
 2024 10:26:44 -0800 (PST)
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
In-Reply-To: <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 27 Feb 2024 10:26:32 -0800
Message-ID: <CALPaoCgxSAWPYGcmnZZS7M31M+gMJQ-vWd+Q5Zn1Y548bxi2Kw@mail.gmail.com>
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

On Tue, Feb 27, 2024 at 10:12=E2=80=AFAM Moger, Babu <babu.moger@amd.com> w=
rote:
>
> On 2/26/24 15:20, Reinette Chatre wrote:
> >
> > For example, if I understand correctly, theoretically, when ABMC is ena=
bled then
> > "num_rmids" can be U32_MAX (after a quick look it is not clear to me wh=
y r->num_rmid
> > is not unsigned, tbd if number of directories may also be limited by ke=
rnfs).
> > User space could theoretically create more monitor groups than the numb=
er of
> > rmids that a resource claims to support using current upstream enumerat=
ion.
>
> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
> more than this limit(r->num_rmid).
>
> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
> RMID to assign the monitoring. So, assignment limit is
> mbm_assignable_counters. The number of mon groups limit is still r->num_r=
mid.

That is not entirely true. As long as you don't need to maintain
bandwidth counts for unassigned monitoring groups, there's no need to
allocate a HW RMID to a monitoring group.

In my soft-ABMC prototype, where a limited number of HW RMIDs are
allocated to assigned monitoring groups, I was forced to replace the
HW RMID value stored in the task_struct to a pointer to the struct
mongroup, since the RMID value assigned to the mongroup would
frequently change, resulting in excessive walks down the tasklist to
find all of the tasks using the previous value.

However, the number of hardware monitor group identifiers supported
(i.e., RMID, PARTID:PMG) is usually high enough that I don't think
there's much motivation to support unlimited monitoring groups. In
both soft-RMID and soft-ABMC, I didn't bother supporting more groups
than num_rmids, because the number was large enough.

-Peter

