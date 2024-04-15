Return-Path: <linux-kernel+bounces-144832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A08A4B66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220471F225BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB563EA96;
	Mon, 15 Apr 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="gBT/iVry"
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE0383B0;
	Mon, 15 Apr 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173189; cv=none; b=BjXLxLnc7E9c72rYSWS53s8VD8M3ZbollZ82b30WZdbewvty3isI6920CPBdmYWaPg3wbmB6gW6HrPI9uWJjGAjSj4jOu8SYuyjguYHOQ1WH1dL0zlcNlu96EBqIIwsw4QbfGRXM/jusKITMWgvYz/sbhZitBeMI+SYrM+LM8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173189; c=relaxed/simple;
	bh=KA0+CPGFHfmJHhAA2WmrZiTNFjssWuFlhgCioLGnjA8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ggM3/p3wn5MD/mNoKT7ym0e4mMU7xo6ZkgsaEsqEsf1pJT9Hp/dcQ+fAWMKG2a7vsuPj6oQhtEIRvYzF7ol6kYsz2rqk5YoOz+1FsIPvlyiimA9p4MMOiMtEgRQEHeXXrb4UmowJAreGIsTKH3qNb8+Qaw7PfZttlCHLtm2wUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=gBT/iVry; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 43F9Q1wd282006
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:26:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1713173161; bh=KhON5lChtzng6LnzOvsC9a6xUGsfOfDLK851N17ueKo=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=gBT/iVryaQKnEpshAetRo1gqYfeWE5fMOr0JcXNrQms4RNkb23VQPMQQToJoeafCC
	 OyWV7Cx2ehV8y2ZunWa5dicINVXP4WJ9q8XMJ/L3NuMI3lx0dVlV/qEGqhfgoRZhCt
	 OU9wop3EdhfbNyI001tmgVZBaGfbCM+ggzGcr8I0=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 43F9Q0dW399022
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 11:26:00 +0200
Received: (nullmailer pid 21640 invoked by uid 1000);
	Mon, 15 Apr 2024 09:26:00 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: Aleksander Morgado <aleksandermj@chromium.org>, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, ejcaruso@chromium.org
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
Organization: m
References: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
	<87mspvi0lk.fsf@miraculix.mork.no>
	<a6ad34d3-9cce-4178-8271-0e09ced2b6f4@suse.com>
Date: Mon, 15 Apr 2024 11:26:00 +0200
In-Reply-To: <a6ad34d3-9cce-4178-8271-0e09ced2b6f4@suse.com> (Oliver Neukum's
	message of "Mon, 15 Apr 2024 11:06:33 +0200")
Message-ID: <878r1fht93.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Oliver Neukum <oneukum@suse.com> writes:
> On 15.04.24 08:47, Bj=C3=B8rn Mork wrote:
>
>> urb from service_outstanding_interrupt(). That's why it was added. See
>> the explanation Robert wrote when introducing it:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/drivers/usb/class/cdc-wdm.c?id=3Dc1da59dad0ebd3f9bd238f3fff82b1f7ffda7829
>
> Well, the explanation is correct in that we must read
> data available. However, if the RESPONDING flag is set
> and the URB submitted, we are already doing so.

Sounds reasonable.  Except that the bug proves we didn't.

If you are right that service_outstanding_interrupt can race againts
itself (and I don't doubt that), then I guess this could also happen
between failure to submit the URB and clearing the flag?

>> As for the XMM behaviour: it's been a long time since I tried any of
>> those, but AFAIR one the major differences compared to Qualcomm was the
>> strict queue handling in the firmware.  This caused a number of problems
>> where the cdc-wdm driver wanted to skip a message for some reason.  So
>> I'm not surprised that a bug like this is triggered by one of those
>> modems. That's probably the only thing they are good for :-)
>
> I am not sure where exactly the issue lies here. Suggestions for
> debugging?

Nothing more than the obvious;  Get one of those modems and do some
usbmon snooping.


Bj=C3=B8rn

