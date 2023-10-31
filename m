Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D17DD6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJaUFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjJaUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:05:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B57C9;
        Tue, 31 Oct 2023 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wN7hoCdZjW2Qi5EV2D6vN+0xz2qgaPB0lFfQQA1NDJc=; b=CCPQqz/OCjQy8Bu7hLe6nE3rKM
        WyqY+s0CxwA4JgbLPJomToXKheGbdKMG3rznfeNS3Pyu4ZJ3dFezHFMrkEMXAHolsZ6ae2nUYO8N3
        gT6bfkYCTC/m+vtJj0S7Q3KAW/k916z0LNu/fq8UR3bGs1g0h8Ao/lAwSB/cxQJc5C1T32zj0wTej
        ZEEiXYsLbm1AdOxHRSyHXTW5bdsZPFvhSyY7x1/12Ew1C8zkdKqgjYiqC/aPblw6SltPUI42G92is
        /c1ErYiK8sSAYLhuJoPbQ0b+K1eHUV98f/RQlpvHA5VbAsBBM+8tW+Gewg0Qkl37pkNwRVJhmqygx
        qMuwoUPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxuzO-0053Q4-2l;
        Tue, 31 Oct 2023 20:05:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 784E8300473; Tue, 31 Oct 2023 21:05:26 +0100 (CET)
Date:   Tue, 31 Oct 2023 21:05:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] sched: psi: fix unprivileged polling against cgroups
Message-ID: <20231031200526.GH15024@noisy.programming.kicks-ass.net>
References: <20231026164114.2488682-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026164114.2488682-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+cc tj because cgroup

On Thu, Oct 26, 2023 at 12:41:14PM -0400, Johannes Weiner wrote:
> 519fabc7aaba ("psi: remove 500ms min window size limitation for
> triggers") breaks unprivileged psi polling on cgroups.
> 
> Historically, we had a privilege check for polling in the open() of a
> pressure file in /proc, but were erroneously missing it for the open()
> of cgroup pressure files.
> 
> When unprivileged polling was introduced in d82caa273565 ("sched/psi:
> Allow unprivileged polling of N*2s period"), it needed to filter
> privileges depending on the exact polling parameters, and as such
> moved the CAP_SYS_RESOURCE check from the proc open() callback to
> psi_trigger_create(). Both the proc files as well as cgroup files go
> through this during write(). This implicitly added the missing check
> for privileges required for HT polling for cgroups.
> 
> When 519fabc7aaba ("psi: remove 500ms min window size limitation for
> triggers") followed right after to remove further restrictions on the
> RT polling window, it incorrectly assumed the cgroup privilege check
> was still missing and added it to the cgroup open(), mirroring what we
> used to do for proc files in the past.
> 
> As a result, unprivileged poll requests that would be supported now
> get rejected when opening the cgroup pressure file for writing.
> 
> Remove the cgroup open() check. psi_trigger_create() handles it.
> 
> Fixes: 519fabc7aaba ("psi: remove 500ms min window size limitation for triggers")
> Cc: stable@vger.kernel.org # 6.5+
> Reported-by: Luca Boccassi <bluca@debian.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Since merge window is upon is, I've queued this with the intent to stick
into sched/urgent after rc1.

> ---
>  kernel/cgroup/cgroup.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index f11488b18ceb..2069ee98da60 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3879,14 +3879,6 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
>  	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
>  }
>  
> -static int cgroup_pressure_open(struct kernfs_open_file *of)
> -{
> -	if (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
> -		return -EPERM;
> -
> -	return 0;
> -}
> -
>  static void cgroup_pressure_release(struct kernfs_open_file *of)
>  {
>  	struct cgroup_file_ctx *ctx = of->priv;
> @@ -5287,7 +5279,6 @@ static struct cftype cgroup_psi_files[] = {
>  	{
>  		.name = "io.pressure",
>  		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
> -		.open = cgroup_pressure_open,
>  		.seq_show = cgroup_io_pressure_show,
>  		.write = cgroup_io_pressure_write,
>  		.poll = cgroup_pressure_poll,
> @@ -5296,7 +5287,6 @@ static struct cftype cgroup_psi_files[] = {
>  	{
>  		.name = "memory.pressure",
>  		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
> -		.open = cgroup_pressure_open,
>  		.seq_show = cgroup_memory_pressure_show,
>  		.write = cgroup_memory_pressure_write,
>  		.poll = cgroup_pressure_poll,
> @@ -5305,7 +5295,6 @@ static struct cftype cgroup_psi_files[] = {
>  	{
>  		.name = "cpu.pressure",
>  		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
> -		.open = cgroup_pressure_open,
>  		.seq_show = cgroup_cpu_pressure_show,
>  		.write = cgroup_cpu_pressure_write,
>  		.poll = cgroup_pressure_poll,
> @@ -5315,7 +5304,6 @@ static struct cftype cgroup_psi_files[] = {
>  	{
>  		.name = "irq.pressure",
>  		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
> -		.open = cgroup_pressure_open,
>  		.seq_show = cgroup_irq_pressure_show,
>  		.write = cgroup_irq_pressure_write,
>  		.poll = cgroup_pressure_poll,
> -- 
> 2.42.0
> 
