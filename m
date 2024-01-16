Return-Path: <linux-kernel+bounces-27699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54482F44E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA9B1F249D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494E13FE5;
	Tue, 16 Jan 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkiPhIMT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B81CD07
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429994; cv=none; b=RSckkhINGxnIiUiMrXKZUd/SNmNrSvwNZOKZn/RFkoCnraxqYTaEI4XOEzsJmPClNzZzGi1lfk0GWbvzkVgmEe5wGGU1Of1r7DNgLshUpy2ryOXEWVSv/rSUKHrl0P6/shYgKouTYr142hZM7TX6ziqb3g/Uou0G3GyB3NsghEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429994; c=relaxed/simple;
	bh=JwNvuHi5CpdeD9Q7CbYVbQzkcZ5+AVv/Usz1r2vNrkw=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=kBlljvsxw8zqGtB2Q38kWl0LudjSSz7vZAwZkabUggDRaeU6lNlAax4MZH0b+0Mhee5P4YwH/ifHKEQoDD89cjmtnkKSKqV15laRiNPkrOB4l8CF62pnFcfTYFXwoaE5/X5o6Gdz6pj3YoSbYWN++9JqGaSo3iO9H1a2B+9PZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkiPhIMT; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705429992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FISaMlvGT4jM9D2WMtxVsmws03Og0Eq0GceC6awRLlY=;
	b=RkiPhIMTk1WM7rn6arWhT1CDiVjvFgwoQgKByn3NAAslIJwMw3VcEgCq+8y+1bG4ZZo/E2
	8RGAv4J5wCf/qVhyGEPHrL8vnOLjyLvFAupmFkrMXTKeFoWlkMJ6iHPaA7ghI1EiCVCINs
	m8TKWbdMEOOINCkaYUVEu5WuxRGkQvk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-od7ggAK3NeCfwkGRrBosiA-1; Tue, 16 Jan 2024 13:33:10 -0500
X-MC-Unique: od7ggAK3NeCfwkGRrBosiA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bb454e1d63so1103390639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429990; x=1706034790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FISaMlvGT4jM9D2WMtxVsmws03Og0Eq0GceC6awRLlY=;
        b=dJMun9QVKVaHELXUySqA2n/omodqWQ9ypgckexwNYxoc5hwy4FjZnEHWIj922K13kV
         Kwjh4NdvEsaYhwiV3InXjMbkzxFyNvs6F/clLk0FYaeVEXLdPV6OASTTU6Hh5B3ZU48J
         3HWpT3zjSnxrLWECIhIT17Nwjfmw+L46y4Qrz1DNXLzO0kBYIAhqdkWXJv6bfVNjZSxm
         OLfn4trokGHOg42TaMEcY1KEnDHyyJnHhUnB2Z0fO7FUwa1UNAIxMdq3+oan+FJ3JL5v
         W0sD4Z5GkF8EjnSYMarN3eYeURhNEp3tufqPuWiRD/6YnqKkkNNtWW2bMAD7H7k9wnCE
         mpSQ==
X-Gm-Message-State: AOJu0YwCEyeBRPUmHXofcwGeBbBF8epfCbXnbCGUnW5ImabEfhFQBNmV
	3/jahBa08BJQtkb3RNNn7kQaIkYf/tusJYiGmVApRGLvzCYa9I0MF3Z8yIdQJ4dTY4abPatRb+3
	wl1SQQyQQx75vrsQY6zbgluJ2eU8FPk1u
X-Received: by 2002:a5d:8c9a:0:b0:7bf:4694:6c36 with SMTP id g26-20020a5d8c9a000000b007bf46946c36mr4546968ion.9.1705429990000;
        Tue, 16 Jan 2024 10:33:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErDazX7NWGFXtbf/P4jQZuCg4zJCLsr6AAXK6x7UHmTrzfxIKGZgBT8q7U2HRZ1DI6P7MRHA==
X-Received: by 2002:a5d:8c9a:0:b0:7bf:4694:6c36 with SMTP id g26-20020a5d8c9a000000b007bf46946c36mr4546960ion.9.1705429989777;
        Tue, 16 Jan 2024 10:33:09 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id bm7-20020a05663842c700b0046e41dace9csm3020396jab.30.2024.01.16.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:33:09 -0800 (PST)
Date: Tue, 16 Jan 2024 11:33:08 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Eric Auger <eric.auger@redhat.com>, kvm@vger.kernel.org,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: vfio/platform: Use common error handling code in
 vfio_set_trigger()
Message-ID: <20240116113308.78935e11.alex.williamson@redhat.com>
In-Reply-To: <ab6bcd8b-f53c-47d1-8c55-c374a36d6ee4@web.de>
References: <f1977c1c-1c55-4194-9f72-f77120b2e4e5@web.de>
	<20240115133756.674ae019.alex.williamson@redhat.com>
	<ab6bcd8b-f53c-47d1-8c55-c374a36d6ee4@web.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 12:32:23 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > TBH, this doesn't seem like a worthwhile exit point consolidation.  A
> > change like this might be justified if there were some common unlock
> > code that could be shared, but for a simple free and return errno by
> > jumping to a different exception block, rather than even a common exit
> > block, I don't see the value.  
> 
> Can it be helpful to store the shown kfree() call only once
> in this function implementation?

I don't believe it's worthwhile, it's a simple function with simple
exit paths and consolidating those exit paths for a trivial kfree() is
unnecessarily complex.  Thanks,

Alex


