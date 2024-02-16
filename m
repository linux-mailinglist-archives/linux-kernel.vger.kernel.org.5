Return-Path: <linux-kernel+bounces-68664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1C857E06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E35FB2193A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317C12BF33;
	Fri, 16 Feb 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGzrjMVB"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF31129A9E;
	Fri, 16 Feb 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091362; cv=none; b=U81voowWE7wVTnmZEbwoGURDl+/mzBPm6PHjG4OOiDl6mgbzVR7H7Ln+uvXa4oL2nxfcJznXq+ZxS32nfTf8gvl5XI/m2fj1iO1PxkUal51WIHq+yNfzaeUqw7Y0Qf9B/5QS+ppaO6G9PHpH5EEOKTEMf2mfrnksb58rmOrVmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091362; c=relaxed/simple;
	bh=H+T5FYgKFojb6M4WitBTre0vhWBwiXJLpEA07zWHYGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I/wy332IzO97BmTDCGlnGWvh9iFclUBdneXGdH5Qni194B8R+nAibOuV4y2rI+mi+aMc7wR47/MSL60edCzrhLlqKqEnzM0JBOJxFZFcoWDVgwZMhF3y0FKyrM6rfzoBXx6pkaGOdxOydrH170NRC+2H5JZpoqPfmLo9DKC/Fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGzrjMVB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411d715c401so16061715e9.1;
        Fri, 16 Feb 2024 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708091359; x=1708696159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14+mC4rW9qPm6BJ5liAT/H15Nh4bSLCkqgnbdBJo+rQ=;
        b=QGzrjMVB7jvkJLiymRIlvUBJxugcUsCE26C0UGbC+R2n+KDVgbEIBWrQ8EDbeESPQG
         aUB0Bc6S7XCreBxhk6gU89AaKKNHaColX/dHz5jgfwN8fPy8v2wv3i0aaM4UPFJSny0w
         /0K09BtWMLgIBCYt8fNcREj9thyIR0KGqIA763f6jPqbWhVt9GYvY/7RJrywxlpVdnhJ
         3sRnAxLn+6rf4shgeY0CQuhJ40RKYrSQWHAlcRe42qT2TBB3ZaUF5w4basxREGDDCrf4
         phg/fcMnB+WEu9IKdgHv8DXP4H8lYojEi4MNclMzFIpppeS7a/0Ot0kAXDL9rGFvvmxv
         xpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091359; x=1708696159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14+mC4rW9qPm6BJ5liAT/H15Nh4bSLCkqgnbdBJo+rQ=;
        b=WZDh3+CvC98eF1LJmU9tN0vZx3eyhquSJ+dXiHAnLMqiDxpAZNCpUqqeyD9GcF0e9z
         ZOWNx1Btu+jwjvxIaEr7tHy2mKNhk+aqQOR0PmsqU+/1Mx+XWojItuMdgK/f6ginDlPR
         mvAaUyMyjswyHHD7K5+SpB4AKsQNLM9diBoTE+CEdc9obKuatMG7kvIafWVrFpnHlXKw
         OnBiGZNDSRKrPhsKet/ChGHknqj4gGabzNzIbtri2XJkQP+G54frGBMqQbDvp9HvY3Z8
         tCFJR7wyX+tKLCG9Fa1/yByXNt5IjjaSnJJZ39IbZhw21LqYcj9dq9ioQO45B5hqtjxp
         rmSw==
X-Forwarded-Encrypted: i=1; AJvYcCXAtWLGCE1Ds1t5jA612d71N0BNEk9pxdKYhz7c6nEAD1bu+JCUpR2/03DcMG7n5cf9CZC9G1bYlGqPP/TueJkGUAIJ3IiC6wBF0WBe
X-Gm-Message-State: AOJu0Yz8ZouUVyXUkBcNiM4uIMJ2C+PFRf8o0Qqtr7GlYYsidwPq9qpE
	9fM/1WeT+wnDmWTUuNngfCSbBTpcF+c8OF3YCNDI6I6VR3LDCvrb
X-Google-Smtp-Source: AGHT+IEAYRRuyNEUiuKTwoaLnMzJ9j9OCZ3M7AT1/dc1lZZ0TIgzOarG5W/PihZDAACoESI2L29yPQ==
X-Received: by 2002:a05:600c:2305:b0:411:e2bf:73b9 with SMTP id 5-20020a05600c230500b00411e2bf73b9mr3595831wmo.39.1708091359176;
        Fri, 16 Feb 2024 05:49:19 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b0041228b2e179sm2351489wmf.39.2024.02.16.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:49:18 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: core: Remove redundant assignment to variable possible_uV
Date: Fri, 16 Feb 2024 13:49:18 +0000
Message-Id: <20240216134918.2108262-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable possible_uV being assigned a value that is never read, the
control flow via the following goto statement takes a path where the
variable is not accessed. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/regulator/core.c:3935:3: warning: Value stored to 'possible_uV'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/regulator/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a968dabb48f5..17c98c5fa45f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3932,7 +3932,6 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		if (ret < 0)
 			return ret;
 
-		possible_uV = desired_min_uV;
 		done = true;
 
 		goto finish;
-- 
2.39.2


