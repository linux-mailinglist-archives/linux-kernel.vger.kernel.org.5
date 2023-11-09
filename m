Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16927E7268
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjKITiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKITiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:38:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E743C01;
        Thu,  9 Nov 2023 11:38:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB46C433C7;
        Thu,  9 Nov 2023 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699558681;
        bh=W+5EFbRzSc82wWtYP28Rf+JY1o29oWZOx/AX38zMweA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojpN+zsHVHV7MsUrOxLQZleMAomXqi9fUD6vJPBHHaFF1EPyMfOIj5uxObb1aQq16
         lVlITggUlrqxgCyWFPjeMLKnvaRjusibGPqeN6Vd7oN5xY0fMsNSVVp8etGeL9n5Hu
         6FSz3Ws1jslpIjmQHYZhbvGUu27OWNNdZ+l1t3XFG646rYKK/NuQ1ZjYJqJBkjVvZJ
         TxYaaJB7mLgznprux11GmiG6ZzrTly1CQuxWf5PlW6rMoXqTYZBA+oHCuVSJjR/3Pu
         LzxDmBRN71amcgZMa7gq6C8G6QU76oO+VkyZXYt3k4XOVPPYgXJs7bH/l/8jWaekCh
         9Bdrnf7wvUTyQ==
Date:   Thu, 9 Nov 2023 11:37:59 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 09/10] unwind: Introduce SFrame user space unwinding
Message-ID: <20231109193759.6wugcdpucoilnncl@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
 <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:31:59AM -0800, Indu Bhagat wrote:
> > +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> > +	    shdr.preamble.version != SFRAME_VERSION_1 ||
> > +	    (!shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> > +	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
> > +	    shdr.fdes_off > shdr.fres_off) {
> > +		return -EINVAL;
> > +	}
> > +
> 
> I would say that it will be ideal to start the support with SFRAME_VERSION_2
> onwards, if we have a choice.
> 
> The structure SFrame FDE in SFRAME_VERSION_1 was unaligned on-disk.  We
> fixed that in SFRAME_VERSION_2 (Binutils 2.41) by adding some padding as you
> have already noted. For x86_64, its not an issue though, yes.

Agreed.  I actually had v2 implemented but then realized my binutils was
older so I changed to v1 for testing.  But yeah, we can make v2 the
minimum.

-- 
Josh
