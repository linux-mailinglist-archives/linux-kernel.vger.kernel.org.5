Return-Path: <linux-kernel+bounces-34562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204583809E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74F71F2CDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86B131723;
	Tue, 23 Jan 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBLWUALz"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B9130E39
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971821; cv=none; b=rX2oFTa4BYPqbWaWI7vvE0Qf5DCbZUhh4DkhqYmu4ZVMkQchSinbtneUkxdySvILiGVNLljTht3BABQ+fynjrt42KdhhoCx4qI8m3OL5QO1j/RMayd5xlQzvkyQ7O5jIEyNRia8A8Xyp1BSSriAqlIagdMFPXaKLVJlRqG44ork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971821; c=relaxed/simple;
	bh=EmH/DZbTBXxe0dWdplwnDgyJ2eUGGILv5amEUByys6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQkF+BhDaibjsF+o/eHmuHj9ZqOEKBc7MixH9JH5JqJDeFmoRr6c8orJVCbBOsOBeu7UFhrZTz0vAsKXc0k6bF/2W7Grtlu8oVtmutOOgapZcVLTanUwxTKdkSLpZXZ99//e9Q9bNYUQYDcPlgGcwvGTWnUPdL1uMrXCLDWSoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DBLWUALz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dbd146c76cso1200075b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971820; x=1706576620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLd7hWEOoj/WL0ILJU9a6Kds4Kj9qjcWAXBu30bMrQE=;
        b=DBLWUALzzzduLFTN9Qj5HhHrhKB6NqKSzJmGUF8k6LU7y2W/VG57qYtKJNAhnNoTUo
         SLQ3IWKJeXUsfKHdev3s3J+xKxj+RZ/1yny9A6rApVQBUpc6FlCrzeG1FiaHNu5WX+qj
         6XfdllcTbkPJbuSo+7EBC38YQu8iTtbCBkHo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971820; x=1706576620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLd7hWEOoj/WL0ILJU9a6Kds4Kj9qjcWAXBu30bMrQE=;
        b=QZsv/yWAWMwIfr2GC1jNfLUtXoMpSr/wkVbNOu+EF2Gdaq20IfKbeA//yqfRGBZCaX
         uPmvHMBsqFrxv2z32fWKvouy+pZ2+ntEyGOY8CvLI4ke+URfBQNVociotrIyydOoOTC6
         Mq4zfKECbIA7EkaJgz3kkXO13JNuNaF3h5ZyqlNgUFdPg1/uVuUnrlJjl2HIlX6jq1E+
         8KhJ7IjutIUCK/quu+mwHtLEbJsIttGF6l/4SVtuX2IJkwqVLGHN0t53SnteHea89Wth
         7WJl/RTcefoym3edd29/6WUFYMJj2q2JToNwQ5Ct2/Zwvd0DQ1MBxT7nvaCPhFNEMnR8
         J6iw==
X-Gm-Message-State: AOJu0Yz1Vcq+YZu01erN5bblJl3VEL9zxzxrFu/sNH+jx5cgObvBysM8
	8Az3SSoaGlIVFyMYsY8hk3DdlWN67FkcXfrhHa6cJLkEnvZTpH1VShoOK1gfGA==
X-Google-Smtp-Source: AGHT+IH4bCaTuK5q2oXQL/3LvOghBBeDr8MYYSdkNUAJgJVfYreLotGyY63qGusCbK0boNe459IYkg==
X-Received: by 2002:a05:6a00:21c9:b0:6db:9e9f:6a55 with SMTP id t9-20020a056a0021c900b006db9e9f6a55mr3113822pfj.25.1705971819741;
        Mon, 22 Jan 2024 17:03:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a62d106000000b006d9b0336a27sm10655197pfg.125.2024.01.22.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/82] ACPI: custom_method: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:10 -0800
Message-Id: <20240123002814.1396804-35-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=keescook@chromium.org;
 h=from:subject; bh=EmH/DZbTBXxe0dWdplwnDgyJ2eUGGILv5amEUByys6s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHHHr/VKg/KAlcqjdcF5SYPKo1cfb9YxYbN
 Ub5YAXr20iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 Jm9OD/42OVFSF2SZuj2/Xm3blXVzWso1EIjDFteNwkRAzj/OhbsOveDY28YTwAprTxSc4mfzKh2
 r7wc8fydFpA5Y8yVoR5Jq17o3YOw7xu8gZiX8GUHzRZRLiI88Bn0jOqyO96m5KRz/Oku4J9OJ1n
 lmgM7ubTGbc02BXB8oXJyNpBdVzqIOlNwD/ECpnxos42xDCcYITE6BC+/JUaUTVtU3usc2e03+B
 TwiHzcwD6iRnWxRxmVXnPXQPaaRaHWhyeGbhoWy30SFcvTY0EFAKqcwzZ/HggSCogQiktvuo4jw
 yKlwoj8AIcEquL/jcpRDgr1y8ZIO9gbut1BiyYhWI4QNFcP+uDl6R36CWESOrfqtgF2FhHrxI8w
 +YNsJz1cVkXUm4++MjtKT1gQym/CI6Yo6CEatJSvLwV7UE+LvUU9Q03t27lqUKhe9zCK5IRhOKm
 n5j9sTlJJJdJJTul3h3jXlEbP6Incxf0zT/TPVJuwAVlmJPtH1PyZ+c0TIzPgU4F+n6SL8Pho79
 r8x2Q0FTlvu5RWYgG4P4HsGROu/rEfLajxdjnTbMLliKam77rFXZcJohT4UHLycRLcvT+2wuTrL
 1Iesm634rNZPYYLnMax9FyEZwv0Q2Y1lQEFiSybEDKXGM4pheL3Dba5LCqYt2434cbDGUg0vfpk 77kzj9tRg0KuJ7Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/acpi/custom_method.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index d39a9b474727..0789317f4a1a 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -54,7 +54,7 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 
 	if ((*ppos > max_size) ||
 	    (*ppos + count > max_size) ||
-	    (*ppos + count < count) ||
+	    (add_would_overflow(count, *ppos)) ||
 	    (count > uncopied_bytes)) {
 		kfree(buf);
 		buf = NULL;
-- 
2.34.1


