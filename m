Return-Path: <linux-kernel+bounces-97505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D3876B26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CDDB21A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F25B5AC;
	Fri,  8 Mar 2024 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl+jtdfG"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34D5A7B1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925692; cv=none; b=FlB7WXwaDRvJIR83S/m2CQb3BEJPA2u9RFrAQqXKUS5vHRcf3ihKZ5CYLJC9rYO+BQ97W1RUgXHOYDK4AlL0bCkSse6BqGvcQ7yfuwxRIlwgVdlkxcypIXdXcUGH9jkYRLD3GPctA3NNPA0I3qW6i2AlaHk2be2X70JFcQIGL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925692; c=relaxed/simple;
	bh=yrNvJuMKfEkMrbX4nQmERQ9j8YLmKqtNJuVxSWKzphw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ed5TpKNHL3UPvfDcmsITOrYMd0s26Tbfr/vXPUUNx6vHU3edJ6vLeQNt84Uby5D0A6/DQkFcI8hgdYSGZ3EbdhgJO/1YwKGyEgd9ohhpYAW5iyox5QZsWaJ+8pI6r+2KbQgzjC/A/5Mn5JAftq7C6QlB4T4krZwu9iU47UW1KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl+jtdfG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a0579a914so10020967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709925690; x=1710530490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJZpV3CUo8ldBlbOhga8a8MDt4AxyZ1qnYKzMPyTsPA=;
        b=Nl+jtdfGWifM9EFk89hGl6pxGCOOzFq6olX49X5Vj591bN+hNFV0QYAJ1XvfYXeBBg
         rnwJv/GwwmPT9zaQjrzMraVTQbJbtweDglAtSS+gA7YwM8ouIcO8YZaK9wNQA22UXalR
         qgw7Qid3DPrtpKygq/MV1sGcXmUYw0VGS8Mdh82wQKeEdFU+Lf4EdlG2KS6phTmMaRzh
         ln1oPa1p+zRoMJr/TVKX68fskpNYy/xaSj6R9aj7zWILaKMKPZYIvhGll+fZQr4a/xh6
         FoS9XVKVnmoqXGiPUA+hrK/TWgHiG8djuX5aWZR4hKx5T53zUPe3B2Xc/j8LBA6KIzHv
         tiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709925690; x=1710530490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJZpV3CUo8ldBlbOhga8a8MDt4AxyZ1qnYKzMPyTsPA=;
        b=vomwk/mUCscdwHApaGFoOD43pUGP3Ic76ZuWNIW9led69StNCsSIxjPiwn/L7JQ4XC
         Y8BkrSAl8kkgLk8YHERq2bderYXYm9j5gSSZ4858jgnt1UydDmHNx6yxpJQxF0Fz0esa
         2E3IjY7KId9Py17cuZ6/KszGjfChe7agCuJKIqr+K8Lk+jxr4kMwJmXdBgNwEgtUlLho
         tCTo+Pz6fFfM9tldDhkOrSpiNNLCk27WrNjqR1pjIv8K6+xmtRODarcrhNVBl/1BY/yc
         +kwApL31Ik746vjM6p2X4j62Q9UvAaOy0s2xUGmxiMIJEbjtCp+43QA+YFo/tthZSocD
         XKPw==
X-Gm-Message-State: AOJu0YxcssBuz4mu+u2gCQXslUwZzzOwys6u2HzDqnMcXF65DHB+Z4sS
	mv39SHE4lDRKOZcymMesRCLD+obblaqUvwNP4SGkbVDk/vFEwcSBLA6XIQ9CGo+Atr7MrJvL3zV
	faYWkZtTS9cLIBIZOJHTGaXAi0qL99bfd5h4=
X-Google-Smtp-Source: AGHT+IGzW9QFSwJGy6utHf/8vMrRYZ7qTAFVqR+UAnEdSEKKaBuorbU11D9rWZhQYpfHdGQepBJtr6yYh8N1T2R3rh4=
X-Received: by 2002:a0d:d416:0:b0:60a:8de:e606 with SMTP id
 w22-20020a0dd416000000b0060a08dee606mr142742ywd.12.1709925689911; Fri, 08 Mar
 2024 11:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Donald Carr <sirspudd@gmail.com>
Date: Fri, 8 Mar 2024 11:21:18 -0800
Message-ID: <CAOVeLGRX-i63uJ4RwZ3dAWHOWUr64fQ9_nBeDW0cJ_2A+_J55w@mail.gmail.com>
Subject: Setting negative PANIC_TIMEOUT values not respected
To: akpm@linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

despite there being existing defconfigs which specify negative values,
this channel does not actually appear to work, and the kernel behaves
as if the sign is being discarded. A PANIC_TIMEOUT=3D-1 reboots after a
second, not immediately.

https://bugzilla.kernel.org/show_bug.cgi?id=3D218574#c0

Hardcoding the value in situ works, passing it via defconfig not so
much. I assume the negative value code path is intended for
consumption :D

Yours sincerely,
Donald

---
My apologies for the noise, I am trying to follow:

https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

but:

=E2=94=94=E2=94=80[148] <git:(master 1874fe7ae927=E2=9C=B1=E2=9C=88) > ./sc=
ripts/get_maintainer.pl
/kernel/panic.c
Andrew Morton <akpm@linux-foundation.org> (commit_signer:3/6=3D50%)
"Peter Zijlstra (Intel)" <peterz@infradead.org> (commit_signer:2/6=3D33%)
Josh Poimboeuf <jpoimboe@kernel.org>
(commit_signer:2/6=3D33%,authored:2/6=3D33%,added_lines:2/18=3D11%,removed_=
lines:2/14=3D14%)
Kefeng Wang <wangkefeng.wang@huawei.com>
(commit_signer:1/6=3D17%,authored:1/6=3D17%,added_lines:1/18=3D6%,removed_l=
ines:1/14=3D7%)
Ingo Molnar <mingo@kernel.org> (commit_signer:1/6=3D17%)
Arnd Bergmann <arnd@arndb.de>
(authored:1/6=3D17%,added_lines:1/18=3D6%,removed_lines:2/14=3D14%)
Uros Bizjak <ubizjak@gmail.com>
(authored:1/6=3D17%,added_lines:13/18=3D72%,removed_lines:9/14=3D64%)
Lukas Wunner <lukas@wunner.de> (authored:1/6=3D17%,added_lines:1/18=3D6%)

has no "supporter", so patient zero gets the to: field.

--=20
-------------------------------
 =C2=B0v=C2=B0  Donald Carr
/(_)\ Chaos Reins
^ ^   http://chaos-reins.com/

