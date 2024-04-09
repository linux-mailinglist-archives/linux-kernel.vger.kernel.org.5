Return-Path: <linux-kernel+bounces-136932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9389DA11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3494B1F22F86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103612F36B;
	Tue,  9 Apr 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SxpjGk7A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680A12A144;
	Tue,  9 Apr 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668961; cv=none; b=kD01Liy9o6qfiCm/4N+hom3lPv+MzqQxE9RodJBzCt/KYKFflr2k8/9bmFSYA6cu59oZf/Tmv+z8Xed8mOpVeezoc6ffAP86qiKVGi0PSKuhDsnqLkdZBHzxp1i85cR/3B9Kx00Gc3oTTAzAV4awJuKHafwRaR7l1zmn9rNB4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668961; c=relaxed/simple;
	bh=wBDe5zbXaJl2Kd0acfoEQsp/B54ywA9DNFxRA+vilQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=orsYs11r7AwY0JolqTYtQnIIqwsdRB8IfoHfziROmlVeMW9qSmNlYgx9njBpHYuOY9Rm8kEr30f6fNbS8AEF8K40fRlWBY4W4Bi8RJEood3KcmJLo+XLDHoB7Jml7Hu0fmRJAZLoTNj+NmYi/WpJ9mR32AKzsR6CwIY/QIqmkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SxpjGk7A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439CLl3C015249;
	Tue, 9 Apr 2024 13:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2yqSKT9Bbhkr9bltS0gNzqIpZjnctyVVLv97qIJ7+jo=; b=Sx
	pjGk7Ame1AAbp6fSd4zk0Jw1o1md+6mK/94HBb6Ig1FGIjQnwo6/oHZ66CYpq3vB
	kRb2FMyLnHP3qO+xuimAtKoTr3Svl+HCCbtuqLiC30ZX3amrL30LR1FhwXhZTnnV
	ZxaqSChlmFngu4k6V8qlve1Qc9rgoAqf2wa/ymzlGkY2Y/T/M/dXKcuuMRJjaZw0
	Gt0F/6VxqQXQGOkngJV7GYjSeY2WLLeHid/azaSMUQ9qrCBnEiQb/s9snrTi/G2n
	EaZkB6d2EPG9iY/qL6gR2YY8Vu2VKcyYqMOJX39j4ND3g1QZDmZqx21zZIRoKMqd
	gky2zBIxU2oZyZ3ZOeMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd3bsgckq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 13:22:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439DMH13003421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 13:22:17 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 06:22:13 -0700
Message-ID: <6baaff95-728b-4492-ae3e-00dedbb50fb0@quicinc.com>
Date: Tue, 9 Apr 2024 21:22:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] coresight: Add support for multiple output ports on
 the funnel
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-3-git-send-email-quic_taozha@quicinc.com>
 <8d381e6e-9328-46ff-83fe-efbe5bb4363e@arm.com>
 <ffce4577-b0f9-4af3-a379-0385a02ddae8@quicinc.com>
 <a8947ac4-e251-47ba-b44a-6f4fc58f1aac@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <a8947ac4-e251-47ba-b44a-6f4fc58f1aac@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w2rdVCEbni5enT-AfEySqFaak7J1adx_
X-Proofpoint-ORIG-GUID: w2rdVCEbni5enT-AfEySqFaak7J1adx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_09,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090085


On 4/9/2024 3:13 PM, Suzuki K Poulose wrote:
> Hi
>
> On 29/03/2024 09:27, Tao Zhang wrote:
>>
>> On 3/22/2024 12:41 AM, Suzuki K Poulose wrote:
>>> On 21/03/2024 08:32, Tao Zhang wrote:
>>>> Funnel devices are now capable of supporting multiple-inputs and
>>>> multiple-outputs configuration with in built hardware filtering
>>>> for TPDM devices. Add software support to this function. Output
>>>> port is selected according to the source in the trace path.
>>>>
>>>> The source of the input port on funnels will be marked in the
>>>> device tree.
>>>> e.g.
>>>> tpdm@xxxxxxx {
>>>>      ... ... ... ...
>>>> };
>>>>
>>>> funnel_XXX: funnel@xxxxxxx {
>>>>      ... ... ... ...
>>>>      out-ports {
>>>>          ... ... ... ...
>>>>          port@x {
>>>>              ... ... ... ...
>>>>              label = "xxxxxxx.tpdm"; <-- To label the source
>>>>          };                           corresponding to the output
>>>>      ... ... ... ...                  connection "port@x". And this
>>>>      };                               is a hardware static 
>>>> connections.
>>>>      ... ... ... ...                  Here needs to refer to hardware
>>>> };                                   design.
>>>>
>>>> Then driver will parse the source label marked in the device tree, and
>>>> save it to the coresight path. When the function needs to know the
>>>> source label, it could obtain it from coresight path parameter. 
>>>> Finally,
>>>> the output port knows which source it corresponds to, and it also 
>>>> knows
>>>> which input port it corresponds to.
>>>
>>> Why do we need labels ? We have connection information for all devices
>>> (both in and out), so, why do we need this label to find a device ?
>>
>> Because our funnel's design has multi-output ports, the data stream 
>> will not
>>
>> know which output port should pass in building the data trace path. 
>> This source
>>
>> label can make the data stream find the right output port to go.
>>
>>>
>>> And also, I thought TPDM is a source device, why does a funnel output
>>> port link to a source ?
>>
>> No, this label doesn't mean this funnel output port link to a source, 
>> it just let
>>
>> the output port know its data source.
>>
>>>
>>> Are these funnels programmable ? Or, are they static ? If they are
>>> static, do these need to be described in the DT ? If they are simply
>>> acting as a "LINK" (or HWFIFO ?)
>>
>> These funnels are static, and we will add the "label" to the DT to 
>> describe the
>>
>> multi-output ports for these funnels.
>
> I think there is still a bit of confusion. By "Dynamic" I mean,
> the "dynamic funnel" (explicit port enablement via MMIO) vs "static 
> funnel" (no programming, always ON).
>
> So, coming to your example, do we need to "explicitly" enable trace 
> flow for an "input" and/or an "output" port in your "funnel" ?

Sorry for my misunderstanding in the previous mails. Our funnels are 
programmable just like the common dynamic funnels.

In our solution, we just make funnels have multiple output ports 
connected to different devices or ports. When we use it, we still

enable the input port through programming. Our solution is to know which 
input port the expected data comes from based on the

source label corresponding to the output port. This way we can build the 
expected trace path. In other respects, it is used the same

as common dynamic funnels.


Best,

Tao

>
>
>>
>> "If they are simply acting as a "LINK" (or HWFIFO ?) " I'm not sure 
>> what's the meaning
>
> i.e, Like TMC-ETF in HWFIFO mode. In this mode, the TMC-ETF is acting
> like a cache for easing ATB data load, by providing h/w buffering.
> (In your case, it may not be providing any buffering, it doesn't matter
> either way, as it is not visible to the driver).
>
> Suzuki
>
>>
>> of this. Could you describe it in detail?
>>
>>
>> Best,
>>
>> Tao
>>
>>>
>>> Suzuki
>>>
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-core.c  | 81 
>>>> ++++++++++++++++---
>>>>   .../hwtracing/coresight/coresight-platform.c  |  5 ++
>>>>   include/linux/coresight.h                     |  2 +
>>>>   3 files changed, 75 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>> index 5dde597403b3..b1b5e6d9ec7a 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>> @@ -113,15 +113,63 @@ struct coresight_device 
>>>> *coresight_get_percpu_sink(int cpu)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
>>>>   +static struct coresight_device *coresight_get_source(struct 
>>>> list_head *path)
>>>> +{
>>>> +    struct coresight_device *csdev;
>>>> +
>>>> +    if (!path)
>>>> +        return NULL;
>>>> +
>>>> +    csdev = list_first_entry(path, struct coresight_node, 
>>>> link)->csdev;
>>>> +    if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
>>>> +        return NULL;
>>>> +
>>>> +    return csdev;
>>>> +}
>>>> +
>>>> +/**
>>>> + * coresight_source_filter - checks whether the connection matches 
>>>> the source
>>>> + * of path if connection is binded to specific source.
>>>> + * @path:    The list of devices
>>>> + * @conn:    The connection of one outport
>>>> + *
>>>> + * Return zero if the connection doesn't have a source binded or 
>>>> source of the
>>>> + * path matches the source binds to connection.
>>>> + */
>>>> +static int coresight_source_filter(struct list_head *path,
>>>> +            struct coresight_connection *conn)
>>>> +{
>>>> +    int ret = 0;
>>>> +    struct coresight_device *source = NULL;
>>>> +
>>>> +    if (conn->source_label == NULL)
>>>> +        return ret;
>>>> +
>>>> +    source = coresight_get_source(path);
>>>> +    if (source == NULL)
>>>> +        return ret;
>>>> +
>>>> +    if (strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
>>>> +            conn->source_label))
>>>> +        ret = 0;
>>>> +    else
>>>> +        ret = -1;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   static struct coresight_connection *
>>>>   coresight_find_out_connection(struct coresight_device *src_dev,
>>>> -                  struct coresight_device *dest_dev)
>>>> +                  struct coresight_device *dest_dev,
>>>> +                  struct list_head *path)
>>>>   {
>>>>       int i;
>>>>       struct coresight_connection *conn;
>>>>         for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
>>>>           conn = src_dev->pdata->out_conns[i];
>>>> +        if (coresight_source_filter(path, conn))
>>>> +            continue;
>>>>           if (conn->dest_dev == dest_dev)
>>>>               return conn;
>>>>       }
>>>> @@ -312,7 +360,8 @@ static void coresight_disable_sink(struct 
>>>> coresight_device *csdev)
>>>>     static int coresight_enable_link(struct coresight_device *csdev,
>>>>                    struct coresight_device *parent,
>>>> -                 struct coresight_device *child)
>>>> +                 struct coresight_device *child,
>>>> +                 struct list_head *path)
>>>>   {
>>>>       int ret = 0;
>>>>       int link_subtype;
>>>> @@ -321,8 +370,8 @@ static int coresight_enable_link(struct 
>>>> coresight_device *csdev,
>>>>       if (!parent || !child)
>>>>           return -EINVAL;
>>>>   -    inconn = coresight_find_out_connection(parent, csdev);
>>>> -    outconn = coresight_find_out_connection(csdev, child);
>>>> +    inconn = coresight_find_out_connection(parent, csdev, path);
>>>> +    outconn = coresight_find_out_connection(csdev, child, path);
>>>>       link_subtype = csdev->subtype.link_subtype;
>>>>         if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && 
>>>> IS_ERR(inconn))
>>>> @@ -341,7 +390,8 @@ static int coresight_enable_link(struct 
>>>> coresight_device *csdev,
>>>>     static void coresight_disable_link(struct coresight_device *csdev,
>>>>                      struct coresight_device *parent,
>>>> -                   struct coresight_device *child)
>>>> +                   struct coresight_device *child,
>>>> +                   struct list_head *path)
>>>>   {
>>>>       int i;
>>>>       int link_subtype;
>>>> @@ -350,8 +400,8 @@ static void coresight_disable_link(struct 
>>>> coresight_device *csdev,
>>>>       if (!parent || !child)
>>>>           return;
>>>>   -    inconn = coresight_find_out_connection(parent, csdev);
>>>> -    outconn = coresight_find_out_connection(csdev, child);
>>>> +    inconn = coresight_find_out_connection(parent, csdev, path);
>>>> +    outconn = coresight_find_out_connection(csdev, child, path);
>>>>       link_subtype = csdev->subtype.link_subtype;
>>>>         if (link_ops(csdev)->disable) {
>>>> @@ -507,7 +557,7 @@ static void coresight_disable_path_from(struct 
>>>> list_head *path,
>>>>           case CORESIGHT_DEV_TYPE_LINK:
>>>>               parent = list_prev_entry(nd, link)->csdev;
>>>>               child = list_next_entry(nd, link)->csdev;
>>>> -            coresight_disable_link(csdev, parent, child);
>>>> +            coresight_disable_link(csdev, parent, child, path);
>>>>               break;
>>>>           default:
>>>>               break;
>>>> @@ -588,7 +638,7 @@ int coresight_enable_path(struct list_head 
>>>> *path, enum cs_mode mode,
>>>>           case CORESIGHT_DEV_TYPE_LINK:
>>>>               parent = list_prev_entry(nd, link)->csdev;
>>>>               child = list_next_entry(nd, link)->csdev;
>>>> -            ret = coresight_enable_link(csdev, parent, child);
>>>> +            ret = coresight_enable_link(csdev, parent, child, path);
>>>>               if (ret)
>>>>                   goto err;
>>>>               break;
>>>> @@ -802,7 +852,8 @@ static void coresight_drop_device(struct 
>>>> coresight_device *csdev)
>>>>    */
>>>>   static int _coresight_build_path(struct coresight_device *csdev,
>>>>                    struct coresight_device *sink,
>>>> -                 struct list_head *path)
>>>> +                 struct list_head *path,
>>>> +                 struct coresight_device *source)
>>>>   {
>>>>       int i, ret;
>>>>       bool found = false;
>>>> @@ -814,7 +865,7 @@ static int _coresight_build_path(struct 
>>>> coresight_device *csdev,
>>>>         if (coresight_is_percpu_source(csdev) && 
>>>> coresight_is_percpu_sink(sink) &&
>>>>           sink == per_cpu(csdev_sink, 
>>>> source_ops(csdev)->cpu_id(csdev))) {
>>>> -        if (_coresight_build_path(sink, sink, path) == 0) {
>>>> +        if (_coresight_build_path(sink, sink, path, source) == 0) {
>>>>               found = true;
>>>>               goto out;
>>>>           }
>>>> @@ -825,8 +876,12 @@ static int _coresight_build_path(struct 
>>>> coresight_device *csdev,
>>>>           struct coresight_device *child_dev;
>>>>             child_dev = csdev->pdata->out_conns[i]->dest_dev;
>>>> +        if (csdev->pdata->out_conns[i]->source_label &&
>>>> + !strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
>>>> + csdev->pdata->out_conns[i]->source_label))
>>>> +            continue;
>>>>           if (child_dev &&
>>>> -            _coresight_build_path(child_dev, sink, path) == 0) {
>>>> +            _coresight_build_path(child_dev, sink, path, source) 
>>>> == 0) {
>>>>               found = true;
>>>>               break;
>>>>           }
>>>> @@ -871,7 +926,7 @@ struct list_head *coresight_build_path(struct 
>>>> coresight_device *source,
>>>>         INIT_LIST_HEAD(path);
>>>>   -    rc = _coresight_build_path(source, sink, path);
>>>> +    rc = _coresight_build_path(source, sink, path, source);
>>>>       if (rc) {
>>>>           kfree(path);
>>>>           return ERR_PTR(rc);
>>>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c 
>>>> b/drivers/hwtracing/coresight/coresight-platform.c
>>>> index 9d550f5697fa..f553fb20966d 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>>> @@ -205,6 +205,7 @@ static int of_coresight_parse_endpoint(struct 
>>>> device *dev,
>>>>       struct fwnode_handle *rdev_fwnode;
>>>>       struct coresight_connection conn = {};
>>>>       struct coresight_connection *new_conn;
>>>> +    const char *label;
>>>>         do {
>>>>           /* Parse the local port details */
>>>> @@ -243,6 +244,10 @@ static int of_coresight_parse_endpoint(struct 
>>>> device *dev,
>>>>           conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
>>>>           conn.dest_port = rendpoint.port;
>>>>   +        conn.source_label = NULL;
>>>> +        if (!of_property_read_string(ep, "label", &label))
>>>> +            conn.source_label = label;
>>>> +
>>>>           new_conn = coresight_add_out_conn(dev, pdata, &conn);
>>>>           if (IS_ERR_VALUE(new_conn)) {
>>>>               fwnode_handle_put(conn.dest_fwnode);
>>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>>> index e8b6e388218c..a9c06ef9bbb2 100644
>>>> --- a/include/linux/coresight.h
>>>> +++ b/include/linux/coresight.h
>>>> @@ -167,6 +167,7 @@ struct coresight_desc {
>>>>    * struct coresight_connection - representation of a single 
>>>> connection
>>>>    * @src_port:    a connection's output port number.
>>>>    * @dest_port:    destination's input port number @src_port is 
>>>> connected to.
>>>> + * @source_label: source component's label.
>>>>    * @dest_fwnode: destination component's fwnode handle.
>>>>    * @dest_dev:    a @coresight_device representation of the component
>>>>           connected to @src_port. NULL until the device is created
>>>> @@ -195,6 +196,7 @@ struct coresight_desc {
>>>>   struct coresight_connection {
>>>>       int src_port;
>>>>       int dest_port;
>>>> +    const char *source_label;
>>>>       struct fwnode_handle *dest_fwnode;
>>>>       struct coresight_device *dest_dev;
>>>>       struct coresight_sysfs_link *link;
>>>
>

