Return-Path: <linux-kernel+bounces-63955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229708536BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19E52867D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8E25FBB1;
	Tue, 13 Feb 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zioZcQgq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6015FB9D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843725; cv=none; b=lRAeyPJbBSPYcc+93mX82d8JH695QH8/ZoYQNMCWrZ4gaVnViaFwo3kqGh2tpxgPWpU4totMOQiqKWim7YwhEbde25pZ82H/YbcKqXLNLgKhzRVNl61GzY9amDnlNfldnbw0Q/afd2GkJe2Oqj9njMROmnm60d5BuwrlEJIWs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843725; c=relaxed/simple;
	bh=kFEBmVzCDcc62ul2nmKiFx/x08WUXookmiLkT3RdZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQrR6m/fU0TSrdjm/x8bUpG8YQdmC/JGbECwnxaMv3I4MFlrCrTrG6lh0sU6QJbTSxYe2xdasRYyhNZSGuwz9+5sDviN6cYLDMVfiUdhMh9rPJBL1l5cx4Em39+GxELgDmqIrlJ32ioy3L+Aijn34w8ziOQi7kUZpoaBCJ7gHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zioZcQgq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1db35934648so103845ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707843722; x=1708448522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFEBmVzCDcc62ul2nmKiFx/x08WUXookmiLkT3RdZO0=;
        b=zioZcQgq7/WCb6Z/hQB31I/sflRJ/ulSI1vmWzT1VBEJF5MOUay+zZ7jQB8bJkjkMk
         p4IcdQE6x5dOZt9LbGEcGS1kK1Il2t0r5PWpxvLVX3pTKojOWfsIDetMNM6WvS+zB/sa
         /LFfXdkqqFmMtWN5v68nGMXP1RWapNMaVzefWWDeAa/S9585RbPc/W2NDqF8RuQUXiNY
         eOZMnqLgx0Fcex0VZAxZE9oc7lXh1wAE/PbwjEm8sc9EEZ31NrvjkaRMl8b2NRatJdUY
         /d025YhQ/oQp9HiMmDkGtbx9Dq4IdaeYhqmPsxW8yLLzWH2jrvD2/av52h+fn71wCOuj
         cq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843722; x=1708448522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFEBmVzCDcc62ul2nmKiFx/x08WUXookmiLkT3RdZO0=;
        b=RVnk71Zzet+/kluRes2FF9XStPRqyOYdp3QO6R6hdHxGcXmhRFzW0I5lc4eIgSpyB4
         gFn2GE2O/VfSzVr/g8tMpXYDGOeF4LLTNe2omezlis7k7vlAcGO6jzyNo51M3536IHOC
         HQKrT/0zFuX9DMKnaPbPL0gE2lSwD7QjV2J9Rv2TbpA/VfA5mh8jMN2b6VFEvmQTfdIR
         q0rkGu/fqi4cti03HWA/IgEVTeLkwHnfKR9QrWHM2/ROIPVxxXQscuBb2+fQ34Az1Cvb
         eLHt21FXrkDbl3O/xMT8vz0H9RVhN66d8xGDNTvpv7ebGoxFkU+NKlo2NjvC9nlQ4jlq
         WbKA==
X-Forwarded-Encrypted: i=1; AJvYcCWpM4BZCnuftq6Lp41Qudl3OSYpQzkhLOaIevGd5uI7N69Dwe5SnBZvaa/zoFox74zXOEu7y+VpExM53qwvOCIHo/lx+MlITSK35O++
X-Gm-Message-State: AOJu0YwSjheUBfKNJ1cvsKzrJvuvSw6L6vgfKMcQLI69LKDr3TL0pFnF
	hRjNJEj9625lS+ml4m+b8Da/MvdGgFH6Vzj6u6Z8I/moKRIdyEghUkenoEwu3gliB0+5FNt0fkn
	WK3TqWWGVhnkizzSzf3zgv6CBDSvO2tFnafdw
X-Google-Smtp-Source: AGHT+IFgCqv/XRtoQtQ4/r0rGFzG9aCmFONaMnDDOPnOxPjhaUUFtNH2qle/Tw8GsuonJ5SI6Oo7o2+2OwCK/Zu/4Dc=
X-Received: by 2002:a17:903:33c7:b0:1d8:d90d:c9ae with SMTP id
 kc7-20020a17090333c700b001d8d90dc9aemr20118plb.1.1707843722210; Tue, 13 Feb
 2024 09:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213081634.3652326-1-hannes@cmpxchg.org>
In-Reply-To: <20240213081634.3652326-1-hannes@cmpxchg.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 13 Feb 2024 09:01:48 -0800
Message-ID: <CALvZod7wqfy63cis_v_D_9gpOS=3A2cS5J-LHq0WUrhVQOum8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Jonas_Sch=C3=A4fer?= <jonas@wielicki.name>, 
	Narcis Garcia <debianlists@actiu.net>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:16=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> The swapaccount deprecation warning is throwing false positives. Since
> we deprecated the knob and defaulted to enabling, the only reports
> we've been getting are from folks that set swapaccount=3D1. While this
> is a nice affirmation that always-enabling was the right choice, we
> certainly don't want to warn when users request the supported mode.
>
> Only warn when disabling is requested, and clarify the warning.
>
> Fixes: b25806dcd3d5 ("mm: memcontrol: deprecate swapaccounting=3D0 mode")
> Cc: stable@vger.kernel.org
> Reported-by: "Jonas Sch=C3=A4fer" <jonas@wielicki.name>
> Reported-by: Narcis Garcia <debianlists@actiu.net>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

