Return-Path: <linux-kernel+bounces-166882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362028BA153
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79265B210DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF98180A76;
	Thu,  2 May 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Jmwqb1"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63315B988
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680339; cv=none; b=JB3tnkVAX5DEdaLdAWcBT/mdCRFvQdkna29A5rQDGfrFjkdl5ftd9T8PQsOLWn+oGXol4z9FQ1mdZ8KywbqGYpbsUcRXFGrpaJhmSKlqji3fkqR4VGps+5ah1xmcO2f4FJ+SAFnBXdFoKocnnpMfN9820b5DMOz9gWKL8nNiw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680339; c=relaxed/simple;
	bh=43xhqax5OZB+fNG79cNPTmNdh2hsFr0p9Q/znbpjzTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEoVEuBxf6ekGNCsRL+CG7pO7cOge/9ykq2QC2wGDMxasO+ziyK0fF8V+wL/2NMjgziuyOvKBB2/JPcrKlHrmYUtLlsh8lWbcsCmsqV62NmZ0bG//iwSRYmWpuEcfmBhl+JUS2jbAesknTz4nxSymA7RMyrlB3NyHb4B5kDyJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Jmwqb1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792639cf4faso195585885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680337; x=1715285137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM/vla2dxQKMUSw2Hu/aYlIc+yYWbZoBCg5kXLpyiBw=;
        b=W3Jmwqb1WPFeHFk6wav9RSEul6/ynyxNd+/R/5vL9qJygFXUiGoj+nvLhw6NMHb/QZ
         9g3jmT0zSC43ciLxwXqy2u0plZCQY6O+RiXSjB9HEzYgS0RbBzAHBqi6asBw8PYIF1ZH
         XCPrtK5PRmZf1leHdwL10d97eMb1SOcicgJntwER2Cvs+sfb69wf3ue3sshCSBk5/8RM
         8naAzhPBvDceQ66kWL3uEX1+wFsjGNHsrJBcsNzhB+zxydKKE6WlUMQdfX4ZkyHJ7uIx
         Uf5eVZh8AZP7dpjJ81aWUQp05cWdlgmjpsoRb4UuOJ9VrRPeN+afI9g5CqNmS9hBh2/p
         MrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680337; x=1715285137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM/vla2dxQKMUSw2Hu/aYlIc+yYWbZoBCg5kXLpyiBw=;
        b=J7PbSX+SGghYhYcyB4D5JxpSJfuDVH02dOKoxJ3WmhZ4uDfZlrh9RMH/4wDEbGuBN/
         9I+7wTKo9tJm7Sfef4TDi5N2lROaMIiSh25eND2gwA+1QlpwxT5SaqemGIoi9qJTmt9l
         /iVl83oF086e1LA5CjfErkLDyaVYQv8tdP6SQv3J3U7RUA/SkK20ps4M2/XAEH9o/M+9
         sa4COREAlyG4OBUBo93pURcQyVdvfvu0InrGZaBcCiCSvzqx10/yQZYjHbnybR4u1McY
         uWgXObCH64dJR0kfqYow1VIdm0HQ9ycbpfzGro1RjTi+9V2tOTPELPfKMP7XYNW9pd8P
         tiiw==
X-Forwarded-Encrypted: i=1; AJvYcCWV/ZfWJGkdt4hgIm+X5VABZiQ0Bg+FmD6/757E7Empgzda+iHgCi1rnR8UQJ8M/YBZmUwdESlwMgiKNaoJxumbBv4Ra0gZ17QaoIp8
X-Gm-Message-State: AOJu0Yy85SJtwC2O/mfAN72ThN678TGVgmpQ6NnKZXSX3MVnYhAd9FxT
	j63ZC0EMluu0r22nOnNp0hsaklpBTpbXwIbHLfB8RdNxUXgHUfxU
X-Google-Smtp-Source: AGHT+IHriX+Yiyt/muskxjaMdMha9ZOSNIyPPbfjFb2jD3KqX+4rRRCz8S4iDuRLmA5Qlwe8bvsQUQ==
X-Received: by 2002:a05:620a:5590:b0:790:605f:43c4 with SMTP id vq16-20020a05620a559000b00790605f43c4mr701919qkn.61.1714680336592;
        Thu, 02 May 2024 13:05:36 -0700 (PDT)
Received: from localhost (fwdproxy-nao-119.fbsv.net. [2a03:2880:23ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id a2-20020a05620a102200b0078ee7bad7a2sm628436qkk.3.2024.05.02.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:05:36 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 0/1] cgroup: remove redundant addition of memory controller
Date: Thu,  2 May 2024 21:04:25 +0100
Message-ID: <20240502200529.4193651-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory controller is already added in main which invokes
the test, hence this does not need to be done in
test_no_kmem_bypass.

v1 -> v2:
- Add more description to commit message.

Usama Arif (1):
  selftests: cgroup: remove redundant addition of memory controller

 tools/testing/selftests/cgroup/test_zswap.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.43.0


