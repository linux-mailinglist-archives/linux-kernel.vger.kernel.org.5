Return-Path: <linux-kernel+bounces-126495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253178938A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A287C281A92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AFB671;
	Mon,  1 Apr 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hXhTFi3Q"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8653BE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956741; cv=none; b=mOzwlcNXtFST1Ojatjd9NkLMtulKCQ9YNip20vDHjGDQvqm02+mHzn6XxJa2QNpi3123/sXZb744AXBLlTyctkekhASTymb8bWJdv9XvKeRlU1Jmaf2Loj+nu/3Da2w+6DtHFbz2VO95sPPP9UM4przQwe2RGWWKZbMv2Vy+ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956741; c=relaxed/simple;
	bh=oIq/k7QSNY4VXE5qTIzdmpP02YxKDabeCib0tznAHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1hLLeDXHPg4UL6EjB8eNmjbgD77/Y5aCwrAGELxxc0sdcs5vYlfcUODuoMGnCApyCv3m9UjG2vpDKBw/8lp8RWQYWfJUcx+SKet6VyHYtbeapM34m3UAJLmcRiZZxFbblasbqw/lVl/hskW5L1vLXKQiBPDEiTBQa5wAdcxmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hXhTFi3Q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 075BB411BD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711956729;
	bh=QCCLiPNOxpS2FShA4qPYs8euISrDLAWIFv7k+ZCMiCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=hXhTFi3QEJzAAq4+Q42iXVRbDjuUr/mcoJdGfca7tu7AvTYuvFNQ5yRsATV8VyZU2
	 27DYTuGPWVOMDrj9nyNWjbdQqlguzUafAm/Corz/FsgY/MvSgdjesT7s2xz764VJgq
	 Dx/FMWpGCzxnlMVQq2IGfSLzo84d2OUwBW7xdLNmA3BoPhjy/ZdytNReWW3jAomc/5
	 zDhfUTlyiY802lfGypKVopHcREW94BnQueD1Ne7YT6HpXnESwNQ3t3A62m9t6nLyjE
	 6n+T0bPWJckvb5nS3gO5KVPIx7R1PpjLSp4bxxISS8SizkFiuf+WNywjWPjXhLA3rA
	 VxPf+nwgmA+hQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-568728e521bso3893211a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956728; x=1712561528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCCLiPNOxpS2FShA4qPYs8euISrDLAWIFv7k+ZCMiCE=;
        b=KABXNcOGKHJLhVBFTVJUwB/MWvOgd8PvezhApEXxsnBbKp0GhT1ENvtZ+Gvn99Adoi
         iyNph4UqK/WdA2N9IhsZjjbzXmhzjl3Q8ITJtfXnbIoUP8WoN81P9OxmV/Z/MpK9H9Qv
         e8z6Qs9EPx5Ev/vOQ7EPhFJZa0Uhs+0tYrTneCGxxoY4+oXQYL4uc+Uj955r033fCh7y
         cRDPjgRPk8RU9wasBgW9WO2Q8P2si4o8GUzJnOLYcWpMS7hDNY9WfzXuT0MM3dNbBdBK
         NurJn/2AoqUbwGAFRYMvzalXnnAN0XQ782fvcxeF8wv0kOqpkVZWm/D6UAsAR9b1Qrcz
         /cfA==
X-Forwarded-Encrypted: i=1; AJvYcCXSXdSN2M7FE2vgjBtb94HiViff7qrNA3bd6HwKH0rdQuv1MSKxDJFoJU0FfgD2pmjeseQOFUUSXiSCtrAfNJwY2+RoSZnNRL/YAE9C
X-Gm-Message-State: AOJu0Yw0jVAZlqVaYyCDt6FT/M0LKieC0zo1X+/HBXSsZHZt2qpSd0Tj
	O8xtBDb63leErO/JrTIUEqrTY3y11UxUOyhE9kVv574RaxwFgN/OJhSHekxO9QnKysS13wPf6B4
	vUE7iYRhOVCxkml7xCftpkl7hwq20jYp70ak9nPQZle2Ocn1+n6fb9AGw8Bba2TM3VslLcgRs6O
	rvvw==
X-Received: by 2002:a50:a697:0:b0:56b:d212:b032 with SMTP id e23-20020a50a697000000b0056bd212b032mr5327016edc.14.1711956728197;
        Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh1G5/18x8uzGzn6AJKqdUge4eitCIl9bM5TJUhmqS8MyIFBBJ6d0fq1am5zXZmHiXsXlg7A==
X-Received: by 2002:a50:a697:0:b0:56b:d212:b032 with SMTP id e23-20020a50a697000000b0056bd212b032mr5326998edc.14.1711956727672;
        Mon, 01 Apr 2024 00:32:07 -0700 (PDT)
Received: from localhost.localdomain (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b0056b2c5c58d2sm5096511edy.21.2024.04.01.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:32:07 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] libbpf: API to partially consume items from ringbuffer
Date: Mon,  1 Apr 2024 09:19:00 +0200
Message-ID: <20240401073159.16668-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ring__consume_max() and ring_buffer__consume_max() API to
partially consume items from one (or more) ringbuffer(s).

This can be useful, for example, to consume just a single item or when
we need to copy multiple items to a limited user-space buffer from the
ringbuffer callback.

Practical example (where this API can be used):
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

See also:
https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (2):
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_max / ring_buffer__consume_max

 tools/lib/bpf/libbpf.h   | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-------------

