Return-Path: <linux-kernel+bounces-52714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E42849BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254371C2252E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61124B26;
	Mon,  5 Feb 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="iAU5Cygi"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950724A09
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139654; cv=none; b=acGY6OJXgAOeaITrEdFtU4Fxq4BCu9TtyZcDJLes1w9gF9P0zGeQo1CpTMmSjOpoIzcGN3ukh/q/7sxLsr63U41nZjNlb1o/036tdZJ410ycxdAE0W7ZnEt6zJxcq86j1pPcYy6XxQF5AFsUYUyvI8IpHDvCG+ElISTl+phTMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139654; c=relaxed/simple;
	bh=ohd2b4QJUiBI+u2W+/bqlN+cDhKAzefVIpOzmXTVka8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MF02KWOR46FF5llY0kGC6OthvVaP1DGvNSWYK5syFEEdWYPpbI+P9AZBqlNnme3W9gRfFvsCiW/LL2VR1rIOEho6e3bSCjxafjUK57phouiEp9MHaxVWmd7V4ZxC1UGh7vUhGowiLe4JYTqfCCIP3gqgWKWOsnAPjeGu2A/NTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=iAU5Cygi; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5100cb238bcso7934399e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707139649; x=1707744449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5n4ydAnPupPd3U6BJzPTr7OuGw8QKp6ux4SyUSisFEA=;
        b=iAU5CygifKUFaYJGEH3oS0gj7Iva8mcgw/OQiuTgjCEMLRjVqStipxUTkoqBOlYoQY
         KWsAQsyuTePfB2bU/Hu1pCZVPbDAHeRBlI25qa3vAmtce32nCSjXrFBxcjFHpVcAYLrh
         Odzq0DozEyMYCsRB90eB6qj3rydRnpctqAb6rwGQhi/eyuKjVkdgQ2+7fdBsE2hylxf4
         RVesgnoDygat4V4dtH+k6G+HTpson1rBW0sZ0DNz/s34mNAGrKj4s/hfywStUGm2BQv/
         VWlIRIOzIc9uMGG3KVQ3XQDfDZhlL1AFAr0uTtN0GrB/yKRSCXLdZLgsJWSstPrNJ+Jt
         V2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707139649; x=1707744449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n4ydAnPupPd3U6BJzPTr7OuGw8QKp6ux4SyUSisFEA=;
        b=SxZ3t/WmobVcgM65OS4SOulgJ3Hu4J2emEUYIHHDcNQbs3akcelIaqygTckQDMpRaq
         31l+jJplYD030c+VZB4y3TggUXC/p9qCBNG5WrHaiYJD2genAYf9ojrSgGrFtNP+aTvd
         er9O0bbp6KO4ze/VKE+7K1acPi5tapchIxAmO3LcKEj50JUspSD1Ib4LJUJVgq4fCTMD
         k0JxIFOIEnqFX70duEkJe5Ve5gjd7KLOtgYp6Hr7xLEmWm9Omspe043lzqG1mmWILzDT
         7Eaz4sQy45yUEYZLkD0RYtdEtqS0BlxiUb9F7fhKwPjy/YCJMXevpzOaBFlnXWz8z/t8
         +6gw==
X-Gm-Message-State: AOJu0YwvrVWJdeTr7dnaPko3zobCIHqgP+/63A2lINMPu0t1mY9lrUi9
	e0kRFbCObPNJDtqlUH+yTZY7hzw/sIOwbVhMoc3nfqQdth6SfjtBzaMojSwwYoDtnE0I85MWjAP
	jEpY1oA==
X-Google-Smtp-Source: AGHT+IGu2gtE1cUt6AHDOUPwaptcYcsZjSXRvZxIhDCgcRk9JF0x2AihclIRoqRhXs/mFwdgEWbSeA==
X-Received: by 2002:a05:6512:5d7:b0:511:486d:454a with SMTP id o23-20020a05651205d700b00511486d454amr3380981lfo.39.1707139649198;
        Mon, 05 Feb 2024 05:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNcP7Glt7qtXOYVGsFMgoaRvL0k6QMXQVxeVyrv4j2QCU7c3WomuBcT3v1VM4TcRpJ5K4aE4RfUhHCgSkIXn/wZTgUdO88TVSNTIzP9SKFNnTFyzM8K00nOEuBRVFNw1A1D6+WGp3BFvIcrmxMEy9qFDNfboDMWu7YQg==
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3756cb9370sm2872837ejc.91.2024.02.05.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:27:28 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] Documentation: admin-guide: tainted-kernels.rst: Add missing article and comma
Date: Mon,  5 Feb 2024 14:24:10 +0100
Message-Id: <20240205132409.1957-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add missing article "the"
- s/above example/example above/
- Add missing comma after introductory clause to improve readability

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/admin-guide/tainted-kernels.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 92a8a07f5c43..f92551539e8a 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -34,7 +34,7 @@ name of the command ('Comm:') that triggered the event::
 
 You'll find a 'Not tainted: ' there if the kernel was not tainted at the
 time of the event; if it was, then it will print 'Tainted: ' and characters
-either letters or blanks. In above example it looks like this::
+either letters or blanks. In the example above it looks like this::
 
 	Tainted: P        W  O
 
@@ -52,7 +52,7 @@ At runtime, you can query the tainted state by reading
 tainted; any other number indicates the reasons why it is. The easiest way to
 decode that number is the script ``tools/debugging/kernel-chktaint``, which your
 distribution might ship as part of a package called ``linux-tools`` or
-``kernel-tools``; if it doesn't you can download the script from
+``kernel-tools``; if it doesn't, you can download the script from
 `git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_
 and execute it with ``sh kernel-chktaint``, which would print something like
 this on the machine that had the statements in the logs that were quoted earlier::
-- 
2.39.2


