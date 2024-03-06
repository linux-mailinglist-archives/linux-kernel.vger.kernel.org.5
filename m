Return-Path: <linux-kernel+bounces-93601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C684287323E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C981F25E19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493AE5DF3C;
	Wed,  6 Mar 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bhBhU5fN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C05CDF1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716425; cv=none; b=ZJyBdy7vgdTythNEfKKl8BTpGRuncJth+0VX6UkTfYkS5z060obX8hKXY4zOAy63iII4AHw8ETq4JhmH4nHLBgqP9V/BvO3Oa6C/wgxUXczaAhDDGqJXQRZCq/pcuaRww630qEK/5odTyJ8lG4cNOb88j/pdDwyNx5e1QPAWK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716425; c=relaxed/simple;
	bh=Qk/DgjzzjMSGlkOr40MEBE4bLbSg4IfJnGTatQO/eMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNbipkvKxvxIpq9boWGfI025O94RoHdKXFLg86r1mX9RsY9p/7d6uEFTsfLJ9X1FGy4CNd/wsIRYm6uQaTWI0H638WnltInRaTEug6rylCChGCcE1qSH4lAdbMvdnPBXM9zv8ejxBIatM1IPkYoDART97T0XROv830JJ4GABoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bhBhU5fN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a449c5411e1so662967866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709716421; x=1710321221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk/DgjzzjMSGlkOr40MEBE4bLbSg4IfJnGTatQO/eMo=;
        b=bhBhU5fNwZ5NqT0bjBfmI8yYE8497uLD5ocbat8fgeLSUHkpHADu4CV6Px/N7I7wzg
         5mKP+wC8FaeYdcidDoxMNECGlkyX5G9DEE+nGgi0lls+5HPUXm/Opo6mOPt0FA/iIH4H
         DIBbg1aujcIteGxEv9Zr4ci4GHnXD1eiZHVWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716421; x=1710321221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk/DgjzzjMSGlkOr40MEBE4bLbSg4IfJnGTatQO/eMo=;
        b=fIk3YKKdwhAHJT3bHN8UOJ+4m6M6s8Wl8eY6Zv8Ru7DDKi7Gmtfi9YuV3E3LiMtlrX
         qDg/BPqJFbPPIUvz46Rxbdn26ua5Kk1ghB+8eh9q7mV8H3Mo9AJpIFcPEewMnpE6dLxo
         bSAzKehJlItw3of2UwI3nUbA+Sx5oqHLjANpUQeaawLBSWYRO/YBXYQIl/cfmMNj9+ft
         gCqJKXJHKbWeMM6X7ZX6p5+x+Ud6UykrDoLph1tGAyk5GmHSTFZu7dTGZBJEU6IUdUsl
         HssWSPZ3jsHXEIn4/fOozI7g+oo5uORfWfRpn8Qn7G4Vgg63yIDfNurO9SWEt4qTfEsz
         pdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX38li3EqyTaF199JJzyg5ce4rLTcYYP50FFffL9/zsvvsXR5GrQ3JQAYyiuxSo0/MiNBfWLNhLPHjDHUaYAiWNSMWybEjTaXUFg+PK
X-Gm-Message-State: AOJu0Yxn0MHgQO7q7cccdT6Ggm7Cn3Ry8r6Dj7uVPcxCkfqyXE1lTLdr
	CoVc+qA2WbjQYmDGqiRuJviEH4LMXzIYxrkO1hFUex9ZZ3uu+hHNPYirC/A6Y5sUCrAygD6+jOe
	uxtjL07JTBws//PNRosPN/4hJpSkZSr8K7QyjfA==
X-Google-Smtp-Source: AGHT+IF5uZKkvzzVvH1pdzaj4G0tyPvVgc2P1x6T/jfjAEtk8AF3FusxtxHz4G91nr1NSpZWjbsyOBQrRGKPsU4HqrE=
X-Received: by 2002:a17:907:20b9:b0:a43:eb29:a293 with SMTP id
 pw25-20020a17090720b900b00a43eb29a293mr9389627ejb.5.1709716420766; Wed, 06
 Mar 2024 01:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com> <20230608084609.14245-3-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230608084609.14245-3-zhangjiachen.jaycee@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 10:13:29 +0100
Message-ID: <CAJfpegtnTafRiHGG6jpZaZ_XbOhT2aGFyZM3FeDdPoSSEanNNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: remove an unnecessary if statement
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@osdl.org>, me@jcix.top
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jun 2023 at 10:47, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> FUSE remote locking code paths never add any locking state to
> inode->i_flctx, so the locks_remove_posix() function called on
> file close will return without calling fuse_setlk().
>
> Therefore, as the if statement to be removed in this commit will
> always be false, remove it for clearness.
>
> Fixes: 7142125937e1 ("[PATCH] fuse: add POSIX file locking support")
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Applied, thanks.

Miklos

