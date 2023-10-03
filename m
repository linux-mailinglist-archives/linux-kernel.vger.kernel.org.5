Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06E7B71BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjJCT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE3AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696361210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMBIdi2ioacPrgcNxZx8em/+qPteSdTdEA8YmTtjejM=;
        b=ipdNfst8nwKmK4c6FUD0Tscqk2eICC8SZiftF30Yd3PYarwsfbdl+ji6wBPdHnXl0l/8kW
        QVe0FQDHbTxDF0jzxtVPS+vQ/8rO3clhiiT64QQ+lAp1nNZXz/tgaKrGNKPXnJCet3pEVh
        XCXj5Kj8cVaCDSOYRfPVqyDW6ZFR1w4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-YspD32CKMrmaIi6sOYDAJQ-1; Tue, 03 Oct 2023 15:26:38 -0400
X-MC-Unique: YspD32CKMrmaIi6sOYDAJQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77e3eaa1343so88232839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361197; x=1696965997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMBIdi2ioacPrgcNxZx8em/+qPteSdTdEA8YmTtjejM=;
        b=h713BIREXT1cKG6P8RQnhEUoo/WNmmxWl5BIW/HkB7kEdvrwQXU4IiY5SfQqC4bTu+
         KVgN2VYxdG5qLAgzdmmbwNXg9K1794wNCXrgNqT8+xglJgVW3uImg+XwWvsN3Eti79O7
         GdawSMmuxWrYiJseDhiu2vIN3QE43zDTgQf+orBwRfbNI9aya1y8VMX9cg4p/lwyEPaN
         hyXsaQ5yhJbXGVgC2kv5u4/lR3jmBhmWglmeohKae+CIG8A/PdigUMp57C0/sW7K9Ppd
         aFy5cTDXN6TJ+xY4sNAcZP5D4R9WA+qYwKPLBDtYfHaKwvv7KR1FeRwHt0TidpR0Oe4h
         3Q1Q==
X-Gm-Message-State: AOJu0YyxNdlY+rgHCVz3AkcsO3NYi61Dnr+fqEk45pbwAOSsOmmjiIvl
        6+dlimzKtyUYly33H0tL4J7jHxvSPn1/JKy7uh0bGAYuS6YXA1LORD2eoaltrdrIacKLaA6rsRb
        nTlOAoEqkZ8Og2tCRSQ6CZlLN
X-Received: by 2002:a5e:c908:0:b0:791:1e87:b47e with SMTP id z8-20020a5ec908000000b007911e87b47emr370022iol.15.1696361197744;
        Tue, 03 Oct 2023 12:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUIE7D772U4N0qDPompsKRtvx1NT7mfvg4RI/jwspaPsXINk3ViMeEP2EeRC7fwg83oLza4Q==
X-Received: by 2002:a5e:c908:0:b0:791:1e87:b47e with SMTP id z8-20020a5ec908000000b007911e87b47emr370006iol.15.1696361197459;
        Tue, 03 Oct 2023 12:26:37 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id h11-20020a02cd2b000000b0043194542229sm507033jaq.52.2023.10.03.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:26:36 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:26:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <bcreeley@amd.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: Re: [PATCH v16 2/2] Documentation: add debugfs description for vfio
Message-ID: <20231003132635.7df44c44.alex.williamson@redhat.com>
In-Reply-To: <20230926093356.56014-3-liulongfang@huawei.com>
References: <20230926093356.56014-1-liulongfang@huawei.com>
        <20230926093356.56014-3-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 17:33:56 +0800
liulongfang <liulongfang@huawei.com> wrote:

> From: Longfang Liu <liulongfang@huawei.com>
> 
> 1.Add an debugfs document description file to help users understand
> how to use the accelerator live migration driver's debugfs.
> 2.Update the file paths that need to be maintained in MAINTAINERS
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  Documentation/ABI/testing/debugfs-vfio | 25 +++++++++++++++++++++++++
>  MAINTAINERS                            |  1 +
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
> 
> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
> new file mode 100644
> index 000000000000..7959ec5ac445
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-vfio
> @@ -0,0 +1,25 @@
> +What:		/sys/kernel/debug/vfio
> +Date:		Sep 2023
> +KernelVersion:  6.7
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices, it's a common directory for all vfio devices.
> +		Vfio core will create a device subdirectory under this
> +		directory.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration
> +Date:		Sep 2023
> +KernelVersion:  6.7
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices that support live migration.
> +		The debugfs of each vfio device that supports live migration
> +		could be created under this directory.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/state
> +Date:		Sep 2023
> +KernelVersion:  6.7
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration status of the vfio device.
> +		The status of these live migrations includes:
> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.

This is another area that's doomed to be out of sync, it's already not
updated for P2P states.  Better to avoid the problem and say something
like "The contents of the state file reflects the migration state
relative to those defined in the vfio_device_mig_state enum".

Also, as suggested last time, October is a more realistic date.  Thanks,

Alex

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b1306615fc0..bd01ca674c60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22304,6 +22304,7 @@ L:	kvm@vger.kernel.org
>  S:	Maintained
>  T:	git https://github.com/awilliam/linux-vfio.git
>  F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> +F:	Documentation/ABI/testing/debugfs-vfio
>  F:	Documentation/driver-api/vfio.rst
>  F:	drivers/vfio/
>  F:	include/linux/vfio.h

