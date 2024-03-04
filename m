Return-Path: <linux-kernel+bounces-91069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465987092E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41302863A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425362146;
	Mon,  4 Mar 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwHs/4WY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCD61698
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575911; cv=none; b=G3HmkJLyLrA8H9/eDo5EtSr7fpaxUo2b8UmxuUbYNA972+tIsLYBYmoaqf5uDdJAYxW7wXcX6Fn2HtzZG69e3/NwQMG+dDb3BJAYkgZpzVbiwsfABkXmO7EwkYuSLqha4SB+faGIN5GMZeg2H0TwxKdYWRqpnYxwm8TA9jeUG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575911; c=relaxed/simple;
	bh=tcDiqbccYHi4AinqQLgnM+VghsYJV2IrozkELxqhwLE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SDjVRj/3y8nITUxEYB2a4k0F54J/tXSZDbSypjjeFm+UDoUzD04d9GbYe+QIivRCLUlnD6JxTzWMbBEBIVt8eZf4M++hFBJHl2l8fYMOsukPWiwmdTp946Z3l7VQelcbn6/xFmpDVw0qzAl8+PCFb5ms5vpfsTJ9G34pruwVWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwHs/4WY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7983267276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709575909; x=1710180709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4kLD90+hXSvFb0+fALtfseiTDbKyQ30y8gjmVqCojkg=;
        b=AwHs/4WYyrFxMxsEbGAjIgm7Ytckw8FRNV4rYs5mSaIhmHu3U2REf6DxZ7MsoufDvM
         cUPWlT4uLX5njt90uz27iB5Aqmr5dZ9OU5oyuLgkk1uprLEvCzz95JosQmdZuIEzgZxA
         1wCrkI2Nq42FCbD35LcUGEZtzAYjF6ncGSGLLUUOctQ+Go5nSk0X8uKHxdm8wJtvS2IE
         G3zlWyq9Misi0MaoCBFlELV/PGRQnNsYlRuA4K5AK9LVcbCfd9Cg5epyjOpYu524Po+M
         5eO0CHN32nWblYHYSzfABZcNqgR5xOiX/d5Zn9VplKEBjQYp1SG7Ya27VwviYw1f89Qa
         JKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575909; x=1710180709;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kLD90+hXSvFb0+fALtfseiTDbKyQ30y8gjmVqCojkg=;
        b=kFfJapu0G1h54qKnEma1BS5xoGcreZ5rVilpLCaNCtC72lb1yEGe2AbqPpQi+9GHPs
         751Te8g85So2DC38ZvsEpzpWQ4TPko51e33QMvs/pW578x5CcEWB1mJb4ybD+COxgS4a
         W2k9LXekmj+eVeT7eMXJaBqaxqvgFHCQVAWo0FuTNLQEFUnJRn3CX6jq8ivP/i5+eoEL
         mvTTVAr2ssdC/C12Sl/0vLn1/8qo3pS2/S5hVJgruFZxTC4tVGI2Be8+UgmChJJmze8n
         PQv35tMzaX8QR646Zj/hvWL57XPNlT7kJILFwlM8UGOqbyaDaAYReb3/NL9HfMf8XSko
         qNxg==
X-Gm-Message-State: AOJu0YwEGeahZNeLWqNmo90w7e4MxUXcUk2YfQWKDNIuoERowofPqXgg
	WcJFzotkHwq+96MmSk8bry4MC1/fg7nM2BnopV/DaFcHBhISIQtI3fsRbqtpT2NX/wrq0c7kyGd
	O1HqB6/Mw/ADVYs2hCLtco2s0Uq361alXTrk6/jyx+jfIBmEk9drB+pJyAujaaRuo6S/FENdoP+
	GDl1SP7VaYVP3nwrokUYeg+3jCJUpSrv9eE9JZB0Zb
X-Google-Smtp-Source: AGHT+IHxwF/zU5cb5Vfvw5bR+wuloHPq0SidEq3LQN1W2vemc6jjWhYsFXPGqLxGNUu4w4mRsgdxwWFh/pQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:c786:0:b0:dc2:466a:23c4 with SMTP id
 w128-20020a25c786000000b00dc2466a23c4mr2575853ybe.4.1709575908874; Mon, 04
 Mar 2024 10:11:48 -0800 (PST)
Date: Mon,  4 Mar 2024 18:11:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304181140.644212-1-edliaw@google.com>
Subject: [PATCH v1 0/3] selftests/timers/posix_timers: various cleanups
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I'm sending some patches that were orignally in
https://lore.kernel.org/lkml/20230606132949.068951363@linutronix.de/
to prevent the timer_distribution test from hanging and also fix some
format inconsistencies.

Edward Liaw (3):
  selftests/timers/posix_timers: Make signal distribution test less
    fragile
  selftests/timers/posix_timers: Use TAP reporting format
  selftests/timers/posix_timers: Use llabs for long long

 tools/testing/selftests/timers/posix_timers.c | 196 ++++++++----------
 1 file changed, 89 insertions(+), 107 deletions(-)

--
2.44.0.rc1.240.g4c46232300-goog


