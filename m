Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B637BF533
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442709AbjJJICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442536AbjJJIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:01:56 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D296592;
        Tue, 10 Oct 2023 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=QM5Im+7k5GpQA/JxbJgORC477jL0+OQeMFKuqizFCv0=; b=HimaW3MEuVu9hIyFdVUHaS9/Mz
        3vW+IpvgwTDGEpiu3fRopt4gwLwu7QR6pTroCqHtp9VWuy/jSf7T4a4KBrHQclHYC5lN8TFngSck3
        cd6nf91a41FyK3G+2LbUYztywiE17/LR97+bNRXEXFASbPd6SbFCyJ8Iul1PmaD9l5nshTbJC5wso
        i6eI8HPopLF77xx7G/mpkYZNiY3/QRdLVa91l6Bpp4fXphDw/mokWbb+/qYvXSiw9uNJaiI9sV7ja
        wJ4ipg10tL/ygP5CzdhD7YvHq2AMaeiA1XYCytHU2+wGzD8jpkpU9mUwriuJIH7mnYHUYTIi8UZ5c
        GdQS0PCA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qq7ge-000OeD-3m; Tue, 10 Oct 2023 10:01:52 +0200
Received: from [178.197.249.27] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qq7gd-000Lqg-Qs; Tue, 10 Oct 2023 10:01:51 +0200
Subject: Re: [PATCH bpf-next v4 0/8] Add Open-coded task, css_task and css
 iters
To:     Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org,
        tj@kernel.org, linux-kernel@vger.kernel.org
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d25f9b70-e958-c229-c275-95ed664bf0ed@iogearbox.net>
Date:   Tue, 10 Oct 2023 10:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27056/Mon Oct  9 09:40:11 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/23 2:45 PM, Chuyi Zhou wrote:
> Hi,
> 
> This is version 4 of task, css_task and css iters support.
> Thanks for your review!
> 
> --- Changelog ---
> 
> v3 -> v4:https://lore.kernel.org/all/20230925105552.817513-1-zhouchuyi@bytedance.com/
> 
> * Address all the comments from Andrii in patch-3 ~ patch-6
> * Collect Tejun's ack
> * Add a extra patch to rename bpf_iter_task.c to bpf_iter_tasks.c
> * Seperate three BPF program files for selftests (iters_task.c iters_css_task.c iters_css.c)

This fails to build BPF selftests:

[...]
  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:166:6: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK(err, "setup_cgroup_environment"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: note: uninitialized use occurs here
           iters_css_task__destroy(skel);
                                   ^~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:166:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK(err, "setup_cgroup_environment"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:162:6: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_GE(cg_fd, 0, "cg_create"))
     TEST-OBJ [test_progs] xdp.test.o
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: note: uninitialized use occurs here
           iters_css_task__destroy(skel);
                                   ^~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:162:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_GE(cg_fd, 0, "cg_create"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:159:6: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK(err, "setup_cgroup_environment"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: note: uninitialized use occurs here
           iters_css_task__destroy(skel);
                                   ^~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:159:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK(err, "setup_cgroup_environment"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:154:29: note: initialize the variable 'skel' to silence this warning
           struct iters_css_task *skel;
                                      ^
                                       = NULL
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:213:7: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                   if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:244:21: note: uninitialized use occurs here
           iters_css__destroy(skel);
                              ^~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:213:3: note: remove the 'if' if its condition is always false
                   if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:209:6: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
           if (!ASSERT_OK(err, "setup_cgroup_environment"))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:244:21: note: uninitialized use occurs here
           iters_css__destroy(skel);
                              ^~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:209:2: note: remove the 'if' if its condition is always false
           if (!ASSERT_OK(err, "setup_cgroup_environment"))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:195:24: note: initialize the variable 'skel' to silence this warning
           struct iters_css *skel;
                                 ^
                                  = NULL
   5 errors generated.
   make: *** [Makefile:605: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/iters.test.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.
