Return-Path: <linux-kernel+bounces-51204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475508487BB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0362A285D83
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4F5FDDE;
	Sat,  3 Feb 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msiihumI"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751395FDD1
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979401; cv=none; b=kgexqprll9MIXlULc6lXtALN7EJyMhx0vT7G0AAoyWLZ+1v5WDgRvB5SjADEapsaD2NoHxBLgG+onKRa73KAMGKo6XvRBbjGdhHmhRQyyMJOLr/6zH49f1jS9J6HqMIgGOFG2pZrCmyHWxOj7XiDC6Ln4zKgTArK8YeDqzYxY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979401; c=relaxed/simple;
	bh=2l1IPV11WG55dsuk+2ePhtHKYWomk94wx2EjnRWoVrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9tyt2rhPVwHlFEyg1tqg25RUSBHplmKVO0fDdCz4pwDyzP8SVw3pFGFTFyosJjQBfS2PnxY6Jy8ifbzq+sz8EmwCxMl9SESCJVZt9MUATAML0l8wkQar5nDKHeVguPgyricwCbBgM5D0juaWRKuF/hBJg9/7zQwUqA6EwQGeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msiihumI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29658f0c034so782338a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 08:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979399; x=1707584199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOV2yP+jsek74mx2O7DdMdBp/wgqkEnoeJs0Nj7voHQ=;
        b=msiihumIIcBUw6bIMdmaFsk7Hrrmw/YSQ0lNK6rgkLJ9vSnyMVVMKHDvcBAt4jJ1sX
         YbBCnDjWxm+StQ3AdpXMD9SafWB2jz2ZrWOQyYWRGmSkm2bNHITVoYeSnHRPGogGZNJu
         Ou+6K6OyGTDPPV+HAyfAX8LMsMEENaWX14CTrXpHOhY3vqZDkBAiF4+rzY3s5tKq9yKT
         sviHXZC7dKLqF/8gI7VmYYPMDfiDUmKdlvsP5+ClU65f8D1kxI5jhiONGohaYPz8FcFY
         FmEzhwBupPNGoOxH52RUKzK8NkquPiQ3MiY5VVMWo9HfvcAS7Lp3KFPrmjRoQiCDkHYn
         jb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979399; x=1707584199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOV2yP+jsek74mx2O7DdMdBp/wgqkEnoeJs0Nj7voHQ=;
        b=oMlyigX7XGo0mxwVfpZbmXir3VpG0YkkMdsWUxKaNc+XxgqYUaqmpMqYTTmfBHWmTg
         nLGt4y89SLnBzWpY2W1q7DVrq122Dv6+w2vT/ZVJ5YKGr8y+Pp4vuMDqOUZjDVPSRcj2
         9fcngaQgTHnfh8UT2PPY2wU03dvT8zNpFRnTpMntpbCmlPdHGOngjDCOyHsE+kJOH+93
         Q502M7i0dLcbcJlbZDQUlUR+XjfbWkOPWMQVrMyEe5oSrmwZyuubltQmdnb1zBuowysP
         jpDWdosWjXT82Hf7iAhNDBs/DOmtrcPuU3SgtmBhyLFe+FmDcLuiZpXSlUnmRKjnAVJr
         N1zw==
X-Gm-Message-State: AOJu0YzGKzawSWLOgZ/NW0CawvTcmPz5V5rS0uV4aw7oZpIod7NKmv/i
	VxPc3MQSBvrXjOHpjG7VtTsnaHFMa9QcFGKsAy0flOX1WKDB58HC
X-Google-Smtp-Source: AGHT+IE6oThN9u76U8M+L4wh/1Ir84oPvlD+LsqrPyJpeW6rVycNbvO94BtEWrDczFh25opdco9VcA==
X-Received: by 2002:a17:90b:190b:b0:296:6875:3e66 with SMTP id mp11-20020a17090b190b00b0029668753e66mr1102014pjb.16.1706979399514;
        Sat, 03 Feb 2024 08:56:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXRbPOpr/8qC7iVSh5hJPBJ26jRIpbUhH2Fch2wrzYA29QpdKjgNnrFIII4yE3pwdMQB+IYY0guRe5ouaQk2Yn6In2P5KI0Jh7N
Received: from localhost.localdomain ([122.161.75.254])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a020300b002965e463ee9sm2062664pjc.34.2024.02.03.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:56:39 -0800 (PST)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH 3/3] Task: Kselftests: LKMP Bug Fixing Spring 2024
Date: Sat,  3 Feb 2024 16:56:33 +0000
Message-Id: <20240203165633.149719-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed zero length string to a blank to fix the zero-length
gnu-printf format string warnings

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 97b86980b768..bbd20280e7e2 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -162,14 +162,14 @@ int main(int argc, char *argv[])
 	ksft_set_plan(7);
 
 	ksft_print_msg("Running on:\n");
-	ksft_print_msg("");
+	ksft_print_msg(" ");
 	system("uname -a");
 
 	ksft_print_msg("Current BPF sysctl settings:\n");
 	/* Avoid using "sysctl" which may not be installed. */
-	ksft_print_msg("");
+	ksft_print_msg(" ");
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
-	ksft_print_msg("");
+	ksft_print_msg(" ");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
 	if (argc > 1)
-- 
2.25.1


