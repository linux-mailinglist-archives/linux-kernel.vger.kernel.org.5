Return-Path: <linux-kernel+bounces-153712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF88AD1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0212828E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C215381E;
	Mon, 22 Apr 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOYb5BBV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CE1DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803874; cv=none; b=fW/PMUSImVHFxhCgt+Y57FI6rhBi7ihbhp1aXbzAsWrl2+LZckM+6lm6ozklOCqqLjRTHQL4vCSAfuLckdnJnswQd95/pBtASJcmF4vasS5Tlr7186aad75HD9IyLOH68uI9c1Xr3j21BvRBvE8dUlEG3h0jYMfYhHZp7C9FUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803874; c=relaxed/simple;
	bh=H6lY9kh62C4YQstjcqSOklbN1ZNSivp/MHHRCWngx/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y2CGvSUTc408Lin6FTF+Ian3ZCL7OPZUGtBrfWeOPmRcTVvVwnmK7HS+D9CYZzZ79gz0tlYdyEE3wfejQwTo1aYLOzyxiK198uYNYLxGcduNcYDgSj1OARFCJpSw2shaUBe511nsmiyXnQeBZLMbCRruiAsKSpbr4ssQkvCOY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UOYb5BBV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41aa21b06b3so1834335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803870; x=1714408670; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/RJrrrs8RwvpYrHG7SbHwPY/r0CKqLeGFzxu6oxqWA=;
        b=UOYb5BBVre+5E6nos39Uiao3CK2OxOG7MUlmz4HX7BqHBw1TSpDWuopt/sKarjM1kF
         rrCRifJI9Jd4XUemwN6KvHZ63evdivIEU5hnfeMAZjkmn4euqPBTldYEgRI/iipkG93+
         OXru28yYUvdUMfA5jOyV8HYKOz1Dq5lZonU4dzQKRJ8cBwBZAkZOWOKKRfkZ/EAtYk6O
         GdPsJOtUC2QtJwAh7+uf9Opfox4LyaWc+rXvebP0PAZhdA2eP1a0czsIqe1nLnYBY3GJ
         cNSYaqmUFEmbuK5GEi2S6cNNNKgB+bTUEUbVNBYQ9TqtfbpZeEu1gjxW3TlQ4c+7NKH0
         yL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803870; x=1714408670;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/RJrrrs8RwvpYrHG7SbHwPY/r0CKqLeGFzxu6oxqWA=;
        b=WXSTutFlo3ogH7wICMzhB0SbqsXSx7R9M9y0AC6GUiXADr51QlJCSUdqFl8S07K3T3
         BvBJyJyxLtOZ+/q88xmC28Eqr4CoJDOHFxkU9poEeEQPMijhHo1X936V7zR16pve8h3P
         YpWu4HEHWpP7hVHPYoGm1sVvcL+mXoE/Hy4PLCMG3cRZaAImI1l25VNUm1j8IYIxINsQ
         5ymxSQdu+tiu7nIod7uePMAjW2NG6hAEnjx9c2l1fWNnPG3vRz6DVswx2ouk29jNkLwO
         ue54UZdha35ORAJXYtBejn3YjavkUOwiCZxpZJFocdEjfZhA0KKZMCMvfE6xFai7WsWx
         HW4A==
X-Forwarded-Encrypted: i=1; AJvYcCVN3bamV3kcdj6HmfnC2zUvQUO8cwJJcpVcg8Q3qCQIwMWkrqAEcc8Qx31QucDxedouOFvP/y9of1A5Kb+h7wVoJEt/Eue9m2WQmBcz
X-Gm-Message-State: AOJu0YynhLWtrQnzrL2PZJzu9XxrjZF21NNUh67N5otSfWCbMIM//xX7
	rVBJd5QNIeASgVXLFh7Erplk+mg9u7zgxpZKacyjRSiOcy64Sn3ensTgIWBfFek=
X-Google-Smtp-Source: AGHT+IEq1dPmWSDiW/s+JYEDdjB58eHF/R/VUvio1ax8A9B8QWPR1f0qHTZyqiH56s6nclUVAWVSJg==
X-Received: by 2002:a05:600c:4689:b0:418:f308:7fa2 with SMTP id p9-20020a05600c468900b00418f3087fa2mr9531927wmo.14.1713803869838;
        Mon, 22 Apr 2024 09:37:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:49 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v2 0/7] kdb: Refactor and fix bugs in kdb_read()
Date: Mon, 22 Apr 2024 17:35:53 +0100
Message-Id: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmRJmYC/22N0QrCMAxFf2Xk2Upbtik++R8ypG26LiittFKU0
 X83DnzzJXBuck9WKD6TL3DqVsi+UqEUGfSuA7eYGLwgZAYtdS97NYhbQHvN3iCP2bhnykJ7o3F
 2akBrgYsP3tBrk14m5oUKn723H1V9059u/KerSkhh1dFplEoeRjzfKZqc9ikHmFprHxZbklS1A
 AAA
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=H6lY9kh62C4YQstjcqSOklbN1ZNSivp/MHHRCWngx/g=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpHtkKsfkSXNmY9hGFqe83qhrZ53UoPZO663u
 6hQPnNvMfWJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaR7QAKCRB84yVdOfeI
 oeekEACbufg6Gh/VvIIcYb0alGNjOAr7Mt/Xh2T+vBP1rKQ59CIlF6jekwGOWqZrLQWxvngMN7r
 +1H7M9HRBfuW8EHdOtLkncBL+Zc9sO9XlAVbp0tEZA93WzyFrqZuFUqZVGcVP+RKn76blnYgCLE
 gkJpCWKRBW+N8amQNP6rmLhZjjVpTuv/0QpPKbkNXbxhUZBrFnrsH+8FkSpx8xwmt6MyTqjKZVJ
 KUynxaIMBXMyjMv81FgnTojX2NAB8NynwrsxCnhfc/LX5KzKIjCDijYP2wfWpT37VBE4rpiI0rZ
 qrDgjhRPg0DeHPiKdtjIEOgbD+n5HlWU/iKzNFWpytkKyfFES/3O2Vx2RkkwgXQlUOcBlUJ3HkC
 gUF217AgffkBRamyjOqPYZszjG4BUibaJTbNmeNK3Oz8p4sSI8y3bW+mgg/t0d/bvSt94f3VUQ/
 R/7k40vyL2vrEMSks/kE9e3jUSMWtKe/yWKUueWEi9ILZkSYTrPZhO5H5PdMG0EsJ/Fp914tDgf
 oGRPWvoUXinJrvLaMgbFYVoGoig80vjilbwmvbYlq/qypUMCUFOnreglL3HSexrsHxykbrEDM82
 3JzFHDOlReG7Tcn/GMLAzhQ+o19Akf1JEgaGExm6F6Ce5lH8TLcBpmcbTaQSXpdH25RMZ6FLB52
 3Kf8+wJ5FwwDsaw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Inspired by a patch from [Justin][1] I took a closer look at kdb_read().

Despite Justin's patch being a (correct) one-line manipulation it was a
tough patch to review because the surrounding code was hard to read and
it looked like there were unfixed problems.

This series isn't enough to make kdb_read() beautiful but it does make
it shorter, easier to reason about and fixes two buffer overflows and a
screen redraw problem!

[1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- No code changes!
- I belatedly realized that one of the cleanups actually fixed a buffer
  overflow so there are changes to Cc: (to add stable@...) and to one
  of the patch descriptions.
- Link to v1: https://lore.kernel.org/r/20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org

---
Daniel Thompson (7):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()
      kdb: Replace double memcpy() with memmove() in kdb_read()
      kdb: Simplify management of tmpbuffer in kdb_read()

 kernel/debug/kdb/kdb_io.c | 133 ++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 75 deletions(-)
---
base-commit: dccce9b8780618986962ba37c373668bcf426866
change-id: 20240415-kgdb_read_refactor-2ea2dfc15dbb

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


