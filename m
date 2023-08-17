Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B158477F892
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351785AbjHQOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351784AbjHQOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082F19A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A518A655C3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2A2C433C8;
        Thu, 17 Aug 2023 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692281878;
        bh=Eh/ozKtbLI/HRbUnhaWUM2NDO9nyhEJKs7t13q9wfdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQqErHpfajHJW8oDJB2eiLDZg6ggwix4EOOQuVMkoNo63MOl7Y0N52bn9IumYU4Zy
         QWS2/xXQNNrGYw6y/AyfzgjuoU+R1n3JbTD+9fW7dYLUhbEHSccjE6/jmq26L6d+qW
         EvhPdN9hTlnrV95ZXDqiu2maA7XQAVfYtIAv7vrmTgah2/NZmYhQcXFmxd78f+DV55
         JwWhgjalK2xAvq1EvbZ9AxwbN2ukeVDvoPrN9ir5Tl7TrOvk3xCVIPI9yh/b2KQFmG
         2GZyN9OB0xmFG+P0vbLm7OAwJgN/EEq3FhAkvpfXwiepE0LWBRZS0euuRrPr1mMSQc
         VfxVqzVmNrBCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71608404DF; Thu, 17 Aug 2023 11:17:55 -0300 (-03)
Date:   Thu, 17 Aug 2023 11:17:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFE: perf lock contention --bpf on an RT kernel
Message-ID: <ZN4sE4eC6C61B3WE@kernel.org>
References: <ZN4nRfquIsQLx1lV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN4nRfquIsQLx1lV@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 17, 2023 at 10:57:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Namhyung, I noticed this when trying to use the BPF mode of perf lock
> contention on an RT kernel:
> 
> 
> I tried up to now the following patch, it loads, but produces no output
> :-\

To check that a BPF skel based programs works with this kernel I tried:

[root@nine perf-tools-next]# uname -a
Linux nine 5.14.0-284.18.1.rt14.303.el9_2.x86_64 #1 SMP PREEMPT_RT Wed May 31 13:18:55 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@nine perf-tools-next]# tools/bpf/runqslower/.output/runqslower 50 | head -20
Tracing run queue latency higher than 50 us
TIME     COMM             PID           LAT(us)
11:13:47 ktimers/5        60                 54
11:13:47 irq_work/5       62                124
11:13:47 ktimers/5        60                 53
11:13:47 irq_work/5       62                 88
11:13:47 swapper/0        3942               59
11:13:47 ktimers/4        52                 55
11:13:47 irq_work/4       54                102
11:13:47 swapper/0        3942               51
11:13:47 ktimers/5        60                 54
11:13:47 irq_work/5       62                 93
11:13:47 swapper/0        3942               51
11:13:47 kworker/2:2      38                141
11:13:47 swapper/4        14                 90
11:13:47 swapper/6        642               102
11:13:47 swapper/7        77                 52
11:13:47 ktimers/7        76                103
11:13:47 irq_work/7       78                 92
11:13:47 ktimers/6        68                 83
[root@nine perf-tools-next]#

- Arnaldo
