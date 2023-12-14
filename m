Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EEA812A69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjLNIbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjLNIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:31:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57869126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:31:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B431C433C8;
        Thu, 14 Dec 2023 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702542670;
        bh=XhtXMTLrB7TaL4OGwCq1/5AnWLeypq+BMzyNEqR5H9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kk+AZ+DVVomEJXbQK/IGA23dG4WisCKhVO6q/x+A8aiuX4YFdzwJtFgPHS/E2cJIK
         /QDsWd4xgu5UuGhEXCmjVkOjVqZUiygkwA10BRlV00oZLJKvAP4CSEsygOj30LXQxU
         ZPUuEX4HqOK/bucObq8W7oUoD5kusVE/ub0N7oKk=
Date:   Thu, 14 Dec 2023 09:31:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 4/4] dax: add a sysfs knob to control memmap_on_memory
 behavior
Message-ID: <2023121453-tiling-banshee-5acd@gregkh>
References: <20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com>
 <20231214-vv-dax_abi-v5-4-3f7b006960b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-vv-dax_abi-v5-4-3f7b006960b4@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:37:57AM -0700, Vishal Verma wrote:
> +static ssize_t memmap_on_memory_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +
> +	return sprintf(buf, "%d\n", dev_dax->memmap_on_memory);

checkpatch should have noticed that this should be sysfs_emit(), right?
If not, please make the change anyway.

> diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
> index 6359f7bc9bf4..40d9965733b2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-dax
> +++ b/Documentation/ABI/testing/sysfs-bus-dax
> @@ -134,3 +134,20 @@ KernelVersion:	v5.1
>  Contact:	nvdimm@lists.linux.dev
>  Description:
>  		(RO) The id attribute indicates the region id of a dax region.
> +
> +What:		/sys/bus/dax/devices/daxX.Y/memmap_on_memory
> +Date:		October, 2023

It's not October anymore :)

thanks,

greg k-h
