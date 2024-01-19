Return-Path: <linux-kernel+bounces-31165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFBF8329FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EB3283CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89552F9B;
	Fri, 19 Jan 2024 13:02:09 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002AC524B3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669329; cv=none; b=pkB3BDfenTdSWZG0uMr/UI0xLb5+fBobzbU9bcqDApxpXfILiUxWNCck2WkqH6w7l6aCcHVnICclv8xnk7r9DrP8qE5QpaUhRv5vYyQMKqUwLyX7qDFOXyM4ocNgsQLlHysYY1TYWLMHqb9QJ+rcU8Gp8pJhh2rs1JNLzhyvZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669329; c=relaxed/simple;
	bh=eLBftNGSL1xLJR9++0mXZCIaxv96znkbq/QBETDJa9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WyPH+GkKv34W1TyyWsobMg4AasVakWGA331pUjUyQuneTcdny9m5WL5b6f/M1ICMrD60IpWCbknNdDtzdtEs6B1SpknpfVoY593g2AKpHsuMHVRf3TPT3TjRvaj/GZwq/lgqViTKweqd52tNfnQ44vlpExVLpZPbE80vcQyK2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.220])
	by sina.com (10.75.12.45) with ESMTP
	id 65AA72BF00009B9F; Fri, 19 Jan 2024 21:01:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 11669731457895
X-SMAIL-UIID: 95AE969CDE7F4D8481837C86F40B5358-20240119-210155-1
From: Hillf Danton <hdanton@sina.com>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Suman Ghosh <sumang@marvell.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request in __skb_flow_dissect
Date: Fri, 19 Jan 2024 21:01:41 +0800
Message-Id: <20240119130141.2160-1-hdanton@sina.com>
In-Reply-To: <2c5794fb-c7cd-405a-8c63-f1820b8dbfaa.bugreport@ubisectech.com>
References: <2c5794fb-c7cd-405a-8c63-f1820b8dbfaa.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jan 2024 15:32:28 +0800 Ubisectech Sirius <bugreport@ubisectech.com>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.
> Recently, our team has discovered a issue in Linux kernel 6.7.0-g052d534373b7.
> Attached to the email were a POC file of the issue.
> Stack dump:
> [ 185.664167][ T8332] BUG: unable to handle page fault for address: ffffed1029c40001
> [ 185.665134][ T8332] #PF: supervisor read access in kernel mode
> [ 185.665877][ T8332] #PF: error_code(0x0000) - not-present page
> [ 185.666481][ T8332] PGD 7ffd0067 P4D 7ffd0067 PUD 3fff5067 PMD 0
> [ 185.667129][ T8332] Oops: 0000 [#1] PREEMPT SMP KASAN
> [ 185.667719][ T8332] CPU: 1 PID: 8332 Comm: poc Not tainted 6.7.0-g052d534373b7 #19
> [ 185.668641][ T8332] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [ 185.669639][ T8332] RIP: 0010:__skb_flow_dissect (net/core/flow_dissector.c:1170 (discriminator 1))

Looks like the syzbot report [1] on 01 Jan 2024, and decoding the test
result of a debug patch [2] is welcome.

Hillf

[1] https://lore.kernel.org/lkml/000000000000498a02060de59162@google.com/
[2] https://lore.kernel.org/lkml/00000000000078d073060f4b51e7@google.com/

