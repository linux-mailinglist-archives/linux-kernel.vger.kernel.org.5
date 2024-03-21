Return-Path: <linux-kernel+bounces-110402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBB885EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F482B24F33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE356768;
	Thu, 21 Mar 2024 16:42:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E85134733;
	Thu, 21 Mar 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039322; cv=none; b=ZG5KBQzloBYHYfPfl+TWt529/KdRdpzx0l1BrexMuIQeKDkEMuRGE1soBb7EqYva4h3ZwVRImEx4RIfDkja43SGSwhjxfx+jYIEmXRypb5/qt10JygS6z2NTrltt40chXkQUXO04l/W5JL8Xayh+wwBp9Nd3VcbFv6MRr4/23/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039322; c=relaxed/simple;
	bh=fznBggQcBCFiKQC6HZG44OJYau2TgxMOPGYgwwAiXuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgCRlSJHm/cfaqzwrPaiCc+HVsxJMPWpgI5GF1g+S6jsLpbmF3NO4+acL87UbS9Cg9jaziPfeSDxcGmiW4URCQ5+MkGgJWQwog6iTLWDpqDNWHxfAFy4G207XAm1BN9ND6ERj6Jx52sROn2o20JEWV0jUBc8B18I5XLSD0tvMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F041B1007;
	Thu, 21 Mar 2024 09:42:32 -0700 (PDT)
Received: from [10.57.53.86] (unknown [10.57.53.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6C8D3F67D;
	Thu, 21 Mar 2024 09:41:55 -0700 (PDT)
Message-ID: <8d381e6e-9328-46ff-83fe-efbe5bb4363e@arm.com>
Date: Thu, 21 Mar 2024 16:41:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] coresight: Add support for multiple output ports on
 the funnel
Content-Language: en-GB
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-3-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1711009927-17873-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2024 08:32, Tao Zhang wrote:
> Funnel devices are now capable of supporting multiple-inputs and
> multiple-outputs configuration with in built hardware filtering
> for TPDM devices. Add software support to this function. Output
> port is selected according to the source in the trace path.
> 
> The source of the input port on funnels will be marked in the
> device tree.
> e.g.
> tpdm@xxxxxxx {
>      ... ... ... ...
> };
> 
> funnel_XXX: funnel@xxxxxxx {
>      ... ... ... ...
>      out-ports {
>          ... ... ... ...
>          port@x {
>              ... ... ... ...
>              label = "xxxxxxx.tpdm"; <-- To label the source
>          };                           corresponding to the output
>      ... ... ... ...                  connection "port@x". And this
>      };                               is a hardware static connections.
>      ... ... ... ...                  Here needs to refer to hardware
> };                                   design.
> 
> Then driver will parse the source label marked in the device tree, and
> save it to the coresight path. When the function needs to know the
> source label, it could obtain it from coresight path parameter. Finally,
> the output port knows which source it corresponds to, and it also knows
> which input port it corresponds to.

Why do we need labels ? We have connection information for all devices
(both in and out), so, why do we need this label to find a device ?

And also, I thought TPDM is a source device, why does a funnel output
port link to a source ?

Are these funnels programmable ? Or, are they static ? If they are
static, do these need to be described in the DT ? If they are simply
acting as a "LINK" (or HWFIFO ?)

Suzuki

> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 81 ++++++++++++++++---
>   .../hwtracing/coresight/coresight-platform.c  |  5 ++
>   include/linux/coresight.h                     |  2 +
>   3 files changed, 75 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 5dde597403b3..b1b5e6d9ec7a 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -113,15 +113,63 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
>   }
>   EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
>   
> +static struct coresight_device *coresight_get_source(struct list_head *path)
> +{
> +	struct coresight_device *csdev;
> +
> +	if (!path)
> +		return NULL;
> +
> +	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> +		return NULL;
> +
> +	return csdev;
> +}
> +
> +/**
> + * coresight_source_filter - checks whether the connection matches the source
> + * of path if connection is binded to specific source.
> + * @path:	The list of devices
> + * @conn:	The connection of one outport
> + *
> + * Return zero if the connection doesn't have a source binded or source of the
> + * path matches the source binds to connection.
> + */
> +static int coresight_source_filter(struct list_head *path,
> +			struct coresight_connection *conn)
> +{
> +	int ret = 0;
> +	struct coresight_device *source = NULL;
> +
> +	if (conn->source_label == NULL)
> +		return ret;
> +
> +	source = coresight_get_source(path);
> +	if (source == NULL)
> +		return ret;
> +
> +	if (strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
> +			conn->source_label))
> +		ret = 0;
> +	else
> +		ret = -1;
> +
> +	return ret;
> +}
> +
>   static struct coresight_connection *
>   coresight_find_out_connection(struct coresight_device *src_dev,
> -			      struct coresight_device *dest_dev)
> +			      struct coresight_device *dest_dev,
> +			      struct list_head *path)
>   {
>   	int i;
>   	struct coresight_connection *conn;
>   
>   	for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
>   		conn = src_dev->pdata->out_conns[i];
> +		if (coresight_source_filter(path, conn))
> +			continue;
>   		if (conn->dest_dev == dest_dev)
>   			return conn;
>   	}
> @@ -312,7 +360,8 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>   
>   static int coresight_enable_link(struct coresight_device *csdev,
>   				 struct coresight_device *parent,
> -				 struct coresight_device *child)
> +				 struct coresight_device *child,
> +				 struct list_head *path)
>   {
>   	int ret = 0;
>   	int link_subtype;
> @@ -321,8 +370,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   	if (!parent || !child)
>   		return -EINVAL;
>   
> -	inconn = coresight_find_out_connection(parent, csdev);
> -	outconn = coresight_find_out_connection(csdev, child);
> +	inconn = coresight_find_out_connection(parent, csdev, path);
> +	outconn = coresight_find_out_connection(csdev, child, path);
>   	link_subtype = csdev->subtype.link_subtype;
>   
>   	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && IS_ERR(inconn))
> @@ -341,7 +390,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   
>   static void coresight_disable_link(struct coresight_device *csdev,
>   				   struct coresight_device *parent,
> -				   struct coresight_device *child)
> +				   struct coresight_device *child,
> +				   struct list_head *path)
>   {
>   	int i;
>   	int link_subtype;
> @@ -350,8 +400,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   	if (!parent || !child)
>   		return;
>   
> -	inconn = coresight_find_out_connection(parent, csdev);
> -	outconn = coresight_find_out_connection(csdev, child);
> +	inconn = coresight_find_out_connection(parent, csdev, path);
> +	outconn = coresight_find_out_connection(csdev, child, path);
>   	link_subtype = csdev->subtype.link_subtype;
>   
>   	if (link_ops(csdev)->disable) {
> @@ -507,7 +557,7 @@ static void coresight_disable_path_from(struct list_head *path,
>   		case CORESIGHT_DEV_TYPE_LINK:
>   			parent = list_prev_entry(nd, link)->csdev;
>   			child = list_next_entry(nd, link)->csdev;
> -			coresight_disable_link(csdev, parent, child);
> +			coresight_disable_link(csdev, parent, child, path);
>   			break;
>   		default:
>   			break;
> @@ -588,7 +638,7 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
>   		case CORESIGHT_DEV_TYPE_LINK:
>   			parent = list_prev_entry(nd, link)->csdev;
>   			child = list_next_entry(nd, link)->csdev;
> -			ret = coresight_enable_link(csdev, parent, child);
> +			ret = coresight_enable_link(csdev, parent, child, path);
>   			if (ret)
>   				goto err;
>   			break;
> @@ -802,7 +852,8 @@ static void coresight_drop_device(struct coresight_device *csdev)
>    */
>   static int _coresight_build_path(struct coresight_device *csdev,
>   				 struct coresight_device *sink,
> -				 struct list_head *path)
> +				 struct list_head *path,
> +				 struct coresight_device *source)
>   {
>   	int i, ret;
>   	bool found = false;
> @@ -814,7 +865,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   
>   	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
>   	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> -		if (_coresight_build_path(sink, sink, path) == 0) {
> +		if (_coresight_build_path(sink, sink, path, source) == 0) {
>   			found = true;
>   			goto out;
>   		}
> @@ -825,8 +876,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   		struct coresight_device *child_dev;
>   
>   		child_dev = csdev->pdata->out_conns[i]->dest_dev;
> +		if (csdev->pdata->out_conns[i]->source_label &&
> +			!strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
> +				csdev->pdata->out_conns[i]->source_label))
> +			continue;
>   		if (child_dev &&
> -		    _coresight_build_path(child_dev, sink, path) == 0) {
> +		    _coresight_build_path(child_dev, sink, path, source) == 0) {
>   			found = true;
>   			break;
>   		}
> @@ -871,7 +926,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
>   
>   	INIT_LIST_HEAD(path);
>   
> -	rc = _coresight_build_path(source, sink, path);
> +	rc = _coresight_build_path(source, sink, path, source);
>   	if (rc) {
>   		kfree(path);
>   		return ERR_PTR(rc);
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 9d550f5697fa..f553fb20966d 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -205,6 +205,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>   	struct fwnode_handle *rdev_fwnode;
>   	struct coresight_connection conn = {};
>   	struct coresight_connection *new_conn;
> +	const char *label;
>   
>   	do {
>   		/* Parse the local port details */
> @@ -243,6 +244,10 @@ static int of_coresight_parse_endpoint(struct device *dev,
>   		conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
>   		conn.dest_port = rendpoint.port;
>   
> +		conn.source_label = NULL;
> +		if (!of_property_read_string(ep, "label", &label))
> +			conn.source_label = label;
> +
>   		new_conn = coresight_add_out_conn(dev, pdata, &conn);
>   		if (IS_ERR_VALUE(new_conn)) {
>   			fwnode_handle_put(conn.dest_fwnode);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index e8b6e388218c..a9c06ef9bbb2 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -167,6 +167,7 @@ struct coresight_desc {
>    * struct coresight_connection - representation of a single connection
>    * @src_port:	a connection's output port number.
>    * @dest_port:	destination's input port number @src_port is connected to.
> + * @source_label: source component's label.
>    * @dest_fwnode: destination component's fwnode handle.
>    * @dest_dev:	a @coresight_device representation of the component
>   		connected to @src_port. NULL until the device is created
> @@ -195,6 +196,7 @@ struct coresight_desc {
>   struct coresight_connection {
>   	int src_port;
>   	int dest_port;
> +	const char *source_label;
>   	struct fwnode_handle *dest_fwnode;
>   	struct coresight_device *dest_dev;
>   	struct coresight_sysfs_link *link;


