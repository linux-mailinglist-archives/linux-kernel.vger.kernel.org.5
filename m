Return-Path: <linux-kernel+bounces-44269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA382841FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A09A1F22DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3F60DCB;
	Tue, 30 Jan 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYQSvgVu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135C604B7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607510; cv=none; b=KsE+w/cCTtt2NogTF0bhtUDpHj971y1ZgsSUD4SCbx97jixfJj8xcblnoODjIDE9dJLu52p4n9v0dvB64Ncfvm1dGPU9OodpHiyTUj4d+gtPqXWAlruM4OpRL5pHEbM9bseKERjmMrdbBl9ZW65F+sMKiONu5XSJkeTIolrNweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607510; c=relaxed/simple;
	bh=IuA4mLN6900oSwbnRVrQ2gi7SLLO14ryO68RT0cNCnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emAx0ZpNwrq6eqHjDDTi2UzoEQhuWSJ+zNZKORlLvIqoDK5JAfRriyIIanFzemqWlYNl7IdrqbCV++PRXvauwH5X/b+wNFKl45onMAE4Ec3fD6flsHC6UyDvb1f42aBstyp2d8xZEK6l0J5OtpGaLU86g2lYrLwJCq+QxwWZEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BYQSvgVu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so142855a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706607507; x=1707212307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HttPdQ9wtHT3O36QTysPFmeFn2Ai+flVcwvN38lZlLs=;
        b=BYQSvgVugZxNB2yblYoGsQjNr5q1/6JuhyOFlsS48z/B/dKxVZYOugf7oGIqkq09mu
         wOPQ6LHyhnnTW/7AUsrCHKQEwoCoh4yXgoXsuHYshJi2tH/V4FzfxdosIfZkKWYvxk8/
         Hab0o/nYebqVzwFivBdep44/Y2dMswEaKCoTS/fRRuHGkw/C28eMwRTL6/fNJUsa/JlQ
         dlpktPdKUv1qmTStgGTpiyHnX9HCsndq8HhYys07WBR8iTyXMl2tJRebVXULZ1VLL/T/
         9B7Odhl+aWM+24JXJUT5sGxpIYnfyRyEhsebGZ06YnjKovfttJILfdgTAxaXY0r8FpNx
         yLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607507; x=1707212307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HttPdQ9wtHT3O36QTysPFmeFn2Ai+flVcwvN38lZlLs=;
        b=rnr7Z2r18dTBnhvuDjC9QxIV4mNe3d8Pg/lzgdYRpHETEf8zb0sSc+hK4vGapgB+Up
         U2kt0eg5qwemtOMHLAL+l7xdlZ0kxclX+zk83ZXRbC4qM46QQNRW+gbnnI1x474qevlY
         +c84NcpFb9TxkG9BcEHfG1PoEHcnRtGW7ylUQ5otly5u5JW8W4he7jMQrHAC85Gbdjri
         aOET85TBmQ5ksCiapYK34FtS9HKHw2quc1t/df64uVy4fM48UamJq9ARkrPg4hDHiRKS
         qo/NP7xNiEaGvLZ/iXN8PvtfK9DXV9BJKu7bSv/MzkHttSMx+Z15M7Mk96RdKLzCgcjH
         /51g==
X-Gm-Message-State: AOJu0YwjuEo+gn7yDNg0W7twuRhPxi8w+3gCXr4hS55Kcih26d+96hcK
	w2JjeusiSdQez2M6qmu0t2UEn+nVZPhUEfBgFBqzHw+jxUYA/78LXiuKkFCEiys=
X-Google-Smtp-Source: AGHT+IEA6NxIu/ED4iTEyJP4pvq3EJXhitTD70xShbF+2OaIKJxva1ufNrR7WYdOyG8FHhNLevhi9w==
X-Received: by 2002:a05:6402:26ce:b0:55f:1ef6:48dc with SMTP id x14-20020a05640226ce00b0055f1ef648dcmr2575893edd.21.1706607507072;
        Tue, 30 Jan 2024 01:38:27 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0055ef56f4575sm2281225edt.39.2024.01.30.01.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:38:26 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/6] gs101 oriole: peripheral block 0 (peric0) fixes
Date: Tue, 30 Jan 2024 09:36:39 +0000
Message-ID: <20240130093812.1746512-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

While working on peric1, I've noticed a few issues in the peric0 area
and these patches are the result. They should all be pretty
self-explanatory.

Cheers,
Andre'

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 11 ++++++-----
 drivers/clk/samsung/clk-gs101.c              |  8 +++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

Changes in v2:
* new patch #6
- fix a typo in the commit messages of patches #3 and #5 (André)
- add some empty lines to commit messages (Sam)
- collect Reviewed-by: Tested-by: tags


