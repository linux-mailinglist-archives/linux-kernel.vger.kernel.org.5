Return-Path: <linux-kernel+bounces-61402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B38511F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B9A1F22570
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6B38DDD;
	Mon, 12 Feb 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NEVlBGhv"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE117752;
	Mon, 12 Feb 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736447; cv=none; b=pHRWdFEIHJvDG9oPAHM0L++jPEWAGpS32aa1kPffyljEjvTnSW5l02/qkBxzlqmTa4P0avIit64MbTthLHMrSxHpJIYoVIBRKpBRMauQtn5T9Z3GjDDLl92tA6akawfIzwlrdBbh2XgWXyTLjdNKjgHP5ftRLJQJlHkt2LHUzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736447; c=relaxed/simple;
	bh=0qGgD5wUtgbmEZRsjglxHIOFxTJDqoMjE6LDIsfo7Jo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlomXJc+s10JNM/Uy9vqgzMcMm8io2/5zO6C1UQFbH/Mq40LO1knorpM6ndU3Y2xpx4jGPmhXKFFWwOjHgyXrRKSq+N8DiUvKjJQ+OW7lhXBseL09sR5qYQivaHeM0B5gGGga4+E7VpHUZFWxl+7AdqGNxm8vWtLEpZKs1U60/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NEVlBGhv; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CBDvpr124157;
	Mon, 12 Feb 2024 05:13:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707736437;
	bh=s6lFq/uowt+nG6fepdWGDjcg9JXRvJJDeWCLV3I0lK0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NEVlBGhvWUHIXR/grk3OfjE8uQZv+AlWGFm89FmMKiNMegU9kFJarOwo3PA4PS9Dc
	 RaGb7sD1+MZuGO43ho8RKQIOdxW4Df2RkFQ4FQnE0D1+AV0j0X+fjrSyDqoOCwlF+P
	 FL0Pw+aPh4LEW9n1DGpgyxJv6SytS1Sox8ML+LWo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CBDuHO015855
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 05:13:56 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 05:13:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 05:13:56 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CBDueZ022315;
	Mon, 12 Feb 2024 05:13:56 -0600
Date: Mon, 12 Feb 2024 16:43:55 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Message-ID: <20240212111355.gle4titwolqtzwpi@dhruva>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi!

On Feb 09, 2024 at 14:51:23 +0100, Théo Lebrun wrote:
> Current behavior is that spi-mem operations do not increment statistics,
> neither per-controller nor per-device, if ->exec_op() is used. For
> operations that do NOT use ->exec_op(), stats are increased as the
> usual spi_sync() is called.
> 
> The newly implemented spi_mem_add_op_stats() function is strongly
> inspired by spi_statistics_add_transfer_stats(); locking logic and
> l2len computation comes from there.
> 
> Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
> errors, timedout, transfer_bytes_histo_*.
> 
> Note about messages & transfers counters: in the fallback to spi_sync()
> case, there are from 1 to 4 transfers per message. We only register one
> big transfer in the ->exec_op() case as that is closer to reality.

Can you please elaborate on this point a bit? To me it feels then that
the reported stats in this case will be less than the true value then?

> 
> This patch is NOT touching:
>  - spi_async, spi_sync, spi_sync_immediate: those counters describe
>    precise function calls, incrementing them would be lying. I believe
>    comparing the messages counter to spi_async+spi_sync is a good way
>    to detect ->exec_op() calls, but I might be missing edge cases
>    knowledge.
>  - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
>    provided.

Credit where it's due - This is a very well written and verbose commit
message.

Just my personal opinion maybe but all this data about testing can go
below the tear line in the description?

Or somewhere in the kernel docs would also be just fine. (I know we
kernel developers consider git log as the best source of documentation
:) ) but still.. if you feel like adding ;)

No strong opinions there though.

> 
> Testing this patch:
> 
>    $ cd /sys/devices/platform/soc
>    $ find . -type d -path "*spi*" -name statistics
>    ./2100000.spi/spi_master/spi0/statistics
>    ./2100000.spi/spi_master/spi0/spi0.0/statistics
>    $ cd ./2100000.spi/spi_master/spi0/statistics
> 
>    $ for f in *; do printf "%s\t" $f; cat $f; done | \
>          grep -v transfer_bytes_histo | column -t
>    bytes                    240745444
>    bytes_rx                 240170907
>    bytes_tx                 126320
>    errors                   0
>    messages                 97354
>    spi_async                0
>    spi_sync                 0
>    spi_sync_immediate       0
>    timedout                 0
>    transfers                97354
>    transfers_split_maxsize  0
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/spi/spi-mem.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 2dc8ceb85374..171fe6b1c247 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -297,6 +297,50 @@ static void spi_mem_access_end(struct spi_mem *mem)
>  		pm_runtime_put(ctlr->dev.parent);
>  }
>  
> +static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
> +				 const struct spi_mem_op *op, int exec_op_ret)
> +{
> +	struct spi_statistics *stats;
> +	int len, l2len;
> +
> +	get_cpu();
> +	stats = this_cpu_ptr(pcpu_stats);
> +	u64_stats_update_begin(&stats->syncp);
> +
> +	/*
> +	 * We do not have the concept of messages or transfers. Let's consider
> +	 * that one operation is equivalent to one message and one transfer.

Why 1 message _and_ 1 xfer and not simply 1 xfer?
Even in the example of testing that you showed above the values for
message and xfer are anyway going to be same, then why have these 2
members in the first place? Can we not do away with one of these?

Sorry but I am not too familiar with u64_stats_inc so my q. may sound
silly.

Seems to be more of a concept widely used in networking side of the
kernel.

> +	 */
> +	u64_stats_inc(&stats->messages);
> +	u64_stats_inc(&stats->transfers);
> +
> +	/* Use the sum of all lengths as bytes count and histogram value. */
> +	len = (int)op->cmd.nbytes + (int)op->addr.nbytes;
> +	len += (int)op->dummy.nbytes + (int)op->data.nbytes;
> +	u64_stats_add(&stats->bytes, len);
> +	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
> +	l2len = max(l2len, 0);
> +	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
> +
> +	/* Only account for data bytes as xferred bytes. */
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +		u64_stats_add(&stats->bytes_tx, op->data.nbytes);
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> +		u64_stats_add(&stats->bytes_rx, op->data.nbytes);
> +
> +	/*
> +	 * A timeout is not an error, following the same behavior as
> +	 * spi_transfer_one_message().
> +	 */
> +	if (exec_op_ret == -ETIMEDOUT)
> +		u64_stats_inc(&stats->timedout);
> +	else if (exec_op_ret)
> +		u64_stats_inc(&stats->errors);
> +
> +	u64_stats_update_end(&stats->syncp);
> +	put_cpu();
> +}
> +
>  /**
>   * spi_mem_exec_op() - Execute a memory operation
>   * @mem: the SPI memory
> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		 * read path) and expect the core to use the regular SPI
>  		 * interface in other cases.
>  		 */
> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> +

Just curious, how much does this impact performance? Have you been able
to do some before / after profiling with/out this patch?

For eg. for every single spimem op I'm constantly going to incur the
penalty of these calls right?

Just wondering if we can / should make this optional to have the
op_stats. If there is a perf penalty, like if my ospi operations start
being impacted by these calls then I may not be okay with this patch.

But if you have tested and not found it to be the case I am okay with
these changes.

If I find some time later, I'll try to test but I'm caught up with some
other work. For now I'll leave my R-by with the above conditions
addressed / answered.

Mostly LGTM,

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

