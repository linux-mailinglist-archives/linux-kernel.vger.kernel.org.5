Return-Path: <linux-kernel+bounces-161225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8C8B493A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5842822A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594915D1;
	Sun, 28 Apr 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnaLv8xy"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF610E3;
	Sun, 28 Apr 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714271546; cv=none; b=plxOnwLeDbIIvQ6s56UFRAQG5ch4Fc5vgnA1eGLn33UUwaGQrBotAPElXEDwxkT4u14CdZdoEXhVUzU47PSo1ThbJfG1vVlFj6AH5sM18y64SO3dXq52zLk9+EQZa8ZxSV0tGnOoIcCOqfG0GWjKRgSwT6DnaVLz+Oc/WlAqhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714271546; c=relaxed/simple;
	bh=cio30SX7eajsObnd+w+7pElIn68+SgntMF2u2RP/ZrY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Yzn4Tz47YUdLxFik/APyneQfXc2sNFI7sMGnwNevvu2scVQuLCs42kISKc0inhZQxhlpP4oFgDSKbJj0Wd/nIua+EINO9eYbScS3UcLoWYDNYGHwrQtLOpJXGBtasuJCR8F4eCXlnB/KvxJS84fE6x/lVUIFnt70XvNhrimEyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnaLv8xy; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb8809a44eso2035572a34.0;
        Sat, 27 Apr 2024 19:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714271544; x=1714876344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIS4YOP3o0POVYWexKpBXyOqHRnAJDc/UH596UvNowY=;
        b=CnaLv8xy65iw0fT3oOrTI2w2efzGSaaOnJhB6yI5wlajUzhFJvPTwMvTq329GJ7gRv
         p9E1AITIF5fei6uhZZvsLzqV0rRbiJ+887RkjCVQ9zOw2Ne4LBc9wJ9RDZ2YZrCca7Wg
         RJ2HINojZqrT/icMr9XNpkMeQavngcr+l9rYC+pYKeqzA3D/DZhuBfZVdwkhkOEFbmj7
         BTtInZxOMTyiFUtrk7Cq3Qp1kK0R3EB4hIhfwThSGN8oQrFCYGlshm6jXIjKLe+ftOZV
         ldLQk5uZoPAsL7FB3eWyDxzwoLTu/dABepAwa94NgHAXrf4Bxw3f/fSvZeDtVVS984jb
         2b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714271544; x=1714876344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIS4YOP3o0POVYWexKpBXyOqHRnAJDc/UH596UvNowY=;
        b=qe71JwfTNkIZydp2TVPSKAs/rNvw7fNiAZr06GbI7SFhwqqtH73hsnIrpmROvjlyl6
         W9mxPK4fkLz/xLexHrBe0w9ikfIEQNPHiEZyMUJFLE7VXbb+WKIB2wMxItR2IZkM1uyp
         yxN7AuCRPYn1BQ+bzR4IOEQCUAFrxv2cRb1VqJMFvXq8ZFOU/F0tVGzPYb3/8l72aB+S
         AxTaqrjuQsmez+9O0paRXd1mTfPOPnsDn5lCtXxS1fpipdd5ksw5Vg6Kj1K/WlemtzKo
         fMlPMqSyw/8cjyYHPGCYsqNOEZNoZxcdQzsYyZQmBEgGLjVawZ0FA3qPPnTGnwIsihPw
         SvGw==
X-Forwarded-Encrypted: i=1; AJvYcCWuawFDnZJL2niPhJloN6g4Eib2frPTSJQDKF8BnWZ7MszUzdmoJoIndUeS4otqJv0UOzuVnce/u9UktX6CcK0vzca5sOucFI+XvVN9KvFZaHXbXjGACuIo+ry151+hgucXVSuHgRoM
X-Gm-Message-State: AOJu0Yyd3l2eL89iiuklyANHhzv4NjCpqJzHNcks/1nYA8et04is+CXz
	Ux5CtKYpqxk/UZHcvckaRbdLW3ugffApGgom6CNlK0RnKJviwwby
X-Google-Smtp-Source: AGHT+IGyqv+1Fbh+3Tu4cWnRuQ16CGzOpjg1sj2q8t/uA7yHAGiBGeka7Vr2EIuaVsij3zV3tcgAlQ==
X-Received: by 2002:a05:6808:bcd:b0:3c8:6418:7ac8 with SMTP id o13-20020a0568080bcd00b003c864187ac8mr1634679oik.13.1714271543968;
        Sat, 27 Apr 2024 19:32:23 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id h6-20020a056808014600b003c7520cacd4sm2232428oie.8.2024.04.27.19.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 19:32:23 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org,
	dfustini@baylibre.com,
	yifeng.zhao@rock-chips.com,
	shawn.lin@rock-chips.com,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com,
	guoren@kernel.org,
	inochiama@outlook.com,
	unicorn_wang@outlook.com
Subject: [PATCH v2 0/1] mmc: sdhci-of-dwcmshc: enhance framework
Date: Sun, 28 Apr 2024 10:32:14 +0800
Message-Id: <cover.1714270290.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
existing driver code could be optimized to facilitate expansion for
the new soc. You can see another patch [sg2042-dwcmshc], which I am
working on to add SG2042 to sdhci-of-dwcmshc.

By the way, although I believe this patch only optimizes the framework
of the code and does not change the specific logic, simple verification
is certainly better. Since I don't have rk35xx/th1520 related hardware,
it would be greatly appreciated if someone could help verify it.

---

Changes in v2:
  Rebased on latest 'next' branch of [mmc-git].

Changes in v1:
  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-mmc/cover.1713258948.git.unicorn_wang@outlook.com/ [sg2042-dwcmshc]
Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]

---

Chen Wang (1):
  mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc_priv

 drivers/mmc/host/sdhci-of-dwcmshc.c | 152 +++++++++++++++++-----------
 1 file changed, 91 insertions(+), 61 deletions(-)


base-commit: e38063b94324bc1409a29d699c73938c3d008126
-- 
2.25.1


