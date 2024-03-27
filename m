Return-Path: <linux-kernel+bounces-120626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7B88DA74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68A3B2205B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56718383B0;
	Wed, 27 Mar 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fMH+qMCu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE32CCA0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532702; cv=none; b=IrZ0MqtAvf5iWTl/A3WpAwbwvR0vq2FDw953olEXWABGtFuyovEVTktRwY7IQMe4dc1Au2dws1v0hjoVwhXYJ4j8dugbhjuhSxIddvpEmJKWOmcO/1iNbS8GTTfRWdkrBcHz9B7DDmr8bt6KgdCZL/wLkOi79JYntdkj6QPVJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532702; c=relaxed/simple;
	bh=5zTEJoGPB+tgay4nvfgbQK4EeEdhwCMFFHER4asBSQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kzixXR6sNQBhXFk+aCSFBFvT2u9AOMWrjDXwgxnU/055eQlpQpytotZABQyRCSrTSciOcTmTOrxrl4SU7XqlUOO4bitrqtNoWoSs9tiTarAmgR6gUUhpzlc6FcR1TuV8GZnsDgP3lID5cwOlWotGfTQr+tW07Y3pzssCwtmdbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fMH+qMCu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0411c0a52so49100015ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711532700; x=1712137500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0s2/2nt92fOMZjCKazAsy5Mowx4acP5f/CX6uku2zg=;
        b=fMH+qMCu78f+H76DQlMprxo/7KgHq7gJ8MFzfTaoOy3yckwOMY+c5sITLa6LAEFUeT
         Pk3j4AN99zYJd+tM1WHz0+64nx0UnsqIsO/VbIY3lfcj5BtGJsoyQ8I/zmGpaQVD0KdS
         hQfKZATQ1vEuAlrs7w9iJ9rqLo8fJGx72f/fiBQh6BDt08nlgQgMe+gVUJuQsPtkupoY
         Hkc1jFRJXJBv2l51fTon3tnI5dzJ+eMeAxUx3sQ+UxudG7mp7qwO+sM/ZHslSd/lLXRq
         sa24mVvoCooLkO85ejqLbipy3dbpIWodgGmCDJ8X0eqQDwMM9JxpA+F1Heu8EWJzlyDE
         /Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532700; x=1712137500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0s2/2nt92fOMZjCKazAsy5Mowx4acP5f/CX6uku2zg=;
        b=J9ceuoYHZMLEFDNoFE67Es5HXNSCZSCbpS69EuLA6EY699SsvP23pCyCP/87YnZp/G
         5lz9S/v/G1adxqMsQJJdS0I1KKnjBKxLqsqpTkx/QOanZxfekbBAXwyF+q95ANrZi1RY
         v5E4RlU4xsA+ESFGk4kzQfBAdgg/vvWQzM8Nn5yovmsLDPvmEFFR1J/xx11CK91MSoBN
         CNkLJ6DWCAowY5GdnzAP+F53gOcQY6ppY3I1mZy+8xjeOoo/z8PPXXODGEXvzrdyGAGT
         q2EPwmbC3SsMVLuafY3fvlltdXkodZA5tg3YPzKFyOHSU9Gq07QXGoS/b8BpPk5haf23
         fgSw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTAz3pS9HK9Mu2c9PBMWk0/0HgMhiUqkS95Y3LXZFFSeNyGsrJ+GlNqd4VSUA3tRhlCYVX5HlvSRAC7zuFV4/B21KSVvKeM2h6UuA
X-Gm-Message-State: AOJu0YyhswxoPv9EZSYfWKJuQ2jHYihK04CPr0JExvg4F0uHwwkVlAAl
	NtPy19JhLDYHbM9Qtw/a5UvMOMKg5fv77gO8jS7CyesprUD6k7X5tOOPxEaLqvg=
X-Google-Smtp-Source: AGHT+IESl6EbiprGQ7fdcjtdxHL/0CNtsLJmj2bp7YqhGwHMzCmgr3tnJfDwqDhyhQtmEsddUxcJ1A==
X-Received: by 2002:a17:903:110c:b0:1e0:e9d7:83de with SMTP id n12-20020a170903110c00b001e0e9d783demr672164plh.12.1711532699925;
        Wed, 27 Mar 2024 02:44:59 -0700 (PDT)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902e30300b001e002673fddsm8500474plc.194.2024.03.27.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:44:59 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	sashal@kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH V3 RESEND 0/3] Support intra-function call validation
Date: Wed, 27 Mar 2024 17:44:44 +0800
Message-Id: <20240327094447.47375-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since kernel version 5.4.217 LTS, there has been an issue with the kernel live patching feature becoming unavailable. 
When compiling the sample code for kernel live patching, the following message is displayed when enabled:

livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack

Reproduction steps:
1.git checkout v5.4.269 -b v5.4.269
2.make defconfig
3. Set CONFIG_LIVEPATCH=y、CONFIG_SAMPLE_LIVEPATCH=m
4. make -j bzImage
5. make samples/livepatch/livepatch-sample.ko
6. qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage -nographic -append "console=ttyS0" -initrd initrd.img -m 1024M
7. insmod livepatch-sample.ko

Kernel live patch cannot complete successfully.

After some debugging, the immediate cause of the patch failure is an error in stack checking. The logs are as follows:
[ 340.974853] livepatch: klp_check_stack: kworker/u256:0:23486 has an unreliable stack
[ 340.974858] livepatch: klp_check_stack: kworker/u256:1:23487 has an unreliable stack
[ 340.974863] livepatch: klp_check_stack: kworker/u256:2:23488 has an unreliable stack
[ 340.974868] livepatch: klp_check_stack: kworker/u256:5:23489 has an unreliable stack
[ 340.974872] livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
.....

BTW,if you use the v5.4.217 tag for testing, make sure to set CONFIG_RETPOLINE = y and CONFIG_LIVEPATCH = y, and other steps are consistent with v5.4.269

After investigation, The problem is strongly related to the commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool"),
which would cause incorrect ORC entries to be generated, and the v5.4.217 version can undo this commit to make kernel livepatch work normally. 
It is a back-ported upstream patch with some code adjustments,from the git log, the author also mentioned no intra-function call validation support.

Based on commit 24489321d0cd5339f9c2da01eb8bf2bccbac7956 (Linux 5.4.273), This patchset adds stack validation support for intra-function calls, 
allowing the kernel live patching feature to work correctly.

v3 - v2
 - fix the compile error in arch/x86/kvm/svm.c, the error message is../arch/x86/include/asm/nospec-branch.h: 313: Error: no such instruction: 'unwind_hint_empty'

v2 - v1
 - add the tag "Cc: stable@vger.kernel.org" in the sign-off area for patch x86/speculation: Support intra-function call
 - add my own Signed-off to all patches
s
Alexandre Chartre (2):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Add support for intra-function calls

Rui Qi (1):
  x86/speculation: Support intra-function call validation

 arch/x86/include/asm/nospec-branch.h          |  7 ++
 arch/x86/include/asm/unwind_hints.h           |  2 +-
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 64 +++++++++++++++++--
 6 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.20.1


