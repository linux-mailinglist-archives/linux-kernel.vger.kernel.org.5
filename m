Return-Path: <linux-kernel+bounces-102620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E2B87B4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ABB284E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE405C90A;
	Wed, 13 Mar 2024 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX9HwtAb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F751016;
	Wed, 13 Mar 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370376; cv=none; b=YjXSjcEnerHP2iwBlWuXFH2MmJkUjKOK7yKiM139zBonPI67pu4cMwKh2bq7SD69hfZRX5K95/4Jk0HzX7jrZQQ8vdPurGaS9YdWerTvSdyd6mA4twIUEuJvw23ExqQfFAIGHh1nXaqIAdZGsA3opuHnH+l72FHv4wSbUJZgjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370376; c=relaxed/simple;
	bh=j8wizuNnMkBHpI1E8RbBcBOMbssfc76hVogMMDgT6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9ogsgOQEcDaD7K/M7Eesn1r0xjWdbsJL0W3R5WoxOFRS1Cb3NDpiU07RphJ4mu5c4vdQCEMdIpCv9BzBnD0PzOlXQ2bfXOK9rHpcIaYGYj94KAED24tAIKxWapno+isqDh/3nVzdSpZBdg41APElJmOYBKS9D4pi5HAdJ3uSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX9HwtAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2B8C43390;
	Wed, 13 Mar 2024 22:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710370375;
	bh=j8wizuNnMkBHpI1E8RbBcBOMbssfc76hVogMMDgT6ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BX9HwtAbUyVcVxvoMciVaTIGZ5UAdBQ9npWQLM1hzpNBMYkMT4InTnMYQCQI9rLJe
	 35iG+6ygN12KmhHLV9npQbCA488YniIv5TCnqrTRhYor76tVNU/Rm/uj+NlhMoez1D
	 67UwfsOx3eO1XMc9wUJ1kRLe1YwMGd2Qgzd+3OQq41ysmihlp7bx6+6rBwrHGMn9Ry
	 jzULHqKDzhNNOxbwHy1esVl08I7AYhmNz3eaYmbnmyjaIkElrGa70wT1ecpqXh8fEY
	 DMGl3mvDYC/GebANPxhn0LXPWkYbdm+lrAABXwbSgpsvqKoDJbGONs3f1LAFiT5eUp
	 ZMh2BI7aypcLg==
Date: Wed, 13 Mar 2024 23:52:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <ZfIuRMo8oKbR08Af@lothringen>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>

On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
> On 3/13/24 14:59, Russell King (Oracle) wrote:
> > On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
> > > I will try to provide multiple answers for the sake of everyone having the
> > > same context. Responding to Linus' specifically and his suggestion to use
> > > "initcall_debug", this is what it gave me:
> > > 
> > > [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
> > > [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
> > > [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> > > [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
> > > [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
> > > [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
> > > 
> > > Also got another occurrence happening resuming from suspend to DRAM with:
> > > 
> > > [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
> > > platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
> > > [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
> > > platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
> > > 
> > > and also with the PCIe root complex driver:
> > > 
> > > [   18.266279] brcm-pcie f0460000.pcie: PM: calling
> > > brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
> > > [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
> > > [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
> > > [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
> > > returned 0 after 159190939 usecs
> > > [  177.457257] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
> > > 
> > > Surprisingly those drivers are consistently reproducing the failures I am
> > > seeing so at least this gave me a clue as to where the problem is.
> > > 
> > > There were no changes to drivers/net/ethernet/broadcom/genet/, the two
> > > changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
> > > the read_poll_timeout() conversion is correct, we properly break out of the
> > > loop. The initial delay looked like a good culprit for a little while, but
> > > it is not used on the affected platforms because instead we provide a
> > > callback and we have an interrupt to signal the completion of a MDIO
> > > operation, therefore unimac_mdio_poll() is not used at all. Finally
> > > drivers/memory/brcmstb_dpfe.c also received a single change which is not
> > > functional here (.remove function change do return void).
> > > 
> > > I went back to a manual bisection and this time I believe that I have a more
> > > plausible candidate with:
> > > 
> > > 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
> > > hierarchical pull model")
> > 
> > I haven't understood the code there yet, and how it would interact with
> > arch code, but one thing that immediately jumps out to me is this:
> > 
> > "    As long as a CPU is busy it expires both local and global timers. When a
> >      CPU goes idle it arms for the first expiring local timer."
> > 
> > So are local timers "armed" when they are enqueued while the cpu is
> > "busy" during initialisation, and will they expire, and will that
> > expiry be delivered in a timely manner?
> > 
> > If not, this commit is basically broken, and would be the cause of the
> > issue you are seeing. For the mdio case, we're talking about 2ms
> > polling. For the dpfe case, it looks like we're talking about 1ms
> > sleeps. I'm guessing that these end up being local timers.
> > 
> > Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
> > for link up every 5ms - if the link was down and we msleep(5) I wonder
> > if that's triggering the same issue.
> > 
> > Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
> > say. I would imagine that the same hardware timer driver is being used
> > (may be worth checking DT.) The same should be true for the interrupt
> > driver as well. There's been no changes in that code.
> 
> I just had it happen with ARM64 I was plagued by:
> 
> https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
> 
> and my earlier bisections somehow did not have ARM64 fail, so I thought it
> was immune but it fails with about the same failure rate as ARM 32-bit.

Can you please boot with:

    trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel

And add the following and give us the resulting output in dmesg?

diff --git a/init/main.c b/init/main.c
index d002f30f7f24..f3d548919868 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1233,13 +1233,24 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	int count = preempt_count();
 	char msgbuf[64];
 	int ret;
+	long start;
 
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
 	do_trace_initcall_start(fn);
+	start = READ_ONCE(jiffies);
 	ret = fn();
 	do_trace_initcall_finish(fn, ret);
+	if (READ_ONCE(jiffies) - start > HZ * 20) {
+		static bool warned;
+
+		if (!warned) {
+			warned = 1;
+			ftrace_dump(DUMP_ALL);
+		}
+	}
+
 
 	msgbuf[0] = 0;
 



