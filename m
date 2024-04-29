Return-Path: <linux-kernel+bounces-163168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC238B66A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2571C21DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C370194C7E;
	Mon, 29 Apr 2024 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHSBEGvW"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A7194C72
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434398; cv=none; b=Jxa7m7IIJP3Sy+pqC9Bk8qenjDoaQmzoXLXrL3yeV4hkCIGQmYvbOJ/AxuSDyToQLYJGMrdbnvkqIpqpkMwipUHIh3BX/n3RA0QHQeSERpSsOtDpBvkMxAuqFx70SDOz4WDAE8V6ijGYOCAoVBqzMtMz/Ssrc5b8S8hRzobF9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434398; c=relaxed/simple;
	bh=eegKWMCzrzmAYKZZgWikTznQIF2vb+MOg4eHgNWHlvI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kenXCO+lai1Eij4dFodVxG2MMLAZqlysXoOsdJl90tTKRZPKpF8D+MFAILaDwQd/kEl9nkJK3tRSAjV21kff6PGGkbUrGcA4v7N5BzYdGdl+152DxILH/AwoSNq5/3xpojKTX/nR1CRChgeONHkbpsPn/ihYQSmxocTtAN0pJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHSBEGvW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so5100873a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714434395; x=1715039195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VBKZZVwka2zaA5v6QzXM0lkoNOh+22WGqQQ6UgQ50cs=;
        b=eHSBEGvWL15RNxpFN1o/z2TsCBOpM5PHzbyWILQxF0RW4NMO7OT7Cq9fHtRMNUe0/a
         N1z9R6ipNPuqj0ovEDGBSg+k3W8o6pSHmOshm3DkN80xfwOP+jboIc9EydSgRyXY55oE
         CeM5gF0xV+WH+gPvlWPjMYzu1URutmcL3+kgLrLkZrBHvVzjgMYQXDeIheRDQkjiDeJU
         2kzUbmXYA5fKB5pJWmXrS9QY4NZNrEijtCDsSx29Ln8wSvlvJN0mXyVKQc9d5i7dB80P
         5MPYLvBp+JV6B0wzEDppsc+K8oPjGiDhB/BqYmyYlMfzhPFQuWUOY7GzTlm5UYX3xKcO
         e68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434395; x=1715039195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBKZZVwka2zaA5v6QzXM0lkoNOh+22WGqQQ6UgQ50cs=;
        b=oDWuDtBTdwpGvPK16A9H5RHSsQrqOYMwKzAo/b2DCY/Pzk9MfBr3HD9FqrxDfKE/Vq
         VHW5qLqkOYZ8NcP5gePaZ2TD5Mo+lSPhtsNzpR5IGqfmpbcQhJ6U0Mqi85wJNd5DNe6C
         hf7tgTVubSR1GFCWiPhusTTScBXC7TpUg9YcEdCeo3qIQhX0n7RWAXP9XlFFPG8DFobu
         2q/SaPgziLEBK556YGOcQcfQknWtv3B8gCA7DBsbTQS0aZqLpfCnnHDvBgbR6//gPBqz
         PjHRL8ShAv3h3daNtGBESS8tsPxr0SLOvoaB2F+/YNhjGzDEDHrnXmuzs/ewzCdUKp1m
         d8Jw==
X-Gm-Message-State: AOJu0Yyl7seOM4lEnDlavir7RQbG/sKXti14S4cipCZDfH8EjtevTFKq
	QGfX6kzLNMUSMI8mvEz7+hdWe5LYsGmSB6yiF5pIYoVkRYGY9vqEMoGACOFCwFWiAjz+kZ35pO6
	X208M60EBdtij+7hsiMnVwGgwVPfQd1Psl3oUpym0sXG+YHfZarjnPrxIGrr6LZc4PBYbvkSFkO
	D/oTg7Ic5BQ7vW32OxaPHJpH10CygDTFbtLXSnhVyW
X-Google-Smtp-Source: AGHT+IHmoAnjMd09Wlv6UL5QKa6QxWL7QFhCXyeHDXlfoY9FtEuKDfIaCrjFq4GlMUJN9085xhFmBcBtaf0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:f508:0:b0:5f7:9783:12ed with SMTP id
 w8-20020a63f508000000b005f7978312edmr49147pgh.10.1714434394810; Mon, 29 Apr
 2024 16:46:34 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:46:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429234610.191144-1-edliaw@google.com>
Subject: [PATCH] selftests/kcmp: Remove unused open mode
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Cyrill Gorcunov <gorcunov@openvz.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"

Android bionic warns that open modes are ignored if O_CREAT or O_TMPFILE
aren't specified.  The permissions for the file are set above:

	fd1 = open(kpath, O_RDWR | O_CREAT | O_TRUNC, 0644);

Fixes: d97b46a64674 ("syscalls, x86: add __NR_kcmp syscall")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 25110c7c0b3e..d7a8e321bb16 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 		ksft_print_header();
 		ksft_set_plan(3);
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
-- 
2.44.0.769.g3c40516874-goog


