Return-Path: <linux-kernel+bounces-164701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7D98B814F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C95B24FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9DC19DF41;
	Tue, 30 Apr 2024 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yO7spW2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB23199E9A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508156; cv=none; b=e7tabut4reD1RyJjD0Ht9fCfHhOwr2/rtuug/x/h/KD67xBJ4jlPXROndwtCjBGMsCYMQxmm4KPx0jw0gy5c6eP5r99l+RdGFJNGCq+lIHdDpjQQycaFzOGgB0kJPZpcFN7Yerl5OWWw1+Ja36XoTDOPVrdBLXs6RkWvn0PvvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508156; c=relaxed/simple;
	bh=OwbGPKZtQBf7I9utiwQOUr+V8JX1YYG1+WgFJUHa/cY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cCfQdU3j/372sIvcsyVhr/6deVjnoPbzs8AS4jgaEqlsB0JO8u+Y2TIqkBwCQ6dzO7nk0XCoMzJnxtZYtNTqfBT3MEG1o3iVanZhRYGNRe8ASNdo6xN0GTtksJ1c334WUi8iHEDdZ63ClSem0qKm63y8N3wqPdIT6Rx6Un5jDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yO7spW2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be3f082b0so32393137b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714508154; x=1715112954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+AlJqrV9OSoAlHxX48NUGvUshr8O8Ok/JwpO6+5NnYU=;
        b=0yO7spW2m3KEb7ZURz3BI1n4IJlneRYZfP+6PS1tTO9O1fV4+3S3yUhZBXU0wu0DaG
         Sa8q7kYfyjleWOiTHh7zv+sTeHmlkoaR7n3ti6hbUlv15FXaWbY7uJxzLktGoNRwhQdm
         ayj2QceCzQJwnfVN5coRNTV4RfPwiDePOqya5kLUdlcPtBT1UgtvL/K0B2vGOdYO6Fox
         LgO24sb4WYmOvLAZ6CxLGr2CDlrhrDnm7D3rFpEMG9ltosszsYRBlF9F37zgJg99b5H6
         1O6If4vGeAqdfiWggDPNRyG19XA/vFLrRXhsnr8FZJBPPYvuzWIL2ucjuo1RJj0imtTa
         6uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714508154; x=1715112954;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AlJqrV9OSoAlHxX48NUGvUshr8O8Ok/JwpO6+5NnYU=;
        b=OBeknasBPHc9LqmzGaHzQKKrLCBZOlCbS2r6Ico40RRAStXGzr9rjbzKj0qQPudioM
         YpN4LnUCH9itdwH/rjt9bMCstVrwLTU6vhfMXGpWTuHGwh43EF1V2epAYBCnn3OEHxml
         udegNoPNWVE5C2oTzh/bWvmqcq8j57to5oos7y65m4RiXSnna8tLZyGfWJLxrvFbolzK
         RjIbHRKRLlTCpokweWX2iSSVjkA2otRMYTFQg2vw+f++E3KilRQxqzUSzXMwW9BGx1Tu
         jtbzEaS3m4vwb13VXUvzOn9gcM9yMydGOuws4L1b3mBemoqWXvvcO9Fk6nBzZ/8TkqqZ
         4g2g==
X-Forwarded-Encrypted: i=1; AJvYcCVGqunn2xXBsI4qa7Q8Gy2xsUtJr5JDYiY1g+bwDJRjkaIzd+3NSWED6fm3b8rX6eo73j+2mEOQp5tTtPGuFjfgX6pEf4nNQ/0iPEdr
X-Gm-Message-State: AOJu0Yypn33Vuwg8ex7Y5DSYqQMlT+kFWLcA1k2lc/XcKrL5OdtGRymq
	ZmdfUmsxiFkIRTX4RhskzSnFzO+JStB2J26AornJZpZjn7v8qtzDL+ORy7pk3qoibGntRhSWgaG
	reYGYxQ==
X-Google-Smtp-Source: AGHT+IGmWX6ZuaW9weTWZHpDcyiMGwO6Kewygb0NViAArEjqUb1wlNzYaDMnOjiBjjtwwWqcB3AkhfVJK76A
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:311c:f9a:fca0:fdec])
 (user=jwylder job=sendgmr) by 2002:a25:d34f:0:b0:de5:bc2f:72bb with SMTP id
 e76-20020a25d34f000000b00de5bc2f72bbmr75836ybf.12.1714508154202; Tue, 30 Apr
 2024 13:15:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:15:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240430201534.1842106-1-jwylder@google.com>
Subject: [PATCH] regmap-i2c: Subtract reg size from max_write
From: Jim Wylder <jwylder@google.com>
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jim Wylder <jwylder@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, when an adapter defines a max_write_len quirk,
the data will be chunked into data sizes equal to the
max_write_len quirk value.  But the payload will be increased by
the size of the register address before transmission.  The
resulting value always ends up larger than the limit set
by the quirk.

Avoid this error by setting regmap's max_write to the quirk's
max_write_len minus the number of bytes for the register.  This
allows the chunking to work correctly for this limited case
without impacting other use-cases.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
 drivers/base/regmap/regmap-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 3ec611dc0c09..3b1e78e845bf 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -350,7 +350,7 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 
 		if (quirks->max_write_len &&
 		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
-			max_write = quirks->max_write_len;
+			max_write = quirks->max_write_len - config->reg_bits / BITS_PER_BYTE;
 
 		if (max_read || max_write) {
 			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
-- 
2.45.0.rc0.197.gbae5840b3b-goog


