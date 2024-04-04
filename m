Return-Path: <linux-kernel+bounces-132079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DC3898F69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8E928BDCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB81350D8;
	Thu,  4 Apr 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3YO5sfS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F307138489
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261276; cv=none; b=XAXcj7RiQfZs2xL9Qgx0pRKp3Q8tg5kjCDg79DOXN3l8kOsG26h9i7zZGrVFUGPRc/YlpYWzB221FYuapByeTE8FzDMRitKPP94LVJOXQZybuFFfIQ3ATdpVq2pML/J6Ltm8ILwHVZHE7y6YHz1aTwboLnKilEUylyphaaLBT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261276; c=relaxed/simple;
	bh=F7nFkAVtXzPGjLTO3whVH6ckeO/jZuAKYHBc+06D804=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dc/3SS3s6REhgmr1Bn3K8BoJU9NsHeWM2W/UuuH+5ab0y+1CpIDhi1IPmlYUnZi1ChqTKM0qDswWaJ8XPk2FSNeVLlIV7G+MffkbZma3SCqt+FrJvTAQlPWSYmuFohd6r6r97sQCGyRbZ0vdhgP5S8ETDFsNCzn8HYx19KrZuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3YO5sfS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712261274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBwnpmoXZkQWB3sRlzQjNLqJlL/NUB2ApA0wBpLvaEw=;
	b=D3YO5sfS7Q6D3gVn6DeQnhw8vNwDFaQLm+4uco7qqUsdzCUXosRSdfkPbQYrv4gjmZkglF
	wdoE24fQGm+RZ5MuV/Szl3nFgGgM055tv3hcyop0AcRvDfi27obyjimfrXXN1m5pg7pSKK
	Ow/Ber7Jr5e/Dq+ksPh3lCG4E4KM1Do=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-fCSyn2ZIP1GbM5FvqC9_xg-1; Thu, 04 Apr 2024 16:07:52 -0400
X-MC-Unique: fCSyn2ZIP1GbM5FvqC9_xg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369e1b1411fso15265835ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261272; x=1712866072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBwnpmoXZkQWB3sRlzQjNLqJlL/NUB2ApA0wBpLvaEw=;
        b=G4wpU+xNU1KBxyVjDFK7EBOwcP3jbg1aVHY/c2m1xwEITWZpmrhqs8bQePATSl5lx0
         ssL0j03Uf+FDRXAkrEA2WpXfpUrIfEtbvwjtDxfFnzE5Ze/dXV+0OKTu3UatdoXRKF8t
         EAt3/oTicmC+qeJDdqmqOWb8+ptXnS9tIALRuv42F7F08xOV25fR2HU7TevOldyP2hzY
         uX4k0INamY5f75Dkn0NPHFvibPQhdMdMRAALZVkzmOL/7NzYxNXGxsr9/cTrgm+NL+UA
         Ejkmap108P/ZQDHJSXOvgwOpyq8fDdDl3NVtUZM5JB494ZvQEUO6LbiUiY9ZfQVVYo9q
         tGIw==
X-Forwarded-Encrypted: i=1; AJvYcCVLsXHtNjzN6Ph1v7nf5uEHQAvW++BuzBwJjZYPeufhRyxUzrRUvE+Yr8fM2awQw/ItpDOKQs9gT4G84hBHzugvumfe7fWMwF0P107c
X-Gm-Message-State: AOJu0Yw5f9WKn16483GJoZy5p0vKGI1yzgLDyaaIKVd2UywaP7BK18Cd
	2isAtnRZjNg4iodvb8arxLeNUnKFyE0blbHaEhqhbkBtkS2qForO5rOuCQACovRmXJGnCdRiWVM
	BkTcOjiDHU3V7oeYf9UZRtg7n8VI0Pt1uJtjlt6xAgLMJU4Pymz1z/Qu3hDbMlw==
X-Received: by 2002:a05:6e02:1fee:b0:368:a446:bdc8 with SMTP id dt14-20020a056e021fee00b00368a446bdc8mr460981ilb.22.1712261271919;
        Thu, 04 Apr 2024 13:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaqoDO/+tFcCqum8TqiKc+I/+p4CsQH6hcDf+tNsGOSm5B9KajL+oD63U+eSt4FNzehJDYhQ==
X-Received: by 2002:a05:6e02:1fee:b0:368:a446:bdc8 with SMTP id dt14-20020a056e021fee00b00368a446bdc8mr460961ilb.22.1712261271612;
        Thu, 04 Apr 2024 13:07:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id p5-20020a92da45000000b003686160b165sm5848ilq.75.2024.04.04.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:07:51 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:07:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v4 4/4] Documentation: add debugfs description for hisi
 migration
Message-ID: <20240404140750.78549701.alex.williamson@redhat.com>
In-Reply-To: <20240402032432.41004-5-liulongfang@huawei.com>
References: <20240402032432.41004-1-liulongfang@huawei.com>
	<20240402032432.41004-5-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 11:24:32 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Add a debugfs document description file to help users understand
> how to use the hisilicon accelerator live migration driver's
> debugfs.
> 
> Update the file paths that need to be maintained in MAINTAINERS
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../ABI/testing/debugfs-hisi-migration        | 34 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> new file mode 100644
> index 000000000000..3d7339276e6f
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> @@ -0,0 +1,34 @@
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
> +Date:		Apr 2024
> +KernelVersion:  6.9

At best 6.10 with a merge window in May.

> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration data of the vfio device.
> +		These data include device status data, queue configuration
> +		data and some task configuration data.
> +		The output format of the data is defined by the live
> +		migration driver.

"Dumps the device debug migration buffer, state must first be saved
using the 'save' attribute."

> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
> +Date:		Apr 2024
> +KernelVersion:  6.9
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration attributes of the vfio device.
> +		it include device status attributes and data length attributes
> +		The output format of the attributes is defined by the live
> +		migration driver.

AFAICT from the previous patch, this attribute is useless.

> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/cmd_state
> +Date:		Apr 2024
> +KernelVersion:  6.9
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Used to obtain the device command sending and receiving
> +		channel status. If successful, returns the command value.
> +		If failed, return error log.
> +

Seems like it statically returns "OK" plus the actual value.


> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
> +Date:		Apr 2024
> +KernelVersion:  6.9
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Trigger the Hisilicon accelerator device to perform
> +		the state saving operation of live migration through the read
> +		operation, and output the operation log results.

These interfaces are confusing, attr and data only work if there has
either been a previous save OR the user migration process closed saving
or resuming fds in the interim, and the user doesn't know which one
they get.  Note that debug_migf isn't even discarded between
open/close, only cmd and save require the device to be opened by a
user, data and attr might continue to return data from some previous
user save, resume, or debugfs save.



> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7625911ec2f1..8c2d13b13273 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23072,6 +23072,7 @@ M:	Longfang Liu <liulongfang@huawei.com>
>  M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-hisi-migration
>  F:	drivers/vfio/pci/hisilicon/
>  
>  VFIO MEDIATED DEVICE DRIVERS


