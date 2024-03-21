Return-Path: <linux-kernel+bounces-109966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98564885853
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5470B283F24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967C58AB0;
	Thu, 21 Mar 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjAF72Lx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA7658235;
	Thu, 21 Mar 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020497; cv=none; b=oVQz+uHkGNfppaRu05q6MidQBSBbxxJz2pO0YRsFy0plucDvXwHSt1PLycoz4EO/fk8pShMnRHbkCTfBfjqqJWyfTuDjks9YrqlFHHIBb9rqL4PmaJvYaZZL/3UB9kmKAGxa4ya46Mw6wxTTBC/wvVggpQkepgYvGXdRWKj9IXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020497; c=relaxed/simple;
	bh=w7BnE4I59f3wITcEro53uED3diG2JipzaV86wYEBpig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aTe3Mb1CnIw+Kcsm1ZTesbe9UgaVCSV6mFKSURKVaN7ikwRsmgOnqxJNUyl6m0YtrRetaCOCPEZ/Kh561CTposO9VDpYhItpBVi//eB48B0pWqt0clfD/cM+bJbtVTf5Cwr6a3xxIjSJMZLWEys7Gx1vYtmootExowEmEIF2Pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjAF72Lx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso566618b3a.1;
        Thu, 21 Mar 2024 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711020496; x=1711625296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzjq/94BD2kg6IEXQY/xyl0j4YLV5g7AivSa/+JXGNg=;
        b=bjAF72LxeA8GCLYnAxhPZdJMEECJtXURMT2sPHKow3yVKse0Lb6WCJvYt/xVhjfwCY
         ui/QioSg+55bfkOIgLXEIaF4HYVphxspcfgFEbKQF/K14kKQmEbgICvvZYfr1RtdVm71
         kJKjKbfr297WQv+kIvfuWphvNEGefFbxlLR7AIXvqM111UHYX7vgS5XOpsJ2weNguw1T
         lWy9iBzdFEHypmZq5333JdwTFiXwktcRgxQVK1GWhtfYDkQ6FHn95OWuZfGg6/78RE10
         Y3lKaqSDOe+KeLMirRNnu3veoJHkBnmAujsoUR/4+Ozi0c70Nn68PnwmAyq+R/9bCNzC
         xLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020496; x=1711625296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzjq/94BD2kg6IEXQY/xyl0j4YLV5g7AivSa/+JXGNg=;
        b=hZGONZ6za0sbtJ9t94u0BDbz1sawm2JbkGi1vQCLIlXMYVffZ3VAR50E44nqbY5A7n
         tmQfKJWU9weYZfPBykYXwiNxTtQ3DcgwQwQCsJGwT8tkBFVQ3DkuqsPNPWRttLQAvdMb
         Zz8k9wo2xtukMgA9usesip3NPuptbuITReq2+kMudgPBr4rXENkILkl9h+4ppd9IAh45
         J8XrdZIpJai4NlpG3Ad4ZwaxiJRY8WgboivJdDN+jvZ5v1GnH/ve2KHoOF9DMvMBs1Lj
         SYH0HAq1eyk4Rp9Dp2+iHTNfen9KdXvE9fWvaxfxOwaMRmS6jbr3MUHOh2Om97VZCeqB
         l9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXN0fbtjb02+tK+h7BoeUEfMPxowUtqye6MSvSWB2kKtOWnssfmd1lEuLihzUGL2sTJvjtixjfp4fHzGDSaHiu2d1JC3Gd9drzOY6Pl3bCjM5dQ/U9kpdYY3aM0N9W57NFDiLoHYRKXOxhEZffGKnku2bK1ogbKsY05292/h3/BcsHiEEWVXlgcdPGC
X-Gm-Message-State: AOJu0YzMsrm+XTSv+of3mex25IKAxrZYLDp4ELU0fehZeRTpfYx5ZYTX
	jt8XOVMjxZ8G0aIFiOFWTee5h8t0m5C7bUGW+k2l6DZNJq8pWbFD
X-Google-Smtp-Source: AGHT+IFJCj7qVL7+FrjW2hamZ7lK04kKaGLMrwyVH/1I7+T7NQbG5x3hWhvnTiIibpDrn9Yfk4XjIw==
X-Received: by 2002:a05:6a00:2d82:b0:6ea:7ba2:5003 with SMTP id fb2-20020a056a002d8200b006ea7ba25003mr309328pfb.13.1711020495715;
        Thu, 21 Mar 2024 04:28:15 -0700 (PDT)
Received: from sarat-Dell-G16-7630.. ([2405:201:c003:406c:91c7:e7bc:a440:5af9])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7984a000000b006ea7833e52esm589484pfq.128.2024.03.21.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:28:15 -0700 (PDT)
From: Sarat Mandava <mandavasarat@gmail.com>
To: mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: Sarat Mandava <mandavasarat@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] trace doc: Minor grammatical correction
Date: Thu, 21 Mar 2024 16:57:57 +0530
Message-Id: <20240321112757.17502-1-mandavasarat@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct relative pronoun.

Signed-off-by: Sarat Mandava <mandavasarat@gmail.com>
---
 Documentation/trace/tracepoints.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
index 0cb8d9ca3d60..decabcc77b56 100644
--- a/Documentation/trace/tracepoints.rst
+++ b/Documentation/trace/tracepoints.rst
@@ -27,7 +27,7 @@ the tracepoint site).
 
 You can put tracepoints at important locations in the code. They are
 lightweight hooks that can pass an arbitrary number of parameters,
-which prototypes are described in a tracepoint declaration placed in a
+whose prototypes are described in a tracepoint declaration placed in a
 header file.
 
 They can be used for tracing and performance accounting.
-- 
2.34.1


