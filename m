Return-Path: <linux-kernel+bounces-168210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643EF8BB525
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E7B22419
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A738DE1;
	Fri,  3 May 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiLoik8x"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6142E85E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770035; cv=none; b=d+Q79aZmb1M04VxHjutovicsnjzfo1aYpSwipYUMYZ7a6yYqzEEDNT7b+DrE/zMCAF0tKQJyxuRWoM0c9Mrx1hCUzTW8VKV2Jncz9V3/9yjxIZ1DwN8g9H8jYzc7ZK8J+kQJXSYBP9Cc+lWRmYqzFgS5vNai1krZMVQSkql/aqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770035; c=relaxed/simple;
	bh=cjuvDeKp4X9JIYKyqCJmxX+PFjcdi9fQ1jJZtd6qw34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SevdeT2bNSbXLJbGD9OwXSpGTFNDU5ySsZ/T9Rd4U7JROYxeZSm5eSbH6yZ2HzebhNDIi8kjZko9mEvFpEeL7AL+eBrTCUga24zBaAh7eQrhS7KDpGWcErRGJ67dbX4tGJFsG7qoYr1KE4Uhs5HsQoOHtFtws+/sVZip3TV86sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiLoik8x; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43ae23431fbso18121cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714770033; x=1715374833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjuvDeKp4X9JIYKyqCJmxX+PFjcdi9fQ1jJZtd6qw34=;
        b=wiLoik8xf1dL3rDpgOfkuFX2Y91V1OdgA51BT7QYAS98Op8s2BaTJGLGdxEzmXy+ZR
         IQOMZynMaNR7/wofcso8hMQO26OVe7ZKtO9tjAJmKMHhuajeG7DrgNLndlxxO3/MBoPd
         cpqkmpOxpo6HQHylLUxeyK8/+gV8dxjF26VDh8on8qXqnfUE4/3Z0ajdJYpNeld62r4M
         rEGfeeneLPG/xs0v054Ff7bhg6EIbhdmp54zJ62ksmGS9upUGQ9A1w7C6QzfiZ4+kkuY
         BtINllx3u2e+v9gAhBT7FQMfmzkoF7AZJQEL+eqK+InIoJYGf6ITcOUK1agkz/a1Vb5h
         TkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770033; x=1715374833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjuvDeKp4X9JIYKyqCJmxX+PFjcdi9fQ1jJZtd6qw34=;
        b=hh93Z3jlArll6YNDp0BEp6jZ/JjXORAAPKISEEgdtK5rB/SDRuOSOBbiUNFvVfGpyD
         ZJgWlEkAdZ5SgQCaXPfAOLSn0j+Ux3yD5Y5vj+95rOyTsPDw9PqUSI4nTwiq6j73p4TB
         3B2AFQC0NYjId99sSGFRBbij6ihBgUV+gKkRSSQ5xcib6Y2SUMkNlWo6pgRad5Dc80sH
         z1UIs3266tSIT27R5ii7tla7r+1ikX6Oq/Y67EgovqzW2Lb1XmYpBtJpx4KqT95227wk
         Yz2OLfrh4YxUnGNbjQ6uU9SryR6lKACFltEBTtYhKq8ZGSf5yitzfOzrvskduwA73Zob
         85zw==
X-Forwarded-Encrypted: i=1; AJvYcCXtJtqYHMYQN5nFKZCrU8trSrJSPxx8WW/h6cEWIKVZy+OwwwynzW1vDSH0essKL0Gon6eZcah4uI2ySZFM8gD0+9PXN9eRr348646F
X-Gm-Message-State: AOJu0Yxguz6n9Yq2wzRFzGZSFiNPQ1mytBd+RoSX8ursuwscjOnvkyLQ
	2nb+mCjxhfRQ3PRdrOd8TyI6u0Wm6WnVuO75Pkmwfih0ZZAsLSeCgbjtPUCGuhBtbBl49O8fpG+
	4CRs4izLr53drWcsqHMWCymYVf4+lrgH9xcJg
X-Google-Smtp-Source: AGHT+IEIGy4nqYGH86PDEWSQhg7IkncqGap7dmwBx14xP6Jh9GdrFdigevbJYYU7UTVaEYBgRYxv/BBebFRnyTDfMVY=
X-Received: by 2002:ac8:7d01:0:b0:43b:43c:2e05 with SMTP id
 d75a77b69052e-43d088fa520mr98671cf.19.1714770032856; Fri, 03 May 2024
 14:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com> <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com> <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com> <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
In-Reply-To: <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 3 May 2024 14:00:21 -0700
Message-ID: <CALPaoCiu2_UHyGjsyitz28BL1N93TSn28E1r-6nhXg--bzmU+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net, fenghua.yu@intel.com, 
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

Hi Babu,

On Fri, May 3, 2024 at 1:44=E2=80=AFPM Moger, Babu <bmoger@amd.com> wrote:
>
> Hi Peter,
>
> On 5/2/2024 7:57 PM, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Thu, May 2, 2024 at 4:21=E2=80=AFPM Reinette Chatre
> >> I do think ABMC should be enabled by default when available and it loo=
ks
> >> to be what this series aims to do [1]. The way I reason about this is
> >> that legacy user space gets more reliable monitoring behavior without
> >> needing to change behavior.
> >
> > I don't like that for a monitor assignment-aware user, following the
> > creation of new monitoring groups, there will be less monitors
> > available for assignment. If the user wants precise control over where
> > monitors are allocated, they would need to manually unassign the
> > automatically-assigned monitor after creating new groups.
> >
> > It's an annoyance, but I'm not sure if it would break any realistic
> > usage model. Maybe if the monitoring agent operates independently of
>
> Yes. Its annoyance.
>
> But if you think about it, normal users don't create too many groups.
> They wont have to worry about assign/unassign headache if we enable
> monitor assignment automatically. Also there is pqos tool which uses
> this interface. It does not have to know about assign/unassign stuff.

Thinking about this again, I don't think it's much of a concern
because the automatic assignment on mongroup creation behavior can be
trivially disabled using a boolean flag.

-Peter

