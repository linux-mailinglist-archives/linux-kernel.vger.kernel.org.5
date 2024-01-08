Return-Path: <linux-kernel+bounces-19974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4E8277C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70751F231ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436957314;
	Mon,  8 Jan 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gB0maOuK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6957302
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso2070988a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704738902; x=1705343702; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unPpQVTDeVqN66DKJjPl4haWBetUrrskmet/dbbnct8=;
        b=gB0maOuKH9EYBK20PGbJ1ou6i9UFFJODNOAnMhE4erZqK30iZZAQICGfeUnxMGX2Tg
         fcgkDs6VVv8LCRGoxpr2Y2hJpi4x/PLKPY+ZgN1hOI2qA2sFPnWRfc4kvvWGnQ89+QRa
         8Zs5Rp9tRK6kg2lvjvyf0LhOTFoMtIbMrtPGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738902; x=1705343702;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unPpQVTDeVqN66DKJjPl4haWBetUrrskmet/dbbnct8=;
        b=gK8E3KucVj94DZ107Hp0mNgMPPIfgOFBikoBHVDHBzk19CDScQZnnZ14eeGh1TW3Qj
         dsrxOUrWjJVhRfWutbZFx5Vp8QSJwGGUEZPvo3BUudPhC+XrqTBBN2TZiUFSWTHwvLcG
         f5vB8VKsbt70JrhHWHmHCmMeBamtwvXDVssU9UDwcsso9J5bW2wse8CJ8E+S+zqRYEba
         XY2j65lp1QQlnMqb10OoMyykEnUQodiW4j4eAYjrSK5Gz9+IVcChNeUZK00JtNJ927sI
         GRWyE0HVTli3QH9GVElIeC+i+pqtwPEGikcTvzHZ1xuXZV9Yj4amR2KyOUNugz+QEN8i
         n4lA==
X-Gm-Message-State: AOJu0YyavOXAAaGwrIbhtEXbOhbdXYjQFbc5s7Mg/TgCplGxcpm8xfZf
	8lZGw9v3WbkJYJP5vg6c227qUfw95AwP
X-Google-Smtp-Source: AGHT+IFMAJKlIHur8xVj2dEytFnwu92FXt4vuV1qqmouZ8QSMRxfvhp8/gNVS3ldQZaSlW3lXVBmAA==
X-Received: by 2002:a17:90b:1b50:b0:28b:c02a:d0e2 with SMTP id nv16-20020a17090b1b5000b0028bc02ad0e2mr186788pjb.18.1704738902366;
        Mon, 08 Jan 2024 10:35:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sz15-20020a17090b2d4f00b0028c940cdad8sm6867394pjb.5.2024.01.08.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:35:01 -0800 (PST)
Date: Mon, 8 Jan 2024 10:35:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] execve updates for v6.8-rc1
Message-ID: <202401081028.0E908F9E0A@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.8-rc1. A fast-fail check has
been added to dramatically speed up execve-based PATH searches, and has
been in -next for the entire development window. A minor conflict with
netdev exists due to neighboring MAINTAINERS entries:
https://lore.kernel.org/linux-next/20231218161704.05c25766@canb.auug.org.au/

Thanks!

-Kees

The following changes since commit 21ca59b365c091d583f36ac753eaa8baf947be6f:

  binfmt_misc: enable sandboxed mounts (2023-10-11 08:46:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.8-rc1

for you to fetch changes up to 0a8a952a75f2c5c140939c1616423e240677666c:

  ELF, MAINTAINERS: specifically mention ELF (2023-12-06 14:55:31 -0800)

----------------------------------------------------------------
execve updates for v6.8-rc1

- Update MAINTAINERS entry to explicitly mention ELF (Alexey Dobriyan)

- Add a fail-fast check to speed up execve-based PATH searches (Josh
  Triplett)

----------------------------------------------------------------
Alexey Dobriyan (1):
      ELF, MAINTAINERS: specifically mention ELF

Josh Triplett (1):
      fs/exec.c: Add fast path for ENOENT on PATH search before allocating mm

 MAINTAINERS |  3 ++-
 fs/exec.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
Kees Cook

