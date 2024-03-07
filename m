Return-Path: <linux-kernel+bounces-96331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F9A875A52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8F92841BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18201EEFD;
	Thu,  7 Mar 2024 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="zVn/fyB2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68128EAC5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850820; cv=none; b=hkAG4U3psNsbzz9MXiB8kfK5X0S/dH9JcJ5TSHZOoyOxZqtUzQYPjPagjVtMqDGawDNmA06775xrkE460RPX32Hqxz0nVAi0d+FZRXroZN2KzpSSydbZz4xmGSj+SSgiboEs4CU3sI8g0c5XH4wsUe66InqYHwzS9jCCK0MLa+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850820; c=relaxed/simple;
	bh=QbDis9ujWvuB0TYY5cBvwKUESqVYZJvTZUmWWDNAkhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5D5xx/Gg0I697+LSHtg3cEvsipyZUCeL/2pGxljHzDoG3OeWPaBhpnRyHhc02ECajACUM+Dfz7+2zKo637dSLjj80WDiLbnrvtURBzAWcJ26TaLyo72i99aCoJqvp3pa9eQSItLk9iGKT7E1ZFPFzkXMWL1fMxlEW7jezrYv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVn/fyB2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dbe7e51f91so15545ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709850819; x=1710455619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwoHx6pFclZwDPDo6xMo9qj+spO2iNkCl5a9WRNRG4I=;
        b=zVn/fyB2q9YijD3m8VOF3lnz5oVtSShzNv/1vtVwWzCBleglVtgYM+7F731sQx6gPj
         3bpSqnexQjr9ptfHCOPr42iAL7CyQGXu7uNRl0AbBDSQU4o85v/gBXkgz8BpBzxNRPcj
         pEKNP+aLaSUC6BS1VZ88+fxAxwZBxb+9rz5J8/aNAbKISz6JT1MCjMHWBqztbu6fIhMn
         29ic0/z7KkDyFz69k24Cd6BzAn0Q4neb2VACmMsK23vxad7Z8UcKNkzkDQePfLHVUhsG
         Q/W/ZaC0F/ORVraKgE5aJbDjTtatUax+BAk73ZXKZPcRYN4QiVhACZ/s9vRqXijI+gd5
         tVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709850819; x=1710455619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwoHx6pFclZwDPDo6xMo9qj+spO2iNkCl5a9WRNRG4I=;
        b=Wh7KcCuH7cwbY8DJEVR1RYqts/S+u8aHRWRkLGI4B/cAQMpFULnbVuxgWcr61w+bK4
         e/QUC9qY2UkVDDU10OhHzUfNHqFSHNiUY/g1DDltKbPrFzYzdHDhFfvvU9y/ym7wYvCe
         OdET657iM53tSW1w/LNAJil02Pub0HPyp+rzSzLqO2W7sj/a6WdIcg2pf3EHUlQEaaZG
         7LLcL2rbx/6uCVJwLe47lydEx9NNljkE7Ym8I28v7t5Ng92QwPWHqGh03ZZE5LCoabRl
         YVuxin2Swm0yOxu7i6ctRZt23exmpbzF19C3oIoFnYmhT/TCXUHCRnvwCj7bR7B/r5zk
         E4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCX86aHabaXYRupNz6xEfHzzYVtKQcvxzxWMFj8lMSCb6UoO7f6swO6Qnfjd9k14/U1jaCxcalrO+wzavUEL3llBYMcqhw9IR7Ynt7NH
X-Gm-Message-State: AOJu0Yyf8YMgtUb0Iuh2XX6ijc5wI8jK3gKwwEH69E8ws6B6IVyXu6VK
	f79yrtPWbQ5sAGs0XpFGYHnBs1UChdJUcVFd0vX22I8lrVgRx19zGK17ZCQXDz/cIEG2YhYF54H
	rkw+KTjRYsie7YFoIRNgCdqDZIEsZGcaI+Svt
X-Google-Smtp-Source: AGHT+IH8joqJaopWnia83uUglJxjYZKrs0uxqst5KlhJslS+vRluQ3uvl6piEoeV/n8SDEWkaG552qMJeNScoGKrrrs=
X-Received: by 2002:a17:902:ea03:b0:1dd:8f4:dd8 with SMTP id
 s3-20020a170902ea0300b001dd08f40dd8mr345694plg.3.1709850818292; Thu, 07 Mar
 2024 14:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201005720.235639-1-babu.moger@amd.com> <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com> <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com> <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com> <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com> <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com> <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com> <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com> <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com> <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com> <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
 <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
In-Reply-To: <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 7 Mar 2024 14:33:26 -0800
Message-ID: <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
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

On Thu, Mar 7, 2024 at 12:41=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 3/7/2024 10:57 AM, Peter Newman wrote:
> > Hi Babu,
> >
> > On Mon, Mar 4, 2024 at 2:24=E2=80=AFPM Moger, Babu <bmoger@amd.com> wro=
te:
> >> Based on our discussion, I am listing few examples here. Let me know i=
f
> >> I missed something.
> >>
> >>    mount  -t resctrl resctrl /sys/fs/resctrl/
> >>
> >> 1. Assign both local and total counters to default group on domain 0 a=
nd 1.
> >>     $echo "//00=3Dlt;01=3Dlt" > /sys/fs/resctrl/info/L3_MON/mbm_assign=
_control
> >>
> >>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>     //00=3Dlt;01=3Dlt
> >>
> >> 2. Assign a total event to mon group inside the default group for both
> >> domain 0 and 1.
> >>
> >>     $mkdir /sys/fs/resctrl/mon_groups/mon_a
> >>     $echo "/mon_a/00+t;01+t" >
> >> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>
> >>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>     //00=3Dlt;01=3Dlt
> >>     /mon_a/00=3Dt;01=3Dt
> >>
> >> 3. Assign a local event to non-default control mon group both domain 0
> >> and 1.
> >>     $mkdir /sys/fs/resctrl/ctrl_a
> >>     $echo "/ctrl_a/00=3Dl;01=3Dl"  >
> >> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>
> >>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>     //00=3Dlt;01=3Dlt
> >>     /mon_a/00=3Dt;01=3Dt
> >>     /ctrl_a/00=3Dl;01=3Dl
> >>
> >> 4. Assign a both counters to mon group inside another control
> >> group(non-default).
> >>     $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
> >>     $echo "ctrl_a/mon_ab/00=3Dlt;01=3Dlt" >
> >> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
> >>
> >>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>     //00=3Dlt;01=3Dlt
> >>     /mon_a/00=3Dt;01=3Dt
> >>     /ctrl_a/00=3Dl;01=3Dl
> >>     ctrl_a/mon_ab/00=3Dlt;01=3Dlt
> >>
> >> 5. Unassign a counter to mon group inside another control
> >> group(non-default).
> >>     $echo "ctrl_a/mon_ab/00-l;01-l" >
> >> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> >>
> >>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>    //00=3Dlt;01=3Dlt
> >>    /mon_a/00=3Dt;01=3Dt
> >>    /ctrl_a/00=3Dl;01=3Dl
> >>    ctrl_a/mon_ab/00=3Dt;01=3Dt
> >>
> >> 6. Unassign all the counters on a specific group.
> >>     $echo "ctrl_a/mon_ab/00=3D_" >
> >> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> >>
> >>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>     //00=3Dlt;01=3Dlt
> >>     /mon_a/00=3Dt;01=3Dt
> >>     /ctrl_a/00=3Dl;01=3Dl
> >>     ctrl_a/mon_ab/00=3D_;01=3D_
> >
> > The use case I'm interested in is iterating 32 counters over 256
> > groups[1]. If it's not possible to reassign 32 counters in a single
> > write system call, with just one IPI per domain per batch reassignment
> > operation, then I don't see any advantage over the original proposal
> > with the assignment control file in every group directory. We already
> > had fine-grained control placing assign/unassign nodes throughout the
> > directory hierarchy, with the scope implicit in the directory
> > location.
>
> The intent of this interface is to support modification of several
> groups with a single write. These examples only show impact to a single
> group at a time, but multiple groups can be modified by separating
> configurations with a "\n". I believe Babu was planning to add some
> of these examples in his next iteration since it is not obvious yet.
>
> >
> > The interface I proposed in [1] aims to reduce the per-domain IPIs by
> > a factor of the number of counters, rather than sending off 2 rounds
> > of IPIs to each domain for each monitoring group.
>
> I understood the proposed interface appeared to focus on one use case
> while the goal is to find an interface to support all requirements.
> With this proposed interface it it possible to make large scale changes
> with a single sysfs write.

Ok I see you requested[1] one such example earlier.

From what I've read, is this what you had in mind of reassigning 32
counters from the first 16 groups to the next?

I had found that it's hard to get a single write() syscall out of a
string containing newlines, so I'm using one explicit call:

write([mbm_assign_control fd],
"/c1/m1/00=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;09=3D_;10=
=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
"/c1/m2/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;09=
=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
"/c1/m3/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;09=
=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
[...]
"/c1/m14/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;09=
=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
"/c1/m15/00=3D_;01=3D_;02=3D_;03=3D_;04=3D_;05=3D_;06=3D_;07=3D_;08=3D_;09=
=3D_;10=3D_;11=3D_;12=3D_;13=3D_;14=3D_;15=3D_\n"
"/c1/m16/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dlt;08=
=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
"/c1/m17/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dlt;08=
=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
"/c1/m18/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dlt;08=
=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
[...]
"/c1/m30/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dlt;08=
=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n"
"/c1/m31/00=3Dlt;01=3Dlt;02=3Dlt;03=3Dlt;04=3Dlt;05=3Dlt;06=3Dlt;07=3Dlt;08=
=3Dlt;09=3Dlt;10=3Dlt;11=3Dlt;12=3Dlt;13=3Dlt;14=3Dlt;15=3Dlt\n",
size);

Thanks!
-Peter

[1] https://lore.kernel.org/lkml/d29a28c8-1180-45ec-bd87-d2e8a8124c42@intel=
com/

