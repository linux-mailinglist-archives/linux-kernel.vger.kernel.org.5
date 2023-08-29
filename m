Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713DD78C922
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjH2QAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjH2P7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:59:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFEF12F;
        Tue, 29 Aug 2023 08:59:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZsSx1wZJz6J7Xw;
        Tue, 29 Aug 2023 23:55:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 16:59:31 +0100
Date:   Tue, 29 Aug 2023 16:59:30 +0100
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
Subject: Re: [PATCH RFC v2 10/18] cxl/mem: Handle DCD add and release
 capacity events.
Message-ID: <20230829165930.0000208c@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Mon, 28 Aug 2023 22:21:01 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> A Dynamic Capacity Device (DCD) utilizes events to signal the host about
> the changes to the allocation of Dynamic Capacity (DC) extents. The
> device communicates the state of DC extents through an extent list that
> describes the starting DPA, length, and meta data of the blocks the host
> can access.
> 
> Process the dynamic capacity add and release events.  The addition or
> removal of extents can occur at any time.  Adding asynchronous memory is
> straight forward.  Also remember the host is under no obligation to
> respond to a release event until it is done with the memory.  Introduce
> extent kref's to handle the delay of extent release.
> 
> In the case of a force removal, access to the memory will fail and may
> cause a crash.  However, the extent tracking object is preserved for the
> region to safely tear down as long as the memory is not accessed.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Minor stuff inline.


> +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> +				int *n, struct range *extent)
> +{
> +	struct cxl_mbox_dc_response *dc_res;
> +	unsigned int size;
> +
> +	if (!extent)
> +		size = struct_size(dc_res, extent_list, 0);

This is confusing as if you did have *n > 0 I'd kind of expect
this to just not extend the list rather than shortening it.
Now I guess that never happens, but locally it looks odd.

Maybe just handle that case in a separate function as it doesn't
share much code with the case where there is an extent and I would
assume we always know at the caller which one we want.


> +	else
> +		size = struct_size(dc_res, extent_list, *n + 1);

Might be clearer with a local variable for the number of extents.

extents_count = *n;

if (extent)
	extents_count++;

size = struct_size(dc_res, extent_list, extents_count);

Though I'm not sure that really helps.  Maybe this will just need
to be a little confusing :)

> +
> +	dc_res = krealloc(*res, size, GFP_KERNEL);
> +	if (!dc_res)
> +		return -ENOMEM;
> +
> +	if (extent) {
> +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> +		dc_res->extent_list[*n].length = cpu_to_le64(range_len(extent));
> +		(*n)++;
> +	}
> +
> +	*res = dc_res;
> +	return 0;
> +}

> +
> +/* Returns 0 if the event was handled successfully. */
> +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> +					struct cxl_event_record_raw *rec)
> +{
> +	struct dcd_event_dyn_cap *record = (struct dcd_event_dyn_cap *)rec;
> +	uuid_t *id = &rec->hdr.id;
> +	int rc;
> +
> +	if (!uuid_equal(id, &dc_event_uuid))
> +		return -EINVAL;
> +
> +	switch (record->data.event_type) {
> +	case DCD_ADD_CAPACITY:
> +		rc = cxl_handle_dcd_add_event(mds, &record->data.extent);
> +		break;

I guess it might not be consistent with local style...
		return cxl_handle_dcd_add_event()  etc

> +	case DCD_RELEASE_CAPACITY:
> +        case DCD_FORCED_CAPACITY_RELEASE:
> +		rc = cxl_handle_dcd_release_event(mds, &record->data.extent);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +


