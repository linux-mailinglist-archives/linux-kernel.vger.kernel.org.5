Return-Path: <linux-kernel+bounces-96044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1787567D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A36B20EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC0135A55;
	Thu,  7 Mar 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjuPC2XX"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17553804
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837879; cv=none; b=NkbYGZ/84DNG4apfqi8szkWxQCzcSoocGUfMNi7Vv1N9D6HuTkiFoDlX9+Q8hze7L7wVp8fyD37dcfn/VbzB1dK0JE4jLNIgl7P4EGOTXbAC6EBgk4US6Xa+xKJuJgCAYpXVZbE9e/PiZEQFpuWDej48N8+LjjW8DfEmz0LcOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837879; c=relaxed/simple;
	bh=CzF6084T1W8QScTELrsPCEiFI9xcIZio9lEkN5NITI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv9W3Wq0SK9FWmDZHH39mqlGyCT88iFNBKKmMrxrVhMh9DIj7XiyPk2QcGWXLMsK90RbWIaq+JRPeHicqbVKdfZBE2MzztiUcGleJKqx06dMVoSd2k2WSyp9GdTv4s36EaSqOMXMrpjH6PX9a+fJgugAYZ+hq6XfDHDNoHfrnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjuPC2XX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so33941cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709837877; x=1710442677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ7MjSCLcASwCBb5p6tcLsf8sPaCyROu84a0ZYjWmlU=;
        b=tjuPC2XX8/pBScH3jFj2KtCF66S5JUk/s/5RbUvW9M4lvmGhPZQHh1wrvszHT6xt7h
         RS3Bu/64Crz5v2VzbHyd9+Ovs2nGpGD8yh/e+iu+dCr4uN6gEi4JfUD9YCxwIbvvtZy+
         H8pbzso2gi306neiQ5hmUIiUDKc7VrHFlCJ4f52U0WW4chnj7oNEDpGzn7Aq1dkFcovs
         rIu6RydrSESZS7krgHLzLtIPD+IoUBIm0zeEBrD6fCGmdgvItWLIHkjbfktkNjbagnsZ
         H+k8gab9Uiue4Mr+YKgAmW6+bCGTGOdChh+W4JZigsy5aKs7uaGZ117aVeiDnx41KzAB
         zoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837877; x=1710442677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ7MjSCLcASwCBb5p6tcLsf8sPaCyROu84a0ZYjWmlU=;
        b=VIiRsMC1IUA0CHMQ152tTOmXs0X993mKVMBZ39tL04lytBiATmFlpxOHUFzvMX6VTq
         9t6c789G8wlRGj3qo+wwoYdZDMltcrZjRPv5x7k9B8r9uojHP6Oo5HvcNF2O2CrlRTfv
         NCyPlLtlJh7bau/CiXT6jUmpAR2Ny4NaJ7WF3W5hmSCARCu5uO1qwO+X9kZK0zfmC8gh
         LyMOSCVI2i3L31/VBGozdTtkxnmu/0dYO/JJ9WHpsTu+Q2KeThnPgtKh0xaMwJzVnpW2
         pj18jZvqmXmzX8GJ+mD5Lswrz1ngaTuReM+FMBTvby9y81rLIchZizzUDGKnOv/Xvn3s
         0I3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4AeUr2jizJ0ycWMkQhfv4woTRA9Oihr+l99OG6kA0ewDUoqrQQqY10LmufeSUAho8EKxrx7fNCCeYLgUT7u/Wb0FOF6+tUgAlS1uq
X-Gm-Message-State: AOJu0YxSwA0/8cnFab0a0hSXPP6hECfwHR4kVeHspCMb2AIjZ0gck0AC
	+Ylmvi5nhQYOAuoPJGyqaROe+PTBITm4FrCtqXGuRiqDSSCB34VLAmQ8+MTR5SSFkpX3dXB1535
	70hxo9rKpHh0zfTK4AXzYiyP9HFDz+ZPK8jx2
X-Google-Smtp-Source: AGHT+IHCuoXMd9Xg14UB44fEmJvJ1GBMDqfoF1cqrnYO3BFbg1ZEayUCInc92PMjeRbI46b5djDN6F9LBOb1yQtbCnI=
X-Received: by 2002:a05:622a:64c:b0:42f:a3c:2d47 with SMTP id
 a12-20020a05622a064c00b0042f0a3c2d47mr452569qtb.8.1709837876988; Thu, 07 Mar
 2024 10:57:56 -0800 (PST)
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
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com> <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com> <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com> <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com> <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com> <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
In-Reply-To: <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 7 Mar 2024 10:57:45 -0800
Message-ID: <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
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

On Mon, Mar 4, 2024 at 2:24=E2=80=AFPM Moger, Babu <bmoger@amd.com> wrote:
> Based on our discussion, I am listing few examples here. Let me know if
> I missed something.
>
>    mount  -t resctrl resctrl /sys/fs/resctrl/
>
> 1. Assign both local and total counters to default group on domain 0 and =
1.
>     $echo "//00=3Dlt;01=3Dlt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_co=
ntrol
>
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>     //00=3Dlt;01=3Dlt
>
> 2. Assign a total event to mon group inside the default group for both
> domain 0 and 1.
>
>     $mkdir /sys/fs/resctrl/mon_groups/mon_a
>     $echo "/mon_a/00+t;01+t" >
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>     //00=3Dlt;01=3Dlt
>     /mon_a/00=3Dt;01=3Dt
>
> 3. Assign a local event to non-default control mon group both domain 0
> and 1.
>     $mkdir /sys/fs/resctrl/ctrl_a
>     $echo "/ctrl_a/00=3Dl;01=3Dl"  >
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>     //00=3Dlt;01=3Dlt
>     /mon_a/00=3Dt;01=3Dt
>     /ctrl_a/00=3Dl;01=3Dl
>
> 4. Assign a both counters to mon group inside another control
> group(non-default).
>     $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
>     $echo "ctrl_a/mon_ab/00=3Dlt;01=3Dlt" >
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
>
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>     //00=3Dlt;01=3Dlt
>     /mon_a/00=3Dt;01=3Dt
>     /ctrl_a/00=3Dl;01=3Dl
>     ctrl_a/mon_ab/00=3Dlt;01=3Dlt
>
> 5. Unassign a counter to mon group inside another control
> group(non-default).
>     $echo "ctrl_a/mon_ab/00-l;01-l" >
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    //00=3Dlt;01=3Dlt
>    /mon_a/00=3Dt;01=3Dt
>    /ctrl_a/00=3Dl;01=3Dl
>    ctrl_a/mon_ab/00=3Dt;01=3Dt
>
> 6. Unassign all the counters on a specific group.
>     $echo "ctrl_a/mon_ab/00=3D_" >
> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>     //00=3Dlt;01=3Dlt
>     /mon_a/00=3Dt;01=3Dt
>     /ctrl_a/00=3Dl;01=3Dl
>     ctrl_a/mon_ab/00=3D_;01=3D_

The use case I'm interested in is iterating 32 counters over 256
groups[1]. If it's not possible to reassign 32 counters in a single
write system call, with just one IPI per domain per batch reassignment
operation, then I don't see any advantage over the original proposal
with the assignment control file in every group directory. We already
had fine-grained control placing assign/unassign nodes throughout the
directory hierarchy, with the scope implicit in the directory
location.

The interface I proposed in [1] aims to reduce the per-domain IPIs by
a factor of the number of counters, rather than sending off 2 rounds
of IPIs to each domain for each monitoring group.

-Peter

[1] https://lore.kernel.org/lkml/CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZD=
mhR9RQapw@mail.gmail.com/

