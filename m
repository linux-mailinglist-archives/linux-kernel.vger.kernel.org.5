Return-Path: <linux-kernel+bounces-52579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C408499E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5CC2819AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE4199B8;
	Mon,  5 Feb 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="v5L+M9f6"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD2199B4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135223; cv=none; b=HoJpcdbA4+LfmbeL4wkvZrp8SNlpKcSBFrLCkXPPBAI1iI5e1SUG1cbISBnpOPQMuDSQvrdrxWnFoccZHdBN86bmeChH2NHBWLwFF3q6qkfnIA/FPot2n14ak3t4Ujk6xTgHm5VhtDl1EWdC+3Xpbdcg3EfrayeiHtwXbTApXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135223; c=relaxed/simple;
	bh=b3zEL90q15hC96NDr4vpP1wxQM33aWn3KdnLk0NMY7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HtAYfpG4147wiLQbMSO6rZocLfSzjCRYPNLrurvXvTEcXeV1mydF+WB7TlCvYvU05StOeCBv9uLYDPCWDJgY6HfY+DhrQJHjVUtD9ti1fRZK0sxIYGyvdUYEIR3NnSLAs2BWyjZNiSNIm0P8yY0+xQSJNCkSeXe7ONvDdcl4RdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=v5L+M9f6; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so10715635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707135219; x=1707740019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RSQODvxw90qryNiwnQGt89Wiy04U5DyDbCfGw4ywivs=;
        b=v5L+M9f6uLLzgJ/0MiLCSrmRPPCOoyQNbvXw3q2f9U+eY4dQNG5PmP2DzpY20wMDFf
         G0GAz/ALacWujIOpvEy3bA4VcUG3UTZGbyAEDLzSEbXW0ZmQcg9wEBWwsNHfJGWhQLiG
         caEBzg8jTAsh/1W4AtGXZHjEo8Zy3apsToHD4U+KdLAZZtRuW5thYAQGfWCR3PrqQSDB
         E4mHJ1SA/qX5CTMmIfA/i3CCH5RxAlVimNOp0NHWc4xKmbL3fuBLPMVD1IrGLB8/uce7
         eUCSQpz/xdB8yjnvxfwZOaf3rWdHP2vnBezAHSWAxU6/i9SzIQ9eTRkBXfKNdeKHXqPs
         Vb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707135219; x=1707740019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSQODvxw90qryNiwnQGt89Wiy04U5DyDbCfGw4ywivs=;
        b=xFTr7hp5u8QP3Cx2UrnijI3qxjs2mW4Sy6hrkxcP6TX+TMwT64LcBFLuYQzVb1Zi69
         Z85s1FH53xanwirjbxD5PRfzBizjBfvX0kXBvFZaHN4m20t3RQ11rSmbIQpfGmLCGOTT
         Q99RqozzxPD16GYfnbwNo0EH5vidLFGWQD4ETHO549YyqFUVR7pRF2IRlln+i1y7Wb8t
         Zx1nFASkqzoLz6joL5YIjOAxJHr4Oc+yVkpbL4ZCUetOu17rdQxDbm+WjM9VllpcICz7
         LNOBqYHTMHcNY+z4krZEafEYZDjS6L3evzCLbYj+DR+hqoSsxl8Q/ABkCLGzF+YoJwAj
         WGzA==
X-Gm-Message-State: AOJu0YymxOkFJ97L1kRqNqE6xjk+rldnAy5URVo+duU2A49xN1M9az8/
	PMidGiLIlyqRVX5AT74hB8gtCw4jXGKpqCiUo8zA21NSB8LP70eq7HVxhj7M3icYSj2iGnf6cBV
	aKOUI0A==
X-Google-Smtp-Source: AGHT+IF+6v1/nBFcRGVgzfNCpfbGsAJ1MwumTlPaJ83U33aOvlA6N+lfqbDkUmKrhOcSgb2VVPlznQ==
X-Received: by 2002:a05:600c:3d87:b0:40f:dd18:a014 with SMTP id bi7-20020a05600c3d8700b0040fdd18a014mr1054623wmb.14.1707135219168;
        Mon, 05 Feb 2024 04:13:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJFM57T3TxSBmdhYoCX+h0h1AZUSSC4yX/pGaAigQXn2XOqHluxVRfQPlWk1WrLrest6ItIDUTOqlcpFTOz/DVPgw=
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0040fb03f803esm8459779wmb.24.2024.02.05.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:13:38 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linux-kernel@vger.kernel.org,
	trivial@kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] README: Fix spelling/capitalization
Date: Mon,  5 Feb 2024 13:09:06 +0100
Message-Id: <20240205120904.1711-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Fix spelling/capitalization s/Restructured/ReStructured/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 669ac7c32292..026eff0b8e06 100644
--- a/README
+++ b/README
@@ -11,7 +11,7 @@ In order to build the documentation, use ``make htmldocs`` or
     https://www.kernel.org/doc/html/latest/
 
 There are various text files in the Documentation/ subdirectory,
-several of them using the Restructured Text markup notation.
+several of them using the ReStructured Text markup notation.
 
 Please read the Documentation/process/changes.rst file, as it contains the
 requirements for building and running the kernel, and information about
-- 
2.39.2


