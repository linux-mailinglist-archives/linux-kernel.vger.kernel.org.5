Return-Path: <linux-kernel+bounces-48663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC25845F88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615EB1C2A384
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4112E1EA;
	Thu,  1 Feb 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhrGiisU"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651612D168
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810840; cv=none; b=AHg5+OhDtmIi1PX6axbeNYFHb5AlTSqn2hcG0tYV1fsTiAsNX7HdUhumcP26kt7NAQ3rYtcDlKGRhprv1GWv6Z8xCP8rOegaaMGICik/OUQHKgvXnV84SR6dTyYs/vXYhntr+P/WBFt/mZqZodgoOcXtkoSmwPDYPUXs6QWMcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810840; c=relaxed/simple;
	bh=T86R8HpV7zXDhFND8oowyz9LtpNq2PuQYU95ptdb7h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O82TbouFsLCEDJsN3rNbYWPVPpq078TgrXhQGJ//mwdKy88epAiZikrUwDH4jzsXZxVHskOLXS5Y2fXX6nS17GIaYK+zMg4q8RMffclJOOFDa6WZEEI20kPzf+qCR0adwkXuaJ1A7SyeQ3paOAIkH3RjI0zVajeaAsZFCZjY4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dhrGiisU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1062426a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706810837; x=1707415637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M7HdB/Ln7k5cmlXcTGUtiNuQylG7V6KZfKoZDxv6bw=;
        b=dhrGiisUhwadhWWe/IhUv+PQnT3WwpPe5xs2bK/x89Omzjn422liXPn41lYGp73EhX
         qSYfNEUcNBNYaeCXMFdwQ1ymt5pvhWAe4KJ5gDK/Jy7azgbxIj095YKUGn5EKyAvANmO
         Qw/UyjuK/OEjVyG/Mth5L0ECmDUbgto4MZqQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810837; x=1707415637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0M7HdB/Ln7k5cmlXcTGUtiNuQylG7V6KZfKoZDxv6bw=;
        b=w53xhW+TEqjcPZpDDaWsTQQZYkJvn4Ei6nC6r2kFl3FeABoircqPjXcqGhlfZu3YcS
         PpuPCYz9weulpQVauo1OdAKLhRua7w/jpUQNnQPYh1yIYJUNlmFlj4ciK7KLA/vJXEnw
         ku7JBdzg69AOKD8vhyw/4WfYrVaxa3uUdQinldYc23Uu1lyCnr6jII46uOWwTJxkjsw9
         jiuyAMfNf0PlVRJv1y7JE4YuQgMCs594/Py3+kxxSYAOz3NV8Q0CtcOnHhPaYIeXwXza
         an9424mXIsXtg2W0hdADv1EXuLr6xA/+OIGKezADlnZHRGw8hwkcbo9jiEdPTqWeL1vk
         aelg==
X-Gm-Message-State: AOJu0Yz63F2PS/YNHhx2WNJkV007Qto9Qd3vC+QBDjQDcrGuTnuQZopV
	RjmaqU4Uig7g5wS+2V/7wn76gUMc1AgD1drFPAA1d8mpwufnVdGi2xejUAsuog==
X-Google-Smtp-Source: AGHT+IGZ50YBlnxuzelc5pTz/pz1j+uj9w9e5PyOrID+cIqF/msxn7RtpGU9s8Ie47wWQ+JqRWi2qw==
X-Received: by 2002:a05:6a20:2a0f:b0:19e:30b0:6ad4 with SMTP id e15-20020a056a202a0f00b0019e30b06ad4mr2993716pzh.55.1706810837327;
        Thu, 01 Feb 2024 10:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJbAZjXQp86ijsd6GO7kukUS8GlA8+ilpBR2ZFQjKnYO3qfd2ORGJpiLlI8DkOGs/iziWlI+OtxFUCZlrTelSfulEVpQKRDvnjBwu+cF/gsrZ7/xb6/oMzs5Ei9sjltpWK5JrmhSUQ0E0uiDJBNdjJOl7XDYxRriY0u8IhE7lcH/YqgMtJN03est7wBrz8WozfgujI00xFJTdYE+ADgdnL5dRk2V3dyapAO4iJEhbc8d4JUJl4sUThfD6fua+p0pi0pIA89QEjah1n1fX2dMm1jGzkmYWIE8CyY4E/pMoV1xGUagwITwL3Jyj24wnMSUg4OytQXgtd2wAoIg7S3Bu5toJ81NcgHY1czpWerYDbrsossXSKtSQFdTxkk1YBiLOJ0mwJEmcNz+ezCpGlUH5FBuTVfQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a63d64b000000b005c661a432d7sm94693pgj.75.2024.02.01.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:07:16 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org,
	error27@gmail.com,
	gustavoars@kernel.org,
	Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	vegard.nossum@oracle.com,
	darren.kenny@oracle.com
Subject: Re: [PATCH v2 1/2] VMCI: Use struct_size() in kmalloc()
Date: Thu,  1 Feb 2024 10:06:58 -0800
Message-Id: <170681081625.3764000.6431595387488802492.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Jan 2024 08:39:59 -0800, Harshit Mogalapalli wrote:
> Use struct_size() instead of open coding.
> 
> 

Applied to for-next/hardening, thanks!

[1/2] VMCI: Use struct_size() in kmalloc()
      https://git.kernel.org/kees/c/e03d4910e6e4
[2/2] VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
      https://git.kernel.org/kees/c/19b070fefd0d

Take care,

-- 
Kees Cook


