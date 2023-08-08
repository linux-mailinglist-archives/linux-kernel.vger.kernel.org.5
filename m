Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3077433C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjHHR70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjHHR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:59:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F62CC49;
        Tue,  8 Aug 2023 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512012; x=1723048012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T9G9Kn2Yy64VyUf7GtnFfOpnJ3qoI3E0S57PnbQfz9w=;
  b=V1ksRFGmzFjbJsQiNxh0/I0qCGpVUC3CxC0Q2gRnFJ6MHU7unZO161+k
   4Z6MWS+FQiH5Fy526et9OY/YIXzZVeKjT8VaGHJkRORbD0QmJh67cdw6T
   XVYadLZHsu4K/VS5D/Uuth6QJl/Ue+LzMzIL9gCesPzlFl+CqL8iYyIM1
   4/fDhrXMxuUV9FBsWhvWiYiVi3tTjqXbcmN0SL9qzu87oNKx+v3Y/hcQZ
   v6oys+meLsM4JI2sHSris/9kH7HnU6qWF8O1QE4Ene20SL7OWAUXlbNC6
   feXNOC4BilSz0gvGY3cesNyzIyw0UdFPb6trIdtFTR1pB0Y8a1mS/XIm+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457260962"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457260962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821449150"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821449150"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 09:24:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 42942385; Tue,  8 Aug 2023 19:28:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 2/6] device property: Add fwnode_property_match_property_string()
Date:   Tue,  8 Aug 2023 19:27:56 +0300
Message-Id: <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the users want to match the single value string property
against an array of predefined strings. Create a helper for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/property.h | 12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3bb9505f1631..8f8e2a6816bc 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -498,6 +498,41 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_match_string);
 
+/**
+ * fwnode_property_match_property_string - find a property string value in an array and return index
+ * @fwnode: Firmware node to get the property of
+ * @propname: Name of the property holding the string value
+ * @array: String array to search in
+ * @n: Size of the @array
+ *
+ * Find a property string value in a given @array and if it is found return
+ * the index back.
+ *
+ * Return: index, starting from %0, if the string value was found in the @array (success),
+ *	   %-ENOENT when the string value was not found in the @array,
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO or %-EILSEQ if the property is not a string,
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
+	const char *propname, const char * const *array, size_t n)
+{
+	const char *string;
+	int ret;
+
+	ret = fwnode_property_read_string(fwnode, propname, &string);
+	if (ret)
+		return ret;
+
+	ret = match_string(array, n, string);
+	if (ret < 0)
+		ret = -ENOENT;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fwnode_property_match_property_string);
+
 /**
  * fwnode_property_get_reference_args() - Find a reference with arguments
  * @fwnode:	Firmware node where to look for the reference
diff --git a/include/linux/property.h b/include/linux/property.h
index 8c3c6685a2ae..11f3ad6814f2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -97,6 +97,18 @@ static inline bool device_is_compatible(const struct device *dev, const char *co
 	return fwnode_device_is_compatible(dev_fwnode(dev), compat);
 }
 
+int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
+					  const char *propname,
+					  const char * const *array, size_t n);
+
+static inline
+int device_property_match_property_string(const struct device *dev,
+					  const char *propname,
+					  const char * const *array, size_t n)
+{
+	return fwnode_property_match_property_string(dev_fwnode(dev), propname, array, n);
+}
+
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,
-- 
2.40.0.1.gaa8946217a0b

