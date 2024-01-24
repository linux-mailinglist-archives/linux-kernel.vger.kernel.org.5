Return-Path: <linux-kernel+bounces-37093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83A83AB74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7E8294A04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765227A70F;
	Wed, 24 Jan 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0xTF22l"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40E77F09
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105708; cv=none; b=oKG2IhUSNKGvNBlkpsbqD1XqerFwiQ0//BVUW+kl3OEnZOGMYMy0adJuT9PATUwfdjiOam72YOL+x9B+Mg7NAOkG+qFnaGKPUE6wY93j8V0TRxQBs0rauQdQMIbWCEH6a00sCJc+RQJZUzopJ5ESuG9Gq19dQA3I4ig+uKB69wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105708; c=relaxed/simple;
	bh=SGkD+ZUyjCoSspeUimIEeBgNKSYYBGx6C6pkU0VbwQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+edbAC4rs0sNhd/aOnaJdW+X4ezuEYNSpv5GYxqFV1oxZCy7c2y2nBir0S8CMzPtgNnqDEHXBAlwlkMz/3Q35vGDngC86OdhM7Eq5xpsyzHcnjpjLUnahoerywkaSxO8dvVeOb2CFz3kbp/ugveMudnJCY90mWyi1SWV0uqpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0xTF22l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26fa294e56so557079566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706105705; x=1706710505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzKyb050QdFrleWlKW/ZhaMWNWbmLy+2bQKgqjbFLLk=;
        b=d0xTF22lRZWhweZsQplvvic1yjcLAGbJ3NCR7aSD8wJTOGQ0hz8rbfDmjqUBV356Po
         1ir81diUxKUGkbsAiYinGwJ8JMp6zujcKw3cJCzPE2HKQhHBFK1n6r9xKEfbaX4ilhMn
         Yu9KaQaZj+oLmhFu0OJABzqE4LNRfM385fdsPhZbaBh5GDtc7wBMYUH2/Lf1XWSrABIh
         CSfy2UfzSjFWOBVXYIQl86EZutt2iH/0I/uhzylBWuAin3UtuCYF5qq1KCPunVExebef
         0d8y4hrJA56mSSMdpxk2zX7LBTFca4w/6rBtdfLz9bBthBFNM4IrprOLHTSxdv6zPGqh
         jjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105705; x=1706710505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzKyb050QdFrleWlKW/ZhaMWNWbmLy+2bQKgqjbFLLk=;
        b=qZEiuph00ExfOjOXHrghlePGvwurGAPabaSoe+njtRSwpStxy8fgqFlDNJauZM2FQk
         xLt5CEyy50D54UthuZ3EewlwSSnhv/I7wko+/Y3WV6r/ekAv4i7K9faRZkhzzTcn7TCU
         2v3+kOfM7BSB+93xEznvGSpCkYhHhv3q5uUoXLcidroZH0BTSoM8D3SGjBXksESzgZpB
         yFxelQuC7FU6PLhiaSPRrafjGxO4DsfgN6BzOTfVhFT+Wn72l2U5D5e8c7Q3FLhYN73X
         vG9QTAgB/I597/gu0Ya5z00IF8TIHrysZpXCfTrON3KSC3K14U4gJmCB6ADsYsPoxvx7
         50Hw==
X-Gm-Message-State: AOJu0Ywit0r1c9zVKEhJq6PVMrVLJKbCjn1BUaH/Q/4a3Nd9xaVe0U1N
	Sw46zYybpv8UjncCqA3VMA4vqad4iFulh6CnxD5eZis7vTqGuYe9EHt/wTCKNOk=
X-Google-Smtp-Source: AGHT+IH4zK/XBys58NVqE2pUFAuWshd5IS9ZBG85RmnQPNi+29iksdxduVLc0w0Xw3bMXrZi8zi+/w==
X-Received: by 2002:a17:907:75e9:b0:a30:5a6a:b600 with SMTP id jz9-20020a17090775e900b00a305a6ab600mr843245ejc.141.1706105705262;
        Wed, 24 Jan 2024 06:15:05 -0800 (PST)
Received: from ttritton.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm12399097ejc.29.2024.01.24.06.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:04 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 0/3] selftests/seccomp seccomp_bpf test fixes
Date: Wed, 24 Jan 2024 14:13:54 +0000
Message-ID: <20240124141357.1243457-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Here are a few fixes for seccomp_bpf tests found when testing on 
Android:

user_notification_sibling_pid_ns:
  unshare(CLONE_NEWPID) can return EINVAL so have added a check for this.

KILL_THREAD:
  This one is a bit more Android specific. 
  In Bionic pthread_create is calling prctl, this is causing the test to 
  fail as prctl is in the filter for this test and is killed when it is 
  called. I've just changed prctl to getpid in this case.

user_notification_addfd:
  This test can fail if there are existing file descriptors when the test 
  starts. It expects the next file descriptor to always increase 
  sequentially which is not always the case.
  Added a get_next_fd function to return the next expected file descriptor.

Regards,

Terry

Terry Tritton (3):
  selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)
  selftests/seccomp: Change the syscall used in KILL_THREAD test
  selftests/seccomp: user_notification_addfd check nextfd is available

 tools/testing/selftests/seccomp/seccomp_bpf.c | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


