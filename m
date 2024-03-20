Return-Path: <linux-kernel+bounces-109495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AD881A34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63386281ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12E8613E;
	Wed, 20 Mar 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cHqjRs10"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64081E87E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978032; cv=none; b=CTb3qXtLOSWFSNmCbpmR60sLK0jWGLCTY7O+fvFqhJDtiEmQTGnjIrIXjMJJlbY/oritAuW/jH764QSCJz6DCwyHuq64n0ykbtvzLeJN5t7piWE3Y5zuiLuvmhq0wfzixUYX12v5Z4XzViMjsEyA9kXbjD8B/ta9ntPOmOVMkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978032; c=relaxed/simple;
	bh=KwWyMblbIYq6UPISgPw6fcBtxkC9yr1d9jOgmG9zOt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts1m1SZcCR87xvFrYZloWDE1U1Pgn+kwMRv6SgWvC1XvnesxCBNU91G6t3hbHrRO/zUE+sYEeYMmOi2YoLAJH8Eld4W/VEfL4g8iye4SoL3ITfCW5RR9AIXY2RiGsJOGLGnng8oS9guAtmRGQxny8SZVvJmwMeWQHGqv3Re8qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cHqjRs10; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso48913966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710978029; x=1711582829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ6dgO/nF0HWzmJ0fegbH9GxYNvSqLI3xGG2gpHeyg0=;
        b=cHqjRs102lUBBt5d48EMAlProEekPodVQVx2yYrFQ4siE5QuFCuv1XMKt75xOTW5Gz
         ll4xes7AAtVsd94O1bxo78LL37AX4WCcuVqxdx/CimIN/qafEktmkXud7+G0Bonguejf
         1Hr9/EC7XNTn8Ga7Q2c9QwH6AowvsrKrB//r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710978029; x=1711582829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ6dgO/nF0HWzmJ0fegbH9GxYNvSqLI3xGG2gpHeyg0=;
        b=hO9S3ihKtANmFzoNpBDt0FZd1rCbhkTQY1c/FJzGUfpcvGWrfPO25Tx20nCKSacQAk
         I5eQYWgeqnG/CQYYX6/Qr68KnkrlMPH7DB3KTHVoRNhP7Q0N0HyXRFdUAB7xld/TtsPa
         BreIcVW4DuRcarIOUti30xM9B2TeMtuQfc+92Cgb8Yzl8B4SEIVMKW0yy5F3pdpEfW19
         fbH8dGVJD1G84AmgbnYiDLXPLxr63B+H2mmhBvm+wD5LAs/neFnA9EC68H+EnVaL2j8v
         lpefENi28cNAPpcr0Mhi0nLclki1iK8erKJkWtSDQksMIeVKM64Ktu0oxbQLWg51jcB1
         fpqQ==
X-Gm-Message-State: AOJu0YzPEAT801xgrBSqcbqhegaNxG1EGLhQL+dmS4iXyguL0tM4tkOL
	oR2C0Q4yd5PLewjrSiyIXA15y0vKoKYc0TnSRgedIrv+0N+AKzGlcXorOBLLaE83RCZ0JthJ61+
	yXPXJOw==
X-Google-Smtp-Source: AGHT+IFc3cX3mqJac9REYaIiP5hWA/YIYAS9MoaGG4zpxairTZc5Ev1+RbsF7YbZp6hmDTxShfrlHA==
X-Received: by 2002:a17:906:40c9:b0:a47:100c:b2e7 with SMTP id a9-20020a17090640c900b00a47100cb2e7mr10831ejk.17.1710978028916;
        Wed, 20 Mar 2024 16:40:28 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id gx27-20020a1709068a5b00b00a465fd3977esm7971883ejc.143.2024.03.20.16.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:40:28 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso48912866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:40:28 -0700 (PDT)
X-Received: by 2002:a17:906:640b:b0:a46:3d7d:358 with SMTP id
 d11-20020a170906640b00b00a463d7d0358mr211213ejm.10.1710978027941; Wed, 20 Mar
 2024 16:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320112214.01bc5339@gandalf.local.home>
In-Reply-To: <20240320112214.01bc5339@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Mar 2024 16:40:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCj-LWq4C3GdCeU7kRFVCuhbKTucc-9KSCHNdbe5-O_A@mail.gmail.com>
Message-ID: <CAHk-=wjCj-LWq4C3GdCeU7kRFVCuhbKTucc-9KSCHNdbe5-O_A@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/tools: Updates for v6.9
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 08:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Update makefiles for latency-collector and RTLA, using tools/build/
>   makefiles like perf does, inheriting its benefits.

Lovely. Now it all worked for me, and gave me the legible

  Auto-detecting system features:
  ...                           libtraceevent: [ on  ]
  ...                              libtracefs: [ OFF ]

  libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
  Makefile.config:29: *** Please, check the errors above..  Stop.

and after installing libtracefs-devel as suggested it finished cleanly.

Let's see if it works for others too,

             Linus

