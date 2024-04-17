Return-Path: <linux-kernel+bounces-149098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE28A8BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25DE28315E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438A200D5;
	Wed, 17 Apr 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OE30VUNS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63273FBF3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380545; cv=none; b=F6XV1v/08yPqAICDujDHo8hzypRQjM5zf5HCEml0ffliZ3ZVNgn66dlxg9SFs1jiouAVfjcQ/UdlPcNCKftj9y4WG3+5jUV49qS0Ip3hqA43ajAgEgMm6eOdSrEIZZEX2GCtHcD3HNM9AxE1jKkoat9mioBj1FNuVAcD1AOKUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380545; c=relaxed/simple;
	bh=8PQAiZnHF/iPeT/h/ahgxLc0DMMoUxLe17c1wftbTfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E5MOxz4eb34bXpGAo0RttZ178Z6keAhhkdu8M2w1SuuOelmgKdD7thIbs3SLJS0qacJNFkx0PjHg/S6BvZw0uNQD3k0oMss7vetYn32Pu75B4CzazH1cPacWBS/NhwwXoIHCD0HQu28msnhTcRHthJD1s5+mQw1P+xOn2l3wtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OE30VUNS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61afa79081dso32179717b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713380543; x=1713985343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9OwTH6dE9vZb91cWcqzZmZOjANVd6hL3eddUZ2CPYg=;
        b=OE30VUNSjwDtlV50ugLi/mZ+WVfAOHUWha38hVtzgB0o9PtQygIP96HDp71/kXCgIE
         rEMoSUJlS7Oi4S8h/GxEGVowl1C3Qb/ViKhP5TEFqx8l+RmlBiGwYofNMmCenlNAmHiB
         IMWQoyqAsR4S5PobaL5K8W7vuQ1dnX5UGqYytZCtqy5zhHFBimTXvWcMWkJr/k1BmfSX
         4Bk/A8NN3mp9b5uZ8+tZqOYh7B1vDVIFisgpgqN+k5drtHkz/7Ny41x2GN80n9YR+pVd
         ahX3vntdZiSIokXXy/HfeJ4pYN9RtSXcinfGkOL7ocXLaOTmtcmL0PJnb+ly3ND+nIwe
         o7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380543; x=1713985343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9OwTH6dE9vZb91cWcqzZmZOjANVd6hL3eddUZ2CPYg=;
        b=A4WwtgtBG8gThhXp1GYmM6eMYFkMzz/FvS495RdSrNI+cWVoN7tWVlnTPYjqH1eBOE
         XNjVZTkDWE728HXEVqjFJezifadpoWVEbksinaV44HMXf3dwBPfp6Ytgha0kAWM17uda
         Aj4QzjPZro4IFTbFsKq2POg313cbQN4KameatGYaKY8hbmMI+/xQh/mxnWGuG0GoNZpo
         iK83mQOV1l1Sen26HS7BB00lskg6PFGS6xE519qO1EfDBtlX+LOlH74WipBzAJIHvUGE
         uOebLFEWsIt5l41wtPblisUkJrvvTR0T+mhrymwd+bSVCMbCCp/INAGdwqqlGF1wDQJd
         OOow==
X-Forwarded-Encrypted: i=1; AJvYcCW/CI0gphrXRdDGZtxqWkvPTKE0KYMiF1X/ywG9hwWYjM+Ccc4vL5MGHc3INpkIxQT+zQrmji1Q45uxhGGn07EFDyXXw/gFkQdqcWwt
X-Gm-Message-State: AOJu0YwVUn/qPceAg4ZO9HNof0DL2Mju1WVs5usOo6iOvJJRxJ8a0WmT
	VuMtnU6m+1C1GA3ADPTsh2z5s47KdPOM2HOLsmR4L+oM3TbkM1nsBZOVZUaiwk2L8B9ZEVrn++b
	2Gw==
X-Google-Smtp-Source: AGHT+IEzRmR0s7etBT8I+M2ioSWEZt65EenvLH64CxlKBg3bmYW6SDnzSS+FoZk3iddcDC7cn15EUsSlNts=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:183:0:b0:dbd:73bd:e55a with SMTP id
 125-20020a250183000000b00dbd73bde55amr22502ybb.4.1713380543521; Wed, 17 Apr
 2024 12:02:23 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:02:21 -0700
In-Reply-To: <SJ1PR11MB6083F100B4D957EC472AFF19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3> <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local> <Zh7AZY5X8_uyHrjz@agluck-desk3>
 <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local> <SJ1PR11MB6083F189AB9AB47D3DF74B19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240416195851.GJZh7Ye4eg_7VJrq8a@fat_crate.local> <SJ1PR11MB6083F100B4D957EC472AFF19FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Message-ID: <ZiAcvRWwl9m4x2n0@google.com>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
From: Sean Christopherson <seanjc@google.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Tony Luck wrote:
> > Alternatively, we can take the arch/x86 parts and once 6.10 releases,
> > the other maintainers will have them in tree and thus not need the
> > cross-tree merges.
> 
> I did a bit of this. I moved all the arch/x86 patches up to immediately follow
> the three prep patches. So you can pick through parts 0004..0039 and apply
> any that look good to you (there is no ordering requirement among these).
> Bounce anything that needs extra work back to me.

There are two KVM changes hiding in there, but they're obviously quite trivial
and can to through tip, I don't expect any conflicts.

