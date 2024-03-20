Return-Path: <linux-kernel+bounces-108261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30D88087D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAFD1C225A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68638637;
	Wed, 20 Mar 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maYv+Qoq"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E4394
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894040; cv=none; b=tNZB5aoF84g3xg4pbHx6OZN/VfpULl9LHL7n8VLCcm0ku7M2apj+i+yw2VsNK7TLcZ+QOVlb1hnY2pSqDXWHF1yD76l97rpb2GD1M6eJPWNSQ2PFNd/TjH0BhS/URVr9B0hK7mmqompRlG/eHkxTuR4/mt6AdrzhoEcHsUlHwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894040; c=relaxed/simple;
	bh=Duv7fZnfBkbKrhrDZCSysjhGGXx0sWgvmbyY/HKQND4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvAX1XcqWc8dHMHBFHeuKfl2OHQA6kOaRthru5ux6DuI0U8AWfOX8PtRcNHBwqmBjKOOx9WuQNnRZ4csjCPHkHuxWOK2TA0ixhmK7Nb+VYAHWlwpdNP0rj2FMYBXvxG0sULzOHfau046uF/pih09efis9uopMTI2RYeSCnURVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maYv+Qoq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-366a4bcb2a8so17565005ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710894038; x=1711498838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSsx77JW3Y/Bq0qf/qFd4CC2XBBPtaZoUOPGSlrJOu0=;
        b=maYv+Qoq+ubtD4bu55kTpTywygF6kRDXdF7F4RfTWu0rGOYqL+Ty5T0AYDnFcJwcvz
         FlylPsFVtuc0V02xlTT9C3MN9PNB6zWdFTXJkGNA2k+J5BV/xbNiMI1kZLdmblP6Pt/2
         SS1uTpAjJdmS0iMCnPHSret2GS6NikNudxAlzc3L2dW5nX+TYRa1OzbYM2lt0yIj3j8a
         0E/5RzEuokqHW/O2A+6unU6VCvYXQ8Q7ldYnelgbck4OR9jczfOSOY1JIen0+10tue83
         m4YNi4dBODvpZj3Rm9/Vr8Kj+eQ2HUyGQkl/QKEGccPpOBTbh9eDldTiqy41ELbGRD46
         d7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710894038; x=1711498838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSsx77JW3Y/Bq0qf/qFd4CC2XBBPtaZoUOPGSlrJOu0=;
        b=U++HkvbAnytRAZFnHuye3j1Ds7yFY1JutUwxRoX4a0GmvWoIJNXTC0fuVFcGprlawR
         3MT6L7cA2qZ1swoOm9fg7jQn4eQlk6BzaUYCDeYV6yKuex+n+d4ofu2KHv8+9wn/MJ9y
         oQ2mPT7yKWPOUR76igtVIEtV9u1hdkmtBdNmmRPfGtDtbaQiIA8Une51bCiDwcEWqK2n
         4IhAUH+lDc7OTnWyfXKRs0OOEZKSk8/TMnv7Vq0aqi8hb1dhLSxew6amc1VhFlcgrRo2
         +XWv+3mLgS+4f1f/MduAIAT8lgXdDoyIDATolfCe+jDVj+NvR4F2rV1jSo2F/h48ssQR
         dgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfn4qo7Gt2nqKkIVfbO1CSL4TPAv7Qr4zodMev1xUGEzyZXfyKfscM1b8zi9qX9glE8lGvXUPJoil2+Qp7HtRkVQw4qKDEswWQVrsI
X-Gm-Message-State: AOJu0YyHDSB28g5R1nEp+b6LSlV5ABshL2IJ2n33+05JYuJPK2BlhD4m
	Y1jeGmuzsFeOfQ0/sCDqkU/WvE//o6Bh8Zny2cOOOHexbko5tMO1Nb87gStQM0fsKHWPh9wcDyV
	wPoxuZNRHE5quNOvkhM8/T2pa2WtLI+NqaOp+
X-Google-Smtp-Source: AGHT+IHlaHRL0umHFmanp7quVlbQlQ6CW7wBeJ94tmd7VgEjhUvq3w4XtUlgvBdTcvvAR9k/aJ3co8CRBThiIs8p5Sw=
X-Received: by 2002:a92:2810:0:b0:366:bd79:a567 with SMTP id
 l16-20020a922810000000b00366bd79a567mr558869ilf.7.1710894038141; Tue, 19 Mar
 2024 17:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-zswap-xarray-v6-1-1b82027d7082@kernel.org>
 <CAJD7tkZH-mU_7NMMBAS4nyfyWKKK3tSdQisVQ5iRqckqHouoJQ@mail.gmail.com> <20240316133302.GB372017@cmpxchg.org>
In-Reply-To: <20240316133302.GB372017@cmpxchg.org>
From: Chris Li <chriscli@google.com>
Date: Tue, 19 Mar 2024 17:20:25 -0700
Message-ID: <CAF8kJuM71XEeYdDOdKkz_c+JNnMhxfPAGDoZ-BqpcYuyHxDFmg@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: replace RB tree with xarray
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>, 
	Barry Song <baohua@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 6:33=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Mar 15, 2024 at 06:30:37PM -0700, Yosry Ahmed wrote:
> > [..]
> > >
> > > @@ -1555,28 +1473,35 @@ bool zswap_store(struct folio *folio)
> > >  insert_entry:
> > >         entry->swpentry =3D swp;
> > >         entry->objcg =3D objcg;
> > > -       if (objcg) {
> > > -               obj_cgroup_charge_zswap(objcg, entry->length);
> > > -               /* Account before objcg ref is moved to tree */
> >
> >
> > I do not understand this comment, but it seems to care about the
> > charging happening before the entry is added to the tree. This patch
> > will move it after the tree insertion.
> >
> > Johannes, do you mind elaborating what this comment is referring to?
> > It should be clarified, updated, or removed as part of this movement.
>
> Wait, I wrote that? ^_^
>
> The thinking was this: the objcg reference acquired in this context is
> passed on to the tree. Once the entry is in the tree and the
> tree->lock released, the entry is public and the current context
> doesn't have its own pin on objcg anymore. Ergo, objcg is no longer
> safe to access from this context.
>
> This is a conservative take, though, considering the wider context:
> the swapcache itself, through folio lock, prevents invalidation; and
> reclaim/writeback cannot happen before the entry is on the LRU.
>
> After Chris's patch, the tree is no longer a serialization point for
> stores. The swapcache and the LRU are. I had asked Chris upthread to
> add an explicit comment about that. I think once he does that, the
> objcg situation should be self-evident as well.
>
> So in the next version, please just remove this now stale one-liner.

Ack.

Chris

