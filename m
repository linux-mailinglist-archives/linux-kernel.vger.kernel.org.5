Return-Path: <linux-kernel+bounces-93081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB3872ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD831F27F89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B712DD95;
	Tue,  5 Mar 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDFnob4S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF812D21A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680403; cv=none; b=Rwn9AJmb4DIbNReCvw5AZp74v/uEvEFZsVIhHvIOdBL6LUucyiblVmtMiqsNSILsf+oqox5DObj93rutxnE0Q8irQlnI0j7BOnGAcg/lttZw21KCiYE6lIasV5/52pQ6TdpWJaFgihgzBbQ6vX1dRY+5udg5a7cVnSdU23i1eY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680403; c=relaxed/simple;
	bh=WD18EODX6+lG3dXpyNVLszEn0PWOVlNqIoiI4MWZg04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQpWrmYfi67lAbLj9VqfnrL0hesIim2KajCdGgGr0mV9yBneXxIqz+A/z5XOecWvOIj9wCgPlD9jNcUfn9tEhMd7GkWaT1Yz/nLztEaFcZ9Yh+ibxIkkRuIMkPAb7gPa/pJUei2zqRjj8R0nFOb9Scul+8I+1+bj/XbTeI/nnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDFnob4S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709680400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Kg37p/NEqr8moLlFd/iFiFkiKqaQKyF7qbJCfCCqrk=;
	b=ZDFnob4ShHQoBidHNRz2VW7afQ1ZFYWHioMSvmDBU0n1v3rZwyYw/SQJfNGeFdT+NwIFTP
	e5rRttmjtf+YGjBeBztywjjbJ6TPEYIBKR36dzNQSZr/ce6K9X9l4kc80lqNtKub29TLP1
	mlsellGMGmPkCEKUWm5PLLlZusHKU9k=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-En3OTEoOPNe9ICLJc-copA-1; Tue, 05 Mar 2024 18:13:19 -0500
X-MC-Unique: En3OTEoOPNe9ICLJc-copA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c855240d74so239267939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680397; x=1710285197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kg37p/NEqr8moLlFd/iFiFkiKqaQKyF7qbJCfCCqrk=;
        b=a5Z7vzuQnuwheD/7xAnzfDDvmWKRurW5v1dRR9OpSAPy3fwOkapmlnWfEpZJ83z3Az
         tLyOyDI31hn3KU5XzNpsrmHs+5xKvvh8PPV+PfYHf9JVZbgz6XHMhzvCruDImYn/Ymuj
         kAkeCbW52lS+0Y22LPVsXHHD6BMRb3OLFqD94o9pHG+41G9cHgX0Bf992FWFja2gjdzY
         FXgBrqTYbM8rFUhlurpO4GgVOxuGXMEtJbApwPG16tG96eO4NaAeVFMj4WlzANqMBkDY
         aF0hyMXhLWjCGfYAebScxTY4nBjI5aw9MsbP6WnFSmf+MC6EEuqecy6YewhhORtJznhz
         xLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthNDE4B2ICegBd09rwaUEY0/W/+mhBztIBt37tQVz7xOE7Og3K/Jvko5ch0ayOLbl8AHi7EZXpfuTavznH5/2jGMg+T2DDMuYvQ5T
X-Gm-Message-State: AOJu0YzgqkyoILBvwIBQEviRuSrQaxpcWfih59Mh6AsC4ZiTL6pIcGBC
	/S73l5d4TzVQ/hDxOTGdVTPyuOaFcTohNk3VrbJ00Y2MWGrZm0MJ8oroXf9cr1Kxg6IHT6NwcY/
	75YdnWuc97ELOHpODgtjyQemQaNTodvCZN3FMfRm20qbKbuMsherU9fBHLcyG1A==
X-Received: by 2002:a6b:dc0d:0:b0:7c8:63dc:e9cd with SMTP id s13-20020a6bdc0d000000b007c863dce9cdmr4630992ioc.19.1709680397737;
        Tue, 05 Mar 2024 15:13:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa8XZDmFrTkH/irPMZa8ZGxDfb3ulcCwZXcdb2MdeuSf0kw9SnMkhbXPJw/9QUKBBbEp7Rmg==
X-Received: by 2002:a6b:dc0d:0:b0:7c8:63dc:e9cd with SMTP id s13-20020a6bdc0d000000b007c863dce9cdmr4630973ioc.19.1709680397528;
        Tue, 05 Mar 2024 15:13:17 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id c26-20020a02c9da000000b00474b48a629csm3084467jap.46.2024.03.05.15.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:13:16 -0800 (PST)
Date: Tue, 5 Mar 2024 16:12:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] vfio: constify struct class usage
Message-ID: <20240305161232.1cf094c0.alex.williamson@redhat.com>
In-Reply-To: <20240301-class_cleanup-vfio-v1-0-9236d69083f5@marliere.net>
References: <20240301-class_cleanup-vfio-v1-0-9236d69083f5@marliere.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 Mar 2024 14:51:46 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> This is a simple and straight forward cleanup series that aims to make the
> class structures in vfio constant. This has been possible since 2023 [1].
> 
> ---
> [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> 
> To: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> ---
> Ricardo B. Marliere (2):
>       vfio/mdpy: make mdpy_class constant
>       vfio/mbochs: make mbochs_class constant
> 
>  samples/vfio-mdev/mbochs.c | 18 ++++++++----------
>  samples/vfio-mdev/mdpy.c   | 18 ++++++++----------
>  2 files changed, 16 insertions(+), 20 deletions(-)
> ---
> base-commit: 87adedeba51a822533649b143232418b9e26d08b
> change-id: 20240301-class_cleanup-vfio-3c5f72230ba5
> 
> Best regards,

Applied to vfio next branch for v6.9.  Thanks,

Alex


