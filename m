Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873957732B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjHGWIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHGWHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD13A99
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691445836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y9TeBrPo/OTtfDWC3B0d1ftwgWyN0aOvP/Hu3HtHV94=;
        b=FxltXV+rQ9YvHkIgRPGtuWCtGiNJAUOAAVRl8eq/BH9uLi2PUGp6jQus34qQKxNCN8i4TT
        gtAq7U5KMqxOJfZrYSBXRVIzTHBrRfJU18Q05G4BdtGxV9nBzd+NJp/Wd4SdgSEzCsYgey
        tpwwN1IzKbYN4+OK1jAX+OYosRWKUkY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-ZLSO2oKrM8WLyrP8TFwOHw-1; Mon, 07 Aug 2023 18:03:55 -0400
X-MC-Unique: ZLSO2oKrM8WLyrP8TFwOHw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7773997237cso490358939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 15:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691445834; x=1692050634;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9TeBrPo/OTtfDWC3B0d1ftwgWyN0aOvP/Hu3HtHV94=;
        b=WRimd3nffC4HbSqPR1HLv8I5egVM0KSs0nrdzAFJREkFkTHyAA7G/HUUoB7uvDbw3N
         8xlCdwT4spjQ9j8jqGDkdTmv3fO3+wNsxCCP288l2K3AZNGB+34qth25d0VfYHhxqe+Z
         CEJpC6ET5YnEnFLyKA4OMiS0Jo/+vvxgPRG2J0fnBN/3Um3lg+ka6QjBJ7eR9um++0dR
         vrcJCVzT1/WiJY2BlkBJ4Xrop7r4L4yYBp+nmJ78H54ldEwu6n77SMdengIEdLedKu30
         rWtvF6Cp2I+Ee0pf3SDtXaX/U+CZxFJXY7G9PwNywEEEhObzOTrpm4w3u5oyCzKNriPa
         hrqA==
X-Gm-Message-State: AOJu0YwmyhVF6z06MbLdSgoU1bsqmThLPmWCGQfY8JAHhrfnYBmtJaiJ
        dyzOyJnGThw4MgU/Fg9xBOaONtpXqmbm9U5wctaBG2muleLNvufW4p8SRPCniq7uXJG1ZiFsc7O
        byMsl2b1metbHaEKbAtsTVEa3
X-Received: by 2002:a5d:985a:0:b0:783:68d0:9b34 with SMTP id p26-20020a5d985a000000b0078368d09b34mr11593929ios.7.1691445834490;
        Mon, 07 Aug 2023 15:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUKrOfVqEHkxaMGbYogaRzGKCzopE8LfVGz1kGuwSF8iIwk1U6lQdJdreRfB00ApEKgrpZFQ==
X-Received: by 2002:a5d:985a:0:b0:783:68d0:9b34 with SMTP id p26-20020a5d985a000000b0078368d09b34mr11593914ios.7.1691445834245;
        Mon, 07 Aug 2023 15:03:54 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id k10-20020a02c64a000000b0042b1c02d17csm2764551jan.2.2023.08.07.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 15:03:53 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:03:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v12 4/4] Documentation: add debugfs description for vfio
Message-ID: <20230807160352.0b7a57bf.alex.williamson@redhat.com>
In-Reply-To: <3c557239-447f-116d-3687-cc6e419f2dcc@huawei.com>
References: <20230728072104.64834-1-liulongfang@huawei.com>
        <20230728072104.64834-5-liulongfang@huawei.com>
        <ZM0SAfIHnMHndm8h@nvidia.com>
        <3c557239-447f-116d-3687-cc6e419f2dcc@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 09:33:07 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2023/8/4 22:58, Jason Gunthorpe wrote:
> > On Fri, Jul 28, 2023 at 03:21:04PM +0800, liulongfang wrote:  
> >> From: Longfang Liu <liulongfang@huawei.com>
> >>
> >> 1.Add two debugfs document description file to help users understand
> >> how to use the accelerator live migration driver's debugfs.
> >> 2.Update the file paths that need to be maintained in MAINTAINERS
> >>
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  .../ABI/testing/debugfs-hisi-migration        | 36 +++++++++++++++++++
> >>  Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++
> >>  MAINTAINERS                                   |  2 ++
> >>  3 files changed, 63 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
> >>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
> >>
> >> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> >> new file mode 100644
> >> index 000000000000..791dd8a09575
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> >> @@ -0,0 +1,36 @@
> >> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
> >> +Date:		Aug 2023
> >> +KernelVersion:  6.6
> >> +Contact:	Longfang Liu <liulongfang@huawei.com>
> >> +Description:	Read the live migration data of the vfio device.
> >> +		These data include device status data, queue configuration
> >> +		data and some task configuration data.
> >> +		The output format of the data is defined by the live
> >> +		migration driver.
> >> +
> >> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
> >> +Date:		Aug 2023
> >> +KernelVersion:  6.6
> >> +Contact:	Longfang Liu <liulongfang@huawei.com>
> >> +Description:	Read the live migration attributes of the vfio device.
> >> +		it include device status attributes and data length attributes
> >> +		The output format of the attributes is defined by the live
> >> +		migration driver.
> >> +
> >> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
> >> +Date:		Aug 2023
> >> +KernelVersion:  6.6
> >> +Contact:	Longfang Liu <liulongfang@huawei.com>
> >> +Description:	Trigger the HiSilicon accelerator device to perform
> >> +		the io test through the read operation. If successful,
> >> +		it returns the execution result of mailbox. If fails,
> >> +		it returns error log result.
> >> +
> >> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
> >> +Date:		Aug 2023
> >> +KernelVersion:  6.6
> >> +Contact:	Longfang Liu <liulongfang@huawei.com>
> >> +Description:	Trigger the Hisilicon accelerator device to perform
> >> +		the state saving operation of live migration through the read
> >> +		operation, and output the operation log results.  
> > 
> > I still very much do not like this use of debugfs.
> > 
> > If you want to test migration then make a test program and use the
> > normal api
> >  
> These debugfs are just to get internal state data.
> The test function is no longer executed.
> The store file with test function has been deleted.

The vfio/<device>/migration/state file can provide useful monitoring of
the device progress during a migration, but I think the point Jason is
trying to make is that these hisi_acc seqfiles aren't really doing
anything that couldn't be done by a simple userspace test driver.

Based on my review of the previous patch, we're playing pretty loose
with concurrency and data buffers.  Access to the migration data of
the device outside of the process that owns the device is also a
concern.

The value-add here needs to be that there's something useful about the
kernel being able to dump this data rather than either a simple
userspace program or instrumenting a userspace driver like QEMU, where
we can avoid the complexity that's going to be required to resolve the
issues in the previous patch and ensure that sensitive data from the
device isn't available through debugfs.  Thanks,

Alex

