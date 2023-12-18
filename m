Return-Path: <linux-kernel+bounces-3367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F260E816B90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DE8B21D39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4418021;
	Mon, 18 Dec 2023 10:49:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC51945D;
	Mon, 18 Dec 2023 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8641FB;
	Mon, 18 Dec 2023 02:50:31 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BEBD3F738;
	Mon, 18 Dec 2023 02:49:46 -0800 (PST)
Date: Mon, 18 Dec 2023 10:49:43 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/6] of: irq: add wake capable bit to of_irq_resource()
Message-ID: <ZYAjxxHcCOgDVMTQ@bogus>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.3.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
 <20231213221959.GC2115075-robh@kernel.org>
 <CANg-bXB0EAd-703oOzXsFSS72Z3bfT8La_5K=W41L+B1uMz2-Q@mail.gmail.com>
 <20231215153035.GA3996646-robh@kernel.org>
 <CANg-bXDfOp4e6WDx9JF5XyxjSvh-ctNsM1TTgr8N1NzfDvzpgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANg-bXDfOp4e6WDx9JF5XyxjSvh-ctNsM1TTgr8N1NzfDvzpgw@mail.gmail.com>

On Fri, Dec 15, 2023 at 01:56:47PM -0700, Mark Hasemeyer wrote:
> On Fri, Dec 15, 2023 at 8:30 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 02:05:16PM -0700, Mark Hasemeyer wrote:
> > > > If a device has multiple interrupts, but none named "wakeup" you are
> > > > saying all the interrupts are wakeup capable. That's not right though.
> > > > Only the device knows which interrupts are wakeup capable. You need:
> > > >

Agreed.

> > > > return wakeindex >= 0 && wakeindex == index;
> > >
> > > I was assuming logic described in the DT bindings:
> > > https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
> > > "Also, if device is marked as a wakeup source, then all the primary
> > > interrupt(s) can be used as wakeup interrupt(s)."

At the time it was written, the intention was not to fix any particular
interrupt as wakeup but leave those details to the device. Also this was
just to consolidate various variation of similar bindings/support for the
same wake feature. It didn't enforce any rules as what can be or can't be
wakeup interrupt.

> >
> > Also not the best wording I think.
> >
> > Which interrupts are primary interrupts?
> >
> > If we can't determine which interrupt, then we should just leave it up
> > to the device.
> >

Again I agree with this.

> +Sudeep who authored the documentation and Rob Ack'd: a68eee4c748c
> ("Documentation: devicetree: standardize/consolidate on "wakeup-source"
> property")
>
> I think what Rob is suggesting more closely matches what ACPI supports: where
> interrupt resources are individually marked as wake capable.  The binding
> documentation should be updated though.
>
> Something like:
> ```
> If the device is marked as a wakeup-source, interrupt wake capability depends
> on the device specific "interrupt-names" property. If no interrupts are labeled
> as wake capable, then it is up to the device to determine which interrupts can
> wake the system.
>
> However if a device has a dedicated interrupt as the wakeup source, then it
> needs to specify/identify it using a device specific interrupt name. In such
> cases only that interrupt can be used as a wakeup interrupt.
>
> While various legacy interrupt names exist, new devices should use "wakeup" as
> the canonical interrupt name.
> ```
>
> Parts of the kernel (I2C, bluetooth, MMC) assume "wakeup" as the
> interrupt-name. I added some wording to clarify the assumption.
>
> Thoughts?

Above wordings sounds good to me.

--
Regards,
Sudeep

