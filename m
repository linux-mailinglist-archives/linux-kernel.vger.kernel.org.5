Return-Path: <linux-kernel+bounces-154714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24A8AE00D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA0E1C20DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620859162;
	Tue, 23 Apr 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZKGAWbo"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D058213;
	Tue, 23 Apr 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861762; cv=none; b=CTYTYHZr0/fgmmHDExkbfH1ZpFiPTD8dBoBgE0UYdwrVBmfSouJr3lq80zD7tBgm2dmsKrE696cPvUh0Eh/oxU9NYsqP9VT31VvPv315Od6daHWRvpVXDAevR5j8WiZ6sGGeaZefH25t7dEv4qwQSNyNkTyJ081zZvl9avdVDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861762; c=relaxed/simple;
	bh=jVIS089dbZ3wXdCNQYTfk4ga5CpPJxYC+Ek+nANsWKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jrxuBSt/TVWc7GSJ+QFRhRxodWkpyFl8GkgeuJq09ClzA+wS0UAsOFKER7Ej90G0uWIe/M1GsPy3R7e/mRy99zUHMaYRoHmjjoMdbn0lol55bIKxCNmI6Vd0GY3j5LWhxL30DQ/AdoquTkot5994vjSX+F3MT1e7AX9q4IOffNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZKGAWbo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34a3e0b31e6so3856515f8f.1;
        Tue, 23 Apr 2024 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713861758; x=1714466558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbBwe79c842+R2b2YoCAfcl0fXxYuruoHQYuTfXaKdA=;
        b=JZKGAWbo4e2OO/0IcsfQitbvfdbtd9WOmGwlKKY/Pz+RIdM8Potej8xMZMCj2/rzba
         0bw7PAGt2ZtFV6JGv/fgVhEn4pXeZSSJcZKGYtJ03VAe6xF348vn5rxoFZZB9eojJPdZ
         PbNoIbQA6vYO8A5f7OJyNmpaGirS9S0M00cqkN1tn7KnGhqpGZ4OihVLGhWtN1QLvPAw
         FPQAKhwASllz4wtTnx3MH92lzsw9gDZVEXvIq+BDFeKci30tYrVYI+XoTK95tPicxvT/
         R7u9GFOSjQw46z693vQY7EeQoVdmw3+hYyUyMXPs1VNOxlGekVtK7fV5E0tVdZwGik/w
         7hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861758; x=1714466558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbBwe79c842+R2b2YoCAfcl0fXxYuruoHQYuTfXaKdA=;
        b=mhtkIbJyEOjbt28NZVzcSR6s3ODd7zYsuW9pLfkshZ+YBl5q9Ji+Qx4rrZMoOo07XO
         d2OX4RW7R/EhW8+nPh4NA9vr6PNG+1CV027cx4q1S5AGEYXAwAoPDwe9+la6Gt+le9s5
         1zS2wuHua3MpcbO44Nvb0P8PoufLNz4iqcZQ9NhBHzmYg6J+IxvQldrYULTAQm6FaZhm
         3TZfjzHvmWBMh1ZhYl77VV9/B0RI33iRodzESzVN1l5ZknHKMEPRVIKRIjCbKLkfD+IR
         mym4V0rmwyAWUVG+VnL1MylxStBGdaFtbsxrdphoyqeidTq/1gH39JJ3ohTCge+1EqbH
         Rpmw==
X-Forwarded-Encrypted: i=1; AJvYcCVgFqYjfYVhtosKyLUWf6q59vAawsRRdo2K9AY/B4XzZs9VbBYxZXa3/BJAdv97NzhAThhDVHhSxy8PZo41fg5w4fKQlYNil8zHUD9D3PGfLadqtEXAGD5iCeM+u5lVgKjNOyIc/tC7H0WHG7qmTvFDr42HSYKdTUSK27WIxe82Cg==
X-Gm-Message-State: AOJu0Yx6aVCI1xqVeb5HjR6ul5s+PfTAs2PXAnEW4QPol8iW7fbsI0Bi
	V4iaOKfJ1H8g5CF58JzOGzU/wcrNaSM0rQlcebUSrf16dkv9n7uQG6U1Z6G8
X-Google-Smtp-Source: AGHT+IHQKR4h7agVByUQl9VxYHYGh69c7ndqTu7EZ0nPt8u1A61qGG6Ok/JtpvAeUVR1nFhZqHQVeA==
X-Received: by 2002:adf:f283:0:b0:346:85a0:20af with SMTP id k3-20020adff283000000b0034685a020afmr7333249wro.35.1713861758099;
        Tue, 23 Apr 2024 01:42:38 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:cce2:61fe:1efc:ce48])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b0034af18ef68csm5989939wrr.5.2024.04.23.01.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:37 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 0/5] Add support for adis16545/47
Date: Tue, 23 Apr 2024 11:42:05 +0300
Message-Id: <20240423084210.191987-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for delta angle and delta velocity channels in adis16480 driver.
Add support for ADIS16545/47 devices in already existing adis16480 driver.
Add documentation for adis16480 driver.

Ramona Gradinariu (5):
  iio: adis16480: make the burst_max_speed configurable
  iio: imu: adis16480.c: Add delta angle and delta velocity channels
  dt-bindings: iio: imu: Add docs for ADIS16545/47
  iio: adis16480: add support for adis16545/7 families
  docs: iio: add documentation for adis16480 driver

 .../bindings/iio/imu/adi,adis16480.yaml       |   6 +
 Documentation/iio/adis16480.rst               | 461 ++++++++++++++++++
 Documentation/iio/index.rst                   |   1 +
 drivers/iio/imu/adis16480.c                   | 384 +++++++++++++--
 4 files changed, 803 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/iio/adis16480.rst

--
2.34.1


