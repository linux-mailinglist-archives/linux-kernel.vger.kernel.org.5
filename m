Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2A7ADAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjIYPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjIYPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:01:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255A111;
        Mon, 25 Sep 2023 08:01:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE86C433C8;
        Mon, 25 Sep 2023 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695654060;
        bh=GUTPMlEVCxAI4XqyqO0Rqf3KWAa3RuxtFqcc2gmHP1w=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=pOGJqd26WmXtEWG9MwBrMWw6yfwLBt3Fw2NdJtV5xHWOD9eyLgAixcnEsCAXLJ0c4
         7TJ5DR4cATHHVbGVNr+Q3jly+GM51Q2ZlonAvbt1NhNKnW31AscOFyc1S4kvdkUiFM
         NWQyqQHZ5bj9XsrhrHNcluOpevJyyVSBpDTTYVHhmrH7/OVKUA4aUkIQWJdMfNAII+
         Hj8TmgzsACQLRXu6XyBY01uCt3rFzIl5g88tina/t3F2zrwDagissLn4I2EDC7UG+A
         Rv+zkYxxCros8yPuumZmQe9IYfZiz7vyqRTKGDzfZ1aP8XOR9pCn6QybtRugRVLJVo
         0+wnUc4uR62/Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 18:00:52 +0300
Message-Id: <CVS371QBH3QK.3354DSBK53OFS@suppilovahvero>
Subject: Re: [RESEND PATCH v8 2/2] ACPI: APEI: handle synchronous exceptions
 in task work
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Shuai Xue" <xueshuai@linux.alibaba.com>, <rafael@kernel.org>,
        <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
        <mawupeng1@huawei.com>, <tony.luck@intel.com>,
        <linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <gregkh@linuxfoundation.org>,
        <will@kernel.org>
Cc:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-edac@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>, <stable@vger.kernel.org>,
        <x86@kernel.org>, <justin.he@arm.com>, <ardb@kernel.org>,
        <ying.huang@intel.com>, <ashish.kalra@amd.com>,
        <baolin.wang@linux.alibaba.com>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
        <robert.moore@intel.com>, <lvying6@huawei.com>,
        <xiexiuqi@huawei.com>, <zhuo.song@linux.alibaba.com>
X-Mailer: aerc 0.14.0
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20230919022127.69732-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 19, 2023 at 5:21 AM EEST, Shuai Xue wrote:
> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when an uncorrected error is consumed. Both synchronous a=
nd
> asynchronous error are queued and handled by a dedicated kthread in
> workqueue.
>
> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
> synchronous errors") keep track of whether memory_failure() work was
> queued, and make task_work pending to flush out the workqueue so that the
> work for synchronous error is processed before returning to user-space.
> The trick ensures that the corrupted page is unmapped and poisoned. And
> after returning to user-space, the task starts at current instruction whi=
ch
> triggering a page fault in which kernel will send SIGBUS to current proce=
ss
> due to VM_FAULT_HWPOISON.
>
> However, the memory failure recovery for hwpoison-aware mechanisms does n=
ot
> work as expected. For example, hwpoison-aware user-space processes like
> QEMU register their customized SIGBUS handler and enable early kill mode =
by
> seting PF_MCE_EARLY at initialization. Then the kernel will directy notif=
y
> the process by sending a SIGBUS signal in memory failure with wrong
> si_code: the actual user-space process accessing the corrupt memory
> location, but its memory failure work is handled in a kthread context, so
> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
> process instead of BUS_MCEERR_AR in kill_proc().
>
> To this end, separate synchronous and asynchronous error handling into
> different paths like X86 platform does:
>
> - valid synchronous errors: queue a task_work to synchronously send SIGBU=
S
>   before ret_to_user.
> - valid asynchronous errors: queue a work into workqueue to asynchronousl=
y
>   handle memory failure.
> - abnormal branches such as invalid PA, unexpected severity, no memory
>   failure config support, invalid GUID section, OOM, etc.
>
> Then for valid synchronous errors, the current context in memory failure =
is
> exactly belongs to the task consuming poison data and it will send SIBBUS
> with proper si_code.
>
> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for syn=
chronous errors")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Did 7f17b4a121d0 actually break something that was not broken before?

If not, this is (afaik) not a bug fix.

BR, Jarkko

