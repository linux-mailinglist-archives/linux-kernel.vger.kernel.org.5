Return-Path: <linux-kernel+bounces-165346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FFF8B8B92
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3E51F22AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5212F58D;
	Wed,  1 May 2024 13:59:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63712F583;
	Wed,  1 May 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571962; cv=none; b=kJt9iFipJXWHqmn+oqWkDEbRxY3mScti3kQMCc5KhUms/QxkrOME23+wX/N6pricbAY6w0p4FkBn9QtyK2Drw0k/w4+59LOjq/ogfm9P1wWbV3RXA/BZuS1n4hi12VHFM6sC7zBU+C28ddjRbsfQOZfbfiuLvyaCYqhjfmBmFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571962; c=relaxed/simple;
	bh=kh+yXs/vps5ZxI7eRsLo2rWdX2HrIuuYfU3JQKjNXQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dXY+d51shnDq4eRjGFe1enssDmSm2+tQZrWQSSTw1eIXFBXp9QgzOe6JRuwJglxMRfY7spUdllv8Sg1GNZlC/ncPLVE9fNvnZbsnH5JlfSuZtjAtq7ovc8E6BzlcDPIlfQ+Qc2sHgIW2hfRltIHaGHEn1Gy2PF/7hZoyhQ7rqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1483A2F4;
	Wed,  1 May 2024 06:59:45 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D8ED3F71E;
	Wed,  1 May 2024 06:59:16 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	coresight@lists.linaro.org,
	leo.yan@linux.dev,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] perf cs-etm: Improve version detection and error reporting
Date: Wed,  1 May 2024 14:57:50 +0100
Message-Id: <20240501135753.508022-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
  * Add a commit to use struct perf_cpu in place of some of the ints
  * Add a commit to remove repeated fetches of the ETM PMU

James Clark (3):
  perf cs-etm: Use struct perf_cpu as much as possible
  perf cs-etm: Remove repeated fetches of the ETM PMU
  perf cs-etm: Improve version detection and error reporting

 tools/perf/arch/arm/util/cs-etm.c | 287 +++++++++++++++---------------
 1 file changed, 139 insertions(+), 148 deletions(-)

-- 
2.34.1


