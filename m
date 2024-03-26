Return-Path: <linux-kernel+bounces-119201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F12F88C57B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B2B1C334D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA913C663;
	Tue, 26 Mar 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7eF0AEr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867E13C3F1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464238; cv=none; b=LH27Tcr4vHwE+XGKyhkFiYkJrAVCksDUSEOQ2GXc6YHdLmDU/fyld666gKCZx383lyWe5VgV4Dl24iTIY8/C8ZeHe3V80D5aw49Nir4GWLQn2lEAJXFZkuJCOJ3kbZyqQ9VeYb7moqNMfxF/joahWZebk2g7ifuATKtEpaR5P8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464238; c=relaxed/simple;
	bh=PKvs+Ifa+14hX9p1LNFxIABmBql5tpHj1BT+AEjdf4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQhFdGac6uxagty3d8tdy3etEBQiB8zZ7UXIx2ZpuQEhtanMdg6OMwKWxEc7U8/jV4a3CeggXirvICnqusWQIBYnwGx8cXYKclcvO0TO9JTls6YLy5E3NXrBNsdW1+eZeP/g7WGjVJdfSrXrdYNiyLJ8ZOMbbc9yGlzYd4D6Bj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7eF0AEr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4146f72e2dfso80105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711464235; x=1712069035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvRPX0srI6Nwl8MPf7Dm2KIiqeWF1NL4djSI9z970zQ=;
        b=j7eF0AErNCfdNZ2PD1wsOWfXdC5Jh8J7dBnJO33CYFakuVAfmomB1afAjrA2ZQKaf7
         SMCUShieYJmAq7gWFqeKiuzNsdPlakY567KsZgQtG6gDsvwrQnihtDX9+7U6NnTFaRZx
         RHdmBYPFetsNb4ILWudJVYpkr4lIVhA7ivbuDLUlArt/M4CW8YovnQw3HaJC3Vve4LJk
         07Dc1d2Xmbg2GP5NJiN4sJkJFjjOH+WJ4ise/PHJgmz0GVRw0XTJDFpcV+OEaxiIIlbM
         5ZVB2IfKYG47wlrtEXxWyDwcV5YZW42vBkqVqTdsC59D7fdDc8Bu9Y/dWpeZ/dX6pmg1
         KlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464235; x=1712069035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvRPX0srI6Nwl8MPf7Dm2KIiqeWF1NL4djSI9z970zQ=;
        b=Rr+dItu/6waXs9onNzHEIT6s6+0KBwC/YtzPYjdO/u7aOEbaOr/M3WcaYuVBDduni2
         6mz6Gi92sqZwIF/+EkvnTkg3UdSShk0mOJ08bZHN81dtIIurOXqkpgLhiQnP8Iy9ZA1m
         JsKcfQBo3jrjWMl3OruqbjCAzA0jCSq4NtkZaSicCZlEwr7zUj0+BiEHBxufAEIsrMzS
         IYK8YFuIG4N5rq2z5U7IlDNDQww9o/EN/RcumK6sV8Q3QgeAff9ZFR0EYeryKaSSzntn
         jrEp4suYmizHSGfKfrVMcEvwZH8PXlFQhJlkOMPD1h9pwsjPWHj8WRaQUguxRyj5DNco
         5DfA==
X-Forwarded-Encrypted: i=1; AJvYcCX+l5fRvp+8XJZaWZwQ7G0LKuLH6ELCNhyc1m3w8ZkMISdObHeWwOoBCkmMOcxZvET7jyjpodnSKghy+SAw9ATSCEP4Jf27tg02U8+z
X-Gm-Message-State: AOJu0YyF9ZQ2Ze/d7DAhIlcirreyjQhRnPQitUfPTjG+u2GYbpMaKMDu
	EWk8nNbkKvQnvIBvSH2iJwo6uDWzxQZ1BBozw6Y7r72vvG/Aqjl6kCzZUg7XEe10hHpaY909T+U
	fE1HC7jKNDz6Z2rgh8UdelsXV0aGvLRyMTfJc
X-Google-Smtp-Source: AGHT+IHyQfy0mSMBb57kAfmIDvkx81N8QcG0TvDbWsHX47nCDYyzaS87QB9tRR8mdSTMbNlTZoEBVpDdNz8bsVEN72U=
X-Received: by 2002:a05:600c:1c06:b0:414:11:ec14 with SMTP id
 j6-20020a05600c1c0600b004140011ec14mr185229wms.6.1711464234407; Tue, 26 Mar
 2024 07:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319074337.3307292-1-kyletso@google.com> <2024032624-drizzle-coaster-c97f@gregkh>
In-Reply-To: <2024032624-drizzle-coaster-c97f@gregkh>
From: Kyle Tso <kyletso@google.com>
Date: Tue, 26 Mar 2024 22:43:36 +0800
Message-ID: <CAGZ6i=1BGzRD7nGnLKcbZJOWT_d88gAS_NWUg9KvZ4=wmT8xsw@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Correct the PDO counting in pd_set
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, badhri@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 5:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Mar 19, 2024 at 03:43:37PM +0800, Kyle Tso wrote:
> > The index in the loop has already been added one and is equal to the
> > number of PDOs to be updated when leaving the loop.
>
> That says what is happening but not the issue that is being addressed.
> What is the problem with the number being off by one?  Is this a "crash
> the system" or merely "our accounting is wrong"?
>
> thank,
>
> greg k-h

When doing the power negotiation, TCPM relies on the "nr_snk_pdo" as
the size of the local sink PDO array to match the Source capabilities
of the partner port. If the off-by-one overflow  occurs, a wrong RDO
might be sent and unexpected power transfer might happen such as over
voltage or over current (than expected).

"nr_src_pdo" is used to set the Rp level when the port is in Source
role. It is also the array size of the local Source capabilities when
filling up the buffer which will be sent as the Source PDOs (such as
in Power Negotiation). If the off-by-one overflow occurs, a wrong Rp
level might be set and wrong Source PDOs will be sent to the partner
port. This could potentially cause over current or port resets.

I will update the commit message in the next version of this patch.

Kyle

