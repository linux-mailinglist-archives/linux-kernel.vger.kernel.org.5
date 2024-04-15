Return-Path: <linux-kernel+bounces-144947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5AE8A4D02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F240B24C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DC5D49F;
	Mon, 15 Apr 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="WU11rnaY"
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F005D464;
	Mon, 15 Apr 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178438; cv=none; b=R9v9HVAeKlTvN/091qo4DDoQ/VEVHKpnnE8+3mXJtXbewdgkhnEpHfyiDxJNPbcvqJdytT5dEsY05N1lWvf2ahnI1olvdQGX02v7D1ZbweVWCaszLX3QTadQElRHmeBIeQykwYd/YDhk8uYJcvBbrO8E3xsb5F3PyT0jKFk4Bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178438; c=relaxed/simple;
	bh=aRqk/teKrvviMXPIKT6CFs5nPU17ZzN3A/AFbFn/rYk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ad2RBoGYr1pb3kfz8nfeUp7Cdvx3VAlHuTnR+kWcjkVwz0fJ9X8zcl2kMxqCtrN0oZQYb6QMc0L5z6N7DO8lBL8kTCQMKkdw+BquNfPmkhuiVHwAs4OXTQ6yjdGLerd1sJZ6D9+jy8PmC3PAl9UI1hJyiDaMBNX3CoRwBXvLVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=WU11rnaY; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 43FArVFM290552
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 11:53:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1713178411; bh=evnSF5iKpjGMd8Coo4PRridXTe2uovVu5XsS2E67BXI=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=WU11rnaYXQnScPk7sy81LB/qJK6arWi6GcUk/SG/8ypFQcgwBQ/TARo343gC3PoXi
	 hbWcvicvCw3uoyh2SEOF3bjhnPOVZ99Xt3RZgmUDIuYYLLV/PXT2PAhiq2NNeJeJIw
	 SjFVq0f4thmIK//bo7DXDu9Ioy15UqVqfJYVPZ2w=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 43FArVGc414736
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 12:53:31 +0200
Received: (nullmailer pid 25807 invoked by uid 1000);
	Mon, 15 Apr 2024 10:53:31 -0000
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
	<878r1fht93.fsf@miraculix.mork.no>
	<c35f98be-23a3-41c3-bee5-f394ce504545@suse.com>
Date: Mon, 15 Apr 2024 12:53:31 +0200
In-Reply-To: <c35f98be-23a3-41c3-bee5-f394ce504545@suse.com> (Oliver Neukum's
	message of "Mon, 15 Apr 2024 12:14:48 +0200")
Message-ID: <8734rmj3ro.fsf@miraculix.mork.no>
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
> On 15.04.24 11:26, Bj=C3=B8rn Mork wrote:
>> Oliver Neukum <oneukum@suse.com> writes:
>>> On 15.04.24 08:47, Bj=C3=B8rn Mork wrote:
>>>
>>>> urb from service_outstanding_interrupt(). That's why it was added. See
>>>> the explanation Robert wrote when introducing it:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/drivers/usb/class/cdc-wdm.c?id=3Dc1da59dad0ebd3f9bd238f3fff82b1f7ffda78=
29
>>>
>>> Well, the explanation is correct in that we must read
>>> data available. However, if the RESPONDING flag is set
>>> and the URB submitted, we are already doing so.
>> Sounds reasonable.  Except that the bug proves we didn't.
>
> Why? I am afraid I do not get that part.

I don't get how it happens either.  But that's the only thing changed by
the patch.

>  > If you are right that service_outstanding_interrupt can race
>   againts
>> itself (and I don't doubt that), then I guess this could also happen
>> between failure to submit the URB and clearing the flag?
>
> Yes, it can. In fact in this case the behavior should not change.
> I am afraid we have a misunderstanding. It seems to me that in the
> unchanged driver the result of service_outstanding_interrupt()
> is undefined.
> Please explain.

Sorry, I am so lost here that I am probably only confusing things.  I do
not understand why we unlock &desc->iuspin around the usb_submit_urb
call.  And git tells me I wrote that.


Bj=C3=B8rn

