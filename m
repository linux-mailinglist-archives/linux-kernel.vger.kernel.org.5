Return-Path: <linux-kernel+bounces-111670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58BC886F53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6ED2B248A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06297482D1;
	Fri, 22 Mar 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEoVVAJb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F67482C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119631; cv=none; b=S35Il4n9iKqNfz/jc4hbZEZKYgT+DSGXzMR99MvmVFtfDHAXR1jbfNRy6ULRU7HNo7sPjzJPcTikBZ8CezOjKebwZNmtZ5wYeYgj5MfwjqWjIgoYErMEwy5WBwk9vypAet2YpUOUBNmhT6kGVGYrbiBsQTeBuimFdzPP/zYaVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119631; c=relaxed/simple;
	bh=qXdtNxvPpsbpNODgvKjpT5XrGKp9Pc9HMJY7AIX1h3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltrO6E1IXoZuJl33QjDdvGzJFg41j3QtOzADJB73yq4KinLU7DG+gIQ+xubKGzicptR/25o+8K5wFVWFTGUEY8XSvDv5sckrC2WUxCagGjxFBGCzD50bCe+8jeln0IblZ2jQj4YXJMQTGFrqHU7QEYBzuSsTUw1E4L2Pm+MMdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEoVVAJb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711119628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ot97iwVakR2lkEIdq7JcwHUhieIrzYpSO8j17uVWGlI=;
	b=KEoVVAJbe3uloCRgO6WKszqfyRRwrILRmHy5t0/7apQ1T97xLgn9v4Kw1/eu0MXilJQNzd
	lP2HXWQ2gZZ60z/xwkDv2dm3cWnJI79o3AkpYuWwujbe7GRU8bS9jxQoGR9CWO+H/o8/rl
	KzZ+VpFONk/v+mCiEEwI8J7qDdcb6O4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1_tS1aqYOcy8k7HF8HPslg-1; Fri, 22 Mar 2024 11:00:26 -0400
X-MC-Unique: 1_tS1aqYOcy8k7HF8HPslg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d496045cf1so20641161fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119624; x=1711724424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot97iwVakR2lkEIdq7JcwHUhieIrzYpSO8j17uVWGlI=;
        b=uE8PpnmhWd8rS/Yjw4RIE91pLRQtX3AUpXrN08e4GLXgV4SmYI/wgaNKHfsGKpFaq3
         OhOZLTMnRE4iK+cDqfdQ6qt0NY8FTLumARf4LtlTldjdtvylwBo7FRSNHM2Eq0SQ/04N
         xeWbUxvhzNHLzXRpXM6Jh5B96ccJ/TnbU2Ljuzlt8OIMKnGS0mQT+4XrTzQ4ZpCE6bTO
         B7VpfYydcme353x8N5W7fMDgXcnTFY8KWGMisxwybauYxSSL6smmeeETRskLYRVU2rGr
         d3YjcM6j+NbtsVP7gzA1PHXmkwscAFu61bqQK/GienSQt9zmW1NVdCzujM4Cr8zfi6FW
         GSNw==
X-Forwarded-Encrypted: i=1; AJvYcCWDWpJ//8Y9DpAaJc6pEu02M7p/KI+SBltqbzDb0Bjv7kOesR8GFKPZcrSUb3U58tuoBCvkRPbSJHY7hPh77jaqNEritoyEGXWAKPDj
X-Gm-Message-State: AOJu0YwkFeNcwbKxSxrjPKo/g4a1gyzv+8uFZ7adQfZqMBdxPBAKR9DM
	t6hJnDGhh2TvTfTZAZmxclqa9f8JxXcUetyZsqVSKkIxth5S6z9HnsNYvLlYAPGSAwOOr589lgG
	F5yjFetr/e2zljxipJAZcBbL71FJ1aHsNT+aI1ooSA4BAaAtQpr2Fe2ZPvrPb/j3vtwkvIDYpmZ
	ptXt3bbgI4RTM6WocnSoZ8+MGjXq4VCNX3Mnaf
X-Received: by 2002:a05:6512:612:b0:515:9ae2:93b0 with SMTP id b18-20020a056512061200b005159ae293b0mr1451127lfe.19.1711119624758;
        Fri, 22 Mar 2024 08:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoRqFuVFSCcYFtb/4CXLayeI15qnsRqHHZP3UDWQYikqtlTHVTRgMB97SI5tl1UUWqtCQprd6t9b/Lw0uFLEw=
X-Received: by 2002:a05:6512:612:b0:515:9ae2:93b0 with SMTP id
 b18-20020a056512061200b005159ae293b0mr1451109lfe.19.1711119624396; Fri, 22
 Mar 2024 08:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
 <20240315-b4-hid-bpf-new-funcs-v4-2-079c282469d3@kernel.org> <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
In-Reply-To: <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 22 Mar 2024 16:00:12 +0100
Message-ID: <CAO-hwJLgx=vndgMRW=f-Gy_36CJLqwAzOoELbckvBn8NvCJB6g@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] HID: bpf: export hid_hw_output_report as a BPF kfunc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:06=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 3/15/24 07:44, Benjamin Tissoires wrote:
> > +/**
> > + * hid_bpf_hw_output_report - Send an output report to a HID device
> > + *
> > + * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_=
context()
> > + * @buf: a %PTR_TO_MEM buffer
> > + * @buf__sz: the size of the data to transfer
> > + *
> > + * @returns the number of bytes transferred on success, a negative err=
or code otherwise.
> > + */
>
> Minimum change:
>
>       @returns:
>
> Preferred change:
>
>       Returns:
>
> "@returns" is not documented.

Thanks for the doc review (and in 5/7).

FWIW, I'm still waiting for other reviews if any, and if there are
none, I'll just amend the commit before pushing.

Cheers,
Benjamin

>
>
> Thanks.
> --
> #Randy
>


