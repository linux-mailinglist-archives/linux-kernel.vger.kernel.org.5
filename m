Return-Path: <linux-kernel+bounces-32439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B1835BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA4B281186
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB816427;
	Mon, 22 Jan 2024 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9xDBETY"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF91B7E9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909133; cv=none; b=diFwWy5vTbNOrVEKlw0D5RlDgpC3+PPzln8WivTnUTruMzYIamSs3ugzXJ1zhiF5/ImX4+SY7ad1D5FNpPFxnZpMK1sH2v/HOBL8myFKiN/1UHzQsHSXhbSGUM+srBFxdlEipQZItdd3Ra5i1gRZglhYR/kBQT4jC99V594PGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909133; c=relaxed/simple;
	bh=I0bxZ9OPqrT/uDMzN7yVqtIrwXlVywHoghPHYVi+0rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXWDZ8S0JHD0Yg6X7JrJJpqbzQDWPrS5r0vJDc3eiFMUoxBtBpbeIcA36o/Es2+K8RwKEX5Ydry9py4plvUZ6ig3rvmb6tU1trJ4CqnF116Cl6w0mkUA44KhrpMe/8ywrAvCulFSFBUZKoRzE7dPNxr96TEwf7DhqSPCd8oXYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9xDBETY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff88cbbcceso20240927b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705909131; x=1706513931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btEptr2pD3e12BZE7dkiwHzMFQh/dHJsUOjIgsxvBmo=;
        b=I9xDBETYrGYSKN7adIm3FYpMvxquRGJxf8xozySOS+sJdL8x4SuV8Pe3ZXRmEyAAu7
         2cxDsVTBJ21LkCycrjEdaA5+LkVpYpqjXkTvJN41uDvhWj1pJf9yLWH6/dl8RP1Y21XJ
         zo4rdd/lnOan9S0qt7NahQ8M7YSggOEC04Z8+AZ5Kv0xTcLxlyoVmNa1d+P1qqNmDahY
         D+BMkQUdtwSRejXlscnoO8CBuDmp7HAvj3eCl9jPzD8Hn3YmV2A+tG/92a7CxAXjMP+9
         1Cy7Ly9YHy3LTMUkOgLDbMU4eBeYs47HslYbsxzhF3MbeK0zdCVaOMSxeQn+jwtaxWlt
         eXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909131; x=1706513931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btEptr2pD3e12BZE7dkiwHzMFQh/dHJsUOjIgsxvBmo=;
        b=vLShF7hjlEYzvM7Jx44EBEmdY+NQl3Ioxx43raeGY5qmGyrQAhJAx4Aja9udMXM1qk
         dpC+kj8b/BWVzz+aUUM/EmyZn3uXhbOBftMTDgualn783LtZAMbIooxHSRf7qhoXWjDt
         2pbSpbBz6HLrnJkZpB35ZRuKwgsfIx8KgqVjpC11XczKnHWSXdyaESocw/YkxKicpLBl
         g3f/GRUQ1Ien/7HmpqUUvzhAbxhR5c8L5c/MxuiE3Ri0mNbl6b6mJHfNsqdaM0EYgyXf
         Uqiv897wPbieZ5O1jDYodVLdcaFnd5wCSuTral6ORdi2SQVLFDqmTSxHtlLgF7WxD877
         SOhQ==
X-Gm-Message-State: AOJu0YwLLUZOAMLTeE1e2SvB7PmL+Zq/BJR/Xw2FDo3EAcBp3/V5XXbx
	PUS9GdJFoAZjciTYPq/Qmyv+knKPWJugY/k4thtxZF7HuVCQdNeO+J9vskK6+zuBoXrzRcyeHiE
	NJQuO3x2REjsvqRnG7EbiyPb6K9uZWtirJumI
X-Google-Smtp-Source: AGHT+IGjEOIHrmfM7ezfh27Xzea24O4bRYWpgPSlKnEmn5Ffc3QES0sPWXdEsTBBAXnmQNHKy//6OSpslLEBp2dKAfc=
X-Received: by 2002:a81:7202:0:b0:5ff:b07b:99f0 with SMTP id
 n2-20020a817202000000b005ffb07b99f0mr1289150ywc.93.1705909130740; Sun, 21 Jan
 2024 23:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226214610.109282-1-surenb@google.com> <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
 <Zaw31DVa9q3JZASo@shell.armlinux.org.uk>
In-Reply-To: <Zaw31DVa9q3JZASo@shell.armlinux.org.uk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 21 Jan 2024 23:38:38 -0800
Message-ID: <CAJuCfpGV_CwQm+PuiqRz3L1x7QnpgE9LQb4PPChqFv0mzbYeBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/mm/fault: fix major fault accounting when
 retrying under per-VMA lock
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: patchwork-bot+linux-riscv@kernel.org, linux-riscv@lists.infradead.org, 
	akpm@linux-foundation.org, willy@infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, palmer@dabbelt.com, mpe@ellerman.id.au, 
	christophe.leroy@csgroup.eu, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 1:15=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sat, Jan 20, 2024 at 09:09:47PM +0000, patchwork-bot+linux-riscv@kerne=
l.org wrote:
> > Hello:
> >
> > This patch was applied to riscv/linux.git (fixes)
> > by Andrew Morton <akpm@linux-foundation.org>:
> >
> > On Tue, 26 Dec 2023 13:46:10 -0800 you wrote:
> > > A test [1] in Android test suite started failing after [2] was merged=
.
> > > It turns out that after handling a major fault under per-VMA lock, th=
e
> > > process major fault counter does not register that fault as major.
> > > Before [2] read faults would be done under mmap_lock, in which case
> > > FAULT_FLAG_TRIED flag is set before retrying. That in turn causes
> > > mm_account_fault() to account the fault as major once retry completes=
.
> > > With per-VMA locks we often retry because a fault can't be handled
> > > without locking the whole mm using mmap_lock. Therefore such retries
> > > do not set FAULT_FLAG_TRIED flag. This logic does not work after [2]
> > > because we can now handle read major faults under per-VMA lock and
> > > upon retry the fact there was a major fault gets lost. Fix this by
> > > setting FAULT_FLAG_TRIED after retrying under per-VMA lock if
> > > VM_FAULT_MAJOR was returned. Ideally we would use an additional
> > > VM_FAULT bit to indicate the reason for the retry (could not handle
> > > under per-VMA lock vs other reason) but this simpler solution seems
> > > to work, so keeping it simple.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [1/1] arch/mm/fault: fix major fault accounting when retrying under=
 per-VMA lock
> >     https://git.kernel.org/riscv/c/46e714c729c8
> >
> > You are awesome, thank you!
>
> Now that 32-bit ARM has support for the per-VMA lock, does that also
> need to be patched?

Yes, I think so. I missed the ARM32 change that added support for
per-VMA locks. Will post a similar patch for it tomorrow.
Thanks,
Suren.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

