Return-Path: <linux-kernel+bounces-21666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0C829294
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DDA1C24265
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D997F3234;
	Wed, 10 Jan 2024 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0FfcKiW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77C23B1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso2780990a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704855516; x=1705460316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxBQeKdAHh9/b2pTNvNh/xsRsY9JOpIvRay2GNv+L4o=;
        b=L0FfcKiWERpcLon+IuY/Fq93r/xtT+EALQ/1yE/isFdhZR3vAdp7MLvxwcySQLXpGQ
         5/11fk94XqQJb4ucIljQL3o1/3qWbDH8iLyMmiEQN3O8nkLjdHKqmHuahEih3Kj0gVuZ
         k2H38aLBRf6HFsauc6Nfuxt3gGsXn61iP6SRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855516; x=1705460316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxBQeKdAHh9/b2pTNvNh/xsRsY9JOpIvRay2GNv+L4o=;
        b=I7pTuTBTmBytDIzeK8Il/uh3XP0xaTHWTyJoyRVjtUOYp/0Xv3OOmdrrH4Ac2n3cjE
         yKYlPyqcWdx8wktIt4ej33+Q6+5iz0rVsnDIdJ31jrOBlz/y9nvc8HhNK3yDazn0l450
         fmb+K9W5IrjcvFP0R25swDUZUMwHEGgPaFMsYTVvUaGtx9Xl7Xb9WYda/r24MxMJIeRt
         wC40foZRkqkQdmy1LN0j8+/Fh3FQTEBroZNaDZkeQle3sBzPOm4myFK0g3OMBiklu5Ly
         v/qpjPBOC8x6XDHZk9ojxisLNuY3yZ8fA67vseckA+QIC9nIqEijh6au0eVpktUJVnc7
         DnGA==
X-Gm-Message-State: AOJu0YxxF+YcLwXZUMVa9rgJkUG3SxY8+PZBT48qlNFdDPFAgDuHdJOW
	QZrqIcSj4UT8zivNV1OZfgt4jBPEYebf
X-Google-Smtp-Source: AGHT+IGgLrTZv+Vz6OAgMNgIcAlYxMOtYF27/wKUefy1r1fVcKpJMhkKvD+nEBf1GzA22lGgta7K8Q==
X-Received: by 2002:a05:6a20:7b2f:b0:190:fca:72d8 with SMTP id s47-20020a056a207b2f00b001900fca72d8mr283513pzh.109.1704855516287;
        Tue, 09 Jan 2024 18:58:36 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:b1d0:e755:54c2:4518])
        by smtp.gmail.com with ESMTPSA id t185-20020a6281c2000000b006d97f80c4absm2467521pfd.41.2024.01.09.18.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 18:58:35 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/2] Compiler Attributes: counted_by: bump min gcc version
Date: Wed, 10 Jan 2024 11:58:17 +0900
Message-ID: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC is expected to implement this feature in version 15,
so bump the version.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/compiler_attributes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 28566624f008..215882a1341a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -95,7 +95,7 @@
 #endif
 
 /*
- * Optional: only supported since gcc >= 14
+ * Optional: only supported since gcc >= 15
  * Optional: only supported since clang >= 18
  *
  *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
-- 
2.43.0.472.g3155946c3a-goog


