Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5777D106
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjHORaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbjHORaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E624D1BD7;
        Tue, 15 Aug 2023 10:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B71866220A;
        Tue, 15 Aug 2023 17:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D96C433C8;
        Tue, 15 Aug 2023 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692120622;
        bh=xOZG1e26MXbNqXpqBlxuhCoDrHndmdyQG2THAK8ymSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/Phv3nTF7aTIHbAo4/7UwXSgkuWnYlZvJk8EjjYeoSIyMJBxCKmJUDssdhSKi7c8
         4VT3QOY2B1gKkC6KB9pDEuaeRmbLgfM1gzj+eO4gDJan0lMNHgaavlfQ0zg90c97+/
         z1Jq75/vKASjMsmSb7oLlg5HMb/2meeLSBYK0LFxIj7mUguYqNXUAmm+rXY/6V+IvN
         Jeq0Cd8kHInDHnPRXxkXnPFT/3KwyTAycOfas807Rw0uq9GyRIyXnQ8ixZEDdQYlb7
         7yrZSSOytP36kvxkcoYV5AUi3mGXD+Mq3+59E/KC6x6U5LVehIWXulYNtIQzVlOz2e
         cpmEqmPhe+mCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C56B404DF; Tue, 15 Aug 2023 14:30:18 -0300 (-03)
Date:   Tue, 15 Aug 2023 14:30:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test: Add perf record sample filtering test
Message-ID: <ZNu2KrbgFPY69K2+@kernel.org>
References: <20230811025822.3859771-1-namhyung@kernel.org>
 <20230811025822.3859771-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811025822.3859771-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 10, 2023 at 07:58:22PM -0700, Namhyung Kim escreveu:
>   $ sudo ./perf test 'sample filter' -v
>    94: perf record sample filtering (by BPF) tests                     :
>   --- start ---
>   test child forked, pid 3817527
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Error: task-clock event does not have PERF_SAMPLE_CPU
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Error: task-clock event does not have PERF_SAMPLE_CPU
>   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
>   Group bpf-filter test [Success]
>   test child finished with 0
>   ---- end ----
>   perf record sample filtering (by BPF) tests: Ok

[root@five ~]# perf test -v "by BPF"
 91: perf record sample filtering (by BPF) tests                     :
--- start ---
test child forked, pid 64165
Checking BPF-filter privilege
Basic bpf-filter test
 ffffffff97f4f688
 ffffffff97f73859
 ffffffff97412ce6
 ffffffff976da215
 ffffffff973a92bf
 ffffffff97376ad7
 ffffffff97f73859
 ffffffff97f7400c
 ffffffff97365116
 ffffffff97f73859
 ffffffff97f5320c
 ffffffff973ea351
 ffffffff97143774
 ffffffff9740f730
 ffffffff9736944f
 ffffffff973e593d
 ffffffff976e36c8
 ffffffffc12cf19b
 ffffffff976c79d5
 ffffffff9737d254
 ffffffff9737d254
 ffffffff9737d254
 ffffffff9737d254
 ffffffff9737d254
 ffffffff9737ca5f
 ffffffff9737d254
 ffffffff9737d254
 ffffffff9737d339
 ffffffff9737dcf3
 ffffffff9737dcf3
 ffffffff9737d254
 ffffffff973e442a
 ffffffff973713b8
 ffffffff973ea561
 ffffffff973712ee
 ffffffff973713b8
 ffffffff973713b8
 ffffffff973e43fa
 ffffffff971fa17e
 ffffffff971fa17e
 ffffffff973ac8ee
 ffffffff97f73859
 ffffffff9741082c
 ffffffff973ea34a
 ffffffff974148c6
 ffffffff974c97d5
 ffffffff97394b51
 ffffffff973916af
 ffffffff9737b5e3
 ffffffff976cf825
 ffffffff9737c58d
 ffffffff9788ab15
 ffffffff9732af89
 ffffffff97096ef3
 ffffffff973e92fd
 ffffffff9730a991
 ffffffff9739e2c5
 ffffffff9731cdc2
 ffffffff97f363c4
 ffffffff97f3915c
 ffffffff97f5d754
 ffffffff9718a181
 ffffffff9709b1a5
 ffffffff973710e4
 ffffffff97f52b27
 ffffffff9738b905
 ffffffff971fdca5
 ffffffff9737dbc4
 ffffffff971b4e04
Basic bpf-filter test [Failed invalid output]
test child finished with -1
---- end ----
perf record sample filtering (by BPF) tests: FAILED!
[root@five ~]#

[root@five ~]# uname -a
Linux five 6.2.15-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 11 16:51:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]# 
 
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record_bpf_filter.sh | 128 ++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_bpf_filter.sh
> 
> diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
> new file mode 100755
> index 000000000000..e76ea861b92c
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_bpf_filter.sh
> @@ -0,0 +1,128 @@
> +#!/bin/sh
> +# perf record sample filtering (by BPF) tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_bpf_filter_priv() {
> +  echo "Checking BPF-filter privilege"
> +
> +  if [ "$(id -u)" != 0 ]
> +  then
> +    echo "bpf-filter test [Skipped permission]"
> +    err=2
> +    return
> +  fi
> +  if ! perf record -e task-clock --filter 'period > 1' \
> +	  -o /dev/null --quiet true 2>&1
> +  then
> +    echo "bpf-filter test [Skipped missing BPF support]"
> +    err=2
> +    return
> +  fi
> +}
> +
> +test_bpf_filter_basic() {
> +  echo "Basic bpf-filter test"
> +
> +  if ! perf record -e task-clock -c 10000 --filter 'ip < 0xffffffff00000000' \
> +	  -o "${perfdata}" true 2> /dev/null
> +  then
> +    echo "Basic bpf-filter test [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" -F ip | grep 'ffffffff[0-9a-f]*'
> +  then
> +    echo "Basic bpf-filter test [Failed invalid output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic bpf-filter test [Success]"
> +}
> +
> +test_bpf_filter_fail() {
> +  echo "Failing bpf-filter test"
> +
> +  # 'cpu' requires PERF_SAMPLE_CPU flag
> +  if ! perf record -e task-clock --filter 'cpu > 0' \
> +	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
> +  then
> +    echo "Failing bpf-filter test [Failed forbidden CPU]"
> +    err=1
> +    return
> +  fi
> +
> +  if ! perf record --sample-cpu -e task-clock --filter 'cpu > 0' \
> +	  -o /dev/null true 2>/dev/null
> +  then
> +    echo "Failing bpf-filter test [Failed should succeed]"
> +    err=1
> +    return
> +  fi
> +
> +  echo "Failing bpf-filter test [Success]"
> +}
> +
> +test_bpf_filter_group() {
> +  echo "Group bpf-filter test"
> +
> +  if ! perf record -e task-clock --filter 'period > 1000 || ip > 0' \
> +	  -o /dev/null true 2>/dev/null
> +  then
> +    echo "Group bpf-filter test [Failed should succeed]"
> +    err=1
> +    return
> +  fi
> +
> +  if ! perf record -e task-clock --filter 'cpu > 0 || ip > 0' \
> +	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
> +  then
> +    echo "Group bpf-filter test [Failed forbidden CPU]"
> +    err=1
> +    return
> +  fi
> +
> +  if ! perf record -e task-clock --filter 'period > 0 || code_pgsz > 4096' \
> +	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CODE_PAGE_SIZE
> +  then
> +    echo "Group bpf-filter test [Failed forbidden CODE_PAGE_SIZE]"
> +    err=1
> +    return
> +  fi
> +
> +  echo "Group bpf-filter test [Success]"
> +}
> +
> +
> +test_bpf_filter_priv
> +
> +if [ $err = 0 ]; then
> +  test_bpf_filter_basic
> +fi
> +
> +if [ $err = 0 ]; then
> +  test_bpf_filter_fail
> +fi
> +
> +if [ $err = 0 ]; then
> +  test_bpf_filter_group
> +fi
> +
> +cleanup
> +exit $err
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

-- 

- Arnaldo
