Return-Path: <linux-kernel+bounces-127047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78589462E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BE81C21BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F1537F0;
	Mon,  1 Apr 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2VqDdU3"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1302A1BF;
	Mon,  1 Apr 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004337; cv=none; b=aPkIooF7sQVBQjOweiPOglknzgeW44ebKgkzFCYv3F53yXFoR2jWnSqVvUU/f8eutgfGzSIA+HzPG29PGcO0YTMo0cVG+ufUxB2lUzzVmHmd1uhuW6j53OJt5lcS4x8Kx1h/Mk0NKNrN3l0P44ochEIwguArD2PqgZfhBaslWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004337; c=relaxed/simple;
	bh=0zE9uv6KW6Tw+bZfNRxJGNeiEFHBdZJzqbbocrihr3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oX9e5YMnQTUXiFeEI7jpccQmJEePCtXcoAdqDHuZ5dJVwV7l1NKCgCG32UMRyIrCYngiWrGENIgTxPjOFbiHVWJkLCoQrbX/pUdYqqDSfVEG/qfbgUjgYli6YUBab/6MHl22hxXOLMgYzOCT3LYGf6NxyZlbsv8Y1SHZcNHI73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2VqDdU3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4e39f5030dso396034966b.0;
        Mon, 01 Apr 2024 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004334; x=1712609134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCST4XYzWYyA71tQbv3IPfrHrDtMp82gV81dTWMeOH0=;
        b=G2VqDdU3e3DjH4mDI3ofWJvzF2gRmca9sGk36H/bSlJfEewBS7LqshXH4WeisyVWgL
         gknwO6axaydBEbGjfzyqTLBA6UJFKtmcRjeVBKIG3iWIyOE4+7oprgBwnrXX1YZO/7dg
         CZC8bnwyTuJv1FYtQVqOKQp2LTX3aLfjyE+RlS0ibLVCV0mWVseJPut7b2IHr32t1HkS
         5MLYuUSXu8lt7N427iCKLHzG6iIIICUkOcRmLy+SttiIGi+hkexdxJ+DcrXOJqvsqxYx
         v2YU+2EjFmeOKJbVvDl7aYgPcdii68SfE5G0mLf71nWNmNZt7GArjmc+45m7rSzOOn3g
         Sz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004334; x=1712609134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCST4XYzWYyA71tQbv3IPfrHrDtMp82gV81dTWMeOH0=;
        b=nT3TcHIGnf70CyeBtPM8gCp/zjq5wzxaskwNdPMe1yTBacJ79jsJBcn0lqQmUPGuB/
         LRCGC84pVn35oR8/YFBqoCfozAJ32YaKnIXk4Gxas7eYFIPl8CPTW0rNODpuYomusnhz
         ELC2nVx64Q6ywz+H/IrRfy7x79LHSb4lTL/r3jtDtr+y+VPbsn0CZiqSlGewNQpTJvDg
         qGgYOkIKpLNjxPieBPCXDdAjizrMKHmmfqbDsyqd4rujwc1egZ83HepEnl3a1scxjWzH
         va1f/hYZl+cj0qIXAaXZdWyfMhIETW+PR6bHHcSFl1Ufn19n7I5EoHc9BnqGLkpsIBW1
         w3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7oQRP53YQd8UKzk4AQh20gxkGqpLRTX+quvlizxHaFboqyC0iHRFyFyKxb/5Q1V90IIeKMfXtvpi6m8upaH44E1+GbBueqNIQWPcH
X-Gm-Message-State: AOJu0YzaTgBj9OOPI+EKni/HbuSlt0xPcN2QeLPkC1GkH/5n47oxnHRX
	qHt82VLwPOoqFI+D/jLddPaGdfxEpLvaD7P8MNiQWz+opnu6JquA
X-Google-Smtp-Source: AGHT+IGizvkHIWPGGR5EKJ6LjHFnfy2dVXn75vIBWF4YKklsj8Nacd3EKIYC5AzFvC4ZA1O9BJ3KOQ==
X-Received: by 2002:a17:906:e02:b0:a4a:3679:5514 with SMTP id l2-20020a1709060e0200b00a4a36795514mr8201486eji.48.1712004334049;
        Mon, 01 Apr 2024 13:45:34 -0700 (PDT)
Received: from localhost.localdomain (2a02-8389-41cf-e200-5145-c12f-55fb-574a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5145:c12f:55fb:574a])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm5646751ejp.2.2024.04.01.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:45:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: dan.carpenter@linaro.org,
	javier.carrasco.cruz@gmail.com
Cc: smatch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Documentation/smatch: RST conversion and fixes
Date: Mon,  1 Apr 2024 22:45:09 +0200
Message-Id: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the existing smatch.txt to RST and adds it to the
index, so it can be built together with the sparse documentation.

When at it, a couple of small fixes has been included.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Javier Carrasco (3):
  Documentation/smatch: fix paths in the examples
  Documentation/smatch: convert to RST
  Documentation/smatch: fix typo in submitting-patches.md

 Documentation/index.rst                  |  1 +
 Documentation/{smatch.txt => smatch.rst} | 68 +++++++++++++-----------
 Documentation/submitting-patches.md      |  2 +-
 3 files changed, 38 insertions(+), 33 deletions(-)
 rename Documentation/{smatch.txt => smatch.rst} (60%)

--
2.40.1


