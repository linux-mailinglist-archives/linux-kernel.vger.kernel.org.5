Return-Path: <linux-kernel+bounces-63647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC328532C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B4281DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6F57896;
	Tue, 13 Feb 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPsIJudx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66F5788A;
	Tue, 13 Feb 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833558; cv=none; b=oZfnYDMglNt04d+iKpVDFDHvUhpRrxobFR6JMDVjZbUeqULtPsgEBVUTYYD62Ah3JYBNCLQFY0GcvwLspqZkmrchi6a9GADQWmR06ZMRz0oVnYDfvsF+mwj+OPPmkPqYPkcn9o4Ah8p3yFjCszGDYpbU21fYL+BZ4TtyCOwGSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833558; c=relaxed/simple;
	bh=M60rv+CFL/yd6aFL1rLXU9HDgeU7hqolVlwtimAxAro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aI51IBoN0M4xQhff2iAI6gBxz4FB3wHzKXXH483k/bDEWOaRoIpRlk95Ph9l5t4J8iNDRvgLasEWmLqr4SaeJJixA38Iktja2itQ0DeEVkV75HBSAMi49R6WiHmJSueWc6LtfGZGD1074X4/uCGt2lcFwdiVTlR53fW+jtubr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPsIJudx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7881b1843so39684245ad.3;
        Tue, 13 Feb 2024 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833555; x=1708438355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClcF49SW9TVyg+8qgV4EbQKNakwAki5xkRZzYfgJ398=;
        b=mPsIJudxJdLUGzOAZ/x2iRqjeXRYpCVQA5Acz6YxAq8bdrHP1LxmR8tomsel70zXS9
         VnOwLZWQlO9GUicNsBFrVd69w6RVINV9iwlLeqfwECIboHEomM7Pl53hzB/I+13IK1T/
         0eTdWe6joP5BzV0e3QkyLCLubPKgV6Qm8lL1XkcR3CwMVmzABJC8MQdXlPev+5THTZqv
         uKlGfiSOJSX/JJ8qdz5MogFoFHAK0HLeM22L/ZNZHrulEsyMk8Pyd7sUWC/HOuZLAO3+
         djZW+761GUkrE+4wbq2J/jkRU+68B9yIPEMsiGHg8y7wpUWeSPOdo5YPYHtw65KfO2dG
         fM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833555; x=1708438355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClcF49SW9TVyg+8qgV4EbQKNakwAki5xkRZzYfgJ398=;
        b=l86TupZk3jxXRlFTNY2F8FqXeL2RLqvUUnGj+mqCW67nNmTD5zkm90PateRgNy5A8W
         OcG9lRbCJQdn9YfVE8s0FXRABSacC/5GzYFnpOyxHTQ+//0bjTf1sVTI9lYDFFFcD9Ou
         DupJS/0B+FWJNbJylQ8AVD7EjndljM4hKzCd7DoazwjO9xxtU8abNsxUKtJR5+BwiWfy
         C606Np8+86IAkRAJiBdiUUQH9C+E2JYjdk8eg2ZNPGOlCYI/SzVVP8MIHlbzt5UIgBwR
         ST4btQJD1cB0DVfdd0BcQqaUqYSz8NZLb+LTYgywrxG2TVoWTl0L91iz+xlqXtwyHRNK
         0rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWoJimo05nfWQvtdi1fEItrGByBaY66iODRwKsUni8iGwnQ3ZQS5pEbh2MtZqsMjn19QFoJHJEWFZjuJRPv3Y7yQ/izxgFSJAbnr/7psisjq8VQH+1IhMxb/DJPT4JaxqFXQFLrlg==
X-Gm-Message-State: AOJu0YxK61E/ZRB4r6H/TRboc41Unpi/gSnG+xk8ivzcqwn/pmLsmTMb
	7SJMbkIPM7OOa11Dqz2pkQeVEXepLQQBBOG0QytLujUBPQrPbYeXaQgLXRLV
X-Google-Smtp-Source: AGHT+IFtXwt7v2/zfPpSeohh2Tq3mh2ZhcSZZHS+OaRwI+Y+j7TDWyiP9/yorScurNMnVufD/71ZMA==
X-Received: by 2002:a17:903:595:b0:1db:499c:9b9e with SMTP id jv21-20020a170903059500b001db499c9b9emr410904plb.9.1707833555377;
        Tue, 13 Feb 2024 06:12:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe0AsYir0yCs/ajc1GJvax+XrOTKOsqxoO9LwwnmkIvzXAeYLWZat40/AsaJlvqyOnZD/s0Of4HrjDu6FF3d7pPW77Cr4NFypnqDEcm3/9rOo+m4ft7ojFttbjYTTUI1qwFa2hGvaGeM0AC3fN9o/qHdWtdRfnnZwZVeQLz+rvXN6CWcQVozFzy3Nelc4ukGkIo+YuopSZYLEfRTMLtn7rvKYk/566fb94+OHoP/j9
Received: from rigel.home.arpa ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id ld11-20020a170902facb00b001d9a42f6183sm2151102plb.45.2024.02.13.06.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:12:35 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] Documentation: gpio: consistent use of logical line value terminology
Date: Tue, 13 Feb 2024 22:12:22 +0800
Message-Id: <20240213141222.382457-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistently use active/inactive to describe logical line values, rather
than high/low, which is used for physical values, or asserted/de-asserted
which is awkward.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 3e588b9d678c..ab56ab0dd7a6 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -222,9 +222,9 @@ Use the following calls to access GPIOs from an atomic context::
 	int gpiod_get_value(const struct gpio_desc *desc);
 	void gpiod_set_value(struct gpio_desc *desc, int value);
 
-The values are boolean, zero for low, nonzero for high. When reading the value
-of an output pin, the value returned should be what's seen on the pin. That
-won't always match the specified output value, because of issues including
+The values are boolean, zero for inactive, nonzero for active. When reading the
+value of an output pin, the value returned should be what's seen on the pin.
+That won't always match the specified output value, because of issues including
 open-drain signaling and output latencies.
 
 The get/set calls do not return errors because "invalid GPIO" should have been
@@ -277,11 +277,11 @@ switch their output to a high impedance value. The consumer should not need to
 care. (For details read about open drain in driver.rst.)
 
 With this, all the gpiod_set_(array)_value_xxx() functions interpret the
-parameter "value" as "asserted" ("1") or "de-asserted" ("0"). The physical line
+parameter "value" as "active" ("1") or "inactive" ("0"). The physical line
 level will be driven accordingly.
 
 As an example, if the active low property for a dedicated GPIO is set, and the
-gpiod_set_(array)_value_xxx() passes "asserted" ("1"), the physical line level
+gpiod_set_(array)_value_xxx() passes "active" ("1"), the physical line level
 will be driven low.
 
 To summarize::
-- 
2.39.2


