Return-Path: <linux-kernel+bounces-110857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228638864D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CE628531A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE14436;
	Fri, 22 Mar 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAESQsjB"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76412570
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070938; cv=none; b=ZqGQlGoMwp0EDm0eqOZB0+a7s4LjYOcKFwulktM4CjZd5sNcJeZXKrMGAqJllrnHg53CN1uiZmZJuPysJePZJrvnD5Mlh/ZdV8EE7nt3t/zZ2vFe/jxafEGAZKmfyCVd4crtw6hW1RidwZyqrfrn3x8ILyV1gTYDpzJNXxQVaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070938; c=relaxed/simple;
	bh=wUWtK/vMJLZwX1DvkPLzIaDS7xtrHfNcefyZ/OZD9mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6xI2+u8emnasU1gPdGdHtfjdbRFCpcNUv61l4eeL+PkRd65A/8w9Lho0Kw0PL1GuGgKOKLPd1WNv4QoGbCE86UBCHDzD6pf/HyRsuj6iL7jOoa7vz5NEKmyBqUktosvGIf2pEozZxWCfTI/MlxKqa0uSsDqrdLmnwungYk5mTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAESQsjB; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d44d160830so1461576e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711070936; x=1711675736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elX0v/wzn8FOI5S/DSgb8r/0YEFXzUdTLBxZj76WCmE=;
        b=ZAESQsjBn4dTXFqyfBbHV4w+qQBBLJ/nEfHpi6cTNxV3Y/ll/lyGWmSYzbF8kVxwK7
         PN7FVagNlsaRR/+Uxcr2B0swkiW8nUWPcTVAK6O0InCNngQJ8/g7gkcgOhAGT7D0gtY+
         GRAxpzxyhEUI/YMpjLLHxRxRjS2o9cJT8X7wz5qBham54wH9wz4Wf5PEPf/mo7hyvyND
         nvdgA+Zg3DTSZJlacrFjWq+YqCCkkSjPLQeYI4KD59oLJPz78B5fyQfjYD4y12dpvBlB
         Qr/JA1wAKUfheLf3ubqUcdUN8rvyeHgJIqn2ECvLwNzr2ir4kju/+er5kTmucC4eg3kn
         N8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711070936; x=1711675736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elX0v/wzn8FOI5S/DSgb8r/0YEFXzUdTLBxZj76WCmE=;
        b=VG6eQEGBQQgkBmThBtN7IiCvrVF8iKKyMFGaJoYjZoA22zsfX8MExgLjOSWVv9/CD0
         WLuisDZOd4Ct4CabZqajbEG2HN5H8xtejrgaTMxdUsQtlOrCwCaclDsCdEMl6lY68rJe
         YpQWc05HhU4w/uNFGmQZ5Xxn6mG9Zou0AzgOhLyq4f7HiNcgelS1BQyqt71vSCgd2FQY
         ufrBJS56Hy0gBYFrYIuk0ONFKpnti0DrypkyAK8o6kiRIibBZCc5tdHCYxxO9P4kbIxh
         F2dYpJKmZB6h2vlDHZMrsgLB+oHovpPfKCKvnLHLMTfJE8P00A1Q8KQC831RVsprGTFc
         j6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcWBNPLac7YfDRAXvOclhHaKupIkQqn2qf/+CQIUzrNGrmffhVOUkJJf+Gs1n12XLdIKqQA/Gi5abnzwqFhyoN9X3XXROasgcFfiSN
X-Gm-Message-State: AOJu0YxYIv/PNo9bysOKzDXE/GzbTA6ju74eyRpbKCypZ0eZw0Nv8QEO
	EPxLTrx7iD9s2eB8joP2S1PylvLhyvy5sfmom3Qlh1MhChCk6JVKWt5bHJkyfXgTo18RijroNhQ
	i4o3oAJYW/+owHZbzElpqFqfCpSe0wHVo6Fbeww==
X-Google-Smtp-Source: AGHT+IG3Qs0+xfEueXgay/q0x75ZXaWOWC/3RP7WH7SqqyiLSOLlKrECWMc2rVaZGvh5qPUqqJBhFjmiwePw6P+eh6Y=
X-Received: by 2002:a05:6122:2014:b0:4d4:11e9:c33f with SMTP id
 l20-20020a056122201400b004d411e9c33fmr596399vkd.5.1711070935188; Thu, 21 Mar
 2024 18:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141516.31747-1-liuhailong@oppo.com> <20240315081803.2223-1-liuhailong@oppo.com>
 <ZflTCY-Oaxm0U70u@tiehlicka> <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
 <ZfmV0uEMgZ2Dzdnm@tiehlicka>
In-Reply-To: <ZfmV0uEMgZ2Dzdnm@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Mar 2024 14:28:44 +1300
Message-ID: <CAGsJ_4zC5A2K6=u6jYDmCX4YWw-2utheQZzb8pi-BezayObvKw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not available"
To: Michal Hocko <mhocko@suse.com>
Cc: liuhailong@oppo.com, akpm@linux-foundation.org, nathan@kernel.org, 
	ndesaulniers@google.com, trix@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, surenb@google.com, 
	zhaoyang.huang@unisoc.com, quic_charante@quicinc.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 19-03-24 19:09:18, Barry Song wrote:
> > On Tue, Mar 19, 2024 at 4:56=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Fri 15-03-24 16:18:03, liuhailong@oppo.com wrote:
> > > > From: "Hailong.Liu" <liuhailong@oppo.com>
> > > >
> > > > This reverts
> > > > commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are n=
ot eligible")
> > > > commit 5da226dbfce3 ("mm: skip CMA pages when they are not availabl=
e")
> > > >
> > > > skip_cma may cause system not responding. if cma pages is large in =
lru_list
> > > > and system is in lowmemory, many tasks would direct reclaim and was=
te
> > > > cpu time to isolate_lru_pages and return.
> > > >
> > > > Test this patch on android-5.15 8G device
> > > > reproducer:
> > > > - cma_declare_contiguous 3G pages
> > > > - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim fi=
le
> > > >   only.
> > > > - run a memleak process in userspace
> > >
> > > Does this represent a sane configuration? CMA memory is unusable for
> > > kernel allocations and memleak process is also hard to reclaim due to
> > > swap suppression. Isn't such a system doomed to struggle to reclaim a=
ny
> > > memory? Btw. how does the same setup behave with the regular LRU
> > > implementation? My guess would be that it would struggle as well.
> >
> > I assume the regular LRU implementation you are talking about is the LR=
U
> > without skip_cma()?
>
> No, I mean standard LRU reclaim implementation rather than MGLRU.

I guess Hailong was running the standard LRU with active/inactive lists
as his v1 even didn't touch MGLRU,
https://lore.kernel.org/linux-mm/20240314141516.31747-1-liuhailong@oppo.com=
/

Hailong, please correct me if this is not the case.

>
> --
> Michal Hocko
> SUSE Labs

