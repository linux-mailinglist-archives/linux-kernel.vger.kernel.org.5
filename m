Return-Path: <linux-kernel+bounces-65129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CF854866
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2041F23F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831B199BE;
	Wed, 14 Feb 2024 11:31:46 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06321946C;
	Wed, 14 Feb 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910305; cv=none; b=kWrYOudJah+6voVZ71qyBxhydtCcXtrjrUYXNjYKcxH0toQb3miES3Meh6TjgnNQ3Z/qWwnI6bHIi02u3Ylu/oVt23w8Lr1ct6j38cF13WWMH+LE5KUXn6DyjSAyBzP7R+LxKDAX2furPP/IJrWqNMp5uKTH2t6rkQPm5dIE2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910305; c=relaxed/simple;
	bh=aA0v41Fy4FPPkbpbsVHTm7iflrURNRSRGkKW/fkpDsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r5zeh584L5auL48DHZiKzqNIBD0Z6haQ5VabSLvKzbQP8sHwQkNhEC5uWo1f2tVlkPHkeqDT+kGiehBwtMgVPY6PWvgFu5AJSOjlWmp50ZAVltvwbclpLLAM76NIyGEbrFlETsxJMR8DWwV9UbeiWMOZNeYAYToG3J2QzUT5eSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZbBf69lYz9y61k;
	Wed, 14 Feb 2024 19:12:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DA080140732;
	Wed, 14 Feb 2024 19:31:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rl8pMxlwo99Ag--.51308S2;
	Wed, 14 Feb 2024 12:31:23 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 0/5] Introduce SandBox Mode (SBM)
Date: Wed, 14 Feb 2024 12:30:30 +0100
Message-Id: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAn0Rl8pMxlwo99Ag--.51308S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF17ZF47Gry8XF1kXwb_yoW8Wr4Dp3
	Z3tF1Fg3Z8tFy2y3yfJ3WrCa4Sy3yxCr43GFnrXryYyFyavr1kAFnaqr12qFyrurWxKayY
	qw1Fkr18Kw1UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
	6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JU7CzZUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

The ultimate goal of SandBox Mode is to execute native kernel code
in an environment which permits memory access only to predefined
addresses, so potential vulnerabilities cannot be exploited or will
have no impact on the rest of the kernel.

This patch series adds the API and arch-independent infrastructure
of SandBox Mode to the kernel. It runs the target function on a
vmalloc()'ed copy of all input and output data. This alone prevents
some out-of-bounds accesses thanks to guard pages.

Patch 4/5 adds KUnit tests. It is also a good starting point to
understand how SandBox Mode is supposed to be used.

Detailed description of SandBox Mode goals, usage and future plans
can be found in patch 5/5 of this series and is not repeated in
this cover letter.

Petr Tesarik (5):
  sbm: SandBox Mode core data types and functions
  sbm: sandbox input and output buffers
  sbm: call helpers and thunks
  sbm: SandBox Mode KUnit test suite
  sbm: SandBox Mode documentation

 Documentation/security/index.rst        |   1 +
 Documentation/security/sandbox-mode.rst | 180 ++++++
 include/linux/sbm.h                     | 516 +++++++++++++++++
 init/Kconfig                            |   2 +
 kernel/Kconfig.sbm                      |  43 ++
 kernel/Makefile                         |   2 +
 kernel/sbm.c                            | 133 +++++
 kernel/sbm_test.c                       | 735 ++++++++++++++++++++++++
 8 files changed, 1612 insertions(+)
 create mode 100644 Documentation/security/sandbox-mode.rst
 create mode 100644 include/linux/sbm.h
 create mode 100644 kernel/Kconfig.sbm
 create mode 100644 kernel/sbm.c
 create mode 100644 kernel/sbm_test.c

-- 
2.34.1


