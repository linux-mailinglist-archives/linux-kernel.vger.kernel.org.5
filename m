Return-Path: <linux-kernel+bounces-84443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58F86A6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD6E1C23688
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCB1CF81;
	Wed, 28 Feb 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k4oydFxj"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62D1CD15
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088361; cv=none; b=sYkLYe4cDk0+1TOxXhkqvpl+QyghWr+KSshkQEE+/3KDrP6C2+LqZIdgGhHjT3wdD8e4LjxgnK1z3roWCl0eHHHps1+vCK/VJW3p8FZtqmYMc0h2K6TbNff9+KzlS3/3NItWfuE5J8sLCda73qAfn8BeqHCPHW5e0vE6UJCmLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088361; c=relaxed/simple;
	bh=LV4NmiXNaGZ9KK8IYGWxqyPnJ0nw7pM40lzxC6A9w+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gsQyxlXtJMTypWctgDRWOK3sH1eIyVB6MxURi016+yf67g8L0bgBQK73hSxnVNujvaeg2IfnAK8EtnsEkjo6V2llyWA6Y5qxP0QwN5SD7g1HbBFrfv53t2sc2MmZOpLNX21EFxGSGpyUkzoHOrr6U2SmwmeBXhQ05B4M3c54IQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k4oydFxj; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a089f333bdso1546699eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709088358; x=1709693158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3dehr8Ho7ib3MGSSkhJ7f1dmLYZiqbaCJe9EpuzVRc=;
        b=k4oydFxjFUG0JiFaOmfCtp0b0859nzVCcCKGd3Mj6WxjOEl/OjfW8CVzVDKjy7Aqet
         dhbAuHMejqvQxnaOazVkrV/OpwOKFWmn7F42hm8kcyP0AuPHQSWeSby2yudrJkeRGAtW
         Ph3zI0N+2WO1NB+F69gI5RWQUu5aIRX7ln8DofCSh33HfqwXlFFa1dbsAICT1++N7VKj
         IhYLh3dp+BENQWvC5DDL70Q6bONIMDxlIk2YxqsaxUHO/2z3gvx9264CAfZQzGeVHx0v
         /Scqx1M4PwYq3dufseqzCJaLOZ0ocFkf8wL36/RC2Zg9iywyqgYH7S0p3EguJurgVT2Y
         zGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088358; x=1709693158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3dehr8Ho7ib3MGSSkhJ7f1dmLYZiqbaCJe9EpuzVRc=;
        b=GpchUzHbp3d999YB1JOJoPdOcJ+dJseMWhR2ZGKDbMDbbHd1v2PUQlYVumXqq1o/1+
         ugabeOnCW/MZVxdmv7xFMzzfq/gj7Bbyy02FsTt9sgEDLDw38hO0T+bHCpBZtpJq+kMx
         V/i6Ph0FfxX/qpyEpFKuqYYGjOuWUnlcZ3YjR4dhYayiw8oElwBSO7VbJMAy91erXyA8
         xc4vQYfxdd8SD6AQaqLwp+qdxNw+KnF91OmMS0oyc4ewyMlGlWZ+X+nftWM+UsgfdLhV
         EynC8zpkLM0aeJjcP8IMKvugXrX/HoPikN6KsSSsjKfZ0O5XdUzCfQKienQXPON4BKIJ
         /abQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNAjOrn3u6sGYAssuetMyyX31dIUZQYVH7exuWyRC2dfT29S8zcxDj36Lsw7azj9wPAYMc35PGjgmBL7nbSMc4p3ngi2FiDZPqKTw7
X-Gm-Message-State: AOJu0YwkQ3xn0bLu7xQ+8gzNrTIcxN89DznZXHzphvoKGs6YQp+Hc/nR
	klzcSkltEDOAzHrNd/sZ3Hq6taTAscO0GR56088VClq2by/Ouhirc0Z4wJxsdlg=
X-Google-Smtp-Source: AGHT+IF0cqOe/kAqIuBZWJWGEryFGpLCxIZSZR91T3CBC0PIc+508IRXeYTqKwYOwTzC3V3iqYVweg==
X-Received: by 2002:a05:6358:893:b0:17b:b023:6539 with SMTP id m19-20020a056358089300b0017bb0236539mr7634120rwj.25.1709088358106;
        Tue, 27 Feb 2024 18:45:58 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([240e:6b1:c0:120::1:d])
        by smtp.gmail.com with ESMTPSA id 9-20020a631249000000b005dcbb699abfsm6489072pgs.34.2024.02.27.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 18:45:57 -0800 (PST)
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
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v2 0/3] Support intra-function call validation
Date: Wed, 28 Feb 2024 10:45:32 +0800
Message-Id: <20240228024535.79980-1-qirui.001@bytedance.com>
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

Based on commit 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269), This patchset adds stack validation support for intra-function calls, 
allowing the kernel live patching feature to work correctly.

Alexandre Chartre (2):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Add support for intra-function calls

Rui Qi (1):
  x86/speculation: Support intra-function call validation

 arch/x86/include/asm/nospec-branch.h          |  7 ++
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 64 +++++++++++++++++--
 5 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.39.2 (Apple Git-143)


