Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A587F6EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbjKXIvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 03:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:51:08 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6A1BD;
        Fri, 24 Nov 2023 00:51:14 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sc7rb4SNRzSh5p;
        Fri, 24 Nov 2023 16:46:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 16:51:11 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Fri, 24 Nov 2023 08:51:09 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Brett Creeley <brett.creeley@amd.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        liulongfang <liulongfang@huawei.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "shannon.nelson@amd.com" <shannon.nelson@amd.com>
Subject: RE: [PATCH vfio 2/2] hisi_acc_vfio_pci: Destroy the
 [state|reset]_mutex on release
Thread-Topic: [PATCH vfio 2/2] hisi_acc_vfio_pci: Destroy the
 [state|reset]_mutex on release
Thread-Index: AQHaHXtMt7sx3BVFf0S8PgAhqyIeL7CJKt8A
Date:   Fri, 24 Nov 2023 08:51:09 +0000
Message-ID: <00df3a24ff594c409eb2ab92d20733f5@huawei.com>
References: <20231122193634.27250-1-brett.creeley@amd.com>
 <20231122193634.27250-3-brett.creeley@amd.com>
In-Reply-To: <20231122193634.27250-3-brett.creeley@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Brett Creeley [mailto:brett.creeley@amd.com]
> Sent: 22 November 2023 19:37
> To: jgg@ziepe.ca; yishaih@nvidia.com; liulongfang
> <liulongfang@huawei.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; kevin.tian@intel.com;
> alex.williamson@redhat.com; kvm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: shannon.nelson@amd.com; brett.creeley@amd.com
> Subject: [PATCH vfio 2/2] hisi_acc_vfio_pci: Destroy the [state|reset]_mutex
> on release
> 
> The [state|reset]_mutex are initialized in vfio init, but
> never destroyed. This isn't required as mutex_destroy()
> doesn't do anything unless lock debugging is enabled.
> However, for completeness, fix it by implementing a
> driver specific release function.
> 
> No fixes tag is added as it doesn't seem worthwhile
> for such a trivial and debug only change.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks.

> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 2c049b8de4b4..dc1e376e1b8a 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1358,10 +1358,20 @@ static int
> hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>  	return vfio_pci_core_init_dev(core_vdev);
>  }
> 
> +static void hisi_acc_vfio_pci_migrn_release_dev(struct vfio_device
> *core_vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =
> container_of(core_vdev,
> +			struct hisi_acc_vf_core_device, core_device.vdev);
> +
> +	mutex_destroy(&hisi_acc_vdev->reset_mutex);
> +	mutex_destroy(&hisi_acc_vdev->state_mutex);
> +	vfio_pci_core_release_dev(core_vdev);
> +}
> +
>  static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
>  	.name = "hisi-acc-vfio-pci-migration",
>  	.init = hisi_acc_vfio_pci_migrn_init_dev,
> -	.release = vfio_pci_core_release_dev,
> +	.release = hisi_acc_vfio_pci_migrn_release_dev,
>  	.open_device = hisi_acc_vfio_pci_open_device,
>  	.close_device = hisi_acc_vfio_pci_close_device,
>  	.ioctl = hisi_acc_vfio_pci_ioctl,
> --
> 2.17.1

