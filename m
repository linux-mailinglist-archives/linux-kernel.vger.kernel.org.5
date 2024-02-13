Return-Path: <linux-kernel+bounces-62935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2E852813
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DDD1C2332E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD011721;
	Tue, 13 Feb 2024 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t9rnav63"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095229479;
	Tue, 13 Feb 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800068; cv=none; b=NwnTCRv931YXoDm4aNoSMbbc8mTVrn4VXble13K1iTsG+tsn2+aopi+Dw8irlR2bUoMFrSVwpZtR0F6SGjLkTDXNK4KO+zVDD/IceqoAH+oAWAWLH8BytMeAZqvvzB00M2JoYIikN8x/l9XTjFBVhzs2ofrmiDFTLFzTfvjvqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800068; c=relaxed/simple;
	bh=OikgM/hCG4ig9Zh8YV8aE2rdE6IFofe7npufuCVe8jo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESWRtmJawfqXkEJnU6u2it+pMWGUC9JVIH1X5MYKQwGvynJtGczmrFH3g5SrKqPGDK9/x57UIHCqXL3ZNshtF1Not61BxFUa80dlTy70+VhquLq7NLXbP9m92oImSuaMC+2GlgRW9Y/2mm5K7w4qoPNvXJKUMav+Pb7Nyi+Zqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t9rnav63; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D4sHqd119717;
	Mon, 12 Feb 2024 22:54:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707800057;
	bh=8QiFlEnKkSZPKqeuWuaLAiD4z6eKZ/x5j+cwN+zLjSI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=t9rnav639GWov8X1n1Qp0zBgyj2uxUhE/6upvv9TfgbW9gZc7F4rga3TtkJaqHr0/
	 xhp7sji4g50FAXI3c86v9iXUHaHU3F9qPCGY9Vg3LQ5yGOcita3iKnCVhA+tz+sm5k
	 xoHZgroeCcCWay5h0AObGMx1DyfxzpHYoPBqfgVo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D4sHgK032624
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 22:54:17 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 22:54:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 22:54:16 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D4sGxF072029;
	Mon, 12 Feb 2024 22:54:16 -0600
Date: Tue, 13 Feb 2024 10:24:15 +0530
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
Message-ID: <20240213045415.azreofxu5je6a6kn@dhruva>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <20240212111355.gle4titwolqtzwpi@dhruva>
 <CZ3622YJS316.3HPUUVRW20KSR@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZ3622YJS316.3HPUUVRW20KSR@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 12, 2024 at 15:22:41 +0100, Théo Lebrun wrote:
> Hello,
> 
> On Mon Feb 12, 2024 at 12:13 PM CET, Dhruva Gole wrote:
> > Hi!
> >
> > On Feb 09, 2024 at 14:51:23 +0100, Théo Lebrun wrote:
> > > Current behavior is that spi-mem operations do not increment statistics,
> > > neither per-controller nor per-device, if ->exec_op() is used. For
> > > operations that do NOT use ->exec_op(), stats are increased as the
> > > usual spi_sync() is called.
> > > 
> > > The newly implemented spi_mem_add_op_stats() function is strongly
> > > inspired by spi_statistics_add_transfer_stats(); locking logic and
> > > l2len computation comes from there.
> > > 
> > > Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
> > > errors, timedout, transfer_bytes_histo_*.
> > > 
> > > Note about messages & transfers counters: in the fallback to spi_sync()
> > > case, there are from 1 to 4 transfers per message. We only register one
> > > big transfer in the ->exec_op() case as that is closer to reality.
> >
> > Can you please elaborate on this point a bit? To me it feels then that
> > the reported stats in this case will be less than the true value then?
> 
> To me, a transfer is one transaction with the SPI controller. In most
> implementations of ->exec_op(), the controller gets configured once for
> the full transfer to take place. This contrasts with the fallback case
> that does from 1 to 4 transfers (cmd, addr, dummy & data, with the last
> three being optional).
> 
> One transfer feels closer to what happens from my point-of-view. What
> would be your definition of a transfer? Or the "official" one that the
> sysfs entry represents?

Yeah I understand your point, this is something I'd also call as a transaction

> 
> > > This patch is NOT touching:
> > >  - spi_async, spi_sync, spi_sync_immediate: those counters describe
> > >    precise function calls, incrementing them would be lying. I believe
> > >    comparing the messages counter to spi_async+spi_sync is a good way
> > >    to detect ->exec_op() calls, but I might be missing edge cases
> > >    knowledge.
> > >  - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
> > >    provided.
> >
> > Credit where it's due - This is a very well written and verbose commit
> > message.
> 
> Thanks!
> 
> > Just my personal opinion maybe but all this data about testing can go
> > below the tear line in the description?
> 
> I see where you are coming from. I'll do so on the next revision (if
> there is one).

cool!

> 
> > Or somewhere in the kernel docs would also be just fine. (I know we
> > kernel developers consider git log as the best source of documentation
> > :) ) but still.. if you feel like adding ;)
> 
> A first step would be to have the sysfs SPI statistics API be described
> inside Documentation/. That is outside the scope of this patch
> though. :-)
> 
> > No strong opinions there though.
> 
> Same.
> 
> [...]
> 
> > > +static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
> > > +				 const struct spi_mem_op *op, int exec_op_ret)
> > > +{
> > > +	struct spi_statistics *stats;
> > > +	int len, l2len;
> > > +
> > > +	get_cpu();
> > > +	stats = this_cpu_ptr(pcpu_stats);
> > > +	u64_stats_update_begin(&stats->syncp);
> > > +
> > > +	/*
> > > +	 * We do not have the concept of messages or transfers. Let's consider
> > > +	 * that one operation is equivalent to one message and one transfer.
> >
> > Why 1 message _and_ 1 xfer and not simply 1 xfer?
> > Even in the example of testing that you showed above the values for
> > message and xfer are anyway going to be same, then why have these 2
> > members in the first place? Can we not do away with one of these?
> 
> Mark Brown gave an answer to this. Indeed, with regular SPI operations,
> one message doesn't map to one transfer.

Thanks for explaining Mark, understood.

> 
> [...]
> 
> > >  /**
> > >   * spi_mem_exec_op() - Execute a memory operation
> > >   * @mem: the SPI memory
> > > @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > >  		 * read path) and expect the core to use the regular SPI
> > >  		 * interface in other cases.
> > >  		 */
> > > -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
> > > +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
> > > +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> > > +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> > > +
> >
> > Just curious, how much does this impact performance? Have you been able
> > to do some before / after profiling with/out this patch?
> >
> > For eg. for every single spimem op I'm constantly going to incur the
> > penalty of these calls right?
> 
> I have indeed done some benchmarking. I was not able to measure anything
> significant. Neither doing timings of end-to-end testing by reading
> loads of data over UBIFS, nor by using ftrace's function_graph.

Awesome.

> 
> > Just wondering if we can / should make this optional to have the
> > op_stats. If there is a perf penalty, like if my ospi operations start
> > being impacted by these calls then I may not be okay with this patch.
> 
> I've asked myself the same question. It is being done unconditionally on
> regular SPI ops, so I guess the question has been answered previously:
> no need to make this conditional.
> 
> See spi_statistics_add_transfer_stats() in drivers/spi/spi.c.

Yeah I did see that, but maybe it didn't occur then whether we should
make it optional.

Anyway, I'm ok with this too. Let's worry about optional in future if
required.

> 
> > But if you have tested and not found it to be the case I am okay with
> > these changes.
> >
> > If I find some time later, I'll try to test but I'm caught up with some
> > other work. For now I'll leave my R-by with the above conditions
> > addressed / answered.
> >
> > Mostly LGTM,
> >
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 
> Thanks for your review! I don't regret adding you to the Cc list.
> 

Cheers!


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

