Return-Path: <linux-kernel+bounces-92350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FCA871EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B481C2346C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A495A4D5;
	Tue,  5 Mar 2024 12:20:21 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAC59B5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641220; cv=none; b=YNFelL7wLkuUB/5oS2pdo6gm104ti5dZbUzzjamEI03ZCTZXIFsgTyXkTiUOaJgvNSs7qGTURcAPvoGqwF1qDYCyiQp90Pm/lfMHS5JdBohgoyyDj0BSa05PD2+aDJ35CwHfv08inIE22NZ918VoEVY3VwLprFpvo+I489yWJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641220; c=relaxed/simple;
	bh=gERqFyVIZ0ok10zI/NbW8mp+jooEwAimGGK020xNwzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0TuiF8jU9ZoG2d5/T5GxZdz1KpF/t0SlrlmQBkQJGmQj+BJeQMBgpVwozPLZQmf/qynEuTJp0YyoHz13rMsmGsLXEeZKxCyeOv+ArxejX3bHVpy7QAGzyxycz6LuRsQUs0rUmctq8rbpAZLYms5i479wbvgHjEcUQ8OnZIvcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 425C5f0I023277
	for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2024 20:05:41 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 425C5Vpx023254;
	Tue, 5 Mar 2024 20:05:31 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Mar 2024
 20:05:26 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <dylan@andestech.com>, <tim609@andestech.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>
Subject: [PATCH 0/2] Fix the warnings in the 32-bit platform
Date: Tue, 5 Mar 2024 20:04:59 +0800
Message-ID: <20240305120501.1785084-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 425C5f0I023277

This series fix two incompatible type warnings when building perf in the 
32-bit platform. 

Ben Zong-You Xie (2):
  perf daemon: Fix the warning about time_t
  perf riscv: Fix the warning due to the incompatible type

 tools/perf/arch/riscv/util/header.c | 2 +-
 tools/perf/builtin-daemon.c         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1


