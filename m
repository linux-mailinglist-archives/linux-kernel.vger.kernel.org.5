Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115618000F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjLAB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLAB3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:29:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF210D1;
        Thu, 30 Nov 2023 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701394167; x=1732930167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Od0OV/m0R2tQLMJWSylL1P+SOYauHRST34A3DngAhiY=;
  b=m427PfKTAZEicOESssWYVFDYP441fzXZr12MbapD7EtOzHskZH7hmjDZ
   rXBbJBusqXKCS8i5//gnlIqXYKkGwVKlbguo8e6pWrFNDTNyFNQUZbTdT
   2jY/6kXLcA/fJRXjkc9WuBpu3+mtK5WmmUdhhLTD4laW1jQvlAeeQlI8m
   4KCv9I9jUtTPiy26u0UsB/2YHmKfFifCPrD2DheDeZzPM64LYIoqhj3uP
   Nz++iCCBlHEM5aiV2j0J0r7bJTrVT7TQV5hKZO9C3nRg4gGfR/FtybQMe
   H/v9gDTIozWly9i7wJmJiITgCm/hMxbTSNGIV+Q1ZIABTaCXosJ5w0gsc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="303875"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="303875"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 17:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="745821708"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="745821708"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 17:29:26 -0800
Date:   Thu, 30 Nov 2023 17:27:00 -0800
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, fenghua.yu@intel.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/3] hwmon: (coretemp) Remove unnecessary dependency of
 array index
Message-ID: <ZWk2ZAxuyOFDCTmv@araj-dh-work.jf.intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-3-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127131651.476795-3-rui.zhang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:16:50PM +0800, Zhang Rui wrote:
> When sensor_device_attribute pointer is available, use container_of() to
> get the temp_data address.
> 
> This removes the unnecessary dependency of cached index in
> pdata->core_data[].
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/hwmon/coretemp.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 6053ed3761c2..cef43fedbd58 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -342,7 +342,7 @@ static ssize_t show_label(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_LABEL]);
>  
>  	if (tdata->is_pkg_data)
>  		return sprintf(buf, "Package id %u\n", pdata->pkg_id);
> @@ -355,8 +355,7 @@ static ssize_t show_crit_alarm(struct device *dev,
>  {
>  	u32 eax, edx;
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_CRIT_ALARM]);
>  
>  	mutex_lock(&tdata->update_lock);
>  	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> @@ -369,8 +368,7 @@ static ssize_t show_tjmax(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TJMAX]);
>  	int tjmax;
>  
>  	mutex_lock(&tdata->update_lock);
> @@ -384,8 +382,7 @@ static ssize_t show_ttarget(struct device *dev,
>  				struct device_attribute *devattr, char *buf)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TTARGET]);
>  	int ttarget;
>  
>  	mutex_lock(&tdata->update_lock);
> @@ -402,8 +399,7 @@ static ssize_t show_temp(struct device *dev,
>  {
>  	u32 eax, edx;
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> +	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TEMP]);
>  	int tjmax;
>  
>  	mutex_lock(&tdata->update_lock);
> @@ -445,7 +441,6 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
>  		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
>  		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
>  		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
> -		tdata->sd_attrs[i].index = attr_no;

I was naively thinking if we could nuke that "index". I can see that used
in couple macros, but seems like we can lose it?

Completely untested.. and uncertain :-) 


diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index d896713359cd..4855893f9401 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -12,36 +12,35 @@
 
 struct sensor_device_attribute{
 	struct device_attribute dev_attr;
-	int index;
 };
 #define to_sensor_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
 
-#define SENSOR_ATTR(_name, _mode, _show, _store, _index)	\
+#define SENSOR_ATTR(_name, _mode, _show, _store)	\
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
-	  .index = _index }
+	  }
 
-#define SENSOR_ATTR_RO(_name, _func, _index)			\
+#define SENSOR_ATTR_RO(_name, _func)			\
 	SENSOR_ATTR(_name, 0444, _func##_show, NULL, _index)
 
-#define SENSOR_ATTR_RW(_name, _func, _index)			\
-	SENSOR_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+#define SENSOR_ATTR_RW(_name, _func)			\
+	SENSOR_ATTR(_name, 0644, _func##_show, _func##_store)
 
-#define SENSOR_ATTR_WO(_name, _func, _index)			\
-	SENSOR_ATTR(_name, 0200, NULL, _func##_store, _index)
+#define SENSOR_ATTR_WO(_name, _func)			\
+	SENSOR_ATTR(_name, 0200, NULL, _func##_store)
 
-#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
+#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store)	\
 struct sensor_device_attribute sensor_dev_attr_##_name		\
-	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
+	= SENSOR_ATTR(_name, _mode, _show, _store)
 
-#define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)		\
-	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)
+#define SENSOR_DEVICE_ATTR_RO(_name, _func)		\
+	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL)
 
 #define SENSOR_DEVICE_ATTR_RW(_name, _func, _index)		\
-	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store)
 
-#define SENSOR_DEVICE_ATTR_WO(_name, _func, _index)		\
-	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store, _index)
+#define SENSOR_DEVICE_ATTR_WO(_name, _func)		\
+	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store)
 
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
index 975da8e7f2a9..c3bbf2f7d6eb 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -239,7 +239,7 @@ hwm_power1_max_interval_store(struct device *dev,
 
 static SENSOR_DEVICE_ATTR(power1_max_interval, 0664,
 			  hwm_power1_max_interval_show,
-			  hwm_power1_max_interval_store, 0);
+			  hwm_power1_max_interval_store);
 
 static struct attribute *hwm_attributes[] = {
 	&sensor_dev_attr_power1_max_interval.dev_attr.attr,
