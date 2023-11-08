Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDFF7E5FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjKHVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKHVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:31:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2611BE2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:31:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9369DC433C7;
        Wed,  8 Nov 2023 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699479069;
        bh=u6jgzAOvfO5IfdY8HzC+ARaK2eNrw+SWbTrYWqkMkzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UiHIrHHDXtSrau7d3yBq2LUkTbFuCwjCj9tZzYwp1fXLUt3WNwIOB6hzPXlYEBB4b
         Zoi7biAudiqa63ADXJw5FDgmQrnC57doUU8WYlgEfAkxDoP14+p6WL+XCTdO8Jf4Pq
         1j82tbgnaUcaI9sK4Z2Hf02ENBQJfwjfYlxwOPbGF3uUXMQmtVNs2ltkpcBWA3VHOx
         WJ41kZjYk9w+3xPUcRkT4RzXBq8ToAPDEeCRWRG6a3RFVSz03Kfkn16byyNa0inB3t
         8vl+Leyk0iF2bAZ+XnfmDELiI2kred0hyrtZ//E2lD+egw9TPPPsLKRqICAsk51o8x
         TVE/AWjkWFb4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 52C2540094; Wed,  8 Nov 2023 18:31:07 -0300 (-03)
Date:   Wed, 8 Nov 2023 18:31:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Message-ID: <ZUv+G+w5EvJgQS45@kernel.org>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
 <ZUpTtoCzJFHhnSdh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZUpTtoCzJFHhnSdh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 07, 2023 at 12:11:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 06, 2023 at 04:19:13PM -0500, Liang, Kan escreveu:
> > On 2023-11-06 4:12 p.m., Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.com e=
screveu:
> > Ian has already reviewed the tool parts.

> > But I still owe a test case for the feature. I will post a patch later.
> > https://lore.kernel.org/lkml/acbb895a-475e-4679-98fc-6b90c05a00af@linux=
=2Eintel.com/

> I saw Ian's suggestion, and agree with it, we need to pair new features
> with regression tests in 'perf test', thanks for working on it!

Kan,

	I still have to bisect, but can you check if this works for you?


(gdb) run test -F -v 27
Starting program: /root/bin/perf test -F -v 27

 27: Sample parsing                                                  :
--- start ---

Program received signal SIGSEGV, Segmentation fault.
0x00000000004e4aa6 in evsel.parse_sample ()
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-13=
=2Efc38.x86_64 cyrus-sasl-lib-2.1.28-9.fc38.x86_64 elfutils-debuginfod-clie=
nt-0.189-3.fc38.x86_64 elfutils-libelf-0.189-3.fc38.x86_64 elfutils-libs-0.=
189-3.fc38.x86_64 glib2-2.76.5-2.fc38.x86_64 glibc-2.37-13.fc38.x86_64 keyu=
tils-libs-1.6.1-6.fc38.x86_64 krb5-libs-1.21-3.fc38.x86_64 libbabeltrace-1.=
5.11-2.fc38.x86_64 libbrotli-1.0.9-11.fc38.x86_64 libcap-2.48-6.fc38.x86_64=
 libcom_err-1.46.5-4.fc38.x86_64 libcurl-8.0.1-5.fc38.x86_64 libevent-2.1.1=
2-8.fc38.x86_64 libgcc-13.2.1-4.fc38.x86_64 libidn2-2.3.4-2.fc38.x86_64 lib=
nghttp2-1.52.0-2.fc38.x86_64 libpfm-4.11.0-11.fc38.x86_64 libpsl-0.21.2-2.f=
c38.x86_64 libselinux-3.5-1.fc38.x86_64 libssh-0.10.5-1.fc38.x86_64 libstdc=
++-13.2.1-4.fc38.x86_64 libtraceevent-1.7.2-1.fc38.x86_64 libunistring1.0-1=
=2E0-1.fc38.x86_64 libunwind-1.6.2-7.fc38.x86_64 libuuid-2.38.1-4.fc38.x86_=
64 libxcrypt-4.4.36-1.fc38.x86_64 libzstd-1.5.5-1.fc38.x86_64 opencsd-1.3.3=
-1.fc38.x86_64 openldap-2.6.6-1.fc38.x86_64 openssl-libs-3.0.9-2.fc38.x86_6=
4 perl-libs-5.36.1-497.fc38.x86_64 popt-1.19-2.fc38.x86_64 python3-libs-3.1=
1.6-1.fc38.x86_64 slang-2.3.3-3.fc38.x86_64 zlib-1.2.13-3.fc38.x86_64
(gdb) bt
#0  0x00000000004e4aa6 in evsel.parse_sample ()
#1  0x00000000004b28dc in do_test ()
#2  0x00000000004b2acd in test.sample_parsing ()
#3  0x0000000000495348 in test_and_print.isra ()
#4  0x0000000000495f5d in cmd_test ()
#5  0x00000000004c2a29 in run_builtin ()
#6  0x000000000041053f in main ()
(gdb)

