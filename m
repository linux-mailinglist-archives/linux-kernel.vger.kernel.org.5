Return-Path: <linux-kernel+bounces-13225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C042820161
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BFB282679
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083C1401F;
	Fri, 29 Dec 2023 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JM8IOoEF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F913FEB;
	Fri, 29 Dec 2023 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BTJuc5Z016170;
	Fri, 29 Dec 2023 20:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BRA6Aw7Uh/UneTlaFbDZ/f1zn/5HEUgf2LwzUlJ61yw=; b=JM
	8IOoEFW/owGeXa0s30XVhgVjW3MO/BwaDntp7Agohneaw0vcBEt4lcLCd5xi7XKU
	RCilUydnZHVG+O3GNwTY+H5pxHIDi4xy845FXE8wfMMmZxRAUBIhIo7fAXDW3C3d
	5V9ZTUHN8uoTLavNqsEMWUWYL+olWtqxaL+dHZsjyORBxpo0491uoOOzeOvrXY67
	RfsbeMa4JrMFXv9rTFhn1H91dMttH2wOuhkkJ5WCkHQsy/JwM8bg1ljjkvJCV5sk
	a8d+sWuy9OzpBvkrq6ucTnrl8m3lk98ZK4bhve4r6l1T+SA8wu0ZQbHOA4Kqhkjr
	EXysaDpZ1f3fgWo07NxA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v9qx51c4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 20:21:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BTKLG7d029034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 20:21:16 GMT
Received: from [10.110.100.181] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Dec
 2023 12:21:16 -0800
Message-ID: <22330d85-1d5c-48de-b006-9176f275328e@quicinc.com>
Date: Fri, 29 Dec 2023 12:21:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] PM: domains: Add helper functions to attach/detach
 multiple PM domains
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Viresh
 Kumar" <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Ben Horgan
	<Ben.Horgan@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
 <20231228114157.104822-2-ulf.hansson@linaro.org>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231228114157.104822-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S55ni0MA2R4e_lG86vwD_7cEsxpdTb2a
X-Proofpoint-ORIG-GUID: S55ni0MA2R4e_lG86vwD_7cEsxpdTb2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312290162


On 12/28/2023 3:41 AM, Ulf Hansson wrote:
> Attaching/detaching of a device to multiple PM domains has started to
> become a common operation for many drivers, typically during ->probe() and
> ->remove(). In most cases, this has lead to lots of boilerplate code in the
> drivers.
>
> To fixup up the situation, let's introduce a pair of helper functions,
> dev_pm_domain_attach|detach_list(), that driver can use instead of the
> open-coding. Note that, it seems reasonable to limit the support for these
> helpers to DT based platforms, at it's the only valid use case for now.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/base/power/common.c | 133 ++++++++++++++++++++++++++++++++++++
>   include/linux/pm_domain.h   |  38 +++++++++++
>   2 files changed, 171 insertions(+)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 44ec20918a4d..1ef51889fc6f 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -167,6 +167,114 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
>   
> +/**
> + * dev_pm_domain_attach_list - Associate a device with its PM domains.
> + * @dev: The device used to lookup the PM domains for.
> + * @data: The data used for attaching to the PM domains.
> + * @list: An out-parameter with an allocated list of attached PM domains.
> + *
> + * This function helps to attach a device to its multiple PM domains. The
> + * caller, which is typically a driver's probe function, may provide a list of
> + * names for the PM domains that we should try to attach the device to, but it
> + * may also provide an empty list, in case the attach should be done for all of
> + * the available PM domains.
> + *
> + * Callers must ensure proper synchronization of this function with power
> + * management callbacks.
> + *
> + * Returns the number of attached PM domains or a negative error code in case of
> + * a failure. Note that, to detach the list of PM domains, the driver shall call
> + * dev_pm_domain_detach_list(), typically during the remove phase.
> + */
> +int dev_pm_domain_attach_list(struct device *dev,
> +			      const struct dev_pm_domain_attach_data *data,
> +			      struct dev_pm_domain_list **list)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct dev_pm_domain_list *pds;
> +	struct device *pd_dev = NULL;
> +	int ret, i, num_pds = 0;
> +	bool by_id = true;
> +	u32 link_flags = data && data->pd_flags & PD_FLAG_NO_DEV_LINK ? 0 :
> +			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
> +
> +	if (dev->pm_domain)
> +		return -EEXIST;
> +
> +	/* For now this is limited to OF based platforms. */
> +	if (!np)
> +		return 0;
> +
> +	if (data && data->pd_names) {
> +		num_pds = data->num_pd_names;
> +		by_id = false;
> +	} else {
> +		num_pds = of_count_phandle_with_args(np, "power-domains",
> +						     "#power-domain-cells");
> +	}
> +
> +	if (num_pds <= 0)
> +		return 0;
> +
> +	pds = devm_kzalloc(dev, sizeof(*pds), GFP_KERNEL);
> +	if (!pds)
> +		return -ENOMEM;
> +
> +	pds->pd_devs = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_devs),
> +				    GFP_KERNEL);
> +	if (!pds->pd_devs)
> +		return -ENOMEM;
> +
> +	pds->pd_links = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_links),
> +				     GFP_KERNEL);
> +	if (!pds->pd_links)
> +		return -ENOMEM;
> +
> +	if (link_flags && data->pd_flags & PD_FLAG_DEV_LINK_ON)

Since data is optional, this check results in crash if data is NULL. Thanks


> +		link_flags |= DL_FLAG_RPM_ACTIVE;
> +
> +	for (i = 0; i < num_pds; i++) {
> +		if (by_id)
> +			pd_dev = dev_pm_domain_attach_by_id(dev, i);
> +		else
> +			pd_dev = dev_pm_domain_attach_by_name(dev,
> +							data->pd_names[i]);
> +		if (IS_ERR_OR_NULL(pd_dev)) {
> +			ret = pd_dev ? PTR_ERR(pd_dev) : -ENODEV;
> +			goto err_attach;
> +		}
> +
> +		if (link_flags) {
> +			struct device_link *link;
> +
> +			link = device_link_add(dev, pd_dev, link_flags);
> +			if (!link) {
> +				ret = -ENODEV;
> +				goto err_link;
> +			}
> +
> +			pds->pd_links[i] = link;
> +		}
> +
> +		pds->pd_devs[i] = pd_dev;
> +	}
> +
> +	pds->num_pds = num_pds;
> +	*list = pds;
> +	return num_pds;
> +
> +err_link:
> +	dev_pm_domain_detach(pd_dev, true);
> +err_attach:
> +	while (--i >= 0) {
> +		if (pds->pd_links[i])
> +			device_link_del(pds->pd_links[i]);
> +		dev_pm_domain_detach(pds->pd_devs[i], true);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
> +
>   /**
>    * dev_pm_domain_detach - Detach a device from its PM domain.
>    * @dev: Device to detach.
> @@ -187,6 +295,31 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
>   
> +/**
> + * dev_pm_domain_detach_list - Detach a list of PM domains.
> + * @list: The list of PM domains to detach.
> + *
> + * This function reverse the actions from dev_pm_domain_attach_list().
> + * Typically it should be invoked during the remove phase from drivers.
> + *
> + * Callers must ensure proper synchronization of this function with power
> + * management callbacks.
> + */
> +void dev_pm_domain_detach_list(struct dev_pm_domain_list *list)
> +{
> +	int i;
> +
> +	if (!list)
> +		return;
> +
> +	for (i = 0; i < list->num_pds; i++) {
> +		if (list->pd_links[i])
> +			device_link_del(list->pd_links[i]);
> +		dev_pm_domain_detach(list->pd_devs[i], true);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_detach_list);
> +
>   /**
>    * dev_pm_domain_start - Start the device through its PM domain.
>    * @dev: Device to start.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 34663d0d5c55..6b71fb69c349 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -19,6 +19,33 @@
>   #include <linux/cpumask.h>
>   #include <linux/time64.h>
>   
> +/*
> + * Flags to control the behaviour when attaching a device to its PM domains.
> + *
> + * PD_FLAG_NO_DEV_LINK:		As the default behaviour creates a device-link
> + *				for every PM domain that gets attached, this
> + *				flag can be used to skip that.
> + *
> + * PD_FLAG_DEV_LINK_ON:		Add the DL_FLAG_RPM_ACTIVE to power-on the
> + *				supplier and its PM domain when creating the
> + *				device-links.
> + *
> + */
> +#define PD_FLAG_NO_DEV_LINK		BIT(0)
> +#define PD_FLAG_DEV_LINK_ON		BIT(1)
> +
> +struct dev_pm_domain_attach_data {
> +	const char * const *pd_names;
> +	const u32 num_pd_names;
> +	const u32 pd_flags;
> +};
> +
> +struct dev_pm_domain_list {
> +	struct device **pd_devs;
> +	struct device_link **pd_links;
> +	u32 num_pds;
> +};
> +
>   /*
>    * Flags to control the behaviour of a genpd.
>    *
> @@ -432,7 +459,11 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
>   					  unsigned int index);
>   struct device *dev_pm_domain_attach_by_name(struct device *dev,
>   					    const char *name);
> +int dev_pm_domain_attach_list(struct device *dev,
> +			      const struct dev_pm_domain_attach_data *data,
> +			      struct dev_pm_domain_list **list);
>   void dev_pm_domain_detach(struct device *dev, bool power_off);
> +void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
>   int dev_pm_domain_start(struct device *dev);
>   void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>   int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
> @@ -451,7 +482,14 @@ static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
>   {
>   	return NULL;
>   }
> +static inline int dev_pm_domain_attach_list(struct device *dev,
> +				const struct dev_pm_domain_attach_data *data,
> +				struct dev_pm_domain_list **list)
> +{
> +	return 0;
> +}
>   static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
> +static inline void dev_pm_domain_detach_list(struct dev_pm_domain_list *list) {}
>   static inline int dev_pm_domain_start(struct device *dev)
>   {
>   	return 0;

