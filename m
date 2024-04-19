Return-Path: <linux-kernel+bounces-151034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40488AA82F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04EE3B20D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A663C8DD;
	Fri, 19 Apr 2024 06:02:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CAB883D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506574; cv=none; b=ibgfRVNV7cTLjBD6B6GsPQWzrRPFhy2OPgaZg47fOdAEd5dLj7ziW6JX75grNuA79GM1wJQ9wuBWXOD/anSWI+aEVfYAbnnkYC7fAd+8SJt2UvX9nE8VYZgV/nIyZSrEUMJJoFgJs8GZTs3EYbOd9HoW1VmBkmgQ9ySa56tNYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506574; c=relaxed/simple;
	bh=vMsakpSTXaLFngsOc0z+ORPwqoABxK6u0U8Svsvb3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDhr6ETGcqgC8nAiUaRPVY5P0Tg7X5O0VXjwynMu6RpJaqrKTYGKW0ID0gngAv5TMBeq8ovbwqxgQ/TljO+m66xpudc/w1PDUaiBR0aul3xbCd34QEFjulXTVIoDHn4pLfzp+W8RdebsxvN4tuTFqQQXyBbxyVhpwDGfkotKDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-6c-662208ff0789
Date: Fri, 19 Apr 2024 15:02:34 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v9 rebase on mm-unstable 0/8] Reduce tlb and interrupt
 numbers over 90% by improving folio migration
Message-ID: <20240419060234.GA48027@system.software.com>
References: <20240418061536.11645-1-byungchul@sk.com>
 <20240418131757.cd05a8e7c7e66b3e90508c11@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418131757.cd05a8e7c7e66b3e90508c11@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXC9ZZnke5/DqU0g7+HtC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	s/8rWQveCVe8mLqCvYFxEn8XIyeHhICJxOvVe1lg7EUtT9lAbBYBVYkTq2cygdhsAuoSN278
	ZAaxRQR0JVY93wVkc3EwCzxiklj+cRVYg7BAlcS623fBbF4BC4n9s96D2UICZRI3etZAxQUl
	Ts58AraMWUBL4sa/l0ALOIBsaYnl/zhATE4Bb4mOeTkgFaICyhIHth1nAlklIbCMXeL08n+M
	EHdKShxccYNlAqPALCRTZyGZOgth6gJG5lWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgXG4rPZP
	9A7GTxeCDzEKcDAq8fAuiFdME2JNLCuuzD3EKMHBrCTCa8YBFOJNSaysSi3Kjy8qzUktPsQo
	zcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cAoG3zjxz/TW1s8zrb83XH+xrynPH2hM3d9
	6eKqlfgW+3JXxVF2lpgXZ5hjZULPe6j13IwOrvvTOC9hU/Eug/JfgqtM935+GnGhWmXj64T/
	i18qJDS5zXTf7Xbk2nRum7Q+fbUbB1t+Wf3Z9KM1Vrrr9L2n1y/yaeyYvyUp6pN5yHu7N6Wh
	5081KbEUZyQaajEXFScCAAADjaC/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC5WfdrPufQynN4MYOKYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZTz7v5K14J1wxYupK9gbGCfxdzFyckgImEgsannKBmKzCKhKnFg9kwnEZhNQ
	l7hx4ycziC0ioCux6vkuIJuLg1ngEZPE8o+rwBqEBaok1t2+C2bzClhI7J/1HswWEiiTuNGz
	BiouKHFy5hMWEJtZQEvixr+XQAs4gGxpieX/OEBMTgFviY55OSAVogLKEge2HWeawMg7C0nz
	LCTNsxCaFzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/dxAiMqmW1fybuYPxy2f0QowAHoxIP
	74J4xTQh1sSy4srcQ4wSHMxKIrxmHEAh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJ
	JanZqakFqUUwWSYOTqkGxqaDf7Z4dMdJ7q5nKDX/sYxjY75vwtlw9/y5Ew9vmeUi1DLLU8HS
	xILveAGPxoNVzxY+F2meER7r56XZyeBoITFFeopT7fO8U9ei8vNzDBj2OTl8ZlY8OH/T+Ryb
	5F2LdqzYzB+/b238lGpvt0OqLUFPZX95mh4JUaqRXDqhUNup0Thm/qFOJZbijERDLeai4kQA
	xvmT7KYCAAA=
X-CFilter-Loop: Reflected

On Thu, Apr 18, 2024 at 01:17:57PM -0700, Andrew Morton wrote:
> On Thu, 18 Apr 2024 15:15:28 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> >    $ time XSBench -t 16 -p 50000000
> > 
> >    BEFORE
> >    ------
> >    Threads:     16
> >    Runtime:     968.783 seconds
> >    Lookups:     1,700,000,000
> >    Lookups/s:   1,754,778
> > 
> >    15208.91s user 141.44s system 1564% cpu 16:20.98 total
> > 
> >    AFTER
> >    -----
> >    Threads:     16
> >    Runtime:     913.210 seconds
> >    Lookups:     1,700,000,000
> >    Lookups/s:   1,861,565
> > 
> >    14351.69s user 138.23s system 1565% cpu 15:25.47 total
> 
> Well that's nice.  What exactly is XSBench doing in this situation? 

As far as I know, it's frequently and continuously accessing annon areas
with addresses ranged within 6GB, by multi threads.  Thus, it triggers a
lot of promotions by hinting fault of numa balancing tiering and a lot
of demotions by kswapd as well, resulting in a ton of tlb flushes.

All I need is a system suffering from memory reclaim or any type of
folio migration since migrc mechanism is one for mitigating the overhead
of folio migration.  To see the benefits of migrc, it doesn't have to be
XSBench but any workload suffering from reclaim.

> What sort of improvements can we expect to see in useful workloads?

Increase throughput(= runtime reduction of each work in the system).

   1. Because migrc removes the CPU time that would've been spent in IPI
      handler due to tlb shootdown, by skipping a lot of tlb shootdowns.

   2. Becasue migrc reduces tlb misses so as to utilize tlb cache better,
      by skipping a lof of tlb flushes.

Besides, I expect overall scheduler latencies can be enhanced, the worst
latencies measured using some tracters of ftrace showed no change though.

> I see it no longer consumes an additional page flag, good.
> 
> The patches show no evidence of review activity and I'm not seeing much
> on the mailing list (patchset title was changed.  Previous title
> "Reduce TLB flushes under some specific conditions").  Perhaps a better

I changed the title because it was supposed to work with only numa
balancing tiering like promotion and demotion but, for now, migrc works
with any type of folio migration.  Thus, I can tell migrc demonstrates
its benefits as long as a system is under the control of reclaim and
folio migration.

	Byungchul

> description of the overall benefit to our users would help to motivate
> reviewers.

