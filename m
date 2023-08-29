Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446978C864
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbjH2PPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjH2POy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:14:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15233BD;
        Tue, 29 Aug 2023 08:14:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZrSr75dqz6K5km;
        Tue, 29 Aug 2023 23:10:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 16:14:49 +0100
Date:   Tue, 29 Aug 2023 16:14:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
Message-ID: <20230829161449.00000c7a@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
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

On Mon, 28 Aug 2023 22:20:58 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> user space will need to know the details of the DC Regions available on
> a device.
> 
> Expose driver dynamic capacity configuration through sysfs
> attributes.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
One trivial comment inline.  I wondered a bit if it would
be better to not present dc at all on devices that don't support
dynamic capacity, but for now there isn't an elegant way to do that
(some discussions and patches are flying around however so maybe this
 will be resolved before this series merges giving us that elegant
 option).

With commented code tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
> Changes for v2:
> [iweiny: Rebased on latest master/type2 work]
> [iweiny: add documentation for sysfs entries]
> [iweiny: s/dc_regions_count/region_count/]
> [iweiny: s/dcY_size/regionY_size/]
> [alison: change size format to %#llx]
> [iweiny: change count format to %d]
> [iweiny: Formatting updates]
> [iweiny: Fix crash when device is not a mem device: found with cxl-test]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
>  drivers/cxl/core/memdev.c               | 77 +++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 2268ffcdb604..aa65dc5b4e13 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -37,6 +37,23 @@ Description:
>  		identically named field in the Identify Memory Device Output
>  		Payload in the CXL-2.0 specification.
>  
> +What:		/sys/bus/cxl/devices/memX/dc/region_count
> +Date:		July, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Number of Dynamic Capacity (DC) regions supported on the
> +		device.  May be 0 if the device does not support Dynamic
> +		Capacity.
> +
> +What:		/sys/bus/cxl/devices/memX/dc/regionY_size
> +Date:		July, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Size of the Dynamic Capacity (DC) region Y.  Only
> +		available on devices which support DC and only for those
> +		region indexes supported by the device.
>  
>  What:		/sys/bus/cxl/devices/memX/serial
>  Date:		January, 2022
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 492486707fd0..397262e0ebd2 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -101,6 +101,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t region_count_show(struct device *dev, struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	int len = 0;
> +
> +	len = sysfs_emit(buf, "%d\n", mds->nr_dc_region);
> +	return len;

return sysfs_emit(buf, "...);
	
> +}
> +
> +struct device_attribute dev_attr_region_count =
> +	__ATTR(region_count, 0444, region_count_show, NULL);
> +
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -454,6 +468,62 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
> +}
> +
> +#define REGION_SIZE_ATTR_RO(n)						\
> +static ssize_t region##n##_size_show(struct device *dev,		\
> +				     struct device_attribute *attr,	\
> +				     char *buf)				\
> +{									\
> +	return show_size_regionN(to_cxl_memdev(dev), buf, (n));		\
> +}									\
> +static DEVICE_ATTR_RO(region##n##_size)
> +REGION_SIZE_ATTR_RO(0);
> +REGION_SIZE_ATTR_RO(1);
> +REGION_SIZE_ATTR_RO(2);
> +REGION_SIZE_ATTR_RO(3);
> +REGION_SIZE_ATTR_RO(4);
> +REGION_SIZE_ATTR_RO(5);
> +REGION_SIZE_ATTR_RO(6);
> +REGION_SIZE_ATTR_RO(7);
> +
> +static struct attribute *cxl_memdev_dc_attributes[] = {
> +	&dev_attr_region0_size.attr,
> +	&dev_attr_region1_size.attr,
> +	&dev_attr_region2_size.attr,
> +	&dev_attr_region3_size.attr,
> +	&dev_attr_region4_size.attr,
> +	&dev_attr_region5_size.attr,
> +	&dev_attr_region6_size.attr,
> +	&dev_attr_region7_size.attr,
> +	&dev_attr_region_count.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	/* Not a memory device */
> +	if (!mds)
> +		return 0;
> +
> +	if (a == &dev_attr_region_count.attr)
> +		return a->mode;
> +
> +	if (n < mds->nr_dc_region)
> +		return a->mode;
> +
> +	return 0;
> +}
> +
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> @@ -482,11 +552,18 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
>  	.attrs = cxl_memdev_security_attributes,
>  };
>  
> +static struct attribute_group cxl_memdev_dc_attribute_group = {
> +	.name = "dc",
> +	.attrs = cxl_memdev_dc_attributes,
> +	.is_visible = cxl_dc_visible,
> +};
> +
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
>  	&cxl_memdev_security_attribute_group,
> +	&cxl_memdev_dc_attribute_group,
>  	NULL,
>  };
>  
> 

