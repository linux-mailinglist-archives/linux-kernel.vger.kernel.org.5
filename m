Return-Path: <linux-kernel+bounces-152994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17188AC73A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE15E2864AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41286502A6;
	Mon, 22 Apr 2024 08:38:37 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8491CAA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775116; cv=none; b=HMakrmkzUkD4gJg6o5glE84VSeAJU/300bSqrLAvHCayWjTrDwPPRy3bpKFSfRK4Jbip3PkTMRa6IyBfdiLTgbfvdVxc6rps66VhpTyBtg+odgGVkdmCu4CP6QHkz0Qn8O2p6zJBpB0TE+E9OrDVBOD57MUSNED+6q/KpfVEJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775116; c=relaxed/simple;
	bh=Y5LaT6VMQwV75sFLhiDLZlNUiEGLXlU7BLi/iw4fmdQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eK9FsMJe8XM4BGAQYcVPmubi+3dJGOjHxgfOhEVzVIqOQZohC5IvPoOE2XZHQSbqSfThfbZrf/99GhewwJCSV7GfVrkXJi6CUsncjglDlK9HXTqFtAB1hMvmzTittUntdGTI4JExu8OX9r3BH9ce5qg7LgrNVPpNMNfppWq6r1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1713775098t358t44927
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.247.132])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11855313605505495495
To: "'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>
Cc: <brgl@bgdev.pl>,
	<elder@linaro.org>,
	<geert+renesas@glider.be>,
	<linus.walleij@linaro.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<paulmck@kernel.org>,
	<warthog618@gmail.com>,
	<wsa@the-dreams.de>
References: <02a101da9227$bda04cb0$38e0e610$@trustnetic.com> <CACMJSeuGu4nCVsbSnTrJwEdU+RF0BKHbzS7A9Cf2CiM_stJPzg@mail.gmail.com>
In-Reply-To: <CACMJSeuGu4nCVsbSnTrJwEdU+RF0BKHbzS7A9Cf2CiM_stJPzg@mail.gmail.com>
Subject: RE: [PATCH v3 00/24] gpio: rework locking and object life-time control
Date: Mon, 22 Apr 2024 16:38:17 +0800
Message-ID: <033a01da9490$6c517490$44f45db0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKkRktGdWWxOHu8pOWwvozmol9uowIV96vBr8/aZvA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Sat, April 20, 2024 5:29 AM, Bartosz Golaszewski wrote:
> On Fri, 19 Apr 2024 at 09:04, Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> >
> > Hi Bartosz Golaszewski,
> >
> > I ran into a kernel crash problem when I pull the latest net-next.git, and
> > finally it was found that is caused by this patch series merged.
> >
> > The kernel crashed because I got gpio=0 when I called irq_find_mapping()
> > and then struct irq_data *d=null, as my driver describes:
> >
> >         int gpio = irq_find_mapping(gc->irq.domain, hwirq);
> >         struct irq_data *d = irq_get_irq_data(gpio);
> >
> >         txgbe_gpio_irq_ack(d);
> >
> > The deeper positioning is this line in __irq_resolve_mapping().
> >
> >         data = rcu_dereference(domain->revmap[hwirq]);
> >
> > So, is it the addition of SRCU infrastructure that causes this issue?
> >
> 
> This is irq-specific RCU that I did not add in the GPIO series. Please
> provide us with more information. Bisect to the exact commit causing
> the issue and post the kernel log (we don't know what kind of crash
> you trigger and what the stack trace is).
> 
> Bart
> 

Hi Bartosz & Andy,

Thanks for your replies.

I'm sorry for the misunderstanding, and glad this patch doesn't cause any
problems. I thought the issue was in this patch because of my mistake.
It's actually caused by other patches. :)






