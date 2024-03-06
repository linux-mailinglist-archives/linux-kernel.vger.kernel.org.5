Return-Path: <linux-kernel+bounces-93973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB808737B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B6B23004
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C157130E40;
	Wed,  6 Mar 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vpiapz6t"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37A8615A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731625; cv=none; b=pgkTijevorJrI25LNjfm/iQf5nqjG7ZZcf1hfXNbgrbfpnnZEuJVsxdhGHvbtYmA57RxRuumk8rzQZqBWx8nEHMaOwOB8roFS/6cwkSWEMAIuRiEgWmmaY+BVLzEY0P9sIxDh527CUtra8xnPhiMwHwb4/wPvZxs3r8BKYdBotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731625; c=relaxed/simple;
	bh=yTTBKW3S6AHHJkeUW4yDspV4mq5EkRrqCQYaROMKfSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sshgiPghf+tWYuOUQyO3QYIGYci7xD6ey9qTY/WfuUshc0UK/LA204V6uzSNFlTDBY7WhshaFxZY33H8MwtJ+C/t8mr+HDchMizpP3getZiwjBb8SNirxMR1CMyWdxUhX2cnIR+piTTXLPIDGd0VUa1LNlSbRwrPg4vkh4hqp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vpiapz6t; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21fe1bc5fc4so321152fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709731622; x=1710336422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTTBKW3S6AHHJkeUW4yDspV4mq5EkRrqCQYaROMKfSE=;
        b=Vpiapz6tjyBQuANvuGmUQHwuM4GBzIACcMiyWAJay7mJaxVD49e/TmNkVY8LCePry1
         uIOB0KsvUP5BVdt0XL3RxHd1AfCWCeL7aM35tiX92u/dfA5V4tmSknMuJyt5YTX3OtvM
         sqvqgMKsG3m7X/tU5+azTbnOlWl1ZsaOiUfLJn3X8QAaa1BzGB/TN5vwb4prl2YLRrmV
         MU0qd6ciLee17t1HtcLKrTMRL0jfKcikaT/nhqYDMxNYJro2fsSexZb/5fVMziCGasJ1
         aYdrt6orCqMBTqkmOvnjG6cry/W6ROuSC+GmRioRJqSC/a2E7N+sxmt10jbA+Zb7xj1U
         7gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731622; x=1710336422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTTBKW3S6AHHJkeUW4yDspV4mq5EkRrqCQYaROMKfSE=;
        b=jS5z1YvjSH+L1Sb1o+X3J99pU6m3r++Ag0qdryTnDsvDgrDN8LnMSKMUP+R2MEKhVk
         1NYjD2A8ZJa8SKztvWMNfQbiGW9piVo02oYeXtSrpixEqK5e5ZTFKxHw/FlJUK2wu8Tu
         iNACukZSrG4UOqlzqu8PHprCiP+JVotf41oFjPEkjShzeAOlwMR6OhT+7oYYDq7QizDB
         krZCj9yhng1H8K3X9CGzu2L59+1qyW/1+k4oB+GYb8mXZO47SPbppkY+kDPLNiUDCF0Q
         o301UF5QcPuetCZoYcNwGVOpwZ4FjLboni5dEK8xdeGmsizUu7oJa5yQsJbVaugqOjc9
         s/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWVCC/rgQMEKybnoBF/z93xQeWQfftgytiFnV7u+mykUyqIs9xOBHVxeulvgDu1dd0NuJSmuUq9f3pcsBvLtHEhXM8UhMu/2BBhvURP
X-Gm-Message-State: AOJu0YyjpTzZFK/3TrYbk/ZzebN6C1/r71RxgJr01oPKPY2zmZ64czMo
	2KSyWksMwMWBJ+0iV18y4ZfRA+uFiRV8hWT57JR4K0ruxEMp445sf4KuEQ+SJtnc+xas7IMTwah
	uzsCe/TnLk0M4I0dYWZ8PFkN9JUnhbhohtfFdxw==
X-Google-Smtp-Source: AGHT+IHWNAYEUCXy96aSwRX05SXOrysd9FPb6KniNdKBWJshN+yQQ5ObTNFsHu55muUNwwV/8GXLjM+VKV3S+C0C+00=
X-Received: by 2002:a05:6871:4188:b0:221:4140:2f33 with SMTP id
 lc8-20020a056871418800b0022141402f33mr44063oab.8.1709731621937; Wed, 06 Mar
 2024 05:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com> <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
 <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com>
In-Reply-To: <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 21:26:50 +0800
Message-ID: <CAEEQ3wnvTN5nGWAibjKKdMe4P3j3wPgghKn2HbOF1Xg56G=0kQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Wed, Mar 6, 2024 at 9:11=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 14:08, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >
> > Hi Jan,
> >
> > On Wed, Mar 6, 2024 at 8:52=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.c=
om> wrote:
> > >
> > > On 06.03.24 09:56, Yunhui Cui wrote:
> > > > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> > > >
> > >
> > > This comes without a reason - which is likely something around "will =
fix
> > > this properly later". But then you regress first and only fix
> > > afterwards. Can't that be done the other way around?
> >
> > Sorry, I don't quite understand what you mean. Can you help explain it
> > more clearly? Do you mean "delete mno-relax instead of revert
> > directly?"
> >
>
> You should order your patches in a way that does not create
> intermediate states (between 1-2 or between 2-3) where the original
> problem is being recreated.
>
> So in this case, you should
> a) fix the issue
> b) revert the existing patches in *opposite* order
Simply, I plan to remove "-mno-relax" and
"\|R_RISCV_$(BITS)\|R_RISCV_RELAX" in the third patch (fix patch).


> However, I don't think the EFI stub can use GP - please refer to my other=
 reply.
The problem we encountered is that gcc 13 will optimize efistub using gp.

Thanks,
Yunhui

