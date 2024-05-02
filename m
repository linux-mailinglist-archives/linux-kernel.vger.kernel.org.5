Return-Path: <linux-kernel+bounces-166381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D28B99DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971FCB22D74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719075FB9C;
	Thu,  2 May 2024 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eJYsVg4B"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D55F874
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648582; cv=none; b=Sxo38I9D0wDba4pMaxEUdprm+AoWjfz9fNiaiZSzzcFqF4XpebhcwWN29W0ljEKFVEymedvVLucKa97dIts7A6IE+8rj/nI3Qyt15FWrP0rEVZWUSN4/wl2jKF2bg6CIoo2OPU7o9EvhK5/gGLp1HVFhzsbDgmeC/OIrMtwBjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648582; c=relaxed/simple;
	bh=Uopnuae4XTj+lMXhKoWJrhT/gsv0jkB2SUJrolbIB3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eY+Kuk21Coo3Cn8dVh7Z8SPxIXs+YgFpe2XmSPc3qBY+rqfFYNVjVzF1LxayHcKykMVrrSbH7cI7dsE8b4wb4IEs6sYlDwa+wAOtBrzCsw+1rGZPSMcGexnv11bpspfZDW8XsCbkXqStFhih4xXyjJgX2t4SxSRsWtidJhwwwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eJYsVg4B; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B109424A0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714648576;
	bh=or9J1KNamr3SyadMwGskzlQdXHkztewT20MwCVZSRlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=eJYsVg4BpPQre/K7gIhvu0BPzQjKjz5GUf6KCmcMDm3Z/CT8tY8KBEa9Jkpj+YLEL
	 3BcX2a0OykN+uhPX9LqeaCaWre6HeyoRMiPr3WUyTTTkVyU+4g2EaEBqeMUtXfyZZF
	 TXnvr7a28RC4Hh57zqkV5SiO4hQ2MMzzFoOAQnUmyYUwRxz34eK9OjvDvcIIWjYxG8
	 nbuSBGVdCQypcjPPm5Iq1+7hkXBHkeu5SCrpJ16t3oAwuxghEkH3Euh+OpD6q/1f1d
	 jdHxiQPEk6uVQNA1cowBBnS8zUimnS/4tfXWR+yg2enFmjBC2oRA4Fe/7l8CEH06V0
	 izVRHIZj1Ih3Q==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51b0eed7614so5929794e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 04:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648575; x=1715253375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or9J1KNamr3SyadMwGskzlQdXHkztewT20MwCVZSRlo=;
        b=urTQJl/d17YBKBtL2QCPMr2rEvuuUSkX99j7kZcSxYYCZ7h3uF33WGct8VMIeulc5c
         gwVu1d65U+Q3MYgC7xeRR+youfX6VozzKJsfDZk+3EzJ0iGOuXyEavR4CixznJLk7DP2
         e8rHs0S5OoG7/0yaZMx7CpipxIYRQkDmurtK+AD71gt+OApVDQhmeEQDbGFyFldCDnw8
         84ufc58k1c/gx4k7Nhq6xoMjCOEaZqzoko5LoZBM0G/FIaEBjB02V8yOKO299bce9WLC
         lXv6JSpgBIrlykT4DmzuzMh9z1ccLDXijr1WeX6PgMcaA28zBswW+19nDZ2rWyIOLYrl
         TFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ539KlJkQS574dBbN8JpUbXD+ZGwdNAkKgWJsRl15pXdYctWlyn/B5esaJMcewEO7EPNrR18D2HpDfF4Mkfli5Ua47bscaAPHaGKK
X-Gm-Message-State: AOJu0YzJ/NCXU3RaKjcJ73+ft16F4virVMws2QgFYJynKR/Z6CWXVxib
	A2UUADZz2Un+DIfYJTjt2gvV6bne5Q5GkEiQUsROSTJXr4FgM54YaUlTZhq53r88syllveu+ftT
	T6kkrc5dboS9ah/TZbmSKYMVbp3I5FHzrTH1RIBujTZ2xHNT6C9hnYvDB+fcqjiv8Ul7i4tGj2F
	6kBA==
X-Received: by 2002:a19:6450:0:b0:51b:bb22:f21 with SMTP id b16-20020a196450000000b0051bbb220f21mr4131197lfj.38.1714648575614;
        Thu, 02 May 2024 04:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbuAj3aP4RY2E8LiKmkKVQKaw+wSBaSVpfSeA/6/airVEvEgvLgc91RZ0Nt20kQ1CC2w5sWw==
X-Received: by 2002:a19:6450:0:b0:51b:bb22:f21 with SMTP id b16-20020a196450000000b0051bbb220f21mr4131176lfj.38.1714648575240;
        Thu, 02 May 2024 04:16:15 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b00a4739efd7cesm437278ejb.60.2024.05.02.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:16:14 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCH v1 0/3] riscv: make image compression configurable
Date: Thu,  2 May 2024 13:16:05 +0200
Message-ID: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Masahiro's patch[1] made me wonder why we're not just using KBUILD_IMAGE
to determine which (possibly compressed) kernel image to use in 'make
tar-pkg' like other architectures do. It turns out we're always setting
KBUILD_IMAGE to the uncompressed Image file and then compressing it into
the Image.gz file afterwards.

This series fixes that so the compression method is configurable and
KBUILD_IMAGE is set to the chosen (possibly uncompressed) kernel image
which is then used by targets like 'make install' and 'make bindeb-pkg' and
'make tar-pkg'.

Patch 3/3 depends on the previously mentioned patch below.

[1]: https://lore.kernel.org/r/20240414174139.3001175-1-masahiroy@kernel.org

Emil Renner Berthing (3):
  riscv: make image compression configurable
  riscv: show help string for riscv-specific targets
  kbuild: buildtar: install riscv compressed images as vmlinuz

 arch/riscv/Kconfig         |  7 +++++
 arch/riscv/Makefile        | 60 +++++++++++++++++++++++++-------------
 arch/riscv/boot/install.sh |  9 ++++--
 scripts/package/buildtar   | 18 +++++-------
 4 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.43.0


