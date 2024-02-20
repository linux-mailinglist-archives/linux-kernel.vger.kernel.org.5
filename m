Return-Path: <linux-kernel+bounces-72568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8085B557
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D99281AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462955CDFF;
	Tue, 20 Feb 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwaIdTol"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9F5C60A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418188; cv=none; b=SVAJKPYxD2iTYAnFwCJbhSoG9hc6IiogCpBOItpIUQjtg8GKgMjBXitNNL8ZlrWjtUmAnl/ao0TJXcbeUdEylW7y0VSxXKW/FacvB1cgikllDfkj1VD8X4QHek7wIrFWWoGV33dW2ENl7A3ukYZNDVSpjgmEUiLpy/ZR+zD7jHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418188; c=relaxed/simple;
	bh=zsRWoJ/SB8XyCzsGf6M04J3EaKCb+bbpgCXgW9+Q7BI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IqO+uOHOJR6u/7NFy/UabSl3+QsR1Mcko6SOqZwXDSUEWVENbeqEmpVPyqvB5fRhaODp4moEN5vl7KE8wBDHiUu7ffVOBoN0lnLhzJXWqDaxgJKRw7k6USoIfiNXl9Ug0lRKgMWhrnNuDcGDkFz/9A2nl4q4FJcZzV/AXQotxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwaIdTol; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d24a727f78so3814621fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418185; x=1709022985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PP8e/pyjEKAyyMTaxmA+nBEckgmQt3u+Vn8QnKT04mQ=;
        b=bwaIdTolZNxbHAPv+QOGwGbwDJygDIHtiFsCfQlXWBxti3SXoFuqNPqWiHD7JXflKd
         aORGnpucFXmWZ8lCdzSc1XYuAwP3EqujsHi/xa2Imyk02OMuWUuO3ak6jVSvpCRO9Mg1
         mbD644n0zY+ZhLZJEV5+Bs8dGq7udUAquojH0fMhAUNgGT73G7r/JB4qvbS0d2+uCjSl
         Rlc1iTCXukcQOHIBNGy1+3z0V4AatS5KDZce9Zq/PPP9IkzDyBZl7PLU4OeERDMwPuH7
         QfArQXFWtwibnFFHZDMDq4jlAHWgV6yDGFbJWWo5b5GA8a86S6XMn0E+/0QLC0g1uplW
         cJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418185; x=1709022985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP8e/pyjEKAyyMTaxmA+nBEckgmQt3u+Vn8QnKT04mQ=;
        b=ZWH20Ml6+C+AhmmBWBQy7mzo8AVn8EE0brhW7rdLeATXUFl6dJxlbGSgv/qCAa3o/T
         OuIWdC4wGoJdvDn3Vy/ARuora5zTWGLbLNtUOmJPy6Cq3Ogy9sjxe0hJU9hfqpsT0NJt
         jL9LMIe0KVH0RwY4oReZ71mkg6ZMz1nppJ9/S++axzmEnH3WDi7yNxrq6yPqbDkAZwyu
         zNRMnzjnCrdhBhyZOYLkS6HNtBBk2NROniXFd/b2/3JeY8abbSYt2FN06sDfdLlctyad
         u6YCC/62Nke214X+UR/98vTFKLgyLdZtoE1d1o2158PUPbm7MBAMaw5MkqTa3VUw0jUt
         1Dqw==
X-Gm-Message-State: AOJu0YyRMaWfDe04uggmQ+du11W8WrFPtQ3IO+X68cC2pHwHbsRSEyih
	EVQF8HngwWpTXu0QS1SXbXk8TpA3cw7ST+wQOspfwVNuo7eTKUb5jJngNGPg0aY=
X-Google-Smtp-Source: AGHT+IHgcZSE3XvOyeMgoCvNmhBQXcKV8NxmTVnuTLInqaw3nfY+45hsf5tlMRZezB+MZ9cR/YIxcg==
X-Received: by 2002:a2e:9c94:0:b0:2d2:3902:5bcd with SMTP id x20-20020a2e9c94000000b002d239025bcdmr4848992lji.34.1708418185093;
        Tue, 20 Feb 2024 00:36:25 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k1-20020a2e2401000000b002d2468d3bacsm195317ljk.9.2024.02.20.00.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:36:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] Convert some regulator drivers to GPIO descriptors
Date: Tue, 20 Feb 2024 09:36:23 +0100
Message-Id: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdk1GUC/x2MMQqAMAwAvyKZLbRFB/2KOEhMa0BsSVQE8e+Wb
 nfD3QtKwqQwNi8I3aycjiKubQC35YhkeC0O3vrOeufNSorC+UyiRihe+1IxdH2PGKxzA0KJs1D
 gp46n+ft+maw952gAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Despite the work to convert the regulator core to GPIO
descriptors, there are some outliers that use legacy GPIO
numbers in various ways. Convert them all over.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (5):
      regulator: max8973: Finalize switch to GPIO descriptors
      regulator: da9055: Fully convert to GPIO descriptors
      regulator: lp8788-buck: Fully convert to GPIO descriptors
      regulator: max8997: Convert to GPIO descriptors
      regulator: max8998: Convert to GPIO descriptors

 drivers/regulator/da9055-regulator.c        |  48 ++++-----
 drivers/regulator/lp8788-buck.c             |  64 +++++-------
 drivers/regulator/max8973-regulator.c       |  36 +++----
 drivers/regulator/max8997-regulator.c       |  85 +++++-----------
 drivers/regulator/max8998.c                 | 150 ++++++++++------------------
 include/linux/mfd/da9055/pdata.h            |  13 ---
 include/linux/mfd/lp8788.h                  |   9 +-
 include/linux/mfd/max8997.h                 |   1 -
 include/linux/mfd/max8998.h                 |   6 --
 include/linux/regulator/max8973-regulator.h |   6 --
 10 files changed, 143 insertions(+), 275 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240212-descriptors-regulators-f455ccf0119c

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


