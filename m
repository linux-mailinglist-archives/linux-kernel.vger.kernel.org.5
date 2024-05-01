Return-Path: <linux-kernel+bounces-164958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2848B8574
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEF7B22551
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3A54C3C3;
	Wed,  1 May 2024 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGNJPwpr"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78181D2E5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543105; cv=none; b=ApNotSvy0QT4DrQF/g+rUFjypyogQMvsdcXuyxgsk9pcraXvN583XlhRYSOkllkXyM4+jRq2o04qtEXjJtZHLoFFqiFcHr37Pmz+N7vRXFyCm6z2zSdrMZ7AjZN7q+3lD17JkjJ/5IAggcLJUHuiPKjeIHDjry6SSfjbD0z4d9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543105; c=relaxed/simple;
	bh=NEG2vTlibrdbeHfz/mSNhIkZQL2SAVbK+/ddgB9Wn60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ced+LqswPRiQR4EP+W3YqXwIwCcj3FuSyCoaQIxEtnOoaXOUlchk2vYX6F2rTzXSegyxWGz93ia1gkoNpLZgW1RLxqk98iYG4EsyYV4vdunNYJJbOsKXD6u3q1KAnd/Q+Siv++IkGE4LDk7I1GNUTXxwVBydhiyLIRzmoJD+wwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGNJPwpr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41c011bb920so2301555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714543103; x=1715147903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJSPdGVNL0CH6RKDReTtjMIGVs3tCJE8fRUe5uhYbEM=;
        b=GGNJPwpr7KIMuOKpU/8H8lj03OUuTeTQot5lc+ecTEj8hVQztzN/DcGEFAn/Nny1Ou
         XVrY5sP//ff63P0ZQTv68frIPFEpsuAbA5732xcBBjG7woJzcbyMK1uGxnRzmLOqal4P
         l89NlznE10sHp9u2qig+3buQG9WJ0sZFR1+kRTkZ03rsoVDDb7hKo1yV2juTAdqfZs96
         piADPDZ2TmIwiwdxwFI5yEq0u5SMoiM77uVEuVtXa5icd8izyCwQs5sIwM4QjVXdDHSZ
         AfKK1AwZMjEfDVGLAJEk/dLCkVAxj3BMPoqUeesveFZnA9fjf7OPv+K2a1tV+E8nJQZ2
         +PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714543103; x=1715147903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJSPdGVNL0CH6RKDReTtjMIGVs3tCJE8fRUe5uhYbEM=;
        b=dTZsF7ZY5Q3Nq7bzdk+7dhRt9P1AhTY0JIZ133t6KA7r99ZVeqCnXQRYvhLh9pge91
         f5RbI2yN30Z/2NYjhrBAkQMhqxTSwwO4FQfPTR7ycbJhup4oNCS3HCeZSNfvkvuZmOy+
         53G/i4GIuE+3tXYqb63rrMYCikK44SkkKIgA6pCHt7TUBZeeBeFS9/+Eey8nqRIJp3V8
         bvrSAlM1naLECQIrTRHmMYl4cYW6tJbWzclrjYEeT9eIaBKkjjAU0bmb2ZWXiMVznG9l
         PW2AwFcKgt76QyoNbhco+el4HENmod+cUfokeXVgviNvRq96UKz6+9A0Ej4zQL9c6GZQ
         WnLw==
X-Forwarded-Encrypted: i=1; AJvYcCUncA+wd2BbxJ28dKa2t2cYjQZzcunrdcMYWl35kbenuvqLJOulAEPx81iXSH+stVZaLYgM9LJK6lYygKXI+UMfqv4B3p6HjmLokluu
X-Gm-Message-State: AOJu0YzAtgJVpkmbGgXVCR8dsBzl451Ossn9x2eF+b9UTGcfYHwoxyVp
	iiEAvy0KexZBlPRHQ+c9fItMUNbzj1kTnKA22Q3Ur8UYz/fCoKaM
X-Google-Smtp-Source: AGHT+IGt1yJDDGiDCjl16A+X1xU9Yhehn4TegkmTogjr+xE2qMqYBAsET+Hqkh8odECqIj6ZgfeZ2Q==
X-Received: by 2002:adf:ff87:0:b0:34d:8ed4:ca3b with SMTP id j7-20020adfff87000000b0034d8ed4ca3bmr1634610wrr.0.1714543102754;
        Tue, 30 Apr 2024 22:58:22 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:e314:db5d:b033:4fc2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0034c61e211a5sm12451390wrt.63.2024.04.30.22.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:58:22 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com,
	dan.carpenter@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: pi433: Use class_create API.
Date: Wed,  1 May 2024 08:58:18 +0300
Message-Id: <20240501055820.603272-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset reduces static allocated memory by using class_create
instead of class_register.

Shahar Avidar (2):
  staging: pi433: Use class_create instead of class_register.
  staging: pi433: Rename goto label.

 drivers/staging/pi433/pi433_if.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)


base-commit: 75ff53c44f5e151d21d949416633b56e56160124
prerequisite-patch-id: 91943193af2fea74182be67fb583235a3fbeb77b
prerequisite-patch-id: 2cad031ba6a0782a67ab1645ff034a8be65c2e76
prerequisite-patch-id: 1a852ed8f9d133aec7c651fd9007e59e39c55fb7
-- 
2.34.1


