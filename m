Return-Path: <linux-kernel+bounces-101110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F787A285
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D212836C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B712E54;
	Wed, 13 Mar 2024 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awKcicmA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35B1119B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710305734; cv=none; b=aBUFPdpJnFYRUhCzrLymtNdxstaR1E07aRRCJBvmRbrF87axdBxBBaYU7/ETEIQk2vCA+kP/BYX3z+FeQVwgAFejB9faLLiAlz70K3LZ8LFBKMss6E+qdCb4bzgvhtYyWlyhA3FazjveY0btS8r79hxFDJ0ZdeedsJ8QoKUGK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710305734; c=relaxed/simple;
	bh=RTWz8EpSDEWKJM3TEtQ8z2nh961615KfzXWZv+DoDH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqeATIHEls1GsehGbaosdQWhvg/01Loe4Du2iBq2OwrJg3fCSuzvneWb+T3AX37tcyrM1dUGabOdbbr/M+yf8XIxHpU3xVtHPAJEKDayuSqMrgG3pF8/hk5P8616KDnLxlE2nxGn764a38RgO/cZs3DwwnKHG6m4zBX5wFRQtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=awKcicmA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512ed314881so5592743e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710305731; x=1710910531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTWz8EpSDEWKJM3TEtQ8z2nh961615KfzXWZv+DoDH8=;
        b=awKcicmA2sv2rFN9PCIV1Fem03o9I0g9Wrvm3KyafY/yhQIPX9+EXvRl8EL+kMRONX
         pSLK3jilIQKwitliWT2l7MNIZ9tpcL0YzygrCKPn/mi3noAaEzb2WnG8dANN6m7EX6y5
         0LYHKU7tGN3k5h9qJ1uABYfxGJZJVnvQY6Kc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710305731; x=1710910531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTWz8EpSDEWKJM3TEtQ8z2nh961615KfzXWZv+DoDH8=;
        b=qnZjbausYMnU0v0+4TG8m9D8KH5UscX4WigU/nItftCATPUG0vZq+nSmzj7/2k185s
         236PQCLv2oHdZQpCmK5YE7HQl57aD0uOqlLrspPV1diRkL/A9Q4+axytL5G5+lAel3fs
         xt1tT00iYltj5UVCYz0DjalsQZYq3mGROc04TUj5NdQJ3LfMrVD73osVawbt1bBWW24D
         Psk+kX7ByO+v3ob3qB+b5HBOIH+Qv+iJWmPbX6f6GrOCI+GvveMR3JP207CMgLJtW0/t
         U+cqTih0/2/D0h0fO6wE2ryBQ4p9S9NJbIP5MrzWfjYDGwil5mU140n3blR/Ug0clojj
         I6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqEsTGKYIUtONJpCs7STkp98glAG+I8RWVSTYA+Gs78WqNiRqlqA/rpCVeplQh3kfrvaKEnCEorrn3T0oOuAZqDw88n7aD3nl+NI7r
X-Gm-Message-State: AOJu0YxfRE44gIdoxUVFhEcRG9HkkSLBJAep6AzGMXzjlRbOJOJmwLlH
	AsdeODWBXA9clJM2xn2XDamXxRMw4DgxCo9ZFfk79uFKnc/WwQSKnDtY9ak6KbDhK3wCcp7yeNg
	ZjaXUcxliEA/+VHHJs5YXdv0oSe3mgbgOBDE+
X-Google-Smtp-Source: AGHT+IFnrqxk91ihDavcZ15Yamg0oeFHaSxOKuxqRQfg8amMGoR83ZIRGkueW8eCFqCm+gR78/kxhDbJgQE9zn7EngE=
X-Received: by 2002:a05:6512:556:b0:513:c1e6:3c55 with SMTP id
 h22-20020a056512055600b00513c1e63c55mr1925135lfl.69.1710305731589; Tue, 12
 Mar 2024 21:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com> <ZeCIX5Aw5s1L0YEh@infradead.org>
In-Reply-To: <ZeCIX5Aw5s1L0YEh@infradead.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 13 Mar 2024 13:55:20 +0900
Message-ID: <CAD=HUj7fT2CVXLfi5mty0rSzpG_jK9fhcKYGQnTf_H8Hg-541Q@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] KVM: allow mapping non-refcounted pages
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Koenig <christian.koenig@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:36=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Feb 29, 2024 at 11:57:51AM +0900, David Stevens wrote:
> > Our use case is virtio-gpu blob resources [1], which directly map host
> > graphics buffers into the guest as "vram" for the virtio-gpu device.
> > This feature currently does not work on systems using the amdgpu driver=
,
> > as that driver allocates non-compound higher order pages via
> > ttm_pool_alloc_page().
>
> .. and just as last time around that is still the problem that needs
> to be fixed instead of creating a monster like this to map
> non-refcounted pages.
>

Patches to amdgpu to have been NAKed [1] with the justification that
using non-refcounted pages is working as intended and KVM is in the
wrong for wanting to take references to pages mapped with VM_PFNMAP
[2].

The existence of the VM_PFNMAP implies that the existence of
non-refcounted pages is working as designed. We can argue about
whether or not VM_PFNMAP should exist, but until VM_PFNMAP is removed,
KVM should be able to handle it. Also note that this is not adding a
new source of non-refcounted pages, so it doesn't make removing
non-refcounted pages more difficult, if the kernel does decide to go
in that direction.

-David

[1] https://lore.kernel.org/lkml/8230a356-be38-f228-4a8e-95124e8e8db6@amd.c=
om/
[2] https://lore.kernel.org/lkml/594f1013-b925-3c75-be61-2d649f5ca54e@amd.c=
om/

