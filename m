Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7897E54EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbjKHLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344475AbjKHLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:19:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B21981BD5;
        Wed,  8 Nov 2023 03:19:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF39D1477;
        Wed,  8 Nov 2023 03:19:59 -0800 (PST)
Received: from [10.1.26.57] (e127643.arm.com [10.1.26.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9703F703;
        Wed,  8 Nov 2023 03:19:11 -0800 (PST)
Message-ID: <d396d9ba-9574-8f11-8bbb-d1fd939421c5@arm.com>
Date:   Wed, 8 Nov 2023 11:19:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] coresight: Add remote etm support
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
 <20231107060939.13449-2-quic_jinlmao@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231107060939.13449-2-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2023 06:09, Mao Jinlong wrote:
> Add support for ETM trace collection on remote processor using
> coreSight framework.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/Kconfig           |   9 +
>  drivers/hwtracing/coresight/Makefile          |   1 +
>  drivers/hwtracing/coresight/coresight-core.c  |   3 +
>  drivers/hwtracing/coresight/coresight-qmi.h   | 109 ++++++
>  .../coresight/coresight-remote-etm.c          | 325 ++++++++++++++++++
>  include/linux/coresight.h                     |   1 +
>  6 files changed, 448 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-qmi.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-remote-etm.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 06f0a7594169..425886ab7401 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -247,4 +247,13 @@ config CORESIGHT_DUMMY
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called coresight-dummy.
> +
> +config CORESIGHT_REMOTE_ETM
> +	tristate "Remote processor ETM trace support"
> +	select QCOM_QMI_HELPERS
> +	help
> +	  Enables support for ETM trace collection on remote processor using
> +	  CoreSight framework. Enabling this will allow turning on ETM
> +	  tracing on remote processor via sysfs by configuring the required
> +	  CoreSight components.
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 995d3b2c76df..a5283cab0bc0 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -29,5 +29,6 @@ obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>  obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>  coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>  		   coresight-cti-sysfs.o
> +obj-$(CONFIG_CORESIGHT_REMOTE_ETM) += coresight-remote-etm.o
>  obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>  obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index d7f0e231feb9..f365a3899821 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1094,6 +1094,7 @@ static int coresight_validate_source(struct coresight_device *csdev,
>  	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>  	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>  	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC &&

It's not really related to this patch, but it feels like we're starting
to add too many subtypes that all behave in the same way. Sometimes the
subtype is used for identification, and sometimes it's used for
behavior. But when it's used for behavior like in this case they all
mean the same thing.

We should probably have just three subtypes "PROC", "OTHER" and
"SOFTWARE". And add a new ID field for things like "TPDM", or even just
use the names for identification, if that's possible.

In this case your new one would be "OTHER" because it doesn't have
per-CPU behaviour, and it doesn't have the enable refcounting that
"SOFTWARE" has.

>  	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>  		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>  		return -EINVAL;
> @@ -1164,6 +1165,7 @@ int coresight_enable(struct coresight_device *csdev)
>  		break;
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>  		/*
>  		 * Use the hash of source's device name as ID
> @@ -1215,6 +1217,7 @@ void coresight_disable(struct coresight_device *csdev)
>  		break;
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>  		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>  		/* Find the path by the hash. */
> diff --git a/drivers/hwtracing/coresight/coresight-qmi.h b/drivers/hwtracing/coresight/coresight-qmi.h
> new file mode 100644
> index 000000000000..4c35ba8c8a05
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-qmi.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _CORESIGHT_QMI_H
> +#define _CORESIGHT_QMI_H
> +
> +#include <linux/soc/qcom/qmi.h>
> +
> +#define CORESIGHT_QMI_SVC_ID			(0x33)
> +#define CORESIGHT_QMI_VERSION			(1)
> +
> +#define CORESIGHT_QMI_GET_ETM_REQ_V01		(0x002B)
> +#define CORESIGHT_QMI_GET_ETM_RESP_V01		(0x002B)
> +#define CORESIGHT_QMI_SET_ETM_REQ_V01		(0x002C)
> +#define CORESIGHT_QMI_SET_ETM_RESP_V01		(0x002C)
> +
> +#define CORESIGHT_QMI_GET_ETM_REQ_MAX_LEN	(0)
> +#define CORESIGHT_QMI_GET_ETM_RESP_MAX_LEN	(14)
> +#define CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN	(7)
> +#define CORESIGHT_QMI_SET_ETM_RESP_MAX_LEN	(7)
> +
> +#define TIMEOUT_MS				(10000)
> +
> +enum coresight_etm_state_enum_type_v01 {
> +	/* To force a 32 bit signed enum. Do not change or use */
> +	CORESIGHT_ETM_STATE_ENUM_TYPE_MIN_ENUM_VAL_V01 = INT_MIN,
> +	CORESIGHT_ETM_STATE_DISABLED_V01 = 0,
> +	CORESIGHT_ETM_STATE_ENABLED_V01 = 1,
> +	CORESIGHT_ETM_STATE_ENUM_TYPE_MAX_ENUM_VAL_01 = INT_MAX,
> +};
> +
> +struct coresight_get_etm_req_msg_v01 {
> +	/*
> +	 * This element is a placeholder to prevent declaration of
> +	 * empty struct. Do not change.
> +	 */

But struct coresight_get_etm_req_msg_v01 is never used, so couldn't you
just delete it, then you won't get an issue with the empty struct?

> +	char __placeholder;
> +};
> +
> +struct coresight_get_etm_resp_msg_v01 {

Is this one used either? I couldn't find it. It looks like all of the
get stuff isn't, including the #defines. I know they might be added for
completeness or for use in the future, but if they haven't been tested
it might be better to just delete it all because there is a chance there
is a mistake in it anyway.


> +	/* Mandatory */
> +	/* QMI result Code */
> +	struct qmi_response_type_v01 resp;
> +
> +	/* Optional */
> +	/* ETM output state, must be set to true if state is being passed */
> +	uint8_t state_valid;
> +	/* Present when result code is QMI_RESULT_SUCCESS */
> +	enum coresight_etm_state_enum_type_v01 state;
> +};
> +
> +struct coresight_set_etm_req_msg_v01 {
> +	/* Mandatory */
> +	/* ETM output state */
> +	enum coresight_etm_state_enum_type_v01 state;
> +};
> +
> +struct coresight_set_etm_resp_msg_v01 {
> +	/* Mandatory */
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +static struct qmi_elem_info coresight_set_etm_req_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_UNSIGNED_4_BYTE,
> +		.elem_len  = 1,
> +		.elem_size = sizeof(enum coresight_etm_state_enum_type_v01),
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0x01,
> +		.offset    = offsetof(struct coresight_set_etm_req_msg_v01,
> +				      state),
> +		.ei_array  = NULL,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.elem_len  = 0,
> +		.elem_size = 0,
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0,
> +		.offset    = 0,
> +		.ei_array  = NULL,
> +	},
> +};
> +
> +static struct qmi_elem_info coresight_set_etm_resp_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len  = 1,
> +		.elem_size = sizeof(struct qmi_response_type_v01),
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0x02,
> +		.offset    = offsetof(struct coresight_set_etm_resp_msg_v01,
> +				      resp),
> +		.ei_array  = qmi_response_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.elem_len  = 0,
> +		.elem_size = 0,
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0,
> +		.offset    = 0,
> +		.ei_array  = NULL,
> +	},
> +};
> +
> +#endif
> diff --git a/drivers/hwtracing/coresight/coresight-remote-etm.c b/drivers/hwtracing/coresight/coresight-remote-etm.c
> new file mode 100644
> index 000000000000..d895dc5d14c2
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-remote-etm.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/sysfs.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/coresight.h>
> +#include "coresight-qmi.h"
> +#include "coresight-priv.h"
> +
> +#define REMOTE_ETM_TRACE_ID_START	192

This isn't used.

> +
> +DEFINE_CORESIGHT_DEVLIST(remote_etm_devs, "remote-etm");
> +
> +static DEFINE_MUTEX(remote_etm_lock);
> +static LIST_HEAD(remote_etm_list);
> +
> +struct remote_etm_drvdata {
> +	struct device			*dev;
> +	struct coresight_device		*csdev;
> +	struct mutex			mutex;
> +	struct qmi_handle		handle;
> +	uint32_t			inst_id;
> +	bool				enable;

enable is never read so can probably be dropped. If not, "enabled" would
be better than "enable".

> +	bool service_connected;
> +	bool security;

security is never used either.

> +	struct sockaddr_qrtr s_addr;
> +	struct list_head link;
> +};
> +
> +static int service_remote_etm_new_server(struct qmi_handle *qmi,
> +		struct qmi_service *svc)
> +{
> +	struct remote_etm_drvdata *drvdata = container_of(qmi,
> +					struct remote_etm_drvdata, handle);
> +
> +	drvdata->s_addr.sq_family = AF_QIPCRTR;
> +	drvdata->s_addr.sq_node = svc->node;
> +	drvdata->s_addr.sq_port = svc->port;
> +	drvdata->service_connected = true;
> +	dev_info(drvdata->dev,
> +		"Connection established between QMI handle and %d service\n",
> +		drvdata->inst_id);
> +
> +	return 0;
> +}
> +
> +static void service_remote_etm_del_server(struct qmi_handle *qmi,
> +		struct qmi_service *svc)
> +{
> +	struct remote_etm_drvdata *drvdata = container_of(qmi,
> +					struct remote_etm_drvdata, handle);
> +	drvdata->service_connected = false;
> +	dev_info(drvdata->dev,
> +		"Connection disconnected between QMI handle and %d service\n",
> +		drvdata->inst_id);
> +}
> +
> +static struct qmi_ops server_ops = {
> +	.new_server = service_remote_etm_new_server,
> +	.del_server = service_remote_etm_del_server,
> +};
> +
> +static int remote_etm_enable(struct coresight_device *csdev,
> +			     struct perf_event *event, u32 mode)
> +{
> +	struct remote_etm_drvdata *drvdata =
> +		dev_get_drvdata(csdev->dev.parent);
> +	struct coresight_set_etm_req_msg_v01 req;
> +	struct coresight_set_etm_resp_msg_v01 resp = { { 0, 0 } };
> +	struct qmi_txn txn;
> +	int ret;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +	if (!drvdata->service_connected) {
> +		dev_err(drvdata->dev, "QMI service not connected!\n");
> +		ret = EINVAL;

= -EINVAL?

> +		goto err;
> +	}
> +	/*
> +	 * The QMI handle may be NULL in the following scenarios:
> +	 * 1. QMI service is not present
> +	 * 2. QMI service is present but attempt to enable remote ETM is earlier
> +	 *    than service is ready to handle request
> +	 * 3. Connection between QMI client and QMI service failed
> +	 *
> +	 * Enable CoreSight without processing further QMI commands which
> +	 * provides the option to enable remote ETM by other means.
> +	 */
> +	req.state = CORESIGHT_ETM_STATE_ENABLED_V01;
> +
> +	ret = qmi_txn_init(&drvdata->handle, &txn,
> +			coresight_set_etm_resp_msg_v01_ei,
> +			&resp);
> +
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI tx init failed , ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	ret = qmi_send_request(&drvdata->handle, &drvdata->s_addr,
> +			&txn, CORESIGHT_QMI_SET_ETM_REQ_V01,
> +			CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN,
> +			coresight_set_etm_req_msg_v01_ei,
> +			&req);
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI send ACK failed, ret:%d\n",
> +				ret);
> +		qmi_txn_cancel(&txn);
> +		goto err;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, msecs_to_jiffies(TIMEOUT_MS));
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI qmi txn wait failed, ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	/* Check the response */
> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01)
> +		dev_err(drvdata->dev, "QMI request failed 0x%x\n",
> +				resp.resp.error);
> +
> +	drvdata->enable = true;
> +	mutex_unlock(&drvdata->mutex);
> +
> +	dev_info(drvdata->dev, "Remote ETM tracing enabled for instance %d\n",
> +				drvdata->inst_id);
> +	return 0;
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +	return ret;
> +}
> +
> +static void remote_etm_disable(struct coresight_device *csdev,
> +			       struct perf_event *event)
> +{
> +	struct remote_etm_drvdata *drvdata =
> +		 dev_get_drvdata(csdev->dev.parent);
> +	struct coresight_set_etm_req_msg_v01 req;
> +	struct coresight_set_etm_resp_msg_v01 resp = { { 0, 0 } };
> +	struct qmi_txn txn;
> +	int ret;
> +
> +	mutex_lock(&drvdata->mutex);
> +	if (!drvdata->service_connected) {
> +		dev_err(drvdata->dev, "QMI service not connected!\n");
> +		goto err;
> +	}
> +
> +	req.state = CORESIGHT_ETM_STATE_DISABLED_V01;
> +
> +	ret = qmi_txn_init(&drvdata->handle, &txn,
> +			coresight_set_etm_resp_msg_v01_ei,
> +			&resp);
> +
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI tx init failed , ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	ret = qmi_send_request(&drvdata->handle, &drvdata->s_addr,
> +			&txn, CORESIGHT_QMI_SET_ETM_REQ_V01,
> +			CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN,
> +			coresight_set_etm_req_msg_v01_ei,
> +			&req);
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI send req failed, ret:%d\n",
> +				 ret);
> +		qmi_txn_cancel(&txn);
> +		goto err;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, msecs_to_jiffies(TIMEOUT_MS));
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI qmi txn wait failed, ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	/* Check the response */
> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
> +		dev_err(drvdata->dev, "QMI request failed 0x%x\n",
> +				resp.resp.error);
> +		goto err;
> +	}
> +
> +	drvdata->enable = false;
> +	dev_info(drvdata->dev, "Remote ETM tracing disabled for instance %d\n",
> +				drvdata->inst_id);
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +}
> +
> +static const struct coresight_ops_source remote_etm_source_ops = {
> +	.enable		= remote_etm_enable,
> +	.disable	= remote_etm_disable,
> +};
> +
> +static const struct coresight_ops remote_cs_ops = {
> +	.source_ops	= &remote_etm_source_ops,
> +};
> +
> +static int remote_etm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct coresight_platform_data *pdata;
> +	struct remote_etm_drvdata *drvdata;
> +	struct coresight_desc desc = {0 };
> +	int ret;
> +
> +	desc.name = coresight_alloc_device_name(&remote_etm_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	pdev->dev.platform_data = pdata;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "qcom,inst-id",
> +			&drvdata->inst_id);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&drvdata->mutex);
> +
> +	ret = qmi_handle_init(&drvdata->handle,
> +			CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN,
> +			&server_ops, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "Remote ETM client init failed ret:%d\n", ret);
> +		return ret;
> +	}
> +
> +	qmi_add_lookup(&drvdata->handle,
> +			CORESIGHT_QMI_SVC_ID,
> +			CORESIGHT_QMI_VERSION,
> +			drvdata->inst_id);
> +
> +	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC;
> +	desc.ops = &remote_cs_ops;
> +	desc.pdata = pdev->dev.platform_data;
> +	desc.dev = &pdev->dev;
> +	drvdata->csdev = coresight_register(&desc);
> +	if (IS_ERR(drvdata->csdev)) {
> +		ret = PTR_ERR(drvdata->csdev);
> +		goto err;
> +	}
> +	dev_info(dev, "Remote ETM initialized\n");
> +
> +	pm_runtime_enable(dev);

I think as soon as coresight_register() returns, the coresight mutex is
unlocked and the device can be used, so this pm_runtime_enable() and the
inst_id check are too late.

> +	if (drvdata->inst_id >= sizeof(int)*BITS_PER_BYTE)
> +		dev_err(dev, "inst_id greater than boot_enable bit mask\n");

I didn't understand this inst_id bit. It's specifically a uint32_t, but
it can't be a higher value than 32? So it could be an 8 bit field? It
also looks like it makes sense to validate this where it's read from the
DT, rather than later.

> +
> +	list_add_tail(&drvdata->link, &remote_etm_list);
> +

Apart from being deleted later, I didn't see this link or
remote_etm_list being used.

> +	return 0;
> +err:
> +	qmi_handle_release(&drvdata->handle);
> +	return ret;
> +}
> +
> +static int remote_etm_remove(struct platform_device *pdev)
> +{
> +	struct remote_etm_drvdata *drvdata = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	list_del(&drvdata->link);
> +	pm_runtime_disable(dev);
> +	qmi_handle_release(&drvdata->handle);
> +	coresight_unregister(drvdata->csdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id remote_etm_match[] = {
> +	{.compatible = "qcom,coresight-remote-etm"},
> +	{}
> +};
> +
> +static struct platform_driver remote_etm_driver = {
> +	.probe          = remote_etm_probe,
> +	.remove         = remote_etm_remove,
> +	.driver         = {
> +		.name   = "coresight-remote-etm",
> +		.of_match_table = remote_etm_match,
> +	},
> +};
> +
> +int __init remote_etm_init(void)
> +{
> +	return platform_driver_register(&remote_etm_driver);
> +}
> +module_init(remote_etm_init);
> +
> +void __exit remote_etm_exit(void)
> +{
> +	platform_driver_unregister(&remote_etm_driver);
> +}
> +module_exit(remote_etm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("CoreSight Remote ETM driver");
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index a4cb7dd6ca23..f0a947a61680 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM,
> +	CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC,
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS,
>  };
>  
