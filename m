Return-Path: <linux-kernel+bounces-125980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7FE892ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78D3282399
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCE8C11;
	Sun, 31 Mar 2024 07:25:23 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8098BE0
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711869922; cv=none; b=eHMxXs+ZxkndEuHY5lls1tf5VTqEwvLBC9KcjL31TjXTyLVxXkIFrSENIh8utwRSfsvDb2o+Gg0aPPqSTKXyvskhXiDhQKHHE58mDgF16hQyMcR4S0dsdtkhKbiAm/KuxN3zMIFEDuu5T4Ep/puPqOUTpUh9Kb2ad8FxoOy7kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711869922; c=relaxed/simple;
	bh=3aRlYHjl0cDSvuP3zB/AQrH5Q4ttGK6cNA4MSdziywk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jioVV9lIzapWTR3cJBZlb8OovlWxK+pSnQjzNyWq4SmSswFhfgbLbZVbMbZZC4JrshQ+CBUAQegMeQnOvmuxA39xTJUVhgGFBG5JhVhuwqObYH/7eZiNxoHoB6XUjBqAInMPQBUotZG8DiAWAVi5dP1UBD9DBKob/DtbeKxVLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.152])
	by sina.com (172.16.235.24) with ESMTP
	id 66090FD700007E60; Sun, 31 Mar 2024 15:25:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 52126445088869
X-SMAIL-UIID: D23621F6DF274A20A834387687F31E01-20240331-152514-1
From: Hillf Danton <hdanton@sina.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Paul Moore <paul@paul-moore.com>,
	syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in kauditd_thread (4)
Date: Sun, 31 Mar 2024 15:25:02 +0800
Message-Id: <20240331072502.3456-1-hdanton@sina.com>
In-Reply-To: <ZgVvN5DmLLMaAg_S@alley>
References: <000000000000d929dd0614a8ba8c@google.com> <CAHC9VhTWk8j2OnnH+307UzH+A4tLAmcyw7xde3KboZJ0JE2hzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 15:44:27 +0100 Petr Mladek <pmladek@suse.com>
> > > Call Trace:
> > >  <IRQ>
> > >  </IRQ>
> > >  <TASK>
> > >  csd_lock_wait kernel/smp.c:311 [inline]
> > >  smp_call_function_many_cond+0x50b/0x1590 kernel/smp.c:855
> > >  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
> > >  on_each_cpu include/linux/smp.h:71 [inline]
> 
> It seems that this is really stuck because it is not able to
> run something on the other CPU.
> 
> IMHO, the primary problem is in the code proceed by the hrtimer.
> Adding networking people into Cc.

Yes the taprio hrtimer is a CPU hog [1]

[1] https://lore.kernel.org/lkml/00000000000003c53d0614ef21a4@google.com/

