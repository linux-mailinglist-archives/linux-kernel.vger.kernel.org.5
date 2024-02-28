Return-Path: <linux-kernel+bounces-85729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4886BA03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534C31F292B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391C7004D;
	Wed, 28 Feb 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcLPSQyO"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4C70030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156096; cv=none; b=rzb8ph7HeeJf9RMTrM5BJhcgzoTpAuQvWeyKmBno3OE0eX8ZBZkY+vAZJVIzriV8Ytx9W5BGJn5+7RSb44dg7Nia0taQg+RbBTUVzRM+WvGB5/EfAg4XsmQMBoUAoDpI6u7j6CUNiajagFK3lTPJTZptMRhdB0pdDuVkGkpK4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156096; c=relaxed/simple;
	bh=hYKDYcEw5lHqH2aRTYPwr/dy/RfHP5zZ7HjM/dRqXn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ftmbQnzBuuS2UG0cSuVSuMQWjRWcr+v2EKRfwAnVPW0Ch+TmF8Mprtm8HmF01Q4shf2fmM3OG0Ckx6pHuo7MdwbY/XPEJFMdXttTZYuL2XKDpBSv2F6IvYkpLVCNwsSMdFphcekgZOudiVTshN6/66cPtve6tGEcGw/CYn0m1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcLPSQyO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-299cae4f36bso119820a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709156094; x=1709760894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XXg0IkU5TUPFv8zc80T7AHB4FtUby0AfD+GckQIvQA=;
        b=UcLPSQyOeIiK0wylL/NBmVbjHt3P0pyG3v/m8DYkEENMwHttJRnaQWuwJ9ucwI+6aE
         ShGU1NoCZz9ibuG9IrbJSxhO5im8yLcYO3kJE9mrTJno4xXQPV29Pla+E/JoySkVCkCi
         itBtdkI7oVCTt2k6Nbms9/y2GEi92U8n8aQJxY3fFa3eFDrbpRjoImZyl1NQX5FlFBwn
         EYPD/BDpsB+BqmSN9sipdbDiWbT5zYZmHoAxcHZXrpynnubWfa1rbnZkbzL/zm86MwA6
         UkZn/rjqPCTEwfB88g5OFED7xEQE4m1e6wnGlhPfUDWWPG7+cvLC0vOXa4aLnIckiH9x
         +c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156094; x=1709760894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XXg0IkU5TUPFv8zc80T7AHB4FtUby0AfD+GckQIvQA=;
        b=H3GA+0eYEXgHHa0VJAj67Pl0EOPn2S1f2o8BoD5x2Q6GF4A/Vs2Wj6llfjIJ2IZJM5
         UkjEy0LkSLG1KcMVPCI9jf0A7qGcUkUniQFTGdbpSTQ4vyguXegLaCl03W/7Xkl4a3sO
         kQkGtx+rI3lbsPCVjW0S8hFn+S13CJREyHEtWbSnWzAH3xuT8nMRua5FEEC/LdXwoERT
         EtDL9hs/ze5QBH27jIQ7ToE9SW2xtGceld5MPpVHxYUXAI364efV+9Yq4AI9BkDIjUO6
         JsOYDGUkHyjOG7i6Qcne2iDG963bzhyKdStrjpk/7XXM66u+7FLhQFkOARvkbKiwB4DI
         dILw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgUjan4h5/DpMpGC/GIcALrt90OKy9tF5ABRHLpbVbFmwpEqYkgOs/f7UAeOiaQj1KrIOWw6K9k7VsW9oqGz8pZ6tr195pGbdGxfl
X-Gm-Message-State: AOJu0YxYnJBkh+vOz/bGbmoqcP5XuNC06+MYTPXT3mmEtToVbZ2mGDIt
	3MNaoqZYrBbJZth9qUnwbM5fdZAw8+bjcaIw5F8D5g1O7YS0BuUsR101CLV3lTDZFgvWfG9gaAD
	tfQ==
X-Google-Smtp-Source: AGHT+IHSa/71jx2w7IQMMCTRY7oSd9bBuHsHilIQ/kXSBHYoaxZh4u+KcytiCqhfbrsj61dcHuvEZ/TgqXQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c3:b0:1dc:b333:f2a4 with SMTP id
 o3-20020a170902d4c300b001dcb333f2a4mr463plg.12.1709156094095; Wed, 28 Feb
 2024 13:34:54 -0800 (PST)
Date: Wed, 28 Feb 2024 21:34:53 +0000
In-Reply-To: <Zd-lzwQb0APsBFjM@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com> <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk> <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com> <Zd-lzwQb0APsBFjM@linux.dev>
Message-ID: <Zd-m_WinXvoCmMCb@google.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Marc Zyngier <maz@kernel.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 28, 2024, Oliver Upton wrote:
> +cc Raghavendra
> 
> Hey,
> 
> On Wed, Feb 28, 2024 at 01:19:48PM -0800, Sean Christopherson wrote:
> > but due to a different issue that is fixed in the kvm-arm tree[*], but not in mine,
> > I built without -Werror and didn't see the new warn in the sea of GUEST_PRINTF
> > warnings.
> > 
> > Ugh, and I still can't enable -Werror, because there are unused functions in
> > aarch64/vpmu_counter_access.c
> > 
> >   aarch64/vpmu_counter_access.c:96:20: error: unused function 'enable_counter' [-Werror,-Wunused-function]
> >   static inline void enable_counter(int idx)
> >                    ^
> >   aarch64/vpmu_counter_access.c:104:20: error: unused function 'disable_counter' [-Werror,-Wunused-function]
> >   static inline void disable_counter(int idx)
> >                    ^
> >   2 errors generated.
> >   make: *** [Makefile:278: /usr/local/google/home/seanjc/go/src/kernel.org/nox/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.o] Error 1
> >   make: *** Waiting for unfinished jobs....
> > 
> >   Commit 49f31cff9c533d264659356b90445023b04e10fb failed to build with 'make-clang make-arm make -j128'.
> > 
> > Oliver/Marc, any thoughts on how you want to fix the unused function warnings?
> > As evidenced by this goof, being able to compile with -Werror is super helpful.
> 
> Are these the only remaining warnings we have in the arm64 selftests
> build?

Yep, unless I've missed something, this is the only outstanding warning across
all architectures that support selftests (sans LoongArch and PPC, which are
pending).

