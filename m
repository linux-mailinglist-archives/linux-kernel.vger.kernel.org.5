Return-Path: <linux-kernel+bounces-130807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA11897D50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A17F1F26224
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89227492;
	Thu,  4 Apr 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNV+GggG"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3024C9F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193014; cv=none; b=KPA8pb/HwouWQNXxJsU+nsJHegraA9DxDqflsX1pJZ0aSylm3Ds8WCvNu587WtDKsU4f0b5mSg5tVZzh8isiygCqzLTmHHY9Rs1sZKHiaTJNzzOnuDgSGbKjVTUmCnGmRvNdFW3xisHg5molRF6P9a6kE2kLFR5pQ6I6UfdafWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193014; c=relaxed/simple;
	bh=kC+TSppxAO7zUiJZpluSvGxhmErQAeqtY77z7J8nBmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ersbB3g9kpbzCG3qN7msWzDbktaS7/9kTqWppVQv9TNHLF90P7GxPOTBL7uaDgvl1OGp+NCX9Mxa/+PUTRnNVkxtcIqEyH666X/omQmP2xUqepCmtgEIuJQ627Ra6OPx3knGHRzZSxOXc1w+v+BOD0vGGsbaoAt4DNr79T/1Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNV+GggG; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso9618939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712193011; x=1712797811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0WgnYpbpUKZo8YR8XcwNLrT1//n68QLqGA5DCAOQeg=;
        b=cNV+GggGtUynK0+YkmH/OlBPqkQXb6oKs0MLX1b7Dn+K/gSI6P0LVn+/8eiDZSoWDu
         GHug5VrK5wc11iYWucLjGnrdzczr8gbBRNmRr+qjnIpMsvwhbV9alqwRUAk12yirPwfd
         +NyE+b6VP+P4bC/YefIATBjQIV28TJSedbJZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712193011; x=1712797811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0WgnYpbpUKZo8YR8XcwNLrT1//n68QLqGA5DCAOQeg=;
        b=XoQDdGCrzwoxLio/9gHiXVYhLglcZb0al2CVCiXK+8HSkZRki4Xfsr0HeBH57DNZQv
         M0WrsCYKQTYdAxmQOMlpBeT4mnwn6/K5nE0sIEDOaAV0rkx3UhONkYpgTPuNzDq3uFAz
         /dsr3hrw9pqlk3HZIJ7dNl8QTjkahHqvhahROKry9N8OaMRVtXvIEA24ISQZyLi+bg0J
         xZyhDlFYlyPOo8yEQHrwwqg5ccYbJuy9IJD/ayd629VZOH12JBH3h+obQ3LdIjgxfAiE
         LjT5N6oT47JNlXnJ6ouTg8mVxKT7krsash2ecVGSOH6g3LmwLNX3zbxO+E2PHJHtpH9l
         HMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkV1tH7any5/x2eMJr5haMarp1/5ghQ4krUKwPyfl7mkhVjThg23F8mDDHk0NYpJopY2FvdcU7KcPsz7jalBfH0v/zwd7izN+B6lvf
X-Gm-Message-State: AOJu0Yzi3gIyxbeiT/y5uqyJ3IhKLOQntu6pW4/gkRrEkA5UMcUHtrbD
	248ZNLCC/8pB1FxzYbAhSItwpuQVmF5YitiK2I2nucnRuluMCEr3OIZ0o1X+Gxg=
X-Google-Smtp-Source: AGHT+IGzizUjyNsbrnkvaQ7qsQvHTiJIY9NENu4M2M4viBs1Ni39iIZIhvmOUKjjtTlqii+B3auNoQ==
X-Received: by 2002:a92:d0d2:0:b0:369:bf80:e367 with SMTP id y18-20020a92d0d2000000b00369bf80e367mr1379949ila.3.1712193011377;
        Wed, 03 Apr 2024 18:10:11 -0700 (PDT)
Received: from shuah-tx13.internal ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b11-20020a056e02048b00b00369ed8bb1ffsm797178ils.7.2024.04.03.18.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 18:10:11 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: rostedt@goodmis.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tools/latency-collector: fix -Wformat-security compile warns
Date: Wed,  3 Apr 2024 19:10:09 -0600
Message-Id: <20240404011009.32945-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following -Wformat-security compile warnings adding missing
format arguments:

latency-collector.c: In function ‘show_available’:
latency-collector.c:938:17: warning: format not a string literal and
no format arguments [-Wformat-security]
  938 |                 warnx(no_tracer_msg);
      |                 ^~~~~

latency-collector.c:943:17: warning: format not a string literal and
no format arguments [-Wformat-security]
  943 |                 warnx(no_latency_tr_msg);
      |                 ^~~~~

latency-collector.c: In function ‘find_default_tracer’:
latency-collector.c:986:25: warning: format not a string literal and
no format arguments [-Wformat-security]
  986 |                         errx(EXIT_FAILURE, no_tracer_msg);
      |
                         ^~~~
latency-collector.c: In function ‘scan_arguments’:
latency-collector.c:1881:33: warning: format not a string literal and
no format arguments [-Wformat-security]
 1881 |                                 errx(EXIT_FAILURE, no_tracer_msg);
      |                                 ^~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/tracing/latency/latency-collector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 0fd9c747d396..cf263fe9deaf 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -935,12 +935,12 @@ static void show_available(void)
 	}
 
 	if (!tracers) {
-		warnx(no_tracer_msg);
+		warnx("%s", no_tracer_msg);
 		return;
 	}
 
 	if (!found) {
-		warnx(no_latency_tr_msg);
+		warnx("%s", no_latency_tr_msg);
 		tracefs_list_free(tracers);
 		return;
 	}
@@ -983,7 +983,7 @@ static const char *find_default_tracer(void)
 	for (i = 0; relevant_tracers[i]; i++) {
 		valid = tracer_valid(relevant_tracers[i], &notracer);
 		if (notracer)
-			errx(EXIT_FAILURE, no_tracer_msg);
+			errx(EXIT_FAILURE, "%s", no_tracer_msg);
 		if (valid)
 			return relevant_tracers[i];
 	}
@@ -1878,7 +1878,7 @@ static void scan_arguments(int argc, char *argv[])
 			}
 			valid = tracer_valid(current_tracer, &notracer);
 			if (notracer)
-				errx(EXIT_FAILURE, no_tracer_msg);
+				errx(EXIT_FAILURE, "%s", no_tracer_msg);
 			if (!valid)
 				errx(EXIT_FAILURE,
 "The tracer %s is not supported by your kernel!\n", current_tracer);
-- 
2.40.1


