Return-Path: <linux-kernel+bounces-147006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9C8A6E24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC59D1C22986
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FB1311A0;
	Tue, 16 Apr 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHFs35ra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D1128805;
	Tue, 16 Apr 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277406; cv=none; b=CgF+FesKF4J4LRL0x3zh6QuQeFSKbwyQT97K+KALjtuZdLAv6L2a3XHd6gNTGiZ0FR/ocM/U1YIyhdYCriSN9ZCUsb/F8lHeNsFwvMNDdnK8MOMZ8g0zkLb7EiaPdC2HRNU6WLNkuf3XwKc2IHrnvpUeruSvHxOVqGsd8DvjoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277406; c=relaxed/simple;
	bh=58RkNN441ASwLnkSEKiz2PfX3QCesXCmqb6Tn1mJXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0DTgvcoAX9VrfzFcc4CUv9z1IXkn56FKDE6Kv04YhI4guEMZGWLVlna4OV9YN5GUuc5c9bYxKv457ueJ291njFeaf5CH4lGRtulaOiT4aQv3tc0YzO67+1feOt7XuFm554sO4jD96U87XlvlWwFjQ+2FNqjzNRPMwsXkUDKfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHFs35ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30198C113CE;
	Tue, 16 Apr 2024 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277404;
	bh=58RkNN441ASwLnkSEKiz2PfX3QCesXCmqb6Tn1mJXoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHFs35rafTRXGYB4DLjWfm2CAQJyChKJAeupgqZBMrcpVrfd1mltGOXTkkgC/Ekkd
	 vHH9B8qVs07tISfP3i4gZ/Gnv30Mi5XEHVkxznVlyjsPPbMUerEFWkAoKZSws5kIzT
	 5T7Q+JYK9EIeVxhkclIE53jfTRsyzFtZcZWLrHV9MaQaER4b2kz+5gkjCKr/h2P4ur
	 VZ8Xr04JSd9Ay+sqPosrNrrnEYXPvt5Ycu/i4cCDTLEcc7pg2LgKezFw2x4HWdbzAf
	 WgYU9vl8Gm7lkb3hF3Qpxhl+L3Xfw0mp+F6QsgvJ14kXOXj7o3HWhyjlykx99u2KoR
	 fjUU/7zEuJJJA==
Date: Tue, 16 Apr 2024 11:23:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf annotate-data: Improve debug message with
 location info
Message-ID: <Zh6J2WHVBHV7fXE6@x1>
References: <20240412183310.2518474-1-namhyung@kernel.org>
 <20240412183310.2518474-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412183310.2518474-2-namhyung@kernel.org>

On Fri, Apr 12, 2024 at 11:33:07AM -0700, Namhyung Kim wrote:
> To verify it found the correct variable, let's add the location
> expression to the debug message.

Added the patch below, following your existing convention of casting
Dwarf_Offset/Darf_Word to long.

- Arnaldo

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c6eb5b2cc4d50d79..e53d66c46c540b75 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -110,24 +110,24 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
 			break;
 		case DW_OP_breg0 ...DW_OP_breg31:
 			pr_info("base=reg%d, offset=%#lx\n",
-				ops->atom - DW_OP_breg0, ops->number);
+				ops->atom - DW_OP_breg0, (long)ops->number);
 			break;
 		case DW_OP_regx:
-			pr_info("reg%ld\n", ops->number);
+			pr_info("reg%ld\n", (long)ops->number);
 			break;
 		case DW_OP_bregx:
 			pr_info("base=reg%ld, offset=%#lx\n",
-				ops->number, ops->number2);
+				(long)ops->number, (long)ops->number2);
 			break;
 		case DW_OP_fbreg:
-			pr_info("use frame base, offset=%#lx\n", ops->number);
+			pr_info("use frame base, offset=%#lx\n", (long)ops->number);
 			break;
 		case DW_OP_addr:
-			pr_info("address=%#lx\n", ops->number);
+			pr_info("address=%#lx\n", (long)ops->number);
 			break;
 		default:
 			pr_info("unknown: code=%#x, number=%#lx\n",
-				ops->atom, ops->number);
+				ops->atom, (long)ops->number);
 			break;
 		}
 		break;

