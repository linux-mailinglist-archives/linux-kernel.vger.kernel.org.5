Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2386B764174
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjGZVxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGZVw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:52:57 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EE1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:52:56 -0700 (PDT)
Message-ID: <d988118b-3e02-24e3-281a-cff821f7abef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690408374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bV/5zXyn83HygzV6+vhnrK/gefuxgdwL5wSx2YfGw0=;
        b=bKW5yOlfjXQvgYO+MsYPCpiBf3LO4rjc9dVdsyNb5KC1iUPGnOUn0P1F4p0t4n56dGTbrd
        FF2apvrn4mhrUKdYglRMq6ZtajjHxWbjofoU/6JFvCmohvZAXvjNcBEZ3lJNHV4MLHee4W
        zas7uyNTj1h+0433iHi7pdY1Tr8WSo8=
Date:   Wed, 26 Jul 2023 14:52:45 -0700
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for
 xdp attaching failure tracepoint
Content-Language: en-US
To:     Leon Hwang <hffilwlqm@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hawk@kernel.org, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230720155228.5708-1-hffilwlqm@gmail.com>
 <20230720155228.5708-3-hffilwlqm@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230720155228.5708-3-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 8:52 AM, Leon Hwang wrote:
> Add a test case for the tracepoint of xdp attaching failure by bpf
> tracepoint when attach XDP to a device with invalid flags option.
> 
> The bpf tracepoint retrieves error message from the tracepoint, and
> then put the error message to a perf buffer. The testing code receives
> error message from perf buffer, and then ASSERT "Invalid XDP flags for
> BPF link attachment".
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
>   .../bpf/progs/test_xdp_attach_fail.c          | 52 +++++++++++++++
>   2 files changed, 117 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
> index fa3cac5488f5d..99f8d03f3c8bd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <test_progs.h>
> +#include "test_xdp_attach_fail.skel.h"
>   
>   #define IFINDEX_LO 1
>   #define XDP_FLAGS_REPLACE		(1U << 4)
> @@ -85,10 +86,74 @@ static void test_xdp_attach(const char *file)
>   	bpf_object__close(obj1);
>   }
>   
> +struct xdp_errmsg {
> +	char msg[64];
> +};
> +
> +static void on_xdp_errmsg(void *ctx, int cpu, void *data, __u32 size)
> +{
> +	struct xdp_errmsg *ctx_errmg = ctx, *tp_errmsg = data;
> +
> +	memcpy(&ctx_errmg->msg, &tp_errmsg->msg, size);
> +}
> +
> +static const char tgt_errmsg[] = "Invalid XDP flags for BPF link attachment";
> +
> +static void test_xdp_attach_fail(const char *file)

The test crashed: 
https://github.com/kernel-patches/bpf/actions/runs/5672753995/job/15373384795#step:6:8037

Please monitor the CI test result in the future.

> +{
> +	__u32 duration = 0;
> +	int err, fd_xdp, fd_link_xdp;
> +	struct bpf_object *obj = NULL;
> +	struct test_xdp_attach_fail *skel = NULL;
> +	struct bpf_link *link = NULL;
> +	struct perf_buffer *pb = NULL;
> +	struct xdp_errmsg errmsg = {};
> +
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +
> +	skel = test_xdp_attach_fail__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_xdp_attach_fail_skel"))
> +		goto out_close;
> +
> +	link = bpf_program__attach_tracepoint(skel->progs.tp__xdp__bpf_xdp_link_attach_failed,
> +					      "xdp", "bpf_xdp_link_attach_failed");
> +	if (!ASSERT_OK_PTR(link, "attach_tp"))
> +		goto out_close;
> +
> +	/* set up perf buffer */
> +	pb = perf_buffer__new(bpf_map__fd(skel->maps.xdp_errmsg_pb), 1,
> +			      on_xdp_errmsg, NULL, &errmsg, NULL);
> +
> +	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &fd_xdp);
> +	if (CHECK_FAIL(err))
> +		goto out_close;
> +
> +	opts.flags = 0xFF; // invalid flags to fail to attach XDP prog
> +	fd_link_xdp = bpf_link_create(fd_xdp, IFINDEX_LO, BPF_XDP, &opts);
> +	if (CHECK(fd_link_xdp != -22, "bpf_link_create_failed",

Please stay with the ASSERT_* macro.

-- 
pw-bot: cr


