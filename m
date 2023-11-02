Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA477DEC69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbjKBFkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348540AbjKBFkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:40:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29159128
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:40:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183CBC433C9;
        Thu,  2 Nov 2023 05:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698903615;
        bh=C0oNnW2C4+FnQKa7bIHzaESxVdM7l0n5Xz2J7g6Tzek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQ3mbFJSkioebglr77L0j6L8u0OR1FY/7pYGvuIEUHigCcjjzKy76JlfANUBFgD3m
         dLoTSnCmGpQXW84MBRD6I2KRbwjyiwYvc23sjvfDJrv0kB16MF/qBfngEl262iymrg
         hdc+MDUQQLqljd9l2WeoiedK/a+rbTZ4XRGexV64=
Date:   Thu, 2 Nov 2023 06:40:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, rafael@kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] drivers/base/node: add demote_src and demote_dst
 to numastat
Message-ID: <2023110230-lilly-mustang-9b57@gregkh>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
 <20231102025648.1285477-5-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102025648.1285477-5-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 10:56:48AM +0800, Li Zhijian wrote:
> node0 and node1 is DRAM node, node3 is a PMEM node.
> 
> $ cat /sys/devices/system/node/node1/numastat
> numa_hit 646590
> numa_miss 3963
> numa_foreign 30651
> interleave_hit 416
> local_node 645252
> other_node 5301
> demote_src 200478
> demote_dst 0
> 
> Of cousre, the userspace numastat will be extened to support these 2
> new fields in the future like:
> $ numastat
>                            node0           node1           node3
> numa_hit                  741793          702460          364154
> numa_miss                   1759            8104           28893
> numa_foreign                8105           30651               0
> interleave_hit               653             416               0
> local_node                741762          701115               0
> other_node                  1790            9449          393047
> demote_src                163612          203828               0
> demote_dst                     0               0          367440
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/base/node.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 27e8502548a7..d3fc70599b6a 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -496,20 +496,32 @@ static DEVICE_ATTR(meminfo, 0444, node_read_meminfo, NULL);
>  static ssize_t node_read_numastat(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> +	struct pglist_data *pgdat = NODE_DATA(dev->id);
> +	unsigned long demote_src, demote_dst;
> +
>  	fold_vm_numa_events();
> +	demote_src = node_page_state_pages(pgdat, PGDEMOTE_SRC_KSWAPD) +
> +		     node_page_state_pages(pgdat, PGDEMOTE_SRC_DIRECT) +
> +		     node_page_state_pages(pgdat, PGDEMOTE_SRC_KHUGEPAGED);
> +	demote_dst = node_page_state_pages(pgdat, PGDEMOTE_DST_KSWAPD) +
> +		     node_page_state_pages(pgdat, PGDEMOTE_DST_DIRECT) +
> +		     node_page_state_pages(pgdat, PGDEMOTE_DST_KHUGEPAGED);
>  	return sysfs_emit(buf,
>  			  "numa_hit %lu\n"
>  			  "numa_miss %lu\n"
>  			  "numa_foreign %lu\n"
>  			  "interleave_hit %lu\n"
>  			  "local_node %lu\n"
> -			  "other_node %lu\n",
> +			  "other_node %lu\n"
> +			  "demote_src %lu\n"
> +			  "demote_dst %lu\n",

This sysfs file is already a total abuse of sysfs so please, do NOT make
it worse by adding more fields, that's just wrong and something I can
not take at all for obvious reasons.

thanks,

greg k-h
