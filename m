Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B27544D1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGNWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGNWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64201271E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689372481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPM6Au4CjAe3bEAhg4Pru4x+cqTxSkgcU1upsh+sjB4=;
        b=bWoh42rqrenTdE0MLM3G0zKwGg2hFoyr/zJSaFM7FSAzd7uNi+y5S/l+FG3du/wDMd4Bzs
        bQoMtsOZGvNwYdbHdh/joHmbfWVmU4EjVssb1teC+6xwSkz7WcEl7U0rU0hj6WZXPB87ak
        ozHpxOFe8N9Y2mziwgqCOUprGVI3a8Q=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-tVx6yLUuPhK7oLbktEJkKg-1; Fri, 14 Jul 2023 18:08:00 -0400
X-MC-Unique: tVx6yLUuPhK7oLbktEJkKg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-780addd7382so109889839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372479; x=1691964479;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPM6Au4CjAe3bEAhg4Pru4x+cqTxSkgcU1upsh+sjB4=;
        b=Jtph7tMbBA+LCqbzuTV3sPZuGtNubpyO/Kaak8mQaUP8e/4/NB4tzHYt4p2NZg0JmJ
         ZnfVVE9PQRX63HNzuf8wyTS5f3DlKR/QQ6T3bkwGCNXIA1n7lpUkPm3PgsdfieHyio7j
         Qp8Xh5DftJcIB2LQZzzDU2pF4PBtD5prbnLcnyklHEtCCCYv5oa/Lxwrzwnyg1ZFr5kk
         Asds2Azj75Nn2mN7a/AMZ7EBrjDHLN5+k5I4dKA9uFsk2f9E7rftcKIiexRmZAC2Otae
         XcphrrykQ9W56SiBzK5x4cDQzsaaEHdHPHoSTNAgRiogTSkpaZA4WSMhnbM/i9J45+Ew
         PNFA==
X-Gm-Message-State: ABy/qLYuVJTIwN6asuieYgwST3o2G+GZ9Ge4jYjaGTRlnjbaN0wCimKO
        gPiCYWoclPRC9MOivLsgoliV+q/PETxVIWagy2hsNJjCzInPEQXSgUV0fgrpNwUD3IyRXebM3L2
        qkY5CDVZHPui4q4WTfz28iLyg
X-Received: by 2002:a5e:aa10:0:b0:783:6906:a32c with SMTP id s16-20020a5eaa10000000b007836906a32cmr5918338ioe.16.1689372479517;
        Fri, 14 Jul 2023 15:07:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHto5BqTMT/ELrsUtXrD93k3Fglpp/2oTAkzNdl8bDzV+2+rm65g3tPITRGV1bgiT8umAxHSg==
X-Received: by 2002:a5e:aa10:0:b0:783:6906:a32c with SMTP id s16-20020a5eaa10000000b007836906a32cmr5918327ioe.16.1689372479293;
        Fri, 14 Jul 2023 15:07:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a02cf28000000b0042b5ec3c0cesm2857719jar.5.2023.07.14.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:07:58 -0700 (PDT)
Date:   Fri, 14 Jul 2023 16:07:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v11 4/4] Documentation: add debugfs description for vfio
Message-ID: <20230714160752.78735c4a.alex.williamson@redhat.com>
In-Reply-To: <20230630092457.54902-5-liulongfang@huawei.com>
References: <20230630092457.54902-1-liulongfang@huawei.com>
        <20230630092457.54902-5-liulongfang@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 17:24:57 +0800
liulongfang <liulongfang@huawei.com> wrote:

> From: Longfang Liu <liulongfang@huawei.com>
> 
> 1.Add two debugfs document description file to help users understand
> how to use the accelerator live migration driver's debugfs.
> 2.Update the file paths that need to be maintained in MAINTAINERS
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../ABI/testing/debugfs-hisi-migration        | 32 +++++++++++++++++++
>  Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++++
>  MAINTAINERS                                   |  2 ++
>  3 files changed, 59 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> new file mode 100644
> index 000000000000..0dfc7008a3e1
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> @@ -0,0 +1,32 @@
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
> +Date:		June 2023
> +KernelVersion:  6.4

At best we'd be looking at introducing this for 6.6, where it might get
into mainline in late August for all of these.

> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration data of the vfio device.
> +		The output format of the data is defined by the live
> +		migration driver.

This attribute is specific to the hisi_acc driver, so should the data
be detailed here?

> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
> +Date:		June 2023
> +KernelVersion:  6.4
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration attributes of the vfio device.
> +		The output format of the attributes is defined by the live
> +		migration driver.

Same here.

> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
> +Date:		June 2023
> +KernelVersion:  6.4
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Trigger the HiSilicon accelerator device to perform
> +		the io test through the read operation, and directly output
> +		the test result.

This has essentially been reduced to reading the mailbox value AIUI,
should this simply document that and the resulting possible values?

> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
> +Date:		June 2023
> +KernelVersion:  6.4
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Trigger the Hisilicon accelerator device to perform
> +		the state saving operation of live migration through the read
> +		operation, and directly output the operation result.

It's unclear to me why we need to parse a returned string from the
debugfs seq file rather than read returns zero on success or errno on
failure.

> +
> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
> new file mode 100644
> index 000000000000..e2132a2f602b
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-vfio
> @@ -0,0 +1,25 @@
> +What:		/sys/kernel/debug/vfio
> +Date:		June 2023
> +KernelVersion:  6.4
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices.
> +		Each device can create a device subdirectory under this
> +		directory by referencing the public registration interface.

This suggests it's the device driver's responsibility to create those
subdirectories, but we've delegated that to the core currently.  Maybe
this is suggesting that each driver can create a driver subdirectory
under the core created device directory?

Thanks,
Alex

> +
> +What:		/sys/kernel/debug/vfio/<device>/migration
> +Date:		June 2023
> +KernelVersion:  6.4
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices that support live migration.
> +		The debugfs of each vfio device that supports live migration
> +		could be created under this directory.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/state
> +Date:		June 2023
> +KernelVersion:  6.4
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration status of the vfio device.
> +		The status of these live migrations includes:
> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce6ac552d8f6..bdd6a5e7350f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22098,6 +22098,7 @@ L:	kvm@vger.kernel.org
>  S:	Maintained
>  T:	git https://github.com/awilliam/linux-vfio.git
>  F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> +F:	Documentation/ABI/testing/debugfs-vfio
>  F:	Documentation/driver-api/vfio.rst
>  F:	drivers/vfio/
>  F:	include/linux/vfio.h
> @@ -22115,6 +22116,7 @@ M:	Longfang Liu <liulongfang@huawei.com>
>  M:	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-hisi-migration
>  F:	drivers/vfio/pci/hisilicon/
>  
>  VFIO MEDIATED DEVICE DRIVERS

