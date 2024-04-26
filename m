Return-Path: <linux-kernel+bounces-159410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DF8B2E45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B12B284036
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E8184D;
	Fri, 26 Apr 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Uy/nJbI7"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C3EC5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714094629; cv=none; b=FaIPEhty+WW8PHUdiEC+Lw4QRjCgKd6P/rw/pc44cPOpnrn1a07OPIxhfet1qoi9nGYKL67h7ndCQtGYYVkZZqgwjAZStyaa6R8rVLBWeE8rlX0bpwOPfI5AVP3ROZqnR9cX0l0DAbuDVFkqqVXGGxE6Ptfh83nSe16PvcKnijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714094629; c=relaxed/simple;
	bh=WN3Wx90GnarGBbvwYvBfiRSjvHRTvvewa5iQY3wlfa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LAWEfl2WB5Tu5gxmmHcqG5yh6vhvsE1N0kEFuEtPOH+7DgKVMkQ4D27jK4Fw8+mkRlKsVt4lXK9qwW9eDL8rt7lytRyMKKEsiFkUmpWj0zw2iVyNB0P3ZMFug3J3zGj6QUhclYlHtD4kbuJ0JKlNgIHDpTHP/tML02TGeNv6oxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Uy/nJbI7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2abf9305afcso1222975a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714094626; x=1714699426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdDRTiTBbDsfZNIom41LCBVXtQhaZjQmzcw18UpcVL8=;
        b=Uy/nJbI7ZtE0sZIeb5bA8b4cvh2MHgdQLTscKzPNPdFyUS1ym92NrTcU+5H8YOcMcO
         yHVXj4SoQ59fgQuqL5+ZiBsmbmvpnfJjO1r8fMP5bgINNI5rlFrNwznyyPg/D5EDu0vV
         2kBw6s39PuzRqA2iN8Z8WoboyGpJ+ZSMJ6DgHlRoOW3OE17uKX/KslMW/Ak47M/rUaIh
         LNX0DntE7DURMcJAaYtxkdMMHQk4EICx2w6CwRzQkKwiyeVd0eVdyRvVS8s9Wh5pdfib
         tbowHgNukgNlT5E3wmA8SwzWrW3/k0ct+tDXl7XnL2CmFbQqARuw2hroqr7yfoUs/tpp
         ZASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714094626; x=1714699426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdDRTiTBbDsfZNIom41LCBVXtQhaZjQmzcw18UpcVL8=;
        b=XFwFXJv7p6tHd/cNo1PrgqdFOsb9gzr/0nHEW0cMb+PgxpopOyxggzzGFpFaZNy2j9
         kW8J/6RQxnFXCpG+vnZakqCQkG4l9NUQCiiVS2ZppDeiK/pvPWUUc3f1EsImWhLzca2f
         dfXdUO+AkhrRXnJOW5sGLydYp/P5fMCf8S4NWPaGBb854YIZlYCZBOKQxXmBGgbrvskv
         fFVZUCUjUfNlQcrOi9cBHfwrJsdECxGQvYOM8XOYYQNV4toGIcjLTEzgIOT5TQZmE+tk
         83zZGp6kamHXse9o1iBDXgWqG/6qPf1ougdqDvNopVohMf/3lrZU2Lt8LMLBt1EpwJ0S
         HeHg==
X-Forwarded-Encrypted: i=1; AJvYcCVW6Cx8oOC7t4ogrv0X2kXvJQjpmL9qsJGmZS3yf+3OkitGzBB9nXtX7VHwcgZ7hwfw7Sj+JfqipbsVNzgZKLliG5rqhWABtChfeAmz
X-Gm-Message-State: AOJu0YwlRPLH5PSLjKoSy9zecn8bxvjdHqN3+0E2pdUbAlh6j9wQHUl8
	5xAorU39uTRhhJDDjD4X4zYJZV8I2fezmTw9+EcjQE9pdKxvOvm9y5RHLH+/T2k=
X-Google-Smtp-Source: AGHT+IEVipMCe3/6V2ZK76e8PB1EWM91qLS8PoOs/Qa9lEfL+86k7qHDW5/mcZROHJ3ek+UBpy0ESw==
X-Received: by 2002:a17:90a:4a08:b0:2ae:f53b:113a with SMTP id e8-20020a17090a4a0800b002aef53b113amr1315122pjh.35.1714094626465;
        Thu, 25 Apr 2024 18:23:46 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:9968:e871:2529:9bcd])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b002a513cc466esm15294305pjo.45.2024.04.25.18.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 18:23:45 -0700 (PDT)
From: Gustavo <ogustavo@usp.br>
X-Google-Original-From: Gustavo <gustavenrique01@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo <gustavenrique01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad799x: Fix warning generated by checkpatch
Date: Thu, 25 Apr 2024 22:23:10 -0300
Message-Id: <20240426012313.2295067-1-gustavenrique01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean code of iio:adc:ad799x to avoid warning messages. These include proper variable declaration 'unsigned' to 'unsigned int', add blank line and use of octal permission instead of symbolic.

Gustavo (3):
  iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
  iio: adc: ad799x.c: add blank line to avoid warning messages
  iio: adc: ad799x: Prefer to use octal permission instead of symbolic

 drivers/iio/adc/ad799x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1


