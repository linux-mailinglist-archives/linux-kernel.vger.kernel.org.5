Return-Path: <linux-kernel+bounces-30429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4C831E86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1FA1F213D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808EA2D04E;
	Thu, 18 Jan 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUSPlF9W"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACC2D043
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599473; cv=none; b=QSGdGWb1ur71Ee3rDFFL/U2M7J9aaqgoAnS0x6ZqeqVWCXUNCtZLxF1uUD9bjBzSrZoLZkmpw95A9IjVg5BfECTkI4/F6WQ4akiXKaMouB1u1bWYOPJ3ySYhSc7aOZx4H1AfVbF7960G6iO+qZNwpEHylXOm0I6tfsEpWZzMg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599473; c=relaxed/simple;
	bh=1SLI49q2Cr6+OAuuBarj8au+Z71GOo7Ef/S9Ci54CE0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AEEqyYERACR2c6MwVNS5ZEHEXHFSJkRvdyak6BFjDsRecgTtX4+8RbTCB3uP58GyJT1WNZniYimq76pxLoAJ4F2Fq0EVnSATDo5xE9Sx6HlYU7IXl0p5YNDii/V+YvFf5aNAlYf+WfB67qMEQT769+MFmtDJw1meeRp24c9zyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUSPlF9W; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7b273352so14126714e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705599470; x=1706204270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SLI49q2Cr6+OAuuBarj8au+Z71GOo7Ef/S9Ci54CE0=;
        b=FUSPlF9WB085QF7cJzz1E0xej1kqNK/KXaLSzAFL0voBevC1hHVPvBuo6b/DkCF1cu
         BLmndNOizxdd6WaRIl1BHCLESE1vC7MdrKnJpd59QxXcUwu4sJQdyIr2JihLSmzkXETZ
         IP0ugCWsGJ95Hlppst+a0XwqXhzN0JduauLrYB+yjk5g0kAFf4JxSgWAcsubChF3JfJF
         Uc3wkvFTjIyeGxWwUk95lFaCEQrQ8QU3zvGuyY0gSd349tWVQRrB0yvMq1fiyFjJfMom
         e1fmMJZiOZ5+dv9r+Ik/kkDzzzddvVk/+gQW6JnQR8uWq2+AkcLuWHyqbkhONWX9s56r
         daAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599470; x=1706204270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SLI49q2Cr6+OAuuBarj8au+Z71GOo7Ef/S9Ci54CE0=;
        b=PppJHx856FGlE5iptWnHvNa8FOc7V3OR817nso4ZyOsF8qwPyN2n2Qc+f1MDBxXBfx
         YWY1Ttuh1V0LQKvaGSEj7Mehh3+nWqlQaAQc9lqlbUjR9JB5zWGO1xMfUf+vMdaevf/y
         pbIfsds3Ww+wouLtQ8rZLJ8NtR/NmrgHeBq44U+ZHQP5YBb9WRr+ViAVG1G1G6q8oKlT
         NNX1pJuy69R2WAPmnyRB+KxfgPyxKkjib6hfsc3Y1l+WJ90GF42FDrqaLDo3lUoy78m+
         KmS2OfRKJHDZUjcAJprJO+BOAwSJI/WN2JCMK9F62ZLOG19ScgyFZ314hgYdaRl291qO
         UjdQ==
X-Gm-Message-State: AOJu0YxzNr/+ddTzuVWDQj59lzhH42bpIT9LuqSGTlLxUD8Lza+N1InE
	74MVqpVABWt89rN2ygSxLsJBjR3mwHgtswBJQQidBK1Fgn+XZdtiP7/Yaiamap9BIaJMcM/D0ry
	icvC0/AUfIzYuccvTVk+5EwdPHr8aniIzZ+4N
X-Google-Smtp-Source: AGHT+IF3AEnWYHNRp1Oqp8aUrRQqBgoYUu3uvzRdmsLIYUSCDnQo/aN4tWsJAvsGDTsSZ+ipTWaOuVXwRwbmGHd4+xU=
X-Received: by 2002:a19:4342:0:b0:50e:f5c4:ce39 with SMTP id
 m2-20020a194342000000b0050ef5c4ce39mr607267lfj.53.1705599470178; Thu, 18 Jan
 2024 09:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com> <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 09:37:14 -0800
Message-ID: <CAJD7tkbvoODVN4vcO7cxrtacc7TG8BOXOOoDoNr6nv3eZXOsmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: make sure each swapfile always have zswap rb-tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, Chris Li <chriscli@google.com>, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Not all zswap interfaces can handle the absence of the zswap rb-tree,
> actually only zswap_store() has handled it for now.
>
> To make things simple, we make sure each swapfile always have the
> zswap rb-tree prepared before being enabled and used. The preparation
> is unlikely to fail in practice, this patch just make it explicit.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

