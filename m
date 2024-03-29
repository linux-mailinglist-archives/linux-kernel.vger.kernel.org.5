Return-Path: <linux-kernel+bounces-125540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B310E8927FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0AE1C2106E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5316F13E3EC;
	Fri, 29 Mar 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMMFkQnJ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B189196
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756627; cv=none; b=Yhko3qz4CtzsJLab2KeUcFmot0gNh20+haguAzXemj/3y4092cwhqJUfHbzXtNnN9PNcY1TI1VMwUu3YIrQh0RhAwIdln0zaiqEQbBMaNFvM+ePjlErvh3po3QJ76e896AsErWePttlUVKgngFQeLc058qo+x9llgtUNyN4JxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756627; c=relaxed/simple;
	bh=QQoLyPTSu4GTKIPi2mx8qV2xviu/j5AVh7cDGqQcRf4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rBovZsukcC6L0PTAtw4BmsdTvMa+BjnX8//tTn2fezughMZ0PGMDzfsGIK+6wkAkr7HqhMIrMhRnyX+wLd717B6EqsbNGJpYiPJUiROGYtmTpux/ot0qS34G3trn2E6dQ9avobbgjep5PpxjDmeK9eopwwVwmFjN5Vv4zJt64Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMMFkQnJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430bf84977dso13781881cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711756625; x=1712361425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQoLyPTSu4GTKIPi2mx8qV2xviu/j5AVh7cDGqQcRf4=;
        b=BMMFkQnJZyeFcYpgxPDGKet2EXNSaU0GKOvOGecDTEKUTxF0xdLaddN4YxIgPSGn1x
         x/8ZNAhoHQ8EhZRNf3YFx3yf2HgP9ryh/gciuzmbzGwgxtjcZYouF3LW3jrP+TFzvpCg
         tW/WA2+zCQFIvqR6LyxDYkwudkVKhjrqCx5Y5RrHdi36Lm4zecZ6NZmxW1QzjiD3qE/C
         xfNXWSffuQpmlBOXiHJCTFoOaz9C1ItiznSVri9DRv99ITUKz7HrtVYrPFbf2eknrFuY
         Olu2f8mH8m4FiLWHdWIzJHTVO5x5Tw0iu9ZKUZpGEirhrMvqU8VL6mFJqIaERJxRv9P7
         T82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711756625; x=1712361425;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQoLyPTSu4GTKIPi2mx8qV2xviu/j5AVh7cDGqQcRf4=;
        b=dcdi91yjzGzv4Zr06RxRRhhy41KjXizENTg9rgzkOfCa/Wlv6C4DNpofS2KIpLJmpp
         od+uodeAFwF8nnOykVo05aGXTYETdcLpsMtjDuA+3o1Kt1c7ZTvhBW6SAN6Bc6AhmvTd
         Ntf6QXJRHzmzemcGZOFDdJcC64yHJPia/ihFUiAKk8fEB8fDiq9XV3gY6YALEtewrkoh
         nxiJC7np3V5uWzouZyhcMVcy7Vyf7IzmJo25tv3ih8TIfxRdWojhTROVmEoZ0u9UBpy/
         HPm5Jtnc8Ace9gjeF/un6nHxWWVUSc8jFuLvcA0QX0O+hvkUtkz5+MqpTTMiabWJl/As
         rGrA==
X-Forwarded-Encrypted: i=1; AJvYcCWbGTPNe0XGY5DIaBwMxuqpjxWPZX+OLes/x41Af2OAlN801vjco88lbUsAxJfZx5UgbN9VP5mSgMCijde17suElkspxZRI0QUw/6m2
X-Gm-Message-State: AOJu0Yyeq7xzv9VcRsmJc+0h0TlaadXWOPhqCQDZjEULZ1RDa4abG/VZ
	98WbGS8vxUxK7P95b5IpeaQRYgzFS5eA9r52iQByLetppTI342jDJh/9CF9GdWMbBfkAh6d1uVX
	L0nNEckgRXFD74HA5IiAsbzJTv1A=
X-Google-Smtp-Source: AGHT+IHiMMcHdHcmNb0+QRGBXPjiDBSzWOAtrHWyPjOBUgA11i0OJSDjXZ/p+6bAo0f5q5lVLmCOLsPD/z/bai+cP2E=
X-Received: by 2002:a05:622a:1044:b0:432:c44d:8912 with SMTP id
 f4-20020a05622a104400b00432c44d8912mr2859042qte.18.1711756625103; Fri, 29 Mar
 2024 16:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Sat, 30 Mar 2024 00:56:54 +0100
Message-ID: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
Subject: warning: cast removes address space '__percpu' of expression
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

After switching to linux 6.9-rc1, I get a lot of these errors (when
compiling with cgcc/sparse):

/include/linux/netdevice.h:4033:17: warning: cast removes address
space '__percpu' of expression

This is around code which wasn't changed and which correctly uses the
per cpu helper. Sparse flags were -Wsparse-all for sparse 0.6.4
(latest release). Sparse was enabled via C=1 parameter and sparse was
configured using CHECK="sparse -Wsparse-all"

Problem was introduced between commit 8ae292c66dcb ("x86/lib: Address
kernel-doc warnings") and 3a1d3829e193 ("x86/percpu: Avoid sparse
warning with cast to named address space").

I would even go as far as saying that 1ca3683cc6d2 ("x86/percpu:
Enable named address spaces with known compiler version") together
with 3a1d3829e193 ("x86/percpu: Avoid sparse warning with cast to
named address space") triggered this problem

