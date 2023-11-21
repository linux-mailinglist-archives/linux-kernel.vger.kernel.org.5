Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1FB7F2D39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjKUMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKUMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:32:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EC92
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:32:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFEC433C8;
        Tue, 21 Nov 2023 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700569961;
        bh=zGnoedvglamEbp32UJfoHImXoP4xUfJaqjgMd05AtNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwulOFOw54sw8cq8gtxbQvDcUCh068vF14yB5jDdYBcQp1hb1PqQWzqYBFNRD32eY
         RqWYoFAprQ8Lrb3ZnkVhBFbFGzXceKyyAbiCVn6ip+xpaqfEmg+wYQqUiVspW3Ts7s
         sdP7xyh6jFZDfBj2TnyhpM+qkY3+ZKm3M6j+yz/e+rN7/6O/7oEN35JSleWCt5flN+
         X3gpDII1rTjMuYHidqggpjkik4y+sjp8+Cxe7PMLOIuAfeGr5ZB1mDLbN8Tb1Oukso
         wEs2jHS+G9XtydMJlZmY6FIsweNXCpNCLCtenO5JLZkVmlQv65hi+0XjquesLBTf6E
         yPv6i6/yRi8qA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2AD340094; Tue, 21 Nov 2023 09:32:38 -0300 (-03)
Date:   Tue, 21 Nov 2023 09:32:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     vmolnaro@redhat.com
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        mpetlan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test record.sh: Raise limit of open file descriptors
Message-ID: <ZVyjZjPCXVmGGVFk@kernel.org>
References: <20231115140522.28200-1-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115140522.28200-1-vmolnaro@redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 15, 2023 at 03:05:22PM +0100, vmolnaro@redhat.com escreveu:
> From: Veronika Molnarova <vmolnaro@redhat.com>
 
> Subtest for system-wide record with '--threads' option fails due to a
> limit of open file descriptors(usually set to 1024) on systems with
> 128 and more CPUs.
> 
> If the default limit is set lower than 2048 file descriptors,
> temporarily raise it to this value for the test.

Can we instead raise it to a multiple of the number of CPUs? Using:

[acme@five ~]$ getconf _NPROCESSORS_ONLN
32
[acme@five ~]$

If you tested 2048 is ok for a 128 CPU system, then maybe this is more
future proof:

[acme@five ~]$ echo $(($(getconf _NPROCESSORS_ONLN) * 16))
512
[acme@five ~]$ echo $((128 * 16))
2048
[acme@five ~]$

- Arnaldo
 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/shell/record.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 4fbc74805d52..c6c43263809a 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -11,6 +11,8 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog="perf test -w thloop"
>  testsym="test_loop"
> +min_fd_limit=2048
> +default_fd_limit=$(ulimit -n)
>  
>  cleanup() {
>    rm -rf "${perfdata}"
> @@ -154,10 +156,16 @@ test_workload() {
>    echo "Basic target workload test [Success]"
>  }
>  
> +if [[ $default_fd_limit -lt $min_fd_limit ]]; then
> +	ulimit -n $min_fd_limit
> +fi
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
>  
> +ulimit -n $default_fd_limit
> +
>  cleanup
>  exit $err
> -- 
> 2.41.0
