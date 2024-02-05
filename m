Return-Path: <linux-kernel+bounces-53256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2331384A2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B08286264
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76371482EB;
	Mon,  5 Feb 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="ROdKOgic"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6848791
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159152; cv=none; b=fTmiIf+Y+4og5jUxgXBPWaTGGQiBMXEe8whAMHj88nTI0YTU2uTgrONWne2b4FNrVN7FuaWlCn8bQBcJ2+pJtsmz6eOYkidNYLpDZ0vpdgMGZCtbG7BF7uhuXDcdmbag671Onh87WoRaV33scUbXeJ+ljJhIa7JXp2Jt2FSlUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159152; c=relaxed/simple;
	bh=2n6NEhyvuJ5E4qoevj89tVssjIMXhF/xuHE6hgy21vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVMFNTihy3KM0dRBfRL7brMShtS5zTl+zKkf66bDiIambdySgy4HLw37Ks/4AfStvUPWaa6/G4HdTEgaotvYSZNHDD9WMM8T5MXMGHDI+rOZTAVNvzkDIu8Ry1SzfBExgIDHMO75M6IFpEgTk9TgeGbJ1YK2V+kIsPzI+iIKoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=ROdKOgic reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42c0960382eso17276961cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707159150; x=1707763950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n6NEhyvuJ5E4qoevj89tVssjIMXhF/xuHE6hgy21vA=;
        b=ROdKOgicB5q66X1TcUpe2M9G4q/y1P7RPCKzl3qXDXWG/coIddJE79/aUobIm3mZ9y
         alNxlWZ2G898/D6P2Do2weh9QqjcDxoIXBOpo8aZFHMZPHIPoGPfmIi2RLWpqtLcZcvj
         9WIlffzzWyS8Zkg2BDCEtXGC5UdyeOKYbjATOOdt73QsPwgynk19yR7yhbP7/sfgbJ0A
         1Jh9Mk2KkAnQ/LG5L7Oz6wEdJyawi1n8dN7fNv1li09Cipm4FSRMOJ+y9rdk5jilMuqr
         ksfoX4TuYhEtjZ0gcISH8+G4aMXEPPHJSLa+7ZiYLW2zdCMjw9uT73tZyuD4q0EAChYh
         N+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159150; x=1707763950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n6NEhyvuJ5E4qoevj89tVssjIMXhF/xuHE6hgy21vA=;
        b=pGzHHAQQqbPWI3K1rmxSEPcttDhBHy68LC8SCZpyj5NJ3JOhzpwWIbR8r8grF20/j4
         Xra7hxz3idcl/j3U1Z9r+BnYdBKx3nb6596uDb24HqyRvq7V1b5ddy3PaUzd+nHUv13N
         kjyHEwx9KRuXz+PLPHw0PcRcAKr0P6yVGnB7VeMzruLF1rCjMgR+xmFPAbuMw/B1/aq4
         FVf0ZYIzEvJVMpenFuPWKyLK9BvP2k7G1BkSy82e90otIrd90LyNlC2Ewdo5uH6C2trB
         rZHAD4NF0/2XW8FGfAr4ZHVkdxz77xB4T/wIcAMUGhE1VqrzDfDRaiCUJ2Fr3smEPFZ3
         Brow==
X-Gm-Message-State: AOJu0YyMVm9hu6bHIIsqqOoNhDODmrNB9QjuKBr4ToC4bSadfAidRpE+
	tMUtyj9foxMmt2F4tTuWFFaUVicc785laB7XkTbKWAqARDyfbcrxJK0pNEeUdbfVvsM4ptKpGGh
	yM2vVy1ze+J6vKY/A85aQl+qA8XfMvFBP/LnrvA==
X-Google-Smtp-Source: AGHT+IFxRoPhnX4DyHfg++GDzqZOWUaU4rz9EjS5TCdYAUo2klND3ypyEOGm+jgA5KG6nSjESvNT8+z3Yqb557Gbebc=
X-Received: by 2002:ac8:72d7:0:b0:42a:96cb:c726 with SMTP id
 o23-20020ac872d7000000b0042a96cbc726mr260946qtp.33.1707159149991; Mon, 05 Feb
 2024 10:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707144953.git.robin.murphy@arm.com> <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 5 Feb 2024 13:51:53 -0500
Message-ID: <CA+CK2bDFboGQD1YaZix7O_10F3K8bbxwXuJTVK40sNQWxmek_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com, 
	yosryahmed@google.com, john.g.garry@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

