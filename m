Return-Path: <linux-kernel+bounces-104684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2C87D250
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AF9283B48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5652F68;
	Fri, 15 Mar 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qMayhCI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0C524DC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521823; cv=none; b=mk3Jkpw/o4QJWY+uDe5aAJiXRSNbHmpMxGMJhXfo+YlkNfRVJkiMt8eYQ4hb7Rc6c0mKJIS0RROoun8qXor9P0nhbcW8+dWYNZbhbeX2oJ6q/flqmwADWOACbHXnaqnglhXKz+JRjXPXTFl+Aju4CplwIVQv/dJ7JQYgfrDU3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521823; c=relaxed/simple;
	bh=E2OI4i5n9GVXkESNFOdLrFqVM1pPOMkBwMkePCVCQ90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajku68TwL77r251r0WIFgIG31hFzj524pOsKlmmgpMYo1FU9HulraZMKgAiNnOaIr1acioUoUfnBQs2CJXU9C7YXBbUVZgVo8YhTKStjWal+CHozMvDR0appJlVfl2VyAossJWXdXeCQg6lzOYVXC4MPCbGCY7E8YBhYYN6DIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0qMayhCI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1deddb82b43so5575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710521821; x=1711126621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOdUPZH9jjKky/AACg3rAI21s+PSpiMVtvk5TCW6C+c=;
        b=0qMayhCI0dqBkEhT7SNoZ21NbVhdBaIM67B1R2Sf6yzAyVbCWKHAD5bOk7cvFtLgG1
         /97F27r5hsNSCYL1FP5e9NQfoVuViCHQ+pOEpedn/12JiSn1ZNcgzrDWTwzP4gs9osDG
         oPiOiSm0sQm6DQyVnVJNa3b1090ze6Ev6kZMP52hqxgOeaglp0GoEOwREvYORfF5w/Ns
         GoFccUriHMAyMrQXX/ooM1ymopENBFQt3nq43UmXDPs9CR90MJPTW+tFMuWxnGKyhHpq
         MmvihqOKgfrJ7d76yxGcK7ODnpsMgR8aq4tPE08HB3QH4XUdtwd6k8r3qJmaQoMqRvjB
         cL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521821; x=1711126621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOdUPZH9jjKky/AACg3rAI21s+PSpiMVtvk5TCW6C+c=;
        b=bGYg96pGq3k2lGiuMjER5r3+1bpqNbQFLsHPb2QtyZma6kp1X4WnBIJk2C3RjAOxQ8
         lXDK/WXpM8MhQa56xtNATJvPAvDqrAqPImvtvdmn0GOIlwRj3gOhaxGlElYtuNnbL6YX
         P5C1ovtLTl4UosXYznnOHTNElyk2ePj9icxuE9Zb4Qc4aLmPUCPuYHtaFxapuILDqe92
         FQTrYgRpOlxdLPtkmoU+gARRtnrWgR4gGfHGMOU1MqrfBR1IQ8hUHcLm8a6ASvxv6iFY
         DwZeK00isVrRHjPVAz+6+FYCUg2rxyDgf39XLJC3Zv1yyxL+nmwh91fXvZ6QkR+rgPAx
         IYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeqFthcTjdXlcXn4/fxmQsqZEs1njhTmvZIICZcalMeZoQzU0aDTuV94lqPsE6y4wLp00aepji+OCT8c4soYAhkWzFjuHzPZIsmZp8
X-Gm-Message-State: AOJu0YyNT5NbUda+GUbdu9r/llM6dm/zSXudC4llZZujVjxkRHntRMHr
	6q2GNsXZBNCjNw5Zz7YNoqciAxwfOyrsgwNdbz3wf7TjH2hdV4tpquJ6Nh3Jj/hn2BzY4R8MuHC
	weirsW/ZnpHtbzAmYuqe2GfQW9YtrgfuIQ4XD
X-Google-Smtp-Source: AGHT+IHgb8yP0wjRX30CRr9rgbxk9sIje//+hR0P2deDL/MDqt3+UWa+goz1hS3vf46MxrpfF+jeEXGCQoJH8o9Z23Y=
X-Received: by 2002:a17:903:186:b0:1dd:8a51:7b1f with SMTP id
 z6-20020a170903018600b001dd8a517b1fmr230613plg.23.1710521821096; Fri, 15 Mar
 2024 09:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312075349.977-1-rex.nie@jaguarmicro.com> <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <162f5113-4eb6-dcea-f034-c81b9dc021b6@amd.com>
In-Reply-To: <162f5113-4eb6-dcea-f034-c81b9dc021b6@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 15 Mar 2024 09:56:50 -0700
Message-ID: <CALPaoCjorOe8FVOu6_sMrG_8jAgSNNsw8=KDwOrwtftovGiRXQ@mail.gmail.com>
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
To: babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, Rex Nie <rex.nie@jaguarmicro.com>, 
	james.morse@arm.com, "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, fenghua.yu@intel.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:17=E2=80=AFAM Moger, Babu <bmoger@amd.com> wrote:
>
>
> On 3/14/2024 10:25 AM, Reinette Chatre wrote:
> > +x86 maintainers, Tony, Babu, Peter
> >
> > Hi Everybody,
> >
> > On 3/12/2024 12:53 AM, Rex Nie wrote:
> >> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> >> index 7a6f46b4edd0..096317610949 100644
> >> --- a/fs/resctrl/internal.h
> >> +++ b/fs/resctrl/internal.h
> >> @@ -94,7 +94,7 @@ union mon_data_bits {
> >>      struct {
> >>              unsigned int rid                : 10;
> >>              enum resctrl_event_id evtid     : 8;
> >> -            unsigned int domid              : 14;
> >> +            u32                             domid;
> >>      } u;
> >>   };
> >>
> > resctrl currently supports 32bit builds. Fixing this issue* in this way
>
> I have never bothered about 32bit builds.   Is Intel still testing 32bit
> builds?

I can confirm we don't have any 32-bit builds.


> The structure pointer "union mon_data_bits priv;" is created in stack
> and passed to create mondata directory. We are reading it later again in
> rdtgroup_mondata_show.
>
> How is this pointer valid again?  Shouldn't we use static pointer or
> allocate memory for the pointer?

The union is copied by value into the pointer-sized field, hence the
need for pointers to be large enough to hold this value.

-Peter

