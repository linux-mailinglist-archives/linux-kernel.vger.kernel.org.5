Return-Path: <linux-kernel+bounces-122825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D688FDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F21F23680
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D047E56C;
	Thu, 28 Mar 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gREb3YPd"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8052940F;
	Thu, 28 Mar 2024 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624936; cv=none; b=BnSdPiTAFPxW4pKNk8B3rKrhZVqbLnl3U8YpX4jR5SYSuvVDAYN0knDGY5nmi9Vi8ZCPmtwvYBlD1TStYJgH3nkYJWtAcrwEpLlhudn1ygTDK3IhbdO2ONWohIC2XL454ZL7cgIteIc0yio0JO3oqE4Fz7uol9mm4Cteq91C+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624936; c=relaxed/simple;
	bh=VhBwx336Wa59cMqLvHjIb4VgfXYPykEmXj4L+l2C1Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=h0zSnPLcudMWJxxIfHBkBVmCYPlu0kBN7+MEwsYfOtbA1XYchheD7UauEwm1LjnCEDVAwmVmEKxaRNzXg/LKNmD5TSTJuwueHaiq9/n8yvBjWhByS2AC1jUcDLfx+1Pb3wL4qj01tOjrHH7IjJ/vKEQ3apiONcCWUIduPPATn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gREb3YPd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-415445d169fso4132985e9.2;
        Thu, 28 Mar 2024 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711624933; x=1712229733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIxLkMJg5sxEZW5AaF5ykWjHxeGHlPK3fpUk+EzSYS8=;
        b=gREb3YPdF2hDSX+c5gxwLntOZMuTxi6+Bdsq0ehmpEzzgavtwIUcooDHIW1VhvmEvs
         s3aXR/P12bsH4wNvg86EEQ1IplKFL720uuUGKukecUQ1OM25NNnR/kl84cYQc9L0HZ85
         wRnS5oJC+bsTg6xJQQgCTHQwHIk/8+N5Wp+1fcGGFUEBXkuIRp/ZQJdMwIsxKgr9E8Q7
         qyFnrGYgOouE3UyDG98fVU6mZgUOCwKFIh2z1b0Ig2q9wzVJ5U+x0URSQwuMI7tZ9cP3
         hcg1Zliudwpd/kZQGZ3rpN6iszvyQ2CJBX6PFDcE14WgXerzjoWk53Rc/+JMcL9MUv5W
         y+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624933; x=1712229733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIxLkMJg5sxEZW5AaF5ykWjHxeGHlPK3fpUk+EzSYS8=;
        b=Cx8Y5ScGUMtHX9i6bmE5vgGcQiZub+vsFrvOXvIAfvGkN/IC+yseIu5cI15Iob7/XN
         GVGFYt48GdscqepaQs9CeJp2MmqnIMHdQQP+9TVnZOkfw6uRNYF1htcgYZmna6/p0rn0
         14xjDn54/lyzn4fLBkR3Eu+NRP0rjO4bKrL4ILq0jAzGvfcfgyfoqXqMnY4WI1pesPma
         ix4lHvn4SlqZvMc2PQp8wtWrDaboOQ8Mzcw35toi50uBSjlPFy2wcdBeP8K4hFjvwJsg
         +FEmHxfqqoYzhimTxpcCvi/tyPT+F5TT4Na15FMUJCroEH5fDuOlX83mT38ufnMC+dmC
         x/4w==
X-Forwarded-Encrypted: i=1; AJvYcCV/XhkxiLjpieswoKu/2bagD23ZIIb/HH1+lUCXnt459/DdEmqmm8WR2vn1NQsXTrz0r9h/0rYpCUj5xh8RpoP0fus1ERtPTrXOl8Tf8GYNpUYhmXfKWfhXOKIjE0QZIV0Qjq1tSFBj
X-Gm-Message-State: AOJu0YwCHpVmzasKhn7zEb13iUbMUQbNwvPz+oDJo34JXbtt/vh4gagA
	aDBjgOa+Zq9hDKmtAaGS0FBbVNZvCqPBgzV04O38NFRJjMDlD9L/
X-Google-Smtp-Source: AGHT+IE4gp6H2WzTHbkW38bIjzqyStF34nqi+QhagJN1WxsKs8SRFzFJia6yY029nYoW7NNAaR13Wg==
X-Received: by 2002:a05:600c:a04:b0:414:1eb:3010 with SMTP id z4-20020a05600c0a0400b0041401eb3010mr1958456wmp.17.1711624932446;
        Thu, 28 Mar 2024 04:22:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm4486492wmo.39.2024.03.28.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:22:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: addac: ad74115: remove redundant if statement
Date: Thu, 28 Mar 2024 11:22:11 +0000
Message-Id: <20240328112211.761618-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The if statement is redundant because the variable i being
assigned in the statement is never read afterwards. Remove it.

Cleans up clang scan build warning:
drivers/iio/addac/ad74115.c:570:3: warning: Value stored to 'i'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/addac/ad74115.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index e6bc5eb3788d..d31d4adb017e 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -566,9 +566,6 @@ static int ad74115_set_comp_debounce(struct ad74115_state *st, unsigned int val)
 		if (val <= ad74115_debounce_tbl[i])
 			break;
 
-	if (i == len)
-		i = len - 1;
-
 	return regmap_update_bits(st->regmap, AD74115_DIN_CONFIG1_REG,
 				  AD74115_DIN_DEBOUNCE_MASK,
 				  FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK, val));
-- 
2.39.2


