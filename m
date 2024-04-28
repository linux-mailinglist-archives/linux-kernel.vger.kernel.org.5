Return-Path: <linux-kernel+bounces-161556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695FB8B4DAA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC001C2095F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB960745C9;
	Sun, 28 Apr 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wIdxwk2X"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16368F9D9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714333443; cv=none; b=hPKoQJ6FpedIseH/vhQpdzPPH1Me38UBWAWviw2YrpvS5yAjlI1VvrdY8DFLw04tw2Q6f8qpz/k8Q9/ckHA9iPJD2hjwy+fN26zNggstGd26M4nIzKvW+cV/cEIEOlAKTiEPykcyyqNShfvVZVLakQi65ZKUjjt00NMusAkZmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714333443; c=relaxed/simple;
	bh=cERXvdIZCVS7B1mKykHRycZHT2z+/YgshBbc+TNkg6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDfJpHBGT1FAuK5i0HEm4JfixeQIxsljK4+QOTDxvmvbsvnyfOWxM8CFdMGzPkUJwVV+Ak1RZlZqKpJh1fbxT6LNY2NrTVFu1IUuTNHPUdaEVmBbrU3NXjkROooK4XUDDaLoShuoDq5EJOn03g/PzOYB/DKQ2AdzdjGKXp52buc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=wIdxwk2X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so17626895ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714333440; x=1714938240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEVCsk7X+1CbRmIA7FbTrG9aCtrrBiXW5C9er5WvmSg=;
        b=wIdxwk2XZxRvJHQ6r9um2vd1C6RYY0hytTZh4HwkYR0zq6CJ72M7sEOl9EBm1RJukv
         eQybokjt/esVGILhqR5gJYVDz6HgK07UilSAvJ/zoZRvHmSalez0wGpXBVOgJ1V9HtFO
         mRQ+FlGeudyh/e1Wkl3jZM5RFDUtjneYgXNWDgeVilZDAEPIQrqiIF8epfoJCjR3QNJV
         HsPVDfcwo14W2uwKqxNCgTK7hENGzSeSrCQukeUuwSMfITyDSeSvJFrviE2stX9iasDJ
         LnCUtJjSQ7AkkhKcyPoyCCxms+Qo2X/LYUJoIu5tejMlmffut7yMHSgBPH+8alppWY0X
         cdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714333440; x=1714938240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEVCsk7X+1CbRmIA7FbTrG9aCtrrBiXW5C9er5WvmSg=;
        b=JHFX7lgzcPvWawNYKqlj33jzCLMUti9WNQOEDSeehWEXSzGeSw5QgbIsN9HeUWvjJF
         u+FVz7Hko5EmvP4VDD39nx57J2MIDT7Rat512eqPo6nJcJXbyzl66yZ2SAfaVAhYQ4tF
         YWX2O7ktLvoz4WXdRTBVlchIUEKt4xoMn6NtwaVy4RlaJyz0rromiEZVF6X+x3PF7Q2W
         O3wndcNGlaDLVsMq8gGE3weG+vVJliq9rSJHmkt32hAGz+Cv5KwXOnOtVbyiwWGPaQ/E
         c1MyleqmPI+88iIJ7fzpx8UH5rp7NB8nMLxhwXBCtJ/+Aw7KnF431yqMX2n1g1UfVGNz
         zBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJUzI4f0L7l0/KpA5N/tBdD7yvejcQVfKQyyAziqOFsuv/a42z0ePAH3CHjkf2x22BpAymghsjnB6+gNpnXCgR7FdSR2IUk1chX9lJ
X-Gm-Message-State: AOJu0Yw0/T+b9zvjlA6/zmWrk1gZlOWlihCtTpAE6XumlgUam25Bep5n
	AbAIIIDB/SeJ8IGfqg0IlTTGBUOVeol9kYZbVPg4V0bDf3JqsWZId1wPUOmUOEE=
X-Google-Smtp-Source: AGHT+IEpPw4PDVMY3qVTyN1eVi6fYZcrKm085urilL8So+NO4n14eGtEjL4LW+6Pwdfby/3wINeceQ==
X-Received: by 2002:a17:903:2312:b0:1eb:3df4:e63b with SMTP id d18-20020a170903231200b001eb3df4e63bmr8747571plh.7.1714333440389;
        Sun, 28 Apr 2024 12:44:00 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:a3f3:f05c:11d1:1d76])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b001e45b3539dbsm18826374plh.41.2024.04.28.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:43:59 -0700 (PDT)
From: ogustavo@usp.br
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo Rodrigues <ogustavo@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad799x: Fix warning generated by checkpatch
Date: Sun, 28 Apr 2024 16:43:23 -0300
Message-Id: <20240428194326.2836387-1-ogustavo@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Rodrigues <ogustavo@usp.br>

Clean code of iio:adc:ad799x to cease warning messages pointed by
checkpatch. These include proper variable declaration 'unsigned' to 
'unsigned int', add blank line and use of octal permission instead of 
symbolic.

Gustavo (3):
  iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
  iio: adc: ad799x.c: add blank line to avoid warning messages
  iio: adc: ad799x: Prefer to use octal permission instead of symbolic

 drivers/iio/adc/ad799x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1


