Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419B77F84A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351703AbjHQOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351680AbjHQODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:03:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E81332D75
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB636D75;
        Thu, 17 Aug 2023 07:04:23 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5322B3F6C4;
        Thu, 17 Aug 2023 07:03:41 -0700 (PDT)
Message-ID: <1d38e877-35ed-5f70-e51f-ea875deab903@arm.com>
Date:   Thu, 17 Aug 2023 15:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] coresight: Fix memory leak in acpi_buffer->pointer
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230817085937.55590-1-hejunhao3@huawei.com>
 <20230817085937.55590-2-hejunhao3@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230817085937.55590-2-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 09:59, Junhao He wrote:
> There are memory leaks reported by kmemleak:
> ...
> unreferenced object 0xffff00213c141000 (size 1024):
>   comm "systemd-udevd", pid 2123, jiffies 4294909467 (age 6062.160s)
>   hex dump (first 32 bytes):
>     04 00 00 00 02 00 00 00 18 10 14 3c 21 00 ff ff  ...........<!...
>     00 00 00 00 00 00 00 00 03 00 00 00 10 00 00 00  ................
>   backtrace:
>     [<000000004b7c9001>] __kmem_cache_alloc_node+0x2f8/0x348
>     [<00000000b0fc7ceb>] __kmalloc+0x58/0x108
>     [<0000000064ff4695>] acpi_os_allocate+0x2c/0x68
>     [<000000007d57d116>] acpi_ut_initialize_buffer+0x54/0xe0
>     [<0000000024583908>] acpi_evaluate_object+0x388/0x438
>     [<0000000017b2e72b>] acpi_evaluate_object_typed+0xe8/0x240
>     [<000000005df0eac2>] coresight_get_platform_data+0x1b4/0x988 [coresight]
> ...
> 
> The ACPI buffer memory (buf.pointer) should be freed. But the buffer
> is also used after returning from acpi_get_dsd_graph().
> Move the temporary variables buf to acpi_coresight_parse_graph(),
> and free it before the function return to prevent memory leak.
> 
> Fixes: 76ffa5ab5b79 ("coresight: Support for ACPI bindings")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

I confirmed that the error gone. Thanks for the fix.

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  .../hwtracing/coresight/coresight-platform.c  | 40 ++++++++++++-------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 7d7b641c0a71..9d550f5697fa 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -492,19 +492,18 @@ static inline bool acpi_validate_dsd_graph(const union acpi_object *graph)
>  
>  /* acpi_get_dsd_graph	- Find the _DSD Graph property for the given device. */
>  static const union acpi_object *
> -acpi_get_dsd_graph(struct acpi_device *adev)
> +acpi_get_dsd_graph(struct acpi_device *adev, struct acpi_buffer *buf)
>  {
>  	int i;
> -	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
>  	acpi_status status;
>  	const union acpi_object *dsd;
>  
>  	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL,
> -					    &buf, ACPI_TYPE_PACKAGE);
> +					    buf, ACPI_TYPE_PACKAGE);
>  	if (ACPI_FAILURE(status))
>  		return NULL;
>  
> -	dsd = buf.pointer;
> +	dsd = buf->pointer;
>  
>  	/*
>  	 * _DSD property consists tuples { Prop_UUID, Package() }
> @@ -555,12 +554,12 @@ acpi_validate_coresight_graph(const union acpi_object *cs_graph)
>   * returns NULL.
>   */
>  static const union acpi_object *
> -acpi_get_coresight_graph(struct acpi_device *adev)
> +acpi_get_coresight_graph(struct acpi_device *adev, struct acpi_buffer *buf)
>  {
>  	const union acpi_object *graph_list, *graph;
>  	int i, nr_graphs;
>  
> -	graph_list = acpi_get_dsd_graph(adev);
> +	graph_list = acpi_get_dsd_graph(adev, buf);
>  	if (!graph_list)
>  		return graph_list;
>  
> @@ -661,22 +660,24 @@ static int acpi_coresight_parse_graph(struct device *dev,
>  				      struct acpi_device *adev,
>  				      struct coresight_platform_data *pdata)
>  {
> +	int ret = 0;
>  	int i, nlinks;
>  	const union acpi_object *graph;
>  	struct coresight_connection conn, zero_conn = {};
>  	struct coresight_connection *new_conn;
> +	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  
> -	graph = acpi_get_coresight_graph(adev);
> +	graph = acpi_get_coresight_graph(adev, &buf);
>  	/*
>  	 * There are no graph connections, which is fine for some components.
>  	 * e.g., ETE
>  	 */
>  	if (!graph)
> -		return 0;
> +		goto free;
>  
>  	nlinks = graph->package.elements[2].integer.value;
>  	if (!nlinks)
> -		return 0;
> +		goto free;
>  
>  	for (i = 0; i < nlinks; i++) {
>  		const union acpi_object *link = &graph->package.elements[3 + i];
> @@ -684,17 +685,28 @@ static int acpi_coresight_parse_graph(struct device *dev,
>  
>  		conn = zero_conn;
>  		dir = acpi_coresight_parse_link(adev, link, &conn);
> -		if (dir < 0)
> -			return dir;
> +		if (dir < 0) {
> +			ret = dir;
> +			goto free;
> +		}
>  
>  		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
>  			new_conn = coresight_add_out_conn(dev, pdata, &conn);
> -			if (IS_ERR(new_conn))
> -				return PTR_ERR(new_conn);
> +			if (IS_ERR(new_conn)) {
> +				ret = PTR_ERR(new_conn);
> +				goto free;
> +			}
>  		}
>  	}
>  
> -	return 0;
> +free:
> +	/*
> +	 * When ACPI fails to alloc a buffer, it will free the buffer
> +	 * created via ACPI_ALLOCATE_BUFFER and set to NULL.
> +	 * ACPI_FREE can handle NULL pointers, so free it directly.
> +	 */
> +	ACPI_FREE(buf.pointer);
> +	return ret;
>  }
>  
>  /*
