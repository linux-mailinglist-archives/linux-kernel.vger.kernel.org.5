Return-Path: <linux-kernel+bounces-58347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71284E4FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86141F26DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E37E59F;
	Thu,  8 Feb 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNx5HtNP"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9C7D41A;
	Thu,  8 Feb 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409676; cv=none; b=aOkbddDx4W3eYu8RbNY9NBu2XLns0sxET7w9A8aCynPZEyksnDS7f6eUtMEPNnucPDY3iNTd/pi6klw+/QskUNWYj+OJqo41JcQHlA3zAHRnWUXgzjwL0PnSVFBchurPgFW/fmajwoJufawKCeFNOsaEsnsifPrJRe6eqfq8fZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409676; c=relaxed/simple;
	bh=CwHTWO+tHdVg/EY21mUa+MQ5VK2Z6AScloHo0O5UHk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JorTnilcqW/gsBe9kw7+CXqFiysqdVs4Vlo/gh63SNxEwVcGUqliiPu/OF0CE3Nax2mzRD6XATzxEPRFvnJlCBL9XqLtaW9DxUEJp2yi/5oi1UxUnRRWa7T+xg7xCFD+QVVuarYKw2pFUlwQa1Efd7eSaN3jBrFpgKFkx96o0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNx5HtNP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf5917f049so526781fa.2;
        Thu, 08 Feb 2024 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707409673; x=1708014473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2DpO/ehNpCQSZeHRHus/bDiRHn9+YpCE5i0qNSyvX8=;
        b=YNx5HtNP451ZiDBD4osLaDgaMIhRcB4J3HrEathMOkxZhsWkaTW158rul456VHdcNe
         8ZYTnsW/gmpqbWmxJuJbvbbjoK1D/j0Oj4skBkycumcFiNOnKsj2KKa4O+3c76eoY1vl
         u6Ts2WTL6ETZ2qAUX9a9LM0dQgBYJOqivgVpge9V1HrFWFSQC6R2lRcYwdIAQGR1DrVw
         RIu9TcmOu4TEbbQm0ZTYiccwQdLR5pRAKn3R0ZSV+ZeWjz3eVojwyOJvTe6c1Q5E9wIO
         2fv+TQ1oISf6RVX/1WpWzP3eOvKtGKunh3sF3c3fQDGwDta+cmUtaAOsenSolx9xecMS
         E8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409673; x=1708014473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2DpO/ehNpCQSZeHRHus/bDiRHn9+YpCE5i0qNSyvX8=;
        b=KgwTVW0r7WSM8s4uN1j5Qrg4T9dlBtQaoZ9gNv7oZ+FTbxpFenm3uhM+RzgkQu5gPN
         m5y+P0bjN82ELCxK19QdIKFNd+/gOCj7AhyjdmJGi7UP4arcCrWt+AdimMdl8rzeM8xa
         1v6ZJVYHx6B1q79NJH/JclGv/SbNZFKa4AUlLlRcttmvluMvuFiJKH9KYQ+beYInmB6R
         Ckwvh4bzzKjwld/C6lhG8Dw4ovAIuSP6lV66Ij2BNZDZXWOlSPYIfXN5kkQm7SVzZPAJ
         nyv9hYtigCFmpgKmB4M9WrjM6LfACRHKLXTTNq1Bs2ThvLEfPWLOjiWtdPXH/SGdPgCG
         c6Fw==
X-Gm-Message-State: AOJu0YwYdhzrkU46YcwwF50GBP3VH7WSumKUS0XEEc1jh41msqODw2uE
	LmhkJwtuFJT/07ZlOc8QIebfhUnM/BvkV28ZYysjF/U7dY+bZIesfZY3vBYqZ4VdJg==
X-Google-Smtp-Source: AGHT+IGPcmJ/QpjNV/ae2bog9slmpHPKCkZNWR+N21L6jpLkjjV10VeA022DLmhLAQsIuIxrV3e3Ow==
X-Received: by 2002:a2e:2a46:0:b0:2d0:cbeb:69c8 with SMTP id q67-20020a2e2a46000000b002d0cbeb69c8mr4163332ljq.22.1707409672946;
        Thu, 08 Feb 2024 08:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYe9j36+o4dHr1OY1RuZLOyHZbqNC0Jyj7dQI7CyYAmBhobpl9+isEo31WAMmit1edQi1ytfD54Tf3ZyS9R8aXbNh/vQHUh8yb+FBMg7lvxqdUmeg75dniQ+Ql/arTqdXc1tdy2bsxG9sxxwZe0T4xypWrvl8ioKHTJe+zcQko+aQ52uxXKPVMqufXi+yIxJMXPqsR4T6r8n7qYQIRKLnuemZoVe7gJwc+F/rmCSrbBsZ9JYEgQB/Yw2joSslsb1hC8BY8rSbphusx
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id z14-20020a05651c022e00b002d0522b2550sm35047ljn.32.2024.02.08.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:27:52 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	corbet@lwn.net
Cc: linux-remoteproc@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH] docs: staging: fix typo in docs
Date: Thu,  8 Feb 2024 17:27:48 +0100
Message-Id: <20240208162748.111120-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves a spelling error in the documentation found
with codespell.

It is submitted as part of my application to the "Linux Kernel Bug
Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
Foundation.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 Documentation/staging/rpmsg.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/staging/rpmsg.rst b/Documentation/staging/rpmsg.rst
index dba3e5f65612..3713adaa1608 100644
--- a/Documentation/staging/rpmsg.rst
+++ b/Documentation/staging/rpmsg.rst
@@ -157,7 +157,7 @@ Returns 0 on success and an appropriate error value on failure.
   int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 
 
-sends a message across to the remote processor from a given endoint,
+sends a message across to the remote processor from a given endpoint,
 to a destination address provided by the user.
 
 The user should specify the channel, the data it wants to send,
-- 
2.34.1


