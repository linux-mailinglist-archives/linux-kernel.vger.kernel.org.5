Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A233764344
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjG0BO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjG0BOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:14:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFC2709;
        Wed, 26 Jul 2023 18:14:48 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBCQV63crztRcF;
        Thu, 27 Jul 2023 09:11:30 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 09:14:45 +0800
Subject: Re: [PATCH] scsi: hisi_sas: Fix warning detected by sparse
To:     Sunil V L <sunilvl@ventanamicro.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230726051759.30038-1-sunilvl@ventanamicro.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <ab7231ca-9488-620f-f1bb-ac63e2240c72@hisilicon.com>
Date:   Thu, 27 Jul 2023 09:14:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20230726051759.30038-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,


在 2023/7/26 星期三 13:17, Sunil V L 写道:
> LKP reports below warning when building for RISC-V
> with randconfig configuration.
>
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse:
> sparse: incorrect type in argument 4 (different base types)
> @@     expected restricted __le32 [usertype] *[assigned] ptr
> @@     got unsigned int * @@
>
> Type cast to fix this warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307260823.whMNpZ1C-lkp@intel.com/
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>

Thanks!

> ---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 20e1607c6282..6cd2e485d35b 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -4576,7 +4576,7 @@ static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
>   	debugfs_read_fifo_data_v3_hw(phy);
>   
>   	debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
> -				  phy->fifo.rd_data);
> +				  (__le32 *)phy->fifo.rd_data);
>   
>   	return 0;
>   }

