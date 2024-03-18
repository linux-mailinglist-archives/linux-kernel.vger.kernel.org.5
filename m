Return-Path: <linux-kernel+bounces-106755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B048087F325
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BB9B21CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6C5A792;
	Mon, 18 Mar 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVag+b1G"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AE5A4E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801373; cv=none; b=Q4Ik+1drX0drSt2IsXkMo2hzTEixIv7tXCAgjDL4P8uF6C7a8lrFzUKuj8JR/GIY977/BByAbbdPztWVhyEl4WGl6KtY/FhTFSe6yMfLpLjmhQreyzMECSZ5XAyWJL7JTikaxr/vMIoz8jYsMWDp7ZeoShBsOU/QTuYlsEB+/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801373; c=relaxed/simple;
	bh=idLQG0Kr6yCd5IwGaKvpKO3VhPnelbfggT+hRhuZhCo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJinLfyZM3ezvPAb8dqPlvrHnf8iDCh4ZiI767OM3Y6ZN6onvbXTn6q/zJ4GnzQ41IohgNjz+EJqjUejMVgbbDbHLLiMhkjuCGcR+SH03o8x5Nj29I6NnkhtGPAwj3vFf59Sazkabcxqzd6C2MLZw6s4s6YJFWJn+2IzG0thEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVag+b1G; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-366999e233aso23318865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710801371; x=1711406171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QFNImd0Mua9KCTvHqQYaKAK0qurjGIisgRUAJ+l3grg=;
        b=eVag+b1GKJedkBBNZlW2rtvYKXx0NRe6cJhBMa4jzvNFb1SREmsHKCh+jcMPbeUtR7
         0YGlY+dp4NaFUaV8KSFYznAqYZVRhgaIqw2TGqlGQUW8DHWAozSIxApdcQXuUNQymxvp
         hWgx6DQBVkrVl10KtK59PCu38Gqvoh19nCuNJuY4dTcFLhBvgCFVJXj4nFJp0TgEWbAD
         L26tR9aWqW3zXvYRgnYq6/k/Gu8x15BdUqnGbQVBIctHXey2Oli26+uc27bpHsZjzdSU
         MvUc7QUNU4cRqJ0f0+Qs/kwAcEDZS93A47JQVu88dS5CYzRoKEWDTCXVtBsN7y0FNVtW
         3qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710801371; x=1711406171;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFNImd0Mua9KCTvHqQYaKAK0qurjGIisgRUAJ+l3grg=;
        b=UNDyW9B/T+N6iN7fNGPZZ59M+E7Vd+stnFWIMhMyh2pNXl6/s9RvKp3GHxE3+4OkCX
         GzYVlCFJtywQ0lmqJuinCFhXCyuGmtNKzy0CBCRpcSd1XRaAXtuDME+Q9h8JK5RawQ/t
         jqIZExUi8JA5CZk59rqX9UF2RH44V2I8YaSrrF9V0jcNJ7NLCBc8Lh9YyCBmiF0lFcx3
         MGAlJdRuiYO+OP0grdGN9PMjv8EgcQgObpWgPUXbW7sfZOctCmW4h2D4/ABR4FoRIsKz
         P9Tq65LuODFzirxs9ugFQe4TtYsAMDk8RgB1iPH10+3I5fUODTPm0hSfRxXyfJRqY4sC
         OZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjp6N+9cao8Emu2z9Dd4Anh2frv+ihxHSD/P0jJOLS6z2LlwJ0f5P5ZSkrSD1HrDKKoVFbYvTHgbEvfUn506Jn+Jpq9FhHgFmOxseB
X-Gm-Message-State: AOJu0YwgIgPCgwIGSONhfYQOAuv18IwTtZMzDAIAB+Ghr1tI2D480jEd
	rybZzGxb16WquD1F3VWA4/ecZnQ3iUOLrkHhBRfK6iI/inOSOfAxh9HSaoib6OG2QNrBNNn1kN6
	QH3tA+cIz3UmCsdZ2/93/Mw==
X-Google-Smtp-Source: AGHT+IETbi8KX4eWggvtR8wvzN+qPch/c/mKDS3lve+lL8DnNm4inZBonEvIJPIsNh8alSISBfzToKCHwe7G/+Esfg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a92:d68e:0:b0:366:a780:5cb2 with SMTP
 id p14-20020a92d68e000000b00366a7805cb2mr8306iln.2.1710801371403; Mon, 18 Mar
 2024 15:36:11 -0700 (PDT)
Date: Mon, 18 Mar 2024 22:36:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANnB+GUC/zWO2wqDMBBEf0X2uQu5gaW/UoqEda0LbRo2QRTx3
 xsEXwbOcGBmh8IqXODR7aC8SJFfamBvHdAc05tRxsbgjAvG2zuWqonyhqPKwlqwzqzf+EFJlc/ 0wazD1UbKcsGgTSC0vekNWQ5u8tBmsvIk63nh+TqOP7za5QuSAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710801370; l=2621;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=idLQG0Kr6yCd5IwGaKvpKO3VhPnelbfggT+hRhuZhCo=; b=+HXAnO3jukdE7ZFNa382FaAh2WDE9BnHodEf/wlzTo0fxNc6RJaEx+xFSV5aC0t4hXJSjrzfF
 7wkRpBum/gAB2Evhh4ej0JRMWcC31tyDBUFqUe/bafGVYiWfQDB5PQ1
X-Mailer: b4 0.12.3
Message-ID: <20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_thermal_rel-c-v1-1-08839fbf737a@google.com>
Subject: [PATCH] thermal: intel: int340x_thermal: replace deprecated strncpy
 with strscpy
From: Justin Stitt <justinstitt@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

psvt->limit.string can only be 8 bytes so let's use the appropriate size
macro ACPI_LIMIT_STR_MAX_LEN.

Neither psvt->limit.string or psvt_user[i].limit.string requires the
NUL-padding behavior that strncpy() provides as they have both been
filled with NUL-bytes prior to the string operation.
|	memset(&psvt->limit, 0, sizeof(u64));
and
| 	psvt_user = kzalloc(psvt_len, GFP_KERNEL);

Let's use `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index dc519a665c18..4b4a4d63e61f 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -309,7 +309,7 @@ static int acpi_parse_psvt(acpi_handle handle, int *psvt_count, struct psvt **ps
 
 		if (knob->type == ACPI_TYPE_STRING) {
 			memset(&psvt->limit, 0, sizeof(u64));
-			strncpy(psvt->limit.string, psvt_ptr->limit.str_ptr, knob->string.length);
+			strscpy(psvt->limit.string, psvt_ptr->limit.str_ptr, ACPI_LIMIT_STR_MAX_LEN);
 		} else {
 			psvt->limit.integer = psvt_ptr->limit.integer;
 		}
@@ -468,7 +468,7 @@ static int fill_psvt(char __user *ubuf)
 		psvt_user[i].unlimit_coeff = psvts[i].unlimit_coeff;
 		psvt_user[i].control_knob_type = psvts[i].control_knob_type;
 		if (psvt_user[i].control_knob_type == ACPI_TYPE_STRING)
-			strncpy(psvt_user[i].limit.string, psvts[i].limit.string,
+			strscpy(psvt_user[i].limit.string, psvts[i].limit.string,
 				ACPI_LIMIT_STR_MAX_LEN);
 		else
 			psvt_user[i].limit.integer = psvts[i].limit.integer;

---
base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
change-id: 20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_thermal_rel-c-17070c1e42f3

Best regards,
--
Justin Stitt <justinstitt@google.com>


