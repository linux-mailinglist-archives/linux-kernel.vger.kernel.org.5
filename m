Return-Path: <linux-kernel+bounces-161492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A851D8B4CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FB1F212A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2A7175E;
	Sun, 28 Apr 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="WCzutloV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE957433DA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322021; cv=none; b=hlgrH2YNLq9qGQfQzNFibi7Ldk9jXWiBS9JSwj/orDsjaOCBPrh2/Of4hkV4ylK5r4RapVT8fSFlLNfMsGAqaWwzo2dDg8T81hVqM2ip8cslWMjJBeofhlh8rF7TPaUDMB/wQf4CdAUd4hNfevP7EhFMeYF/+0NVe9+aCs8x4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322021; c=relaxed/simple;
	bh=9ns3Zeagcn2owJh2UVZrXIni5VgaYKCzy1XZ28kpGmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojqX1iz1Z3AA5cQuEPdF/Rq79R5HA+A64yihq1daWQZvd6xoFckocTiJxooyWNQfiCUpWwKrzKUbLOWSqly4jUMY917UTvTY3zz62qXRL9Z9cMPn+1FLm2qTnDcQO9vAQsP8FTCy21dTEhyH2wXHlXfe1TCQDiko/2jEe9IHWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=WCzutloV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714321972; x=1714926772; i=efault@gmx.de;
	bh=XKc8GiNUeMIch2wEoTBmyOb2M49diZSRbPsPlquGtBA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WCzutloVsJBx2ilXu7Wsp8E3TuMcnCu99H2uejtXLxNY3RZcCcK0e8YE+7wUTGhj
	 PE+uNhAc5ZUNyHTkmx8BdR2Key+rbAEBrfBW6HmG1sZdzPyM6MnF3KRGOhEFvVthx
	 3o5cRzwvdWEJRW5g4VYRrNt++j9UYN4LTVtVeR/xXqaobYlgIDckMuHfYiz+GRjKm
	 5xsW0ypKcjsVaaWDk9URP9PxLzJ+UNrtSkm44Tf8Upqo48b82bM70GwEiu+exQ1wn
	 RN2qQiituq3D0v34apeRBIKy9XdGLB74UE/xfdUByXx1bfC294JDIs+7WMhuOoSQk
	 AFIWhcmkLI0IZ2ygYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.49.222]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1rohml10wh-00BFVd; Sun, 28
 Apr 2024 18:32:52 +0200
Message-ID: <b344235ed5e2af6c573ff371d3687f0fa7bc5c5e.camel@gmx.de>
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
Date: Sun, 28 Apr 2024 18:32:49 +0200
In-Reply-To: <8d2fd91db108428680cd4ed988b36cf3f579c5ec.camel@gmx.de>
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
	 <18f557cd69fc65f5b43daddd8ad3e43278dfa44e.camel@gmx.de>
	 <8d2fd91db108428680cd4ed988b36cf3f579c5ec.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sVIbo9Cn2EV8gwjvqxk0bVLpmOdONByGQz1/whKZh28uHgdVNkM
 1qrL2N1GyXsGCJKCPHNihOS7rAYJUfKGgKSe9EtAJfzuYQ2KG8tqHX5Hv4Sa86h0ICp7/9t
 EwZ1FCNpueKlydqZG6VWTHAUh2DFG9hkTb8COe7SR3MxLRLblMSoRZ8mDcoF/Mb/eOx/WGh
 sAxZyAOIJEJSzW1Wg5Vnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ydEGgL5qy8o=;1lFIhO55+OTL6Nxvq/KA5hX/sPV
 WO/kOpZzypWVPUsIB4R36YJVEgd+AvdHxW3pJ7AVauCZmGOUKFqQmi5gABFx2ZEftQiyqBVTU
 cXhXbSgTVAcoFzIa55HRVApdHiWa4v/GEm9hOAvBJn0ZbAjTOF0n4otX/dkj6m8yfWgWa3fsV
 95TwigeGvQriC1gL2PTbsrG2HdPhvJZ6SzfYSPjdk7/A6F0yhNc10XDc47aQbNXynv01tbAL1
 ccBogtUfl7Ylvvk/ovXy882OYMjcc5CMD2bRHMNWcEPhtQt0GniozeTnvmRVk6B59vtpVSWEo
 cGaEnwAy9sGfaMlr97xZ+6OIZci36l35snq7w4//Wyd0j2JqE60GaDyMrFP+A5R3B2rP68Bvc
 AvW+ssyXupghtQOL87JenE3amI7AxoEGY56CA7gIOCAJ85az3lltPVfmE8Mq9Mb8CDGuv6pBH
 sXI63sn0ASGgeFMof5ra1EnZ8M4glKml6xLEiu9mLPaQV4YkPk26q1vPeqqrdb9Z3k2s97dg1
 3K06la5UJYj/ln/RYDvqSDM3K/MSSFLTjh6Y8QFZILDA2PgjS5s77h023K/9oJ4Kng4Qvz+nq
 0C8ZjHHeU4+l9X9kPuYk7k2ZF1baBlhusM2UkRwqS8awPzGY6WKi88xemTvcbAqE6/uonvyyV
 EePfecJrQUjb1V6S5TZ46ZBnWW/wD8wBcnNBceDGfCXNaSWSpKT9xi3Fyjz7fUZ7DBSUNGOCm
 CScd+oFaO+rOaxR0n/gARKH1iWboHbNEGM5J5qgaDxISxV0xWSIC6B0dino5C97CiV7YWfKmB
 RxGMewnZBo12/BqszUcC6BQCTSPPyLN4rQ/iBZiboZDfc=

On Sat, 2024-04-27 at 08:42 +0200, Mike Galbraith wrote:
> On Fri, 2024-04-26 at 18:03 +0200, Mike Galbraith wrote:
> > fwiw, tbench liked the previous version better.
>
> The culprit lies somewhere in the new PREEMPT_SHORT patch.

<squint>

Ah, moving the curr eligibility check into pick_curr() left an
ineligible curr to be seen/used further down in pick_eevdf().

found:
        if (!best || (curr && entity_before(curr, best)))
                best =3D curr;

Nit: PREEMPT_SHORT depending on RUN_TO_PARITY looks odd.

	-Mike

