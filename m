Return-Path: <linux-kernel+bounces-132003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C2898E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7011F27B57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA167132816;
	Thu,  4 Apr 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQB/EhkI"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1251304A9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257278; cv=none; b=KPGcIM8xJxe90OpexNtkM+x5OumW8gdHfT2zjYXDsr0tboy3m+3LR5S9ABENB3L0JoTzOVOWNXOUIeB0nI/Ze5Mi0syG7tfZsvc41yHHC+eXiDDvgmKlHIu45A6rcHbLEAbALVVZmCDNCPEAnGvvN8BJuU1/82Q8xRAx9uJP2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257278; c=relaxed/simple;
	bh=6F9JtmS6q3l7l4wzo0k5Ul6ynXqiVKXW/Eg8kXMxe48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzg+NapNqh4L/cHUEIrwd+HPsao6swITtP0VDz9OZVXvxa8bhPxaom5yldIGQPWqKrGeBEGwSkh2j7+xZ+KGej6D7m/tT6UUGKsg8q1FvHPY2mSnsuusSJF1CmgfWU73DYQSj4USIB45Hs3p35aK5n5qZXhHI9/ZCVSV6zi/9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQB/EhkI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-432d55b0fa9so70331cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712257275; x=1712862075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F9JtmS6q3l7l4wzo0k5Ul6ynXqiVKXW/Eg8kXMxe48=;
        b=QQB/EhkIWZHPWusjUoiSwg0Qg/UPp24eWEfbD2ncbRHKrnRs9SmCRHIa0XrrMDjs3J
         Onw/zAIrujasxi0grcnWopVH2gCmtzoKcwTepjam40IpIHB8/1pMCCVzq8rRbHErFhhO
         W5aoMV1rJRUP66aDBocZaJ84Wh5mb/4tRc0zzW4zhPg03AfJaMdOAROjVIOiRWGl20/h
         Y03dcTTjukzk8O8iSBA2rz+HAaaZazBUN0sNq4L+Mg8eClKjaEdD0vN5I99MJ40+28Ji
         SOVme6VFATIRTpMkeczBgKpjtCuRGVca7gygVUcff7XlsYQoF3b3YG8XWUs8qVI5UBP0
         FiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257275; x=1712862075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F9JtmS6q3l7l4wzo0k5Ul6ynXqiVKXW/Eg8kXMxe48=;
        b=GOJ4OTVDnupU+w/l6H1513sAvZPyq1HOUYNrT7hhQKePCk203L4HHt3mQVrDa3CF2k
         BztR/vPeK3+1gxkBvHVhMovpnRgI/z+6z5F4qeFTpq0WjBtlP79efCQLRbMDFJGT0Ch+
         tIod+88lg3dMVmoyQHkzx4xLwjsKVEV0yLnzXYnHXhnAxR0rugSE0HOrmWA3AzeqGO7/
         xsDM8Wu3IU4q/1Y9C9VfMuRGKFtgV9RE9as4OHslAitJDk9Ur0q3wRFXFiMFOT1KA5Gz
         2SJSn6BmhvKFPxO8rbexkaFQ4e0IpqMXY6ecoJjpuP9fZNAyOIk0qbR5MV7j0fCgA7Xi
         ex0A==
X-Forwarded-Encrypted: i=1; AJvYcCWZGAWxyufwlUVz4awF97qdX1dT1oE4fOqISin0GqNj1NEC0vopBnS2JclGgzVH27bthk5/IUKWwBWB9veh2RcIPZQMXpWsf89JDTAF
X-Gm-Message-State: AOJu0YzeIBjRxLYUv5Y1p+dEmeeovgjiJ1YoPXsnJxyuZ5YKoEaamrYa
	GkS5mWirdohXG2J4B4HDaLtuwaW4T1kuVXRliI7wgramYVurJOklw/Fj7oVEywcpMZ6GsBOE73h
	NQHTdL1XSlYzzXSpPRDOY0/6eI+zc6amZcl3x
X-Google-Smtp-Source: AGHT+IGscPnJMaTflamSyiou6qNPGPoJh7bHworqGeF+ZpFaqtTdQxOvpK0LbohyrD8zZtbSFVEzTa9SHwxS88UjGC4=
X-Received: by 2002:a05:622a:1808:b0:432:fea5:e3b4 with SMTP id
 t8-20020a05622a180800b00432fea5e3b4mr242008qtc.3.1712257275379; Thu, 04 Apr
 2024 12:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com> <08c8162a-f7d7-4e78-8a2a-d9c86780429c@intel.com>
In-Reply-To: <08c8162a-f7d7-4e78-8a2a-d9c86780429c@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 4 Apr 2024 12:01:04 -0700
Message-ID: <CALPaoCjTbTStJiSYRCtcdDgqyNvFrbF3WH3iW18nq8Qk5D4BZg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Apr 4, 2024 at 11:43=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 4/3/2024 5:30 PM, Peter Newman wrote:
>
> ...
> >
> > Presumably this would be called holding the rdtgroup_mutex? Perhaps a
> > lockdep assertion somewhere would be appropriate?
> >
>
> Considering that you are digging into the implementation already, can
> it be assumed that you approve (while considering how "soft RMID" may
> build on this) of the new interface as described in the cover letter?

Yes, I believe we came back to an agreement when discussing the last
series. I'll look over the cover letter in this series just to make
sure everything is there.

-Peter

