Return-Path: <linux-kernel+bounces-139395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0638A0279
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ED2287519
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756FD199EA4;
	Wed, 10 Apr 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhuK/Gub"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14C19068D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786092; cv=none; b=kjg73HcyB0BcP6KJDi4oFt7ZPF60Umj3HHf2aGF5c1SpfZICYtaCOEIeNVqIIM32GANowxfxPzzXhexyMJfFdQHZLPiJHwkTFrUhMdXSEtdzA4FmQO1k4IMPj7ybFwCLhhxH2W+yH2znsO4H45CMCXdNidHwgjB2XnNZ6QATGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786092; c=relaxed/simple;
	bh=qYUzmqmdLZgDJPzb/J2uf6pd/pTz/IsAT54nGnkJH48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoK90sURhn+/11xpgxfy+atxQ6u81RmkC1eDjRFwSvPL02TbZXX1OoQ1899nfNu46YYZ6x0a+2JZdvYjh6eGEcpwLIZ2dqt29DaesrJnm34dReAkNeh0qAX4J3GjgQKhcoy/yf7dLAlbnZvO3pPpKGNF6sF9feDPS94g6gAIV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dhuK/Gub; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43446959b33so31105811cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712786090; x=1713390890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTzjP1Nv4ThzlLlE1Ju5kdcsL0LhZGtnYro6XcnlOmk=;
        b=dhuK/Gubb2eeHhJXl6V5/9G4V3kAKIumQyn5+PG8yTe1F1kXUknFJfB4MEs0hv/NNF
         RG3vjW0kOgl/N6Y+3wrt2JYaFoz6P9Lrb4NuWSKmU0m2g8P4ETz8YXxX9v1OkMK9363F
         GJFdE2D7ImvLiiCUQstdNFqD4iK/qQRpyefms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712786090; x=1713390890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTzjP1Nv4ThzlLlE1Ju5kdcsL0LhZGtnYro6XcnlOmk=;
        b=avEhF3LcaD0zb8q3RzK9PSjKeDzw5bsTQE5kHXkq+p3tmC16Z0NI5oiWAjwDL4UWAp
         +5kZD9Bw85ZH+UET+vO91vqdLlR7o7MHSsrvTUhKUpwzG8MnGpNyAbC2R4QA7S5eGFq5
         n4S0ju9KGoIX4KEV7SpPIywr2na8Ek5Yot67yPXV7uwhxExXdGD2wOJcjnpHOQiVUF/o
         9Q5wZ/oCl7200jP8bDXR77H4NtzqrKszWD0bn1QBLdRYzjZPEem8dHIu/Cb9y7F2C94S
         0uQi3nioN8ZyADGRuXIPh5IUkaZ9DeCrkqhDod4D5BlnXaegYzfXrA5mLAi/fdu/No/e
         SX2g==
X-Forwarded-Encrypted: i=1; AJvYcCWVpjndQYSaSuj0r9OHub6zJyKCQY9Fs9TKVFTO4NJwFJaNsTAY38SG2JDrdEbhIWIO0f9OGuxxC1o6bGxrMyF/XtcaTOpiN+LZbcCq
X-Gm-Message-State: AOJu0YzK1zAglNkeu+kuPqXv4zIB4NcikwfkvF7kMgYSGs4secGcJWT9
	rnZABNAgNeVRJzdPK2hexiSKYk/o389boH3F4vc7Y7cwgpdFcVG6oD5mKB6CLA==
X-Google-Smtp-Source: AGHT+IHLvqSrxvThaEcLle6Xam6RG78CJ3NyLYmwXsqsdgP3jJ/C4bjd1BGbbwL3hfA5aXl4iG7EWw==
X-Received: by 2002:a05:622a:34d:b0:435:18b:d78 with SMTP id r13-20020a05622a034d00b00435018b0d78mr4122157qtw.29.1712786089958;
        Wed, 10 Apr 2024 14:54:49 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id kg26-20020a05622a761a00b00434c1eedb0esm67330qtb.36.2024.04.10.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:54:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 10 Apr 2024 21:54:43 +0000
Subject: [PATCH 6/6] media: touchscreen: sur40: convert le16 to cpu before
 use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-smatch-v1-6-785d009a852b@chromium.org>
References: <20240410-smatch-v1-0-785d009a852b@chromium.org>
In-Reply-To: <20240410-smatch-v1-0-785d009a852b@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Smatch found this issue:
drivers/input/touchscreen/sur40.c:424:55: warning: incorrect type in argument 2 (different base types)
drivers/input/touchscreen/sur40.c:424:55:    expected int key
drivers/input/touchscreen/sur40.c:424:55:    got restricted __le16 [usertype] blob_id

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/input/touchscreen/sur40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index ae3aab4283370..5f2cf8881e724 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -421,7 +421,7 @@ static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
 	if (blob->type != SUR40_TOUCH)
 		return;
 
-	slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
+	slotnum = input_mt_get_slot_by_key(input, le16_to_cpu(blob->blob_id));
 	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
 		return;
 

-- 
2.44.0.478.gd926399ef9-goog


