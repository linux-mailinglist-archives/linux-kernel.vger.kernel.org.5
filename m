Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E456878C894
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjH2P0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjH2P0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:26:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50577CD7;
        Tue, 29 Aug 2023 08:26:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZrjn0zZRz686y1;
        Tue, 29 Aug 2023 23:21:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 16:26:01 +0100
Date:   Tue, 29 Aug 2023 16:26:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 09/18] cxl/mem: Read extents on memory device
 discovery
Message-ID: <20230829162600.00004ac2@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-9-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-9-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 22:21:00 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> When a Dynamic Capacity Device (DCD) is realized some extents may
> already be available within the DC Regions.  This can happen if the host
> has accepted extents and been rebooted or any other time the host driver
> software has become out of sync with the device hardware.
> 
> Read the available extents during probe and store them for later
> use.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
A few minor comments inline.

Thanks,

Jonathan

> ---
> Change for v2:
> [iweiny: new patch]
> ---
>  drivers/cxl/core/mbox.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    |  36 +++++++++
>  drivers/cxl/pci.c       |   4 +
>  3 files changed, 235 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d769814f80e2..9b08c40ef484 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -824,6 +824,37 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)

...

> +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +				     unsigned int *extent_gen_num)
> +{
> +	struct cxl_mbox_get_dc_extent get_dc_extent;
> +	struct cxl_mbox_dc_extents dc_extents;
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	unsigned int count;
> +	int rc;
> +
> +	/* Check GET_DC_EXTENT_LIST is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> +		return 0;
> +	}
> +
> +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> +		.extent_cnt = cpu_to_le32(0),
> +		.start_extent_index = cpu_to_le32(0),
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +		.payload_in = &get_dc_extent,
> +		.size_in = sizeof(get_dc_extent),
> +		.size_out = mds->payload_size,

If all you are after is the count, then size_out can be a lot smaller than that
I think as we know it can't return any extents.

> +		.payload_out = &dc_extents,
> +		.min_out = 1,
> +	};
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	count = le32_to_cpu(dc_extents.total_extent_cnt);
> +	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
> +
> +	return count;
> +}
> +
> +static int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> +				  unsigned int start_gen_num,
> +				  unsigned int exp_cnt)
> +{
> +	struct cxl_mbox_dc_extents *dc_extents;
> +	unsigned int start_index, total_read;
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int retry = 3;

Why 3?

> +	int rc;
> +
> +	/* Check GET_DC_EXTENT_LIST is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> +		return 0;
> +	}
> +
> +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);

Maybe __free magic would simplify this enough to be useful.

> +	if (!dc_extents)
> +		return -ENOMEM;
> +
> +reset:
> +	total_read = 0;
> +	start_index = 0;
> +	do {
> +		unsigned int nr_ext, total_extent_cnt, gen_num;
> +		struct cxl_mbox_get_dc_extent get_dc_extent;
> +
> +		get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> +			.extent_cnt = exp_cnt - start_index,
> +			.start_extent_index = start_index,
> +		};
> +		
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +			.payload_in = &get_dc_extent,
> +			.size_in = sizeof(get_dc_extent),
> +			.size_out = mds->payload_size,
> +			.payload_out = dc_extents,
> +			.min_out = 1,
> +		};
> +		
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0)
> +			goto out;
> +		
> +		nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);
> +		total_read += nr_ext;
> +		total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> +		gen_num = le32_to_cpu(dc_extents->extent_list_num);
> +
> +		dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
> +			total_extent_cnt, gen_num);
> +
> +		if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
> +			dev_err(dev, "Extent list changed while reading; %u != %u : %u != %u\n",
> +				gen_num, start_gen_num, exp_cnt, total_extent_cnt);
> +			if (retry--)
> +				goto reset;
> +			return -EIO;
> +		}
> +		
> +		for (int i = 0; i < nr_ext ; i++) {
> +			dev_dbg(dev, "Storing extent %d/%d\n",
> +				start_index + i, exp_cnt);
> +			rc = cxl_store_dc_extent(mds, &dc_extents->extent[i]);
> +			if (rc)
> +				goto out;
> +		}
> +
> +		start_index += nr_ext;
> +	} while (exp_cnt > total_read);
> +
> +out:
> +	kvfree(dc_extents);
> +	return rc;
> +}


