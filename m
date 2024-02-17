Return-Path: <linux-kernel+bounces-69861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2954858F94
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768691F22CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4367A72D;
	Sat, 17 Feb 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocmrixBy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796697A720
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175240; cv=none; b=HBL9I5KwM3PS217jVKhuQAsNl0zbY3mTbxriFoJY+xd4aqjCaVXk71TqOmF0zZ9badXEx0riE/t8pg7QoAaaPNY1UK6R+zzI/T3p1ErZBVqMm5eJOCP5u+4xVdG/qzWoJ/VjCI5/ZszLtNEX7zPE1hizxQ1qy0SsaLbMwmITlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175240; c=relaxed/simple;
	bh=j7LZasRoslnQ4gLFEYtwIkUpouD3UXb7IZwMMZ0k18Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VuuMB5IweFMOkRRiiUM7V2XtduhBM2uowzfCjr1SbX9MOlrxtV9ivS6fqC98jQaPVWh+3Fpjiic9GdZhhxm5jv1ZSNSfL3OuM5NxspllIboL2YO+X0g0bz83z22TUQ10no7n8FMzjUEx6Y9ohhiwUtunAHxgupm8RLiBvLvfGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocmrixBy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6fcdc1so26139467b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708175237; x=1708780037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4YsTPy+u2ynTkan5HCdCkuqHXbKMObYftk+gGeCLW4=;
        b=ocmrixBy3NFmSM3odedQm+QSviUxBge3lUKmtSH5lekrf1cpgJqrRDt4qRip4v8W4C
         lrcGGoJfbFYzRFp/BScT+ZBxq+LoPDvc6sTowTUM/M0M2GAxqjoDU0qtzf3FY5+N3U/T
         YNzas89aghLKFi/nD4NHEfIe7Nsb5+Xg2Hc5q+4WSDA8zoNAEoZ+GY0cOTmUutoLlKku
         gEyFi+NZAn3PuSTADgqO+YnQU+BIctieA4yeQL/YgmYbFGvr4EaMaWzL7KH3W1lvabbW
         rObI/gY26ac2xsRxOztdi3DV+de8/LaRLyddi8T/Twi0e4265tbj+rRibWNR1vBDOSSw
         iOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175237; x=1708780037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4YsTPy+u2ynTkan5HCdCkuqHXbKMObYftk+gGeCLW4=;
        b=wqdDMca23G4hvZxYwnnJb9POSz3nV5Ex5pSjjXScBVgOHCGZSZG0CZEA0rKvuvVEP/
         2A7tQIhohcbEhF3E50agoNoIRoD5dW1VYwYXdeTDZrVsHnHUkjDk2fy8EGmqeYCaZxFn
         NxAoFcTcS8RDA26QqHnCMOEEFQXMHZ743mb7T37c0rgMySsCt55Bd4StU82ZFBKz/IZy
         1vhRehCpPK5EV2CmuR7dTkGVwUzO9f1XZDpDDwtNserj1mA3EKQAVT4qUmCxDyu5W9+A
         3sJ5lftRKVnLTUgSkhy1r1cvd7dTyjBviBf4lDUfi9eokbrVcNa4k9xrnACuUV0wf1im
         4X+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWEml0oAlvBq6J5d6MU9ofhltCUtyU5GY6XUEo/h9ksM+qUfwcoPJYEGuOzzQQb/wdesYPUQcVVi1PllP+AutS8nfBITeRpfL3rz1G
X-Gm-Message-State: AOJu0Yyr4qEfimMFJnlJczfdyk/2rVDcl/te9+cY7iFZ5E4vuhZC7LMq
	xvIbEMY5otaLAy0mHPVNZ16WiR6Mclrg9yxX10rT4N4L+7yjYBBQXz+NLVvK995dWhiwPbYLJ+3
	k2P9zEeyoMRrnrPodQw==
X-Google-Smtp-Source: AGHT+IFinfKlB1hBzhDd5KtWrCIi8q1+sm/jrGyiRLTf+ANaTQb8rMEdyaFHYvXpOZZpMtxV4FsQmNcsw0xYP+ng
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:728:b0:dcd:4286:4498 with SMTP
 id l8-20020a056902072800b00dcd42864498mr426726ybt.6.1708175237563; Sat, 17
 Feb 2024 05:07:17 -0800 (PST)
Date: Sat, 17 Feb 2024 13:07:10 +0000
In-Reply-To: <Zc/OGnjVKcCuKNA5@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zc/OGnjVKcCuKNA5@andrea>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217130710.3566812-1-ericchancf@google.com>
Subject: Re: [PATCH v5 4/4] riscv/barrier: Resolve checkpatch.pl error
From: Eric Chan <ericchancf@google.com>
To: parri.andrea@gmail.com
Cc: aou@eecs.berkeley.edu, ericchancf@google.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

Thank you very much for patiently reviewing and pointing out areas for improvement.
I also appreciate your kindness.
This is actually my second time submitting an upstream patch,
and the first time submitting multiple patches.
There are still many shortcomings, even though I carefully read the documentation
and refer other submissions before submitting my changes.

Once again, thank you for reviewing and providing such friendly suggestions.

Sincerely,
  Eric Chan

