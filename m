Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74CD804300
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjLEABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjLEABM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF400101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701734478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piqqSuejkLyQ9Pz7D5Lal3VWKengn4Yquh06lKaxnuU=;
        b=OTjdrL++QT7BSFaYvzrPIHXdvRER3FQwDvUUrRmzCiuZXeuhLJwBgBS7zrMvIaxZ9xY/Ue
        xFas50piiiFMt2KXjaa7vMJJ3wzIY9Ij94z072IFGF084yQNsl+NY4L7mJFgnaVmVz2zcZ
        zl1MOi0IyCq2Ju0B8GDa14rwOrhMszM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-ft1_2RKROmehs1pzkBjO_A-1; Mon, 04 Dec 2023 19:01:17 -0500
X-MC-Unique: ft1_2RKROmehs1pzkBjO_A-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b35ba53837so467522339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734475; x=1702339275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piqqSuejkLyQ9Pz7D5Lal3VWKengn4Yquh06lKaxnuU=;
        b=HjdceEw07FZEmjLJyeUiogOSAe2MhohLyuBjdoAX/UH+NG6WMKBMC742VNYFgB9JKY
         sED2j/G5YNMmxX4ZkOc8X8M0iFz8pplVLACGXDBY0/Bucfrx4xQ9CqgKQIlNfQ/pSF+W
         EL+EZb/YF5jbMaPnbR7sQxgbfEM5WfmPl91dkkfMh6labbFZCia5H2gpLYcOWIMB+Onm
         Q1YLbRmkQaOGt0VOFI0ERcZjfLXEibTQphAxjJojiGoAD/aDZrToU8glAlyv9+cNC+GJ
         fIlyUYR+Q2HfnuGF3R7Trut8F3e6PDN1bLcxtNqQciWHmDIoeNFfxQjE7ex8e+E/7QsC
         N/qQ==
X-Gm-Message-State: AOJu0YxO6pNnTGyJP/34SbiKGqugjv1conIY85SMoKsDDlZ58DJGUdcI
        7HJtVJvgUedZdWLAgb9ETb4CscUcAJBL0Pb+I9NJUWL7XsU8PMQFXgzCN7KWryEc7iU8dfyi0gh
        sr5rPoQqjSPsMo7lBiQkbIGFTKcznWhhz
X-Received: by 2002:a6b:7f4d:0:b0:7b4:3be1:91ac with SMTP id m13-20020a6b7f4d000000b007b43be191acmr3339963ioq.22.1701734475343;
        Mon, 04 Dec 2023 16:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV4QsoEor/o1mXZFFWnfqE2M4ZJmwBU7oSlYy855J1CQD2NGlbB8584jTohaen0QHRqQmAGA==
X-Received: by 2002:a6b:7f4d:0:b0:7b4:3be1:91ac with SMTP id m13-20020a6b7f4d000000b007b43be191acmr3339949ioq.22.1701734475085;
        Mon, 04 Dec 2023 16:01:15 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id 22-20020a5d9c56000000b007b35043225fsm3092323iof.32.2023.12.04.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:01:12 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:00:40 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <bcreeley@amd.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: Re: [PATCH v19 0/3] add debugfs to migration driver
Message-ID: <20231204170040.7703f1e1.alex.williamson@redhat.com>
In-Reply-To: <20231106072225.28577-1-liulongfang@huawei.com>
References: <20231106072225.28577-1-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 15:22:22 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Add a debugfs function to the migration driver in VFIO to provide
> a step-by-step debugfs information for the migration driver.
> 
> Changes v18 -> v19
> 	maintainers add a patch.
> 
> Changes v17 -> v18
> 	Replace seq_printf() with seq_puts().
> 
> Changes v16 -> v17
> 	Add separate VFIO_DEBUGFS Kconfig entries.
> 
> Changes v15 -> v16
> 	Update the calling order of functions to maintain symmetry
> 
> Changes v14 -> v15
> 	Update the output status value of live migration.
> 
> Changes v13 -> v14
> 	Split the patchset and keep the vfio debugfs frame.
> 
> Changes v12 -> v13
> 	Solve the problem of open and close competition to debugfs.
> 
> Changes v11 -> v12
> 	Update loading conditions of vfio debugfs.
> 
> Changes v10 -> v11
> 	Delete the device restore function in debugfs.
> 
> Changes v9 -> v10
> 	Update the debugfs file of the live migration driver.
> 
> Changes v8 -> v9
> 	Update the debugfs directory structure of vfio.
> 
> Changes v7 -> v8
> 	Add support for platform devices.
> 
> Changes v6 -> v7
> 	Fix some code style issues.
> 
> Changes v5 -> v6
> 	Control the creation of debugfs through the CONFIG_DEBUG_FS.
> 
> Changes v4 -> v5
> 	Remove the newly added vfio_migration_ops and use seq_printf
> 	to optimize the implementation of debugfs.
> 
> Changes v3 -> v4
> 	Change the migration_debug_operate interface to debug_root file.
> 
> Changes v2 -> v3
> 	Extend the debugfs function from hisilicon device to vfio.
> 
> Changes v1 -> v2
> 	Change the registration method of root_debugfs to register
> 	with module initialization. 
> 
> Longfang Liu (3):
>   vfio/migration: Add debugfs to live migration driver
>   Documentation: add debugfs description for vfio
>   MAINTAINERS: Update the maintenance directory of vfio driver
> 
>  Documentation/ABI/testing/debugfs-vfio | 25 +++++++
>  MAINTAINERS                            |  1 +
>  drivers/vfio/Kconfig                   | 10 +++
>  drivers/vfio/Makefile                  |  1 +
>  drivers/vfio/debugfs.c                 | 90 ++++++++++++++++++++++++++
>  drivers/vfio/vfio.h                    | 14 ++++
>  drivers/vfio/vfio_main.c               |  4 ++
>  include/linux/vfio.h                   |  7 ++
>  include/uapi/linux/vfio.h              |  1 +
>  9 files changed, 153 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
>  create mode 100644 drivers/vfio/debugfs.c
> 

Applied to vfio next branch for v6.8.  I resolved some whitespace
issues and updated the date and kernel release version in the
Documentation as well.  Thanks,

Alex

