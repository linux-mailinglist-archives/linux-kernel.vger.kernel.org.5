Return-Path: <linux-kernel+bounces-101278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7BD87A4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD841C20F17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E402224F1;
	Wed, 13 Mar 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvls81XZ"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E41CF9C;
	Wed, 13 Mar 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321959; cv=none; b=H81HT1jiXEiKQHgXyja3jP2NBG3faIhFLPXz6oY9C0xqSHBAgGR91dq7vAUS9on4I1UXbTrwxcirXYkefmoQRw9tZfE5beEG3gjNc0G8Zd1SLuJdxJxNhCBUuUpEFky/vaPIhbaNyrdKxLf8lsS6CUFTMLkjDcCi3XLdbPyoyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321959; c=relaxed/simple;
	bh=nuuNnhUztY1VeLgDqpK+BdG+dofugFD2ZFhDbkIUnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/cRqs6vi6h1ji9Kws3TRZH+a9NsPo83zpS4B39E/v4NDiT/xRD3dGHeYa477rp96lmvk1BpNUYiDYEbjZ84bq3YOjmwID3NwPVsLh1vjCZgfThrfqaqxr7BsCs/L7SLc5hbc89CLZ2pKstV8Y8mzJnjzKxWq6THUcxBT0IZdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvls81XZ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1dd9b6098aeso25353355ad.0;
        Wed, 13 Mar 2024 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710321957; x=1710926757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v281MgKZ/S2TbnF8JlBP01h7nZDSIBIQX9blsdOTeM8=;
        b=Mvls81XZEbafhrFfatphAu5uCOnAgduDo4S4JtjHxF4HOpFRZK+BkZGxCPleNIva1y
         lZljS5r0JKmXyYajFIeoE0G80R3t93SpcqH+I+1qlk2++eDcq/vPBlBpHVnFkUlvLZ5W
         uggypkN/IZl/1a5HAbtqK75JwljZXamQD7b0W8W29sP1WFeTfrEJZuJqsykBMzWxi4PC
         shWHXKP9BuOGLOlUlRbsJXGkZMd7m9D5cIWXIhZnagMRsrGkQEsYdRSoCwHHgAYyc585
         MV2xl2eg1CG/kAQXew3B9DYrLueXrScQZKkiENeNsLlYII11d0eJiy0ncKd0F263ECeE
         G9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321957; x=1710926757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v281MgKZ/S2TbnF8JlBP01h7nZDSIBIQX9blsdOTeM8=;
        b=bkp2u/8PnjaQD7bwynueIiWBuOps78qYEgqLm0qUxQ7k1p/m2E/ZtkDDBUAoFZ5/3l
         CXOyOPjScyq++e49UuqCqsKxd1FiUxDhDFshHaLho+h2/WhwB4uaO9Ux6vsMISiuvrOG
         7mrnMMrObi2+f91Py49N1MX2X25kRUEFItdZq6oD+NHyvr3qHiFLd1A2+BqTXcTSN0aR
         lfDCJISFo3lpPu2RtEZjeoEfW50LAgNEsb1LTFE/cdgv5/lwkfg+71cPvmdbuxetVHDY
         Glulf2QPSUo8g28EOS7q/OnBwelzfPuHdU6I+IeWoiRMMoty7ModYrzYZ2LVANyyAUUe
         9r5w==
X-Forwarded-Encrypted: i=1; AJvYcCXU4Xq9dz+1WD6++AIb8nYprsQl0vCS8gllbk8e32v8bmxJYNZ31ng1/8YgpyoHHglaM1WTnEKxsQD2AipXlib3WATfLFjrkOkm
X-Gm-Message-State: AOJu0YzydDyGHlW3ob5UXNiFM5xR0DmCmP79KgkxDfi8hHQ+mDjPDpnb
	xPDSMyBs72+Feircebh52Aee44/l+kpT8T/VDkqXQiBEnqohoFMN
X-Google-Smtp-Source: AGHT+IH8bYqA1HygDsHchgAOn/iSNgOqlWpzkvUew0wvH8DWhJ1StLV2piMUegB/qk4uuZpGDzFYrg==
X-Received: by 2002:a17:90a:a008:b0:29b:bbde:8f19 with SMTP id q8-20020a17090aa00800b0029bbbde8f19mr2600175pjp.33.1710321957347;
        Wed, 13 Mar 2024 02:25:57 -0700 (PDT)
Received: from u.localdomain (ns1006999.ip-51-81-155.us. [51.81.155.96])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b0029bb8e80fd9sm1028039pjj.39.2024.03.13.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:25:56 -0700 (PDT)
From: Maki Hatano <maki.y.hatano@gmail.com>
X-Google-Original-From: Maki Hatano <Maki.Y.Hatano@gmail.com>
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maki Hatano <Maki.Y.Hatano@gmail.com>
Subject: [PATCH] README: Fix spelling
Date: Wed, 13 Mar 2024 17:24:37 +0800
Message-ID: <20240313092520.10906-1-Maki.Y.Hatano@gmail.com>
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


