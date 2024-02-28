Return-Path: <linux-kernel+bounces-85537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34D86B739
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46037B24E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B941A85;
	Wed, 28 Feb 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LQBnx1tm"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168179B74
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145155; cv=none; b=XrUMlzb7N2VdqIoFfHFWBhXPMr1uIW6lOSaMIdeSlw4h9OnGR5AoDuFScXFU9Gn7Uw1sqeOiSEeII95H8hnR+WH62CXs5KEZ9YfohgyplkXtNhjYn6VnnOBPYM23yNKtNwz/mJtlfGmzTkByCQoz7EMn3JdM5WaxTs4Yu+v4S+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145155; c=relaxed/simple;
	bh=l4Cl/NiST64tWraJyXUgveTevRf2vajXlc6iu9H/Kd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkVFcyiDA2HwJ5MMG9PzJSpPTMf1ANiXvsu8SK+1IVeoayiJU9Ns6AE3f0AsRVcLyFwP5RZqTIPY/q+Bs5kv1JiQBNOnTS1wvoYC+K+UilfxoyLibh+l/e715N6LYguPaMQSPp0jstKiJAAYcYgeGFrcr2QDYHhTMEEwBgRwE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LQBnx1tm; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 78DFDC003C0F;
	Wed, 28 Feb 2024 10:32:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 78DFDC003C0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1709145147;
	bh=l4Cl/NiST64tWraJyXUgveTevRf2vajXlc6iu9H/Kd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQBnx1tmznLXpdPCptiFL8VTMrcO6TrRtWeCG4F5+12sJQ1AYnCCBIwON7JuSkmB2
	 oPaqPhCheo95zFf5PFPUDPg0sgyXGAv3IRLFZrOG2hrSFRwB7BLmM+C0s20SVPZFXL
	 1D1tZllw95tW5L4ip6yDReaibsKB/c/FNUkRAZMw=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id E0E2918041CAC4;
	Wed, 28 Feb 2024 10:32:25 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: bcm: stop selecing CONFIG_TICK_ONESHOT
Date: Wed, 28 Feb 2024 10:32:27 -0800
Message-Id: <20240228183227.1822982-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228123850.3499024-2-arnd@kernel.org>
References: <20240228123850.3499024-1-arnd@kernel.org> <20240228123850.3499024-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Wed, 28 Feb 2024 13:38:42 +0100, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> ARCH_BCM_MOBILE is the only platform that selects CONFIG_TICK_ONESHOT,
> the others stopped 12 years ago in commit 98fab064d321 ("ARM: Remove
> unnecessary selection of TICK_ONESHOT").
> 
> This inconsistency caused a build regression after an otherwise
> correct change to the timers subsystem:
> 
> kernel/time/tick-sched.c:1599:6: error: redefinition of 'tick_sched_timer_dying'
>  1599 | void tick_sched_timer_dying(int cpu)
>       |      ^
> kernel/time/tick-sched.h:111:20: note: previous definition is here
>   111 | static inline void tick_sched_timer_dying(int cpu) { }
> 
> Drop this dead select.
> 
> Fixes: 3aedb7fcd88a ("tick/sched: Remove useless oneshot ifdeffery")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian

