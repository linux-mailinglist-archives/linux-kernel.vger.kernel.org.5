Return-Path: <linux-kernel+bounces-49722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706D846E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C061C24A25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922E13DB8B;
	Fri,  2 Feb 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVFPn7/t"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65313BEBB;
	Fri,  2 Feb 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871705; cv=none; b=XzpQujsl4rspuSnU0S9PVKwnHoWt59xwEGxU33ICik+VWEAgTnAPUqTBF4gWxMQMTYSQLUwkLOs/XzOCLSTU5WVo2Hdxl7TnBo+PlUYwS6fASslZyG5cSBOUYG5ZNNYw/5+OYIhWtdpCo9e4yy9iFbRznddyvvj0EzllsTkT8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871705; c=relaxed/simple;
	bh=dpT/iSoLMjSGJXj/TpfX1uqagxgVp8U+YtvtqG6NHgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrB1DPFkJcuzaJfhCiH3NwrhlasTs8IaF0xkQllBueTFUormEaANy1OMFwbuaFWbJoUIg16lk5FpxC4RUtoNGbqN2c3FsLI6h7JVLOrGex/V+JD8sqgu81ZCmxz3OsO4VJmiPUJgptrkQgVrskhlw7SkfmB4JkGR2C/ARAUOmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVFPn7/t; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706871703; x=1738407703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dpT/iSoLMjSGJXj/TpfX1uqagxgVp8U+YtvtqG6NHgE=;
  b=iVFPn7/tJRN3nIag6/RRheVNQGl32ynu0biv9mP1flEzl4+2D+H20FD4
   Pz+d72DutIvbx34ZYtZE7NVydD8aN1ajLFv90F/HJV7ZvNWs64k+aYtfy
   w85gsBpD2G5w0cUAd1PyoUx/JAVEoTUHyoWgwqmpNyiry1VwcutCoPydO
   6u64fiYBSTLIBiZ67qNM9xDqPq+1I0GZEjj0PCWI6XUwWa3iz88K5d13k
   hl3sl+16qgDIijKMzR3q/D/Xf0VCr6rjyuGN5i4OkmWF/Hl0RAd3Iyyf7
   z7lJ5NZVtixLjCwupx5/Ucvdj58eqTykeLN1Cuj63FKINWHjmwx+Fv4ol
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="394571882"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="394571882"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639286"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.118])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:01:40 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf symbols: Slightly improve module file executable section mappings
Date: Fri,  2 Feb 2024 13:01:28 +0200
Message-Id: <20240202110130.3553-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Currently perf does not record module section addresses except for
the .text section. In general that means perf cannot get module section
mappings correct (except for .text) when loading symbols from a kernel
module file. (Note using --kcore does not have this issue)

Here are a couple of patches to help shed light upon and slightly improve
the situation.


Adrian Hunter (2):
      perf script: Make it possible to see perf's kernel and module memory mappings
      perf symbols: Slightly improve module file executable section mappings


Regards
Adrian

