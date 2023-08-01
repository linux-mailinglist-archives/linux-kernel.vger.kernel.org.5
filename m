Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEAF76A58A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHAAaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjHAAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA01716;
        Mon, 31 Jul 2023 17:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F33461373;
        Tue,  1 Aug 2023 00:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C069C433C8;
        Tue,  1 Aug 2023 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690849801;
        bh=6A/vRRp/3F+Q+LhbyAwBQLAhY9o/XYm4IbcM19KIrqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QxciWeuDZaxQzAOsOd3KTAutoDjqb2mqR1+Lrq9qTOP2OxV1YmqmKLzJJItoBa6WS
         ve8C9eVHuEKqiMSF453SGb8Z1zSxfr/R6kKlZXPj7q+tcKf5Xk8xIKSYhcISdO6ugZ
         +W/qF/L41cgzzfp2x3X8R/KZ2mI/iPfs1QimNKmP11o1km6X9QeMmI89gmbj7O4KiE
         H6doIxXz35VeAjnE3YVZ9YABFc7dy5sEKUMfdx3Wdz00+x/7eJMMDqMYRtyJmBO9ja
         bnhmS3C8uyfj8MdoDf+i+RNMIWVAVYkk7yZpis4Wp2BkF1yUWHf8so6SFxufYYq4Xc
         zFVcQCel2M3mw==
Date:   Tue, 1 Aug 2023 09:29:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Georg =?UTF-8?B?TcO8bGxlcg==?= <georgmueller@gmx.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: skip test_uprobe_from_different_cu if there
 is no gcc
Message-Id: <20230801092956.f03cd462fcf4939523ed4726@kernel.org>
In-Reply-To: <4085b352-f5e8-c0e8-42cf-7a6ecf23282f@gmx.net>
References: <20230728151812.454806-2-georgmueller@gmx.net>
        <20230729093814.d48a7b4fb51fdd74ad50ba42@kernel.org>
        <4085b352-f5e8-c0e8-42cf-7a6ecf23282f@gmx.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 12:59:50 +0200
Georg Müller <georgmueller@gmx.net> wrote:

> 
> Am 29.07.23 um 02:38 schrieb Masami Hiramatsu (Google):
> >
> > Interesting, so clang will not generate DWARF or perf probe is not able to
> > handle clang generated DWARF?
> >
> 
> clang does not accept mixed -flto and non-lto CUs and the problem is not
> reproducible by this sample code using clang if using -flto for all CUs.
> There might be (bigger?) examples where the same issue is triggered by
> clang and bigger examples (like systemd on fedora) where I ran into the
> bug, but this small example only shows the problem when using gcc and
> mixing -flto and non-lto CUs.

Thanks for the explanation! So the problem will be in the compiler side
(and maybe fixed when it is updated.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
