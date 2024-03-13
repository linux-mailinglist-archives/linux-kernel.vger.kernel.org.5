Return-Path: <linux-kernel+bounces-101315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D0E87A575
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554611C21416
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C638DF7;
	Wed, 13 Mar 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDf951Am"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFC383BA;
	Wed, 13 Mar 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324111; cv=none; b=g065c0JqeNGWbCk5QSUzFdJerjmMbl32Zlasp0jtXlgL/0sk2T36DlUNncvLpLUebveyN4qKWuIDM6z1JigjrdR/oPRmLHZHIRmi9CyPthPo/bYotKJOncxBlNyeIl+g6Q1/CoDiuN5OD1K6v8vTxxUWW1DAEPqeX7XPmp5hUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324111; c=relaxed/simple;
	bh=iz1x5RuOHvSAgTvYl/1JMHFx8PMJeDHVQ081QiJoKqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6hHwi6BXYuH/RCTbJOmp9sE76fhCcmmAL5n5CoWRdVX9uDP7fBwVeGAO5uCGScvUpZ6RU0FfJWI4pY3JHyfMSjszO4dDBJtH4tU5GC0rKFuJjCqiCc2FgRxgCZ5yiJ2OTxvvxAkOhtUDe53Xh21vNxzpCRL5d/ZwW2XzyGapVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDf951Am; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1dd10ae77d8so48247315ad.0;
        Wed, 13 Mar 2024 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710324109; x=1710928909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4v37dg+iJFB5VWIwGZR5ria28sA0OiKXNSMSERlE9Q=;
        b=mDf951AmNPJzpv/LrwyESTpSx8zP6WD6cRKkO8Z6XrG7zjPWPp+5RClsAaqP/viKNa
         26XFwiwhL8KswDrF9y0AWhRvf2D5pYs2uY7O0rmVuioSPEgvGSjUNnbjEm6EpWOmyKLY
         4DfLYBD7JNVSJ5d8t+PMf7PqYk8bQrdqb5ids6KIZeIDDAyu/W2QRWDeKo5ILFPv5GCq
         vbzxbN5wbJp2cOiV5J5ku/fRdRgIHr9UumNYuwkm55HY8zTFVaBiTaajkgeCEDxx1haX
         0qzpMJIUMy1o0if/jarCjRRc+gsOc0utjHKvpUbEX3KHI/GAT7XGJYxUny/gmoKwNTSm
         zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710324109; x=1710928909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4v37dg+iJFB5VWIwGZR5ria28sA0OiKXNSMSERlE9Q=;
        b=tTchvPpWfLsUwm3dDxXmHl8QMNxifdTqVlcMXZuKSxtclc9eTQjf//XuPiO+YWi3Q6
         iPLnp4KjCYzlHHWpkuoDA6nXdIl/Gn4OoBWig7Jvw/9cjgkpDqqHiXODzJMR7eoDLYOV
         EIeXhWkUxWqPqBfDzxPnV5v5v/cCAPP4DoihEFlHjsHOYnpdmxWBl2+TNRsu0KIsboLA
         8N4SZIL+8/KbdYSYqDdZ6xAkPc7KKeixhPPYDYB0VBE3qsL0pvkz0HepChqeRvA9Jy18
         Yb1xSekrii9vglKn0uvKIKNK6dNktQkxiikvUsJUfMt7pQnd8uOMUoJzZjwKyEAxAQfc
         3oyg==
X-Forwarded-Encrypted: i=1; AJvYcCW8V3gPfFbMCHvfRARAsnFp+zLYseByQ2Ne3w6X4hXeY58eieL3v/vre+PqWX5i3st1b8R4uRLvjmOa4cGOE7Yz7bCQpW3IPrTK
X-Gm-Message-State: AOJu0YyO4qEI67yjxGIV7DK+wdmWwfHMwzzeeJ5MN/1v1VjjDfvVRVox
	WJNCqNj2j5BXNLdpskoUXUN15B05pE5kSbObbnKHvLfUypqZ7+8nNqOoROR/v1CXfJQ/Hoo=
X-Google-Smtp-Source: AGHT+IHwqr4F/g7VHfy4bOVoK9rpNdApa6BVDq/i3v3C8DpaeVn0B1xeO0UOq3LggFnG8H3hcQ5jHQ==
X-Received: by 2002:a17:902:c412:b0:1dd:76f0:4455 with SMTP id k18-20020a170902c41200b001dd76f04455mr5052479plk.49.1710324109349;
        Wed, 13 Mar 2024 03:01:49 -0700 (PDT)
Received: from u.localdomain (ns1006999.ip-51-81-155.us. [51.81.155.96])
        by smtp.gmail.com with ESMTPSA id ld12-20020a170902facc00b001dcfaf4db22sm8287466plb.2.2024.03.13.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:01:49 -0700 (PDT)
From: Maki Hatano <maki.y.hatano@gmail.com>
X-Google-Original-From: Maki Hatano <Maki.Y.Hatano@gmail.com>
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maki Hatano <Maki.Y.Hatano@gmail.com>
Subject: [PATCH] README: Fix spelling
Date: Wed, 13 Mar 2024 18:01:07 +0800
Message-ID: <20240313100136.20424-1-Maki.Y.Hatano@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- ReStructured Text should be exactly reStructuredText
- "reStructuredText" is ONE word, not two! according to https://docutils.sourceforge.io/rst.html

Signed-off-by: Maki Hatano <Maki.Y.Hatano@gmail.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 026eff0b8e06..fd903645e6de 100644
--- a/README
+++ b/README
@@ -11,7 +11,7 @@ In order to build the documentation, use ``make htmldocs`` or
     https://www.kernel.org/doc/html/latest/
 
 There are various text files in the Documentation/ subdirectory,
-several of them using the ReStructured Text markup notation.
+several of them using the reStructuredText markup notation.
 
 Please read the Documentation/process/changes.rst file, as it contains the
 requirements for building and running the kernel, and information about
-- 
2.43.0


