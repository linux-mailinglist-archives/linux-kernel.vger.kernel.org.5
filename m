Return-Path: <linux-kernel+bounces-103835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D445787C525
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739A11F22166
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E1A76C79;
	Thu, 14 Mar 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jh4WruTJ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AF76C6A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455383; cv=none; b=TBuxnWDIHY4fAASUhCbn8UzdZsHy5UejYDoiF337xYTc67XdWGoCTTvgc+JqQlRV31iwYZ5H/skr/agwYToqgmtV+3KrMmXq2cixQmuOnFjMIIcvL1rcybwWRG1WLHbYxHe66Q/j/ZeZ4wRCp1mk3xR+sHNuVzaetrQbJHy7F5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455383; c=relaxed/simple;
	bh=0y7oXfa2G7iiYQcQPwa5O+JgaheSC4GaExlqqlUSBEg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CM6P3wbA/SUo5x8x7GhNxjPSamuGnFfxSXEcoOvbZ4meU/TkuI/f4kyBMCuFcW37+Pa1l3S1QyO9GN/SIvs+wsohvLwwMLPLlpNv8MXI/nbbGycYxCNKQinyySIebM89eTKMbVrwm2iCsY4HPVUywa4G35zOzC17cgUsBaoJH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jh4WruTJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc8d4e1a4so25462457b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710455380; x=1711060180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bw7VM9ED7eVgs2yIUEIDaex+hm93Iedl3Ou3zhuMvJ0=;
        b=jh4WruTJe/uxBEeLsVinELNd+Ty7vyVKRcPDN4JNhwwVfz+ylcOvDKWAvK0owwcTFE
         lyuTuHx6m/qx6kj22mgQPOLyI6ZwGfzF8kWtmmH9ZfBB1CpWKcdFFFCfXlCbqYIh+ydC
         7aYCkg6nAzU5TmhTzEfH+fGtt+aX7XR8vlv3v9FyRuXJDtoi7k86wPwNkOmZwMTMwlqd
         Uj9fHYbxlH4BtTgTOwHK+1ilQlcSgBcG2pwDxXriuwRNweES2FqpC/tk+KxQ8ZjJdKMm
         w5M8fZaDpMchuBYiQ0x58W6oh/ushO4C2oPpMh6q/L2hpTZrUwSklQaH3bZ8Bpy4Kkdp
         vLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455380; x=1711060180;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bw7VM9ED7eVgs2yIUEIDaex+hm93Iedl3Ou3zhuMvJ0=;
        b=kG6lzEuIyFnvrFoYn+v7PeOSFlX567z39hyg3syBoWMUWUtyNubA79IoizFKQLaS+C
         /Voxj3mqjLXFLMJUcm0zZO96UKjQEK3djEELe/OTUcWUlJwyeFUrq8PqTI+sr1Zq5VZN
         6QOsSJAeYxRINTUTBpDF4wAF8PeN9WYg1bAMJ81/knzNXpACkBTj01cGMp6BitnpZwzK
         VmDMOynAzXmuGVt+AVs0DRMuDgEd/4sqt9WkA5UW8TNNBJW5fdBZP3Rf5MuJUQlk9E9C
         oYlaQb19NZTJpEI5DLGbBTFZOca/E1O3k+aPj4rq0i5nU16kb1VUeNq47sX3OJ6t/Tto
         QnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpapH/9i/MDTLYy0EkhKA9zlmDF8AIQPNci8aa+zSi2h3vI3ValNghRU1xqDSN+Oz734AZSNnYdXNPoZy8kkNGavy5h/YdItxgkAxI
X-Gm-Message-State: AOJu0YxLf8fJP9Tnv8eY+zNvgXap3lSFdm+F8H7j5KIyff95dw8KHLpg
	4tjYprzo3lLSJz4cizGdZER8pM6s9FyWSel8OeQ1LTIfOL3yk1WcWVjfxCBfVza+uhbsDfeFmWG
	ggLl5Mi1qS54WHAMm+04Sjg==
X-Google-Smtp-Source: AGHT+IFMyiMRVKv43irpw3uNDU30O1gPYqgcBLyY5YZq+gtOE4zxefR0vaZAt5AtUEE0rcq9mTQo1J4kYtP8mw3sAA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:72e:b0:dc6:e8a7:fdba with
 SMTP id l14-20020a056902072e00b00dc6e8a7fdbamr895492ybt.4.1710455380548; Thu,
 14 Mar 2024 15:29:40 -0700 (PDT)
Date: Thu, 14 Mar 2024 22:29:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFB682UC/x3NMQ6DMAxA0asgz7UESQbUq1QdEse0HkioXSEQ4
 u5EjG/5/wBjFTZ4dgcor2JSS8Pw6IC+sXwYJTeD613o/RDQ/lpo2TGrrKyGVgl/VGekOWNOSOj GMPmYYkxphNZZlCfZ7sfrfZ4XL31WkXMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710455379; l=2127;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=0y7oXfa2G7iiYQcQPwa5O+JgaheSC4GaExlqqlUSBEg=; b=ZQp+RyhuScBoaTsu2jjwQLQsgukHp/8xtup+g9tOpnSLLlPtyydTcv55z32T4I3acEXFRlQvs
 1+0UFseQiZ7Cp3BuEy9U8rQC0rlBKfIM4BQvhY1+A20BFSYYI6A1FYx
X-Mailer: b4 0.12.3
Message-ID: <20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com>
Subject: [PATCH] soc: qcom: cmd-db: replace deprecated strncpy with memcpy
From: Justin Stitt <justinstitt@google.com>
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

@query is already marked as __nonstring and doesn't need to be
NUL-terminated. Due to this, we don't need to use a string API here
(especially a deprecated one). Let's have our stack allocation also
zero-initialize so that we can just perform a standard memcpy. Since the
code now speaks for itself we can drop the comment. A memcpy on a
__nonstring buffer explains everything that this comment talks about.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/soc/qcom/cmd-db.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed..512556366a3e 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -141,18 +141,13 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	const struct rsc_hdr *rsc_hdr;
 	const struct entry_header *ent;
 	int ret, i, j;
-	u8 query[sizeof(ent->id)] __nonstring;
+	u8 query[sizeof(ent->id)] __nonstring = { 0 };
 
 	ret = cmd_db_ready();
 	if (ret)
 		return ret;
 
-	/*
-	 * Pad out query string to same length as in DB. NOTE: the output
-	 * query string is not necessarily '\0' terminated if it bumps up
-	 * against the max size. That's OK and expected.
-	 */
-	strncpy(query, id, sizeof(query));
+	memcpy(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];

---
base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
change-id: 20240314-strncpy-drivers-soc-qcom-cmd-db-c-284f3abaabb8

Best regards,
--
Justin Stitt <justinstitt@google.com>


