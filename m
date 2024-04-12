Return-Path: <linux-kernel+bounces-143233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BBA8A360B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D957283071
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75014F13E;
	Fri, 12 Apr 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfD3ehD2"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7414F12A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948031; cv=none; b=adx3DRbe5nNNPF+UM0Y2/TmMir/hEjGL6ZkzsRhjGCVsgDC6SOUbK9vmcDeaUFx9tcN+TCdgBsFLseW1lR5gVxoWuHki5lQyD/6Y3nBCgq64W/xd+j/qUS7dkCLkVIqKvhR+RkTNaJSQup0u01dPcifnUEGEYREMc/YsjLPbDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948031; c=relaxed/simple;
	bh=FHYmDrKaqpfpTRuPXl2DoFH5LA+zgDT0YDVnlDewaH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J7/cCza1b1PhZuLV8wi4lSKBagTPKhRuosEXXS+zavbi84KturrmpQIkuJ6pnMWMF8h/TJwD6hb09bV5DQOxynbu3MS7BerXO4c+sYkrVqiQ3mmBHj2TbPLmcdDIz+UvUjFGFBxtnxz7yoxh0hxITOqPVcuaTYjR1ei8oDJ6ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfD3ehD2; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so176714539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712948029; x=1713552829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ku+cYfV3CL9NDsoRJLchzk83CxUteslcXBw1rBPpBQ4=;
        b=cfD3ehD2hT973F+ZCY6H8bzsssillE4z3k/ST3LiDA+KsZEC93DvdH2nHabn4lwbM/
         gzzWmQ0FelTAd12EfQ2Q89/OOFcmp/D47J4s9Yxnz/0PmprwCzX5mh6JlZjCwCwoZ67Z
         4+bcnIkQCrVWQ0HUHcTqnh3fRgEbwvzdu0dCI3dD8ulsOpl8ohi1Fsdy3KCfO/Vrt3JH
         SLd8t4AAH/v/I8LSXxT2gfLars1zKHxakXOV+ioxTk8z6BQQhMGVBHFb8BrFgc5+oIYB
         e/JV4dSz09Xh8l/K3yVtU03hjZlOvQEJkbBJUFphJfyfKZz0tgFt9kkvqjryRU1LYLJn
         mS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948029; x=1713552829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ku+cYfV3CL9NDsoRJLchzk83CxUteslcXBw1rBPpBQ4=;
        b=nTzSY6WA4T0okD5Qu59h3Zogf+0i2+PNrENBHaJZ2JkD03vsiKKKuBQcU+nui7HfVw
         VHYlENkiHMh0gVe73+A0n/GDYuhSlsDt4nB/pMz1E5VmwLJJ52YmgM2Y/Yu6Er3jTuBo
         MBiFqfVZUfd1ijP4WH1TE0KVfv1OwIi3AfNNVC/VSegGHso2GOnPPyGgvsEAHWp4wXZt
         n9RBkDtdlZCTtCFUxY97x7DF4gmF8JAHhbRmCCGlD4D+PmArO99vrSsmigmer68XBoee
         iFqyTp2IjLZXTp3mEreunPtlV61YbXWne2tYpwmwBzel/yeQavQu2lMC5ZhJo+3G0a/K
         7uMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+qqYv6qA8jJ5RRXIsSHgyzu1rSIjQMKIF9Lw0C0D1ycC2vyR37UQ/XiQD/JnJIA3K6QtexeqA5oSP2q1JvWsAXfryaPHh04NDYCmB
X-Gm-Message-State: AOJu0YxAtS5WakDs060YbehtoPyrDk5J+8jgF2dxvpGpQqKyZMsxzzBH
	1OARGPDiKsYTkt21EaXNFctxpWoZSYez6gQVZz+98etKyq75151yklT1QgfsQYxDHh85NHy1/uI
	uNQh3+WXMf510XzmRo33cYw==
X-Google-Smtp-Source: AGHT+IFIgCcbrNG0WVTnmYkDHfTcUVCEG2xc3xCMlYSow98Vu7k7eQ29VCUlewX5/iqYIg8yJw0Aoj31HUwl+kTG/A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:2720:b0:482:dafb:95b7 with
 SMTP id m32-20020a056638272000b00482dafb95b7mr108126jav.2.1712948029249; Fri,
 12 Apr 2024 11:53:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 18:53:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADqDGWYC/x3NQQ6CMBBG4auQWTsJVBrUqxgXWH50QilkRgmEc
 Hcbl9/mvZ0MKjC6FTspFjGZUkZ1Kii82/QCS5dNrnR1WVeO7aMpzBsP0ITI49R9I3hoY7RtNA5 88edr8GievW8oZ2ZFL+t/cX8cxw/Rj1rpcgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712948028; l=1692;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=FHYmDrKaqpfpTRuPXl2DoFH5LA+zgDT0YDVnlDewaH0=; b=pWm/MHLjmrDU97kGz+go/s2QQbsbuuiO6zSazvNgFRTlpwEH0VSe83O/r1uhKZsmlXVlSBlD4
 r6ftS/8HNstBETceWQdRRLeikrnqi2Zc9U6HVKPIW0at/1YtRhfCNrR
X-Mailer: b4 0.12.3
Message-ID: <20240412-strncpy-kernel-module-kallsyms-c-v1-1-ba3f0fc16163@google.com>
Subject: [PATCH] kallsyms: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. The goal is to remove its use completely [2].

namebuf is eventually cleaned of any trailing llvm suffixes using
strstr(). This hints that namebuf should be NUL-terminated.

static void cleanup_symbol_name(char *s)
{
	char *res;
	...
	res = strstr(s, ".llvm.");
	...
}

Due to this, use strscpy() over strncpy() as it guarantees
NUL-termination on the destination buffer. Drop the -1 from the length
calculation as it is no longer needed to ensure NUL-termination.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90 [2]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
---
 kernel/module/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ef73ae7c8909..62fb57bb9f16 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -348,7 +348,7 @@ const char *module_address_lookup(unsigned long addr,
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
+		strscpy(namebuf, ret, KSYM_NAME_LEN);
 		ret = namebuf;
 	}
 	preempt_enable();

---
base-commit: d7ad0581567927c433918bb5f06f3d29f89807d3
change-id: 20240412-strncpy-kernel-module-kallsyms-c-8539c5e7bf57

Best regards,
--
Justin Stitt <justinstitt@google.com>


