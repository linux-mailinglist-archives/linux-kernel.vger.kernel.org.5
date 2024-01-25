Return-Path: <linux-kernel+bounces-39032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E783C9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CE11C20F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A1130E51;
	Thu, 25 Jan 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl7JXYNg"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F1130E4C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203429; cv=none; b=fvYRH9NmQKspBvZtrD7ykAsGaCnlEFoJYfxRLDH+aZJFt98xO9CXD364cZEvSWixenmZeDQ7o3/HX3w1u0m7PfwA8m6+NCP5v+Rpp2F2VuHAfzXjb4fWaRtJ9/AfHZcxaDq4kYgYGeNtjmdAFGrB71F6c7LaTWPwaiz+67V5PQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203429; c=relaxed/simple;
	bh=YavNyiSBneQJgvsavGCIYXOgMH8ij3t7wLy/BZ9VGoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQXWW72JBkDEc1RZmB0x2FHSzJCWbIpTJ4EUfshB5qpX74CSSEk+x7CIUSLjDx4yKLPGuy88a6DdeRPmuiQEsLFXes5WY9ODPAOmLFeFWF8TP76l42+KDL1dPLlmgQYpr8HvJ6lsf4PcAl2EChE5bkfhvniLEvrko3oxPL73nEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl7JXYNg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso71931867b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706203427; x=1706808227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2gaRixdg+nmjTFS1tauOhVekYOprOLzO/cqNLoAsX8=;
        b=Jl7JXYNgkGZhDX6vAyJTFtTotTjHGd4U7z51FzEBb8FAW9PirDILhODTizFLtyhQ4r
         Lj9VfRigOPMODH9XE26JZghL2VRtjvF2n7rtmE9F7ws3hO8c0pgUQJfiVOziukZP8zye
         7GEANGg1RsQzZoro+BfhYwJuVZf8P4JIjmPU12sQdNQ5yCldVWPDh+hpIM1FkZA/KV3X
         VxWn6kpP0ZBd34aFwbmWXhMDzAFkVhTdQt0OdEM++R9pfyPUw3PvWc07lW+ATYVm8Hdl
         lJeld4/WdtxCe3AJc+6tKd/46Jo3iJx6FSt80yn+vp1DsOw0DHszRttgDzP9iBLKdDEa
         dz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203427; x=1706808227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2gaRixdg+nmjTFS1tauOhVekYOprOLzO/cqNLoAsX8=;
        b=MXEveMXrNaQKmUesZ6nl+EUeyUMofSbx5ZUW4rn/MGR/fmxzmCyDlQPGDonjWfjxKt
         LqzG9qAZTyCWujeTTwLDruiuVrHIbBuVu3E4npG3DgdKojX0sdUgjgTSeKRZHc7j0mYX
         rD/3IchN8j1Gjb1nCeHUxG4N2gHPsdUcB5M1d0BCY4FfuKe2MYhcNMFmaNcOyhwvxrlT
         9IfyIo397x1ldSMsoTBjCDoUcTAheUzbao2PYLCnliE4cdGpQtWaXpB2QZGornV0lrt9
         Us13Jgy5Kq+RWuX05pTininDTyWPzk573QMiegVeN0uMYNOOCkVVd0wggGPbHJ60xuVm
         4ulA==
X-Gm-Message-State: AOJu0Yyg/QE+erLAlAKb8eOrdMii/spc9P87M/jt6QTZaMGea9fmVmdS
	jS5Sl/rL626nB9A/igw3g18LzwcabakvSPX8JYSv2/s56EAddzQpy0A+y2zD0fSN5UYrWMtEiSI
	THtnfIGGGBXgWXnoBfJzHO9s1aqU=
X-Google-Smtp-Source: AGHT+IGGZqfQkJAtoo57UVIKirfdFkN8DoTuxdZehgVFVYr45ju9Q5mL5tp54GNZvYJTnZFvSYKNWAuAQlMc8FBPOvg=
X-Received: by 2002:a81:b54f:0:b0:5ff:5d7e:54af with SMTP id
 c15-20020a81b54f000000b005ff5d7e54afmr114682ywk.105.1706203426764; Thu, 25
 Jan 2024 09:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
 <2faccc1a-7fdd-499b-aa0a-bd54f4068f3e@suse.cz> <CAOVeLGRxXfs4wxSmB2ULZS72NvJkWQvZyPRz0rAmQyFtL39ekw@mail.gmail.com>
 <0a782904-bb19-4111-979a-31b52aa44ca9@suse.cz> <a51ddb8c-cf11-4394-a2fe-ca855749ff02@amd.com>
 <e7eb12a9-67ed-45b1-aaf6-e1df52a247bd@leemhuis.info> <05ddb2da-b182-4791-8ef7-82179fd159a8@amd.com>
 <54efe4c8-38d8-4a5f-ac7a-aeb7a4e3535f@amd.com>
In-Reply-To: <54efe4c8-38d8-4a5f-ac7a-aeb7a4e3535f@amd.com>
From: Donald Carr <sirspudd@gmail.com>
Date: Thu, 25 Jan 2024 09:23:34 -0800
Message-ID: <CAOVeLGRiCZ9KBmsFY5NfGABUcw1CQoEcSKE1k0zv_6Aicdusbg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.8
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Dave Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:23=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> The test patch [1] posted to [2] works for me.  I expect that Matthew
> will post it to dri-devel and this can catch RC2 or RC3.

> [1]
> https://gitlab.freedesktop.org/drm/amd/uploads/ca8dfaa22d6f5d247c28acf6cf=
3eafd2/0001-Drain-all-entities-in-DRM-run-jon-worker.patch
> [2] https://gitlab.freedesktop.org/drm/amd/-/issues/3124

I can also confirm the attached patch has resolved my woes; thank you
peeps for the quick turn around time.

Yours sincerely,
Donald

