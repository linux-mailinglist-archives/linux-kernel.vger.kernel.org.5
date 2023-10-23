Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCE7D4225
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjJWV6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJWV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:58:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71810E;
        Mon, 23 Oct 2023 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698098290; x=1729634290;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=eQ4oTqW1YIBrI/iNAfG19WNteOpQMt+CUi5D2Mm2CjA=;
  b=GVe8UPUKTFZe32JoWG5AzLcFPxeCKy4Jb/3Z9Ted95b9nheSJfKNR+cP
   i/Mnm3uwvbo2R1lpDFosdTGAcn1JqBJjGCzMPxLSLJzd8UavtRS843ERz
   1nK/cCM2AcOIqRUHpS9X9ydHz2+LRRl31x6dRgbjfZMqf1vNOH+FqjxZi
   xv7+HFRmtPqaEc8szJww4h3/Yg35zaPQZzSIMySuTvuURivgNhYo46SNa
   ZJ+pC9yNcRdhHCDKL7Qdw0HvCTrbc83Ox9ucDUPVvWcCQ6ZwYF7Su9tif
   kqNsu4nijDqUFYutVZIH6o/gJt3x2eEDe8KqaT2GZBSBgvpnlNULbmWey
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367165652"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="367165652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 14:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708064639"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="708064639"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 14:58:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 04477301C7C; Mon, 23 Oct 2023 14:58:08 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
References: <20231012035111.676789-1-namhyung@kernel.org>
Date:   Mon, 23 Oct 2023 14:58:08 -0700
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org> (Namhyung Kim's
        message of "Wed, 11 Oct 2023 20:50:23 -0700")
Message-ID: <87pm15vw5r.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung Kim <namhyung@kernel.org> writes:

> Hello,
>
> I'm happy to share my work on data type profiling.  This is to associate
> PMU samples to data types they refer using DWARF debug information.  So
> basically it depends on quality of PMU events and compiler for producing
> DWARF info.  But it doesn't require any changes in the target program.
>
> As it's an early stage, I've targeted the kernel on x86 to reduce the
> amount of work but IIUC there's no fundamental blocker to apply it to
> other architectures and applications.

FWIW i posted a similar patchkit a long time ago

https://lore.kernel.org/lkml/20171128002321.2878-13-andi@firstfloor.org/

It was on my list to resurrect that, it's great that you are doing
something similar.

The latest iteration (not posted) was here:

https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git/log/?h=perf/var-resolve-7

The main difference seems to be that mine was more for perf script
(e.g. i supported PT decoding), while you are more focused on sampling.
I relied on the kprobes/uprobes engine, which unfortunately was always
quite slow and had many limitations.

Perhaps it would be possible merge the useful parts of the two approaches?

-Andi
