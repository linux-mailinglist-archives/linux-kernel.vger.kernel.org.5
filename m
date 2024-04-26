Return-Path: <linux-kernel+bounces-160355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDD8B3C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC631C21996
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6DB14D2B8;
	Fri, 26 Apr 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="PnZW8KxF"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76A148FE6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147490; cv=none; b=YOWCKQiM6oLUW/Qy4g9EXPyjv7XLePLeOx/Qnitu2u8BIq7e0I0QV6+aww/5EoMw3k3nTeSGlR1u4409Pg+PwG9lIwRmhVs0mUHQt8yZ/5d9DLTC3RWR6xUv3F1+BSwYiO49bKohqIkSy49OVhhIlJOl3PulFFu8DbVyY3M+Q/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147490; c=relaxed/simple;
	bh=MjU6ulQsHUMef7I3twwliBFCUYVxAue996jKQ+7o/0Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uS1juG51z5ei1Ig8Dl21AMJECQTWn72o61xfXwadV2zbIz0N/FfE4riEX6VPqpLv2GgeXm5tC0Lr61tBYtME3K9isWRI9xZOkW+4KA0oVJnuEGfrAOa7wUVkBK3DHYgKzq52y5nmODAHiucFbteOnkGt0THW1MpgwVnzQ39VNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=PnZW8KxF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714147428; x=1714752228; i=efault@gmx.de;
	bh=ZQlUMXXDCPk3yuRn2FPRZOBOVheVpQljd2+ka4ZKnQ8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PnZW8KxFVigvTWrTlTMZfkSBtyekdQFMVpJVuotfLO3QyxynvtQR9NRr9ZIHEKsE
	 0NzgV7uUsik01ZZoxXlvSpRHCdT9o4Vm07L9kE1XIAfIJ98AMjJLNgagRGch7Zee2
	 RG3AgJz5a0mVHCZbAQm8Fe3aqRTVb3AtVVYkYv+efOaYPMuIRpiQzhcdyaSWDIbcx
	 Kz+93+8N4qSjj1TlTU26ADGsSUyjmGmYf7r82TetPyVJKhSQYH2PgwlNspFkTEUIC
	 kIawFzyULHvtFhkwikvhN2nIPDqk4AvLaecpfQHpFjYlartUk3I5goy1/a/jnNImE
	 RklzqBHJhStrXyW+wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.49.222]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1siUk728zH-011jYr; Fri, 26
 Apr 2024 18:03:48 +0200
Message-ID: <18f557cd69fc65f5b43daddd8ad3e43278dfa44e.camel@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com, 
 tglx@linutronix.de, Chen Yu <yu.c.chen@intel.com>, Oliver Sang
 <oliver.sang@intel.com>
Date: Fri, 26 Apr 2024 18:03:46 +0200
In-Reply-To: <20240426111607.GL12673@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.631664251@infradead.org>
	 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
	 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
	 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
	 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
	 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
	 <20240425112855.GF21980@noisy.programming.kicks-ass.net>
	 <20240426105607.GK12673@noisy.programming.kicks-ass.net>
	 <20240426111607.GL12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zLRPNnDNUxMhUzL9dVXXQMjrrFsWxBYfhuKDs9vdHXRP2jcFfpz
 RdMO278vRXhgB2dFYOSrUYlbhhcQQs2MMMN0DRoHOBl6YIFpbuRgli5b+iy5DTyGpy7VQS+
 UxF+LmGZUvkZNs3hcvKjUaIGFGX3oTZSUXych/94FqhHzCPHTkYy6zC15WP9yDjA7mS39oD
 X4bndp/EWqESLpBbnQs7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NVoRFJtYfCg=;UVgN2wVuoM3nhbD/RHkLU7CA4TF
 /kGIwv5u6fjOwUW6zMuRrIyouGWOI/k3Mtri0lEDl5qt2fPQzJ6W3RV3a17xJ4T7xZzXik33f
 ED95W56j9AxdBf/cgmH91ecqKeRTGjduLDVg5FiFTPrfsqt8cqSEEgj8dUwnkV9bkJBx1Djt+
 N2KyXqQE/edi3+VoqiC5P+z/tz9BA0o5qN84PcDlpXara4xd9cLp6GrmToZwyUn4S4UVZQx9k
 r/AfLvh/2xr6U7PqDGNWE30thAcIPlPtjvfw6QmzdduNA+u3Ky2Ev8Zf/Tat9vkevVn9hwd7e
 uTvrOThkQzaXKJ0iMr3MUVZCpaiq4uciPlo5JVAfcSKyb60isvVCyxt2q1ifGTOJbsoSSdtME
 BEmu3UwK3mPJE8yXGEgRGMU6ctVkZbVZzVJNG7VMIBxxIQmEAt3K0GGhHb931NNfw5H9YxfYA
 0/7s1syO4yPHXZfrHsxqFIKpqONBR4lhZxHxlTRD3itVFNvHKyCUzXC6Xv/0uQiOwtaTGd+uq
 kIox66uWA7DOkrRzVqLizf9ulzvW9MDtG/7MoTpEtxmk7gJpXBdsS2hEA9QEhza8Z4hPDf1xg
 opC9FdH+qPFa+GFNUX8DoUB86mrWjN7GoPsffUTsY4nuvXZhdynCOyP+CDmEWux+7qaIuAd9c
 pUHkkFjRCZ4uwlZRCIf1VIgfPhYjBttfNhJbZeDtWpzw1i2+5zXk3ZahIQatpcceoLEofy7vG
 SF3IGk6dgjcin9yDN0DDRJCLzQKlsm50qAemMzfHrx8LHAN0NhIeloPDS1JGvT4Y/ysnhxsVZ
 hpGewHi507AzcNX5ZdCksTynPe2DLB9d7jvrKjMpd7TVc=

On Fri, 2024-04-26 at 13:16 +0200, Peter Zijlstra wrote:
> >
> > I ended up with the below instead; lemme go run this unixbench
> > spawn on it.
>
> Seems to survive that.
>
> I pushed out the patches with updates to queue/sched/eevdf

Yup, solid... but fwiw, tbench liked the previous version better.

trusty (with a 'c') ole i7-4790 box, tbench 8

for i in 1 2 3; do tbench.sh 8 10 2>&1|grep Throughput; done

6.9.0.gc942a0c-master +eevdf.current
NO_DELAY_DEQUEUE
Throughput 3285.04 MB/sec 8 clients 8 procs max_latency=3D3.481 ms
Throughput 3289.66 MB/sec 8 clients 8 procs max_latency=3D8.124 ms
Throughput 3293.83 MB/sec 8 clients 8 procs max_latency=3D2.210 ms
DELAY_DEQUEUE
Throughput 3246.3 MB/sec 8 clients 8 procs max_latency=3D2.181 ms
Throughput 3236.96 MB/sec 8 clients 8 procs max_latency=3D6.988 ms
Throughput 3248.6 MB/sec 8 clients 8 procs max_latency=3D2.130 ms

6.9.0.gc942a0c-master +eevdf.prev
NO_DELAY_DEQUEUE
Throughput 3457.92 MB/sec 8 clients 8 procs max_latency=3D3.885 ms
Throughput 3470.95 MB/sec 8 clients 8 procs max_latency=3D4.475 ms
Throughput 3467.87 MB/sec 8 clients 8 procs max_latency=3D2.182 ms
DELAY_DEQUEUE
Throughput 3712.96 MB/sec 8 clients 8 procs max_latency=3D4.231 ms
Throughput 3667.87 MB/sec 8 clients 8 procs max_latency=3D5.020 ms
Throughput 3679.65 MB/sec 8 clients 8 procs max_latency=3D2.847 ms

Trees are identical modulo extracted eevdf additions. The previous win
that put eevdf on par with cfs went missing.. and then some.

For reference, cfs vs eevdf log extract for previously mentioned gain.

6.1.87-cfs
Throughput 3660.98 MB/sec  8 clients  8 procs  max_latency=3D2.204 ms
Throughput 3678.67 MB/sec  8 clients  8 procs  max_latency=3D10.127 ms
Throughput 3631.89 MB/sec  8 clients  8 procs  max_latency=3D13.019 ms
              1.000

6.1.87-eevdf - naked eevdf +fixes
Throughput 3441.86 MB/sec  8 clients  8 procs  max_latency=3D3.943 ms
Throughput 3439.68 MB/sec  8 clients  8 procs  max_latency=3D4.285 ms
Throughput 3432.28 MB/sec  8 clients  8 procs  max_latency=3D3.557 ms
vs cfs         .940

6.1.87-eevdf +delay_dequeue.prev patch set
DELAY_DEQUEUE
Throughput 3696.94 MB/sec  8 clients  8 procs  max_latency=3D2.179 ms
Throughput 3694.64 MB/sec  8 clients  8 procs  max_latency=3D6.322 ms
Throughput 3654.49 MB/sec  8 clients  8 procs  max_latency=3D4.101 ms
vs cfs        1.006

box waxes nostalgic (son, when I was yo age [flex])
4.19.312
Throughput 4099.07 MB/sec  8 clients  8 procs  max_latency=3D2.169 ms
Throughput 4107.49 MB/sec  8 clients  8 procs  max_latency=3D12.404 ms
Throughput 4118.41 MB/sec  8 clients  8 procs  max_latency=3D14.150 ms

	-Mike

