Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57BA8001E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376882AbjLADIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLADIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:08:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9061711;
        Thu, 30 Nov 2023 19:08:50 -0800 (PST)
Received: from kwepemm000005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ShHvb00xFzMnWl;
        Fri,  1 Dec 2023 11:03:54 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemm000005.china.huawei.com (7.193.23.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 11:08:47 +0800
Subject: Re: [PATCH v19 0/3] add debugfs to migration driver
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <bcreeley@amd.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20231106072225.28577-1-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <3288c4f2-551d-a559-4e6a-76590236c72d@huawei.com>
Date:   Fri, 1 Dec 2023 11:08:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231106072225.28577-1-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.110]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000005.china.huawei.com (7.193.23.27)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/6 15:22, Longfang Liu wrote:
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
Hi, Alex:
Please review this patchset.

Thanks.
Longfang.
