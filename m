Return-Path: <linux-kernel+bounces-10519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0554681D57B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362F81C20E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC45612E4C;
	Sat, 23 Dec 2023 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b="BjGFN+t+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793712E56
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khvoinitsky.org
X-Gm-Message-State: AOJu0Yyg+j9071jyseCb+7HOu08V/ste7PwuNUP/yjhjEe9xAxWUH9s4
	K2+7kjjqGYXGWk3z30mbNjcTSLqSP9qp8jO5imw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khvoinitsky.org;
	s=key1; t=1703354679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clZIOd3V3Ycgt96OLxSdyCojGLmOX01/RV/V1oCF3ME=;
	b=BjGFN+t+F40aRuhstFBxIkli4GbVz5sQiuhuaGZy98F/BRw+pXsW3az/ZcLoXaoBZLgQQ0
	mlJWu8wTUiFy9urWx7rJrQbY/83ley+SsiwfKBOZKsTNbDR744qK9Jl+ONB/1LvD/9eS/B
	PhYhL+Hz8hSYjH60ez6gM1yP/HYFaxs=
X-Google-Smtp-Source: AGHT+IE7T0rWy8ho544JYhKbl/1LVf3LWEdRFUJo9liIiKTZ74vK1za4gJqIV4kZBED07DNumN/dlbXuY3H4aN7Yu1E=
X-Received: by 2002:a05:6512:b86:b0:50e:6fda:818 with SMTP id
 b6-20020a0565120b8600b0050e6fda0818mr2135494lfv.3.1703354677681; Sat, 23 Dec
 2023 10:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2312121445510.24250@cbobk.fhfr.pm> <3a29c0a6-9b53-433d-a83d-5b68a87c1155@mailbox.org>
In-Reply-To: <3a29c0a6-9b53-433d-a83d-5b68a87c1155@mailbox.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Mikhail Khvoinitsky <me@khvoinitsky.org>
Date: Sat, 23 Dec 2023 20:04:26 +0200
X-Gmail-Original-Message-ID: <CAMMabwPd-m7a+EQV7zb=wU52=P1FkqFU1dg9=gyvaS1EP5tX3Q@mail.gmail.com>
Message-ID: <CAMMabwPd-m7a+EQV7zb=wU52=P1FkqFU1dg9=gyvaS1EP5tX3Q@mail.gmail.com>
Subject: Re: [PATCH] HID: lenovo: Restrict detection of patched firmware only
 to USB cptkbd
To: "Uli v. d. Ohe" <u-v@mailbox.org>
Cc: jkosina@suse.com, benjamin.tissoires@redhat.com, iam@valdikss.org.ru, 
	jekhor@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hello.

Thank you for the report, sorry about that. I've received one more
report of the same issue by email.
So this means that the only reliable way is to add a sysfs parameter.
I'll send a patch.


On Fri, 22 Dec 2023 at 17:32, Uli v. d. Ohe <u-v@mailbox.org> wrote:
>
> I get buggy middle button scrolling behavior on my USB Compact Keyboard
> (i.e., "1st gen") with original, unmodified firmware and the patch (of
> Sep. 23).
>
> Sometimes the keyboard sends REL_X events while the middle button is
> pressed. Thus the old "workaround" is disabled and middle button
> scrolling henceforth exhibits the known buggy behavior.
>
> Explicitly, I can confirm that the following values occur, leading to
> erroneous disabling of the workaround:
>
> cptkbd_data->middlebutton_state == 1
> usage->type == 2 [i.e., EV_REL]
> usage->code == 0 [i.e., REL_X]
>
> The keyboard is identified by lsusb as:
> ID 17ef:6047 Lenovo ThinkPad Compact Keyboard with TrackPoint
>
> This was tested with kernel 6.1.67 which contains the backported patch
> (commit 6e2076cad8873cc2a9f96e4becab35425c3656dc).
>
> I didn't test the latest patch of Dec. 12. However, I don't expect it to
> fix my issue as the only added condition
> hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD
> should be satisfied, which I understand is also the intention.
> (USB_DEVICE_ID_LENOVO_CUSBKBD == 0x6047, which is the device ID of my
> keyboard as reported by lsusb.)
>
> Best regards,
> Uli

