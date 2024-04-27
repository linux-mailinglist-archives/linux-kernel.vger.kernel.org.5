Return-Path: <linux-kernel+bounces-160834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4288B4364
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218AA1C224CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85782E403;
	Sat, 27 Apr 2024 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGwFRBVL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB725777;
	Sat, 27 Apr 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714179409; cv=none; b=NXMNGUkE1iXMsDhC58E5p8QOoN4r6nXOgwH4ZcAFdkyrLy6Cj3CiPPwURW93kaS4ofBo/lqiQYtzWGb2IC6foG+avohKtDFHw0GFCDGlEksbDnHeJS5a+6wN4cCOgdW7JjqWbuPbVNSQXK1csrsMRDmvQDlyB4gtAOocyZ5qcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714179409; c=relaxed/simple;
	bh=GnDwmsqjw2gFexBSuJVJeSDwlc8LJOSAPfHh9x1k0TE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h5T9YoSYTW5KumG15hMElGPIsygs1SbZaRD2JUFz8jJShKcmbgvg669oxytGiaSPIm3iCgRV0RHzOOtYaFgwqhDmXXsUd2vcNchZLKtlBExVv2xEQcDS7NMujvgYnGcnclYjSOXKJo1HAAyxuMemHZgcW8ccKpDmkWRf110eoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGwFRBVL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so8807105ad.1;
        Fri, 26 Apr 2024 17:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714179407; x=1714784207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1VmVx/gXU8t7Rr/1hp4WucPVLLCCjDl+7oy93oAoNA=;
        b=FGwFRBVLoklOcjab11V7OFvhhzuR/ot4IptOeXXN9zgW1+9EkpLR/x05PJ3LesPchZ
         bCP+EKFrJ/T4ivnEBhgmyoYxXc7HagtueeCBwDvbp9m3MzCilIOmnRM+Raa5w/mQXlAk
         9aF9MdK1aaHMEBFKN/4FGBrdZgmPhHrb2sG31G58PV/Zv5eIEXoQ2fhuQyrKc/4O1nU4
         E0oZ+HK8VgisB6Xz8iAMLh+0rcU9ejzhlyLFcT/9nt1aI4uJppVpZhDR2akywCyfNUp7
         Rh6rNjJE4CVdRBObtBrJ7gJF/7Zcj5LRPthU/lwTdyeMrHnVzDbOi1G/XjKFWRv7vgQo
         WkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714179407; x=1714784207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1VmVx/gXU8t7Rr/1hp4WucPVLLCCjDl+7oy93oAoNA=;
        b=Fsqo1KcJ27s705QUAr3jUqfj6qBzqxsNQfgOZYThXyvwOrscQgUvLfS3zQM0qYmYvn
         m6NRepdW5d0qvqRbnFxRXu7Fjd0E33PfeXMsKdraHgVreifwdcItNcRjZHHoT96YcyVV
         duvNKAKb9M7WrYooKuj0ehA/4PJpv6DXuIYXuJp8JMG7PvMYUBkZmDyusyN/qC/iH2QK
         dJVVPJsv8Ke3wRKjK6E+QIPckjHxwwNAfPY8ni3wyvUcs4KMVA2Z+wmCI6KjBT/Fx1k0
         LPomQ2kB0R+x+0RU9eVLANA+RxZoAtWY9YySB9/RVRUt/cMu0JrQtnFWyLsLCDzMpAga
         AMUg==
X-Forwarded-Encrypted: i=1; AJvYcCWLVRn4EG7PUSfc/d9mwnYCb/xXDbLcC4d1ZJfsqnh1RJmzlT3HmGHf3YRzmzjrQyfPflLdKSGUhzbcBtJ6eUKxKXYA
X-Gm-Message-State: AOJu0Yyc/dd1QDt6RWmtbSsc6ERTut5QkbWcj8gsq4bcVuEKyuRKsUYy
	gBPzyY2z/sqjRXe3C4zsl95aJWZLMsWsqi+JNwDzuUYm0mjv4adnJ41G4VtZ
X-Google-Smtp-Source: AGHT+IEuVHn3L7YCYGc8lyexE5wSS3enuQd1OF24X1QYCkhQvikdYwbmp88ie3iTFEmPjThszvKYiQ==
X-Received: by 2002:a17:902:778a:b0:1e5:4f5:7fa7 with SMTP id o10-20020a170902778a00b001e504f57fa7mr4022755pll.21.1714179406933;
        Fri, 26 Apr 2024 17:56:46 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902a5c200b001e26d572f9esm16018476plq.242.2024.04.26.17.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:56:46 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] x86/rcutorture move CONFIG_HYPERVISOR_GUEST to kvm-test-1-run.sh
Date: Sat, 27 Apr 2024 00:56:26 +0000
Message-Id: <20240427005626.1365935-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_HYPERVISOR_GUEST is a x86 specific kernel option, move to
kvm-test-1-run.sh to avoid ConfigFragment.diags in non-x86 platforms.

Tested in both PPC VM of Open Source lab of Oregon State University and
local x86_64 server.

Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 ++++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon  | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b33cd8753689..75774bc70be7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -68,6 +68,10 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
 config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
+if uname -a | grep -q x86
+then
+	config_override_param "x86 specific option" KcList "CONFIG_HYPERVISOR_GUEST=y"
+fi
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index 0e92d85313aa..cf0387ae5358 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,6 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_KVM_GUEST=y
 CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
-- 
2.34.1


