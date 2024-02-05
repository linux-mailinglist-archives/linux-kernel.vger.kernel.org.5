Return-Path: <linux-kernel+bounces-52997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC2849F51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F30B282C64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA339AF5;
	Mon,  5 Feb 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AihtT1nR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A73CF65
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149753; cv=none; b=WBaX6zgX/lKYHIC69NpGJ9qZcZqjGsHNEOzuqempKVM7H5a9L7eT8Nk+W4It6ncLOtxLRNj6KjdRrApAprOFMYNvjq/25cmW/uKdPD0aW42KKELFMp+17OId4r3MqiD3Gv5retC2qxXZmxEceIdXawbziA3o+TBX4niuo1RTlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149753; c=relaxed/simple;
	bh=QNZdJgtA0DvZ58oCoyunZk+TF/2wguhOSw1ImGIEIfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCbfEB27hDleyTAIBks/bTJpWaWDeMsuq26DIbyQmlp+14HuqiYHBekNaZrIJXFf+1gpMEFwMGNxTHwZhJ24a1W4hqewhEMiGSBNik5MN+wfFA4RkfhtXTB7vD8tRRX83jJvucmmlODCD6eT+fX9H6NvXI80MK5MOfMwKbAWnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AihtT1nR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d911c2103aso25068585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707149742; x=1707754542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kosTlKckLwBkGwRZXFmlE0YMNTJwV5fsSDM4SiElA7o=;
        b=AihtT1nRzY9Q1LXp/euhQFTBVR4LdWCjLavZt+zVepRFYIwS+2BA2hNT1AhWJ0hcXf
         i473PED9Q1Wzy5idI3fTwCtIT2BRjw4XhLnxfA7BLHyBFz80vJn7iY7YadjG1ctCjevo
         olaudYz5l29utYAY8CsHaT33poQ2wsKbpsFXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149742; x=1707754542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kosTlKckLwBkGwRZXFmlE0YMNTJwV5fsSDM4SiElA7o=;
        b=KLiq0HxqvABm+yG/COyBWNCnWehtJfW6CrBLvgtj3zZ9TP5Ih/OFNBpzJ0odGYx/uv
         +IXGbgbUGaLG43/pB6jeLr+NZ+nlS4fv+V3lsjUcqDX9z7UwXdVcfLbHGQ7kNT0GPF4u
         cdtn+zKUknFqNEUFtCayFSO7AabGEWp0GMl7Gxg49V1AMnfHxCKl03D60aP4fgoijmsi
         SCOyoxE1bVAiQ4wRA8QZ5MPQSGf2apvz6qP1hYheOX97w8x2+mHXLECIzmfP3Qhrw7wJ
         F5SoFuzl7sOqwhdWvjjMyxNmFkPxYhhzuWNWKhMYwcrHDeUexhYjmbXhJHoOF/mSubNc
         92Zg==
X-Gm-Message-State: AOJu0YyCTu2KbQND6Errlt6WfDrANf54S0XEJEMtx93eymj++KNk9iHv
	SGDG/lbQ75LD3460D0RIUYoiX+ZqvO25TwwelwAPWeIk85iSEd0ZRhUdIR+a5g==
X-Google-Smtp-Source: AGHT+IER10PZ8XbouP1hq6ENHyJSiMPBPm5z2fhQEfN/Iv9Hp6+8Fv6vRoA95msOqgQUpvJB/3wIzg==
X-Received: by 2002:a17:903:32d1:b0:1d9:bf07:7e64 with SMTP id i17-20020a17090332d100b001d9bf077e64mr3001403plr.59.1707149742484;
        Mon, 05 Feb 2024 08:15:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZBH5UjE+mTjIIU5//tNnFvU3qQhXdjyCTImS88gCJwr/FJwF/CKHGfSNWMH7KQmk42EpOA9ui/dhcWDd7fe5MRT/AULYUTLop/3lX6ohd6vgaKrNknnQ/HtJ2oJsNXGAdFDsqU5GV5fCO8HXBYdnNtO7mojtbXf8Y/4RMpFz9nVxkYdzzivHdJHWXhPgmWyarxT2CqOUzyg/hCEtojh+Qh2Bs4APvFk5/QaboerXG3nXT3kRpIfQuDu1DVpEEIyiuBoiFQqbTaqRezBAff+DllGLpvX/JItWwQKjC67uAi+ZVNthikw7P+lVIPpGQ9SBnahmG6rA=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001d5d736d1b2sm38326plb.261.2024.02.05.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:15:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Chris Zankel <chris@zankel.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fs: binfmt_elf_efpic: don't use missing interpreter's properties
Date: Mon,  5 Feb 2024 08:15:31 -0800
Message-Id: <170714972859.1382644.2755936263342477379.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118150637.660461-1-jcmvbkbc@gmail.com>
References: <20240118150637.660461-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 07:06:37 -0800, Max Filippov wrote:
> Static FDPIC executable may get an executable stack even when it has
> non-executable GNU_STACK segment. This happens when STACK segment has rw
> permissions, but does not specify stack size. In that case FDPIC loader
> uses permissions of the interpreter's stack, and for static executables
> with no interpreter it results in choosing the arch-default permissions
> for the stack.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs: binfmt_elf_efpic: don't use missing interpreter's properties
      https://git.kernel.org/kees/c/15fd1dc3dadb

Take care,

-- 
Kees Cook


