Return-Path: <linux-kernel+bounces-31435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7118832E52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F11F258DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F221255E73;
	Fri, 19 Jan 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgpYOQSU"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270F55C05;
	Fri, 19 Jan 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686347; cv=none; b=Hhv2TQUl1U1kZHPpOWnf9+wYGDJJGcvzFUpcecbfntYgVcSdxKukvfFWpI+W6T1LjHozYrOjIRULlM6cYNM7hvpNOr+RxiMtMbQFb1iaQkrw+3yuu+wmBEhfGJJ5rGYHs3l7em2PArLlDOaJTVNo6ojgpXvkTKrNovm9IXnAQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686347; c=relaxed/simple;
	bh=uCvIEcJYYf5AbGoFG22DmOZZXGKEe8WB1ncLOJnDZs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VI5IKVhQsN1Eokp+3/DvPYWA1UUMapSHXAPglpsKMc365l/F6lM3BNMsuP97YcllCzpsjk8bMdtIbU8rwZ9ZEBtNXgYx3YK6pYx1NO8rDlRvsheNrCTFSQfmN3iW5F6TXC6kQwH0IpDRAeTByLYBuF1hjeVzptoLeQAqnpUSQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgpYOQSU; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705686345; x=1737222345;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uCvIEcJYYf5AbGoFG22DmOZZXGKEe8WB1ncLOJnDZs8=;
  b=OgpYOQSUwAWCFxwegSueH5G21LHVZhGQuPbKVV1YHWawLZ7oj5VB2ArO
   k71icSrF+nWsDKLQIHzM47KvytgRPdrb9FLjpAPr80aGLXo1jAkP5khWh
   K8Vm/PMrz/n87HeT66WLHA5SVL+rBykCl+4QUZUSzy8fGJ3XL6s0uyevP
   nE29kojJKRZI5b5aBXcbhy6cMgigDe7NQRpzE5FF+Kb1qEmTdeHV7iuph
   ZJ/iC43bHgRi/F5QFVZpehmBXvt3TA5RlcGiRoOE+0zUW3wa5V3Tf3L61
   9DG8vULwl3MJYs6HwmPSE4JW9pJSlaeB6kKVNoptNLT+xJ0jXwuGjnhGE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="431969498"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="431969498"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="908371323"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="908371323"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2024 09:45:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 2C089302B79; Fri, 19 Jan 2024 09:45:44 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Ben Gainey <ben.gainey@arm.com>
Cc: linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org,
  peterz@infradead.org,  mingo@redhat.com,  acme@kernel.org,
  mark.rutland@arm.com,  alexander.shishkin@linux.intel.com,
  jolsa@kernel.org,  namhyung@kernel.org,  irogers@google.com,
  adrian.hunter@intel.com,  james.clark@arm.com
Subject: Re: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
In-Reply-To: <20240119163924.2801678-1-ben.gainey@arm.com> (Ben Gainey's
	message of "Fri, 19 Jan 2024 16:39:23 +0000")
References: <20240119163924.2801678-1-ben.gainey@arm.com>
Date: Fri, 19 Jan 2024 09:45:44 -0800
Message-ID: <87a5p1kyif.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Gainey <ben.gainey@arm.com> writes:

> In this configuration stream ids (such as may appear in the read_format 
> field of a PERF_RECORD_SAMPLE) are no longer globally unique, rather 
> the pair of (stream id, tid) uniquely identify each event. Tools that 
> rely on this, for example to calculate a delta between samples, would 
> need updating to take this into account. Previously valid event 
> configurations (system-wide, no-inherit and so on) where each stream id 
> is the identifier are unaffected.

So is this an ABI break? It might need an optin, if it breaks anything,
which wouldn't surprise me. We do have a lot of different perf stream
parsers around these days and we cannot break them.

-Andi

