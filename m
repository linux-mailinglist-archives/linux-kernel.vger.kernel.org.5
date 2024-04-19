Return-Path: <linux-kernel+bounces-150934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9088AA6DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E17E1C20F08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC985256;
	Fri, 19 Apr 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YSaKAOfe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5EB15BB;
	Fri, 19 Apr 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492743; cv=none; b=R2pY+pk/Dzf+xoYf4228eT4C9chJnhXxETHKHGh/iIQuCQUj5l/N/xtPJPTtuOPdwA5dOBi+keI3piutrCdHCWnd8KM9vhedoIB1PtamDkA2UiiXrHkqp9011S3ZrSG9j0f6XIjh4cSN8nJDntxMhHJg3TX8F7BMLTLfi1nXgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492743; c=relaxed/simple;
	bh=vrjSGmmqI1ZFmkyUQd3+U29pPcOFaxEMaCbun/x0Bss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bCyWyLQGq0uZC6pQmahrcfZaOtoL2snmC+3AOW08QdJ4kJdGiaRJ9XibQtNdKzXiG0c4okNnEVkrSGc/+E/P+gaBHL72FTac2iM0f5STWjkQyfC4OJgm1kmC/CE80UF83kx9uAz4/LKU0ISXakqudw8Awze9b13GkHJzjmhTb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YSaKAOfe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J1nwHU004494;
	Fri, 19 Apr 2024 02:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hMRq9TstGBglJsHtP5Ajn1AloKxY1wjfEKESHz/DM6o=; b=YS
	aKAOfeGhYNov2glKh7QIaglDjxLH6BF+wefn+ohmT9ySm+PrT4PmYKxCIeoWXnZm
	fS3MDl0ExeI5eHaBw+CczdGH5egka0BTWlKTCezxtGOI2WWLgtNd/jzveKPf1au/
	M2D4Vm5iJtZTJ7A/8xkNNoc62S9zDEkJzra++r3CRfmmnC2jApEYGEympZnKLPwa
	CvBBDJbm72nw4pdzgFVnAjFZyjwqidH/1KZ3AudvoyjhZJ+47DtQG378uW9qNqq/
	AgSMDs7wggy0tfJLHfFXF3VJN5MxhN5afD5nbhLTwnY7eYQM6s6vtV7oNOZLScD1
	8HhOeeWqwKg/zCw3/GIA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk3tx9mva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 02:12:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J2C1FO021858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 02:12:01 GMT
Received: from [10.233.17.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 19:11:56 -0700
Message-ID: <b9faa152-3e87-4443-b060-66a7c71ae114@quicinc.com>
Date: Fri, 19 Apr 2024 10:11:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] coresight: Add support for multiple output ports on
 the funnel
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<Mike.Leach@arm.com>, Mike Leach <mike.leach@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-3-git-send-email-quic_taozha@quicinc.com>
 <8d381e6e-9328-46ff-83fe-efbe5bb4363e@arm.com>
 <ffce4577-b0f9-4af3-a379-0385a02ddae8@quicinc.com>
 <a8947ac4-e251-47ba-b44a-6f4fc58f1aac@arm.com>
 <6baaff95-728b-4492-ae3e-00dedbb50fb0@quicinc.com>
 <7fc09bfe-b34a-4658-a141-105f0f62e62c@arm.com>
 <CAJ9a7VjP_B8o4krdZcz3J9qzUMSYmvVyy4cFyrYZOdg43YD2YA@mail.gmail.com>
 <1f9609fe-298f-4a5f-aa5e-be8c7dd6a719@arm.com>
 <CAJ9a7Vif3HKcrT16W=jSs-G21idr+ZKGg67F7yQ71L9Laasujg@mail.gmail.com>
 <754fa8ba-5736-4a03-a321-0b40bd8b4d4b@arm.com>
 <PAVPR08MB967408AB27E2FBCCBAE070188C0E2@PAVPR08MB9674.eurprd08.prod.outlook.com>
 <d0018bba-fb01-4b47-9824-2b94ede90ffb@quicinc.com>
 <d59f508f-19fd-4d88-bac1-3b1db3d63fed@arm.com>
From: Tingwei Zhang <quic_tingweiz@quicinc.com>
In-Reply-To: <d59f508f-19fd-4d88-bac1-3b1db3d63fed@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HOsQsOTn7SzwvHkKUCZ5BjW9UfFAXhto
X-Proofpoint-ORIG-GUID: HOsQsOTn7SzwvHkKUCZ5BjW9UfFAXhto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_22,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190015

On 4/18/2024 8:38 PM, Suzuki K Poulose wrote:
> On 18/04/2024 13:01, Tingwei Zhang wrote:
>> Hi Mike and Suzuki
>>
>> On 4/18/2024 5:25 PM, Mike Leach wrote:
>>> Hi Suzuki
>>>
>>>> -----Original Message-----
>>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Sent: Thursday, April 18, 2024 10:00 AM
>>>> To: Mike Leach <mike.leach@linaro.org>
>>>> Cc: Tao Zhang <quic_taozha@quicinc.com>; Mathieu Poirier
>>>> <mathieu.poirier@linaro.org>; Alexander Shishkin
>>>> <alexander.shishkin@linux.intel.com>; Konrad Dybcio
>>>> <konradybcio@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>>>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Jinlong Mao
>>>> <quic_jinlmao@quicinc.com>; Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org>; coresight@lists.linaro.org; linux-arm-
>>>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>> devicetree@vger.kernel.org; Tingwei Zhang <quic_tingweiz@quicinc.com>;
>>>> Yuanfang Zhang <quic_yuanfang@quicinc.com>; Trilok Soni
>>>> <quic_tsoni@quicinc.com>; Song Chai <quic_songchai@quicinc.com>; 
>>>> linux-arm-
>>>> msm@vger.kernel.org; andersson@kernel.org
>>>> Subject: Re: [PATCH 2/4] coresight: Add support for multiple output 
>>>> ports on the
>>>> funnel
>>>>
>>>> Hi Mike
>>>>
>>>> On 18/04/2024 09:48, Mike Leach wrote:
>>>>> Hi Suzuki
>>>>>
>>>>> On Wed, 17 Apr 2024 at 10:21, Suzuki K Poulose 
>>>>> <suzuki.poulose@arm.com>
>>>> wrote:
>>>>>>
>>>>>> Hi Mike
>>>>>>
>>>>>> On 16/04/2024 15:19, Mike Leach wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Mon, 15 Apr 2024 at 14:24, Suzuki K Poulose 
>>>>>>> <suzuki.poulose@arm.com>
>>>> wrote:
>>>>>>>>
>>>>>>>> On 09/04/2024 14:22, Tao Zhang wrote:
>>>>>>>>>
>>>>>>>>> On 4/9/2024 3:13 PM, Suzuki K Poulose wrote:
>>>>>>>>>> Hi
>>>>>>>>>>
>>>>>>>>>> On 29/03/2024 09:27, Tao Zhang wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 3/22/2024 12:41 AM, Suzuki K Poulose wrote:
>>>>>>>>>>>> On 21/03/2024 08:32, Tao Zhang wrote:
>>>>>>>>>>>>> Funnel devices are now capable of supporting multiple-inputs
>>>>>>>>>>>>> and multiple-outputs configuration with in built hardware
>>>>>>>>>>>>> filtering for TPDM devices. Add software support to this
>>>>>>>>>>>>> function. Output port is selected according to the source 
>>>>>>>>>>>>> in the trace
>>>> path.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The source of the input port on funnels will be marked in the
>>>>>>>>>>>>> device tree.
>>>>>>>>>>>>> e.g.
>>>>>>>>>>>>> tpdm@xxxxxxx {
>>>>>>>>>>>>>         ... ... ... ...
>>>>>>>>>>>>> };
>>>>>>>>>>>>>
>>>>>>>>>>>>> funnel_XXX: funnel@xxxxxxx {
>>>>>>>>>>>>>         ... ... ... ...
>>>>>>>>>>>>>         out-ports {
>>>>>>>>>>>>>             ... ... ... ...
>>>>>>>>>>>>>             port@x {
>>>>>>>>>>>>>                 ... ... ... ...
>>>>>>>>>>>>>                 label = "xxxxxxx.tpdm"; <-- To label the 
>>>>>>>>>>>>> source
>>>>>>>>>>>>>             };                           corresponding to 
>>>>>>>>>>>>> the output
>>>>>>>>>>>>>         ... ... ... ...                  connection 
>>>>>>>>>>>>> "port@x". And this
>>>>>>>>>>>>>         };                               is a hardware static
>>>>>>>>>>>>> connections.
>>>>>>>>>>>>>         ... ... ... ...                  Here needs to 
>>>>>>>>>>>>> refer to hardware
>>>>>>>>>>>>> };                                   design.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then driver will parse the source label marked in the device
>>>>>>>>>>>>> tree, and save it to the coresight path. When the function
>>>>>>>>>>>>> needs to know the source label, it could obtain it from 
>>>>>>>>>>>>> coresight path
>>>> parameter.
>>>>>>>>>>>>> Finally,
>>>>>>>>>>>>> the output port knows which source it corresponds to, and it
>>>>>>>>>>>>> also knows which input port it corresponds to.
>>>>>>>>>>>>
>>>>>>>>>>>> Why do we need labels ? We have connection information for all
>>>>>>>>>>>> devices (both in and out), so, why do we need this label to 
>>>>>>>>>>>> find a device
>>>> ?
>>>>>>>>>>>
>>>>>>>>>>> Because our funnel's design has multi-output ports, the data
>>>>>>>>>>> stream will not
>>>>>>>>>>>
>>>>>>>>>>> know which output port should pass in building the data trace 
>>>>>>>>>>> path.
>>>>>>>>>>> This source
>>>>>>>>>>>
>>>>>>>>>>> label can make the data stream find the right output port to go.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> And also, I thought TPDM is a source device, why does a funnel
>>>>>>>>>>>> output port link to a source ?
>>>>>>>>>>>
>>>>>>>>>>> No, this label doesn't mean this funnel output port link to a
>>>>>>>>>>> source, it just let
>>>>>>>>>>>
>>>>>>>>>>> the output port know its data source.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Are these funnels programmable ? Or, are they static ? If they
>>>>>>>>>>>> are static, do these need to be described in the DT ? If they
>>>>>>>>>>>> are simply acting as a "LINK" (or HWFIFO ?)
>>>>>>>>>>>
>>>>>>>>>>> These funnels are static, and we will add the "label" to the DT
>>>>>>>>>>> to describe the
>>>>>>>>>>>
>>>>>>>>>>> multi-output ports for these funnels.
>>>>>>>>>>
>>>>>>>>>> I think there is still a bit of confusion. By "Dynamic" I mean,
>>>>>>>>>> the "dynamic funnel" (explicit port enablement via MMIO) vs
>>>>>>>>>> "static funnel" (no programming, always ON).
>>>>>>>>>>
>>>>>>>>>> So, coming to your example, do we need to "explicitly" enable
>>>>>>>>>> trace flow for an "input" and/or an "output" port in your 
>>>>>>>>>> "funnel" ?
>>>>>>>>>
>>>>>>>>> Sorry for my misunderstanding in the previous mails. Our funnels
>>>>>>>>> are programmable just like the common dynamic funnels.
>>>>>>>>>
>>>>>>>>> In our solution, we just make funnels have multiple output ports
>>>>>>>>> connected to different devices or ports. When we use it, we still
>>>>>>>>>
>>>>>>>>> enable the input port through programming. Our solution is to know
>>>>>>>>> which input port the expected data comes from based on the
>>>>>>>>>
>>>>>>>>> source label corresponding to the output port. This way we can
>>>>>>>>> build the expected trace path. In other respects, it is used the
>>>>>>>>> same
>>>>>>>>>
>>>>>>>>> as common dynamic funnels.
>>>>>>>>
>>>>>>>>
>>>>>>>> Ok. So, to summarise :
>>>>>>>>
>>>>>>>> 1. This is not a standard Funnel, but a trace link with 
>>>>>>>> multiple-input
>>>>>>>>        and multiple-output, with inputs hardwired to an outline at
>>>>>>>>        integration.
>>>>>>>> 2. The programming model is same as that of a "standard funnel".
>>>>>>>>
>>>>>>>> Now, we do have enough information in the coresight_connections to
>>>>>>>> traverse input/output ports. But we need additional logic to
>>>>>>>> "hardwire" the ports to each other and necessary logic to handle
>>>>>>>> the
>>>>>>>>
>>>>>>>> There are two options here :
>>>>>>>>
>>>>>>>> 1. Treat this as a new component and have its own driver, with
>>>>>>>>        additional logic to handle the input/output wiring.
>>>>>>>>
>>>>>>>> 2. Drive it using the funnel driver, with a a new compatible and
>>>>>>>>        add additional logic to handle the input/output wiring.
>>>>>>>>
>>>>>>>> My inclination is towards (2), we need to see how this works out.
>>>>>>>>
>>>>>>>> We need to irrespective of the options, we need special handling
>>>>>>>> for hardwired ports in 1) building path 2) walking back the path
>>>>>>>> (in TPDA driver)
>>>>>>>>
>>>>>>>> We also need some "DT" information to bind a given input port to an
>>>>>>>> output port. We must not use "any device" labels to hack this up,
>>>>>>>> like the approach in this series.
>>>>>>>>
>>>>>>>
>>>>>>> Given that the internal connections are static for the given device,
>>>>>>> then the compatible will imply these connections in just the same
>>>>>>> way as the arm,coresight-funnel implies that all inputs are
>>>>>>> connected to the single output.
>>>>>>
>>>>>> I am sorry, I couldn't follow the last part. We have two or more
>>>>>> output ports and we need a way to identify, which input port is
>>>>>> hardwired to
>>>>>> output-port0 and output-port1. Given we need special handling for
>>>>>> these anyway, I would like to avoid hard coding the input-output 
>>>>>> connection.
>>>>>> i.e., we do not want to assume that input-0  is always => output-0.
>>>>>>
>>>>>
>>>>> If we regard the current component as having compatible
>>>>> "qcom,coresight-compound-funnel-v1", then this identifies the
>>>>> relationship between the in-ports and out-ports.
>>>>> So the new driver / extension to the funnel driver that handles this
>>>>> compatible with know the static mapping between input and output so
>>>>> program it.
>>>>
>>>> Ok, but like I said, having one compatible may not be enough to know 
>>>> the "static"
>>>> mapping for all possible device instances on different SoCs.
>>>>
>>>
>>> The compatible name would have to change if the mapping changed.
>>> Using the compatible is simpler, but less flexible
>>>
>>>>>
>>>>> If however you want a more generic approach to handle future different
>>>>> versions of the component, then of course a method in DT of mapping
>>>>> in-ports to out-ports is useful.
>>>>>
>>>>> If did wonder if something along the lines of:-
>>>>>
>>>>> compound-funnel@0x1234000 {
>>>>>        compatible = "compound-funnel"
>>>>>        regs = < 0x1234000 0x1000>
>>>>>         sub-funnel@0 {
>>>>>                    in-ports {
>>>>>                           [some port definitions]
>>>>>                     }
>>>>>                    out-ports {
>>>>>                          [some port definitions]
>>>>>                     }
>>>>>          }
>>>>>         sub-funnel@1 {
>>>>>                    in-ports {
>>>>>                           [some port definitions]
>>>>>                     }
>>>>>                    out-ports {
>>>>>                          [some port definitions]
>>>>>                    }
>>>>>           }
>>>>> }
>>>>
>>>> That would work, with "two" different coresight devices for each 
>>>> "embedded
>>>> funnel". And that also confuses the user with the topology.
>>>
>>> I wasn't suggesting two different coresight devices, but finding a 
>>> way to iterate the sub-nodes to create a single device with the 
>>> inputs mapped to outputs. Which may or may not be easily do-able.
>>>
>>> As to topology - no more confusing than a "funnel" with multiple 
>>> outputs, or phandle links between inputs and outputs. It does 
>>> visually represent what the device really is - multiple effective 
>>> funnels controlled by a single set of registers.
>>>
>>
>> Let me provide the hardware topology here to facilitate the discussion.
>>
>> |----------|     |---------|     |----------|   |---------|
>> |  TPDM 0  |     | Source0 |     | Source 1 |   | TPDM 1  |
>> |----------|     |---------|     |----------|   |---------|
>>       |                |                |             |
>>       |                |                |             |
>>       |      --------- |                |             |
>>       |      |                          |             |
>>       |      |                          |             |
>>       |      |                          |             |
>>    \-------------/ ----------------------             |
>>     \  Funnel 0 /  |                                  |
>>      -----------   |  ---------------------------------
>>           |        |  |
>>           |        |  |
>>         \ -------------/
>>          \  Funnel 1  /
>>           -----------/
>>              |  |---------------------
>>              |  |------------         |
>>              |               |TPDM0   |TPDM1
>>              |            \ ----------------/
>>              |             \   TPDA 0      /
>>              |              --------------/
>>              |                    |
>>              |                    |
>>              |Source0/1           |
>>           \-------------------------------/
>>            \     Funnel 2                /
>>              ---------------------------
>>
>> To describe this topology in device tree, we need to indicate input 
>> port0 of FUNNEL0 is static link to output port0 of FUNNEL0 which links 
>> to input port0 of TPDA0. When code builds the path, it can get the 
> 
> This is making things even worse. Hold on there. Please could you
> confirm the topology again via the "Funnel 1". You seemed to have
> skipped it in the path description.
> 
Funnel0 has two inputs and one output. Funnel1 has three inputs and 
three outputs.
> 
> How many outputs does the Funnel 1 have ? 2 or 3 ? How does the Funnel 1
> know to split the "data" from Funnel1:input0 (which could be either 
> Source0 or TPDM0) ?
> 
> 
>> static link information from topology and select correct path. As 
>> Suzuki has suggested, we can describe the topology like below.
> 
> No, I suggested hardwiring the output-input of "the same component". Not
> of the two different components. I guess we need to sort this out
> offline, (happy to setup a call to understand and clear things better).
I agree we could have a call to I can clarify things better. Let me get 
some data from hardware team on how funnel1 routes data from different 
source. Do you have preference time to have that call?
> 
> 
>>
>> funnel0 {
>>      ...
>>      in-ports {
>>          port@0 {
>>              funnel0_in0: endpoint {
>>                  remote-endpoint = <&tpdm0_output>;
>>                  <hard-wired-to*>=
>>                    <&funnel1_out0>;
> 
> No, I meant. Not skipping the components.
> 
>          <&funnel0_out0>;
> 
> This leaves the question of how Funnel1 does the separation, unless
> it is a replicator and does the filtering based on the TraceID.
> 
> 
> Suzuki
> 
> 
>>              }
>>          }
>>      }
>> }
>>
>> funnel1 {
>>      ...
>>      out-ports {
>>          port@0 {
>>              funnel1_out0: endpoint {
>>                  remote-endpoint= <&tpdm0_in0>;
>>                  <hard-wired-to*>=
>>                      <&funnel0_in0>;
>>              }
>>          }
>>      }
>> }
>>
>>
>>> Mike
>>>
>>>>
>>>>>
>>>>>
>>>>> might be made to work? not sure about the implications of having more
>>>>> that one set of in-ports and out-ports in a component in the device
>>>>> tree & would need specific handling in the driver to iterate
>>>>> sub-funnels.
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Irrespective of if a new driver is used, or an extension to the
>>>>>>> current funnel driver to handle a new compatible - the mapping
>>>>>>> between input and output ports are created based on the compatible..
>>>>>>>
>>>>>>> As we are building a path from source to sink, what is then needed
>>>>>>> is a method in the generic path building code, to recognise these
>>>>>>> amppings and filter the output ports that are searched based on the
>>>>>>> input port in use.
>>>>>>
>>>>>> Agreed. We could mark this as a property of the
>>>>>> port/coresight_connection.
>>>>>>
>>>>>>>
>>>>>>> On standard components, where the mapping is not present, then the
>>>>>>> code will continue as it does now, for these compound funnels, the
>>>>>>> mappings will be present and the output filtering will occur.
>>>>>>
>>>>>> Agreed
>>>>>>
>>>>>>> This removes the need for the labels / extra connection attributes
>>>>>>> on devices other than the funnel, and also removes the need to
>>>>>>> specify the internal connections as part of the device tree.
>>>>>>
>>>>>> I am still not clear how we map the input-output ports. Rest is what
>>>>>> exactly I had in mind. So, once we sort out the port mapping we could
>>>>>> proceed to the prototyping.
>>>>>>
>>>>>
>>>>> given we iterate by output port index into an array of out ports, and
>>>>> have an array of in-ports by index, a third mapping array, same size
>>>>> as in-ports, determining the associated out port index should suffice.
>>>>> Mapping array should be optional - if not there, path discovery works
>>>>> as previously
>>>>
>>>> We could simply add a "(sticky)flag" to the
>>>> "coresight_connection".src_port/dest_port and extend the array to 
>>>> include the
>>>> sticky_port for src/dest port and use that flag to force the path 
>>>> traversal.
>>>>
>>>> Suzuki
>>>>
>>>>
>>>>
>>>>>
>>>>> Regards
>>>>>
>>>>> Mike
>>>>>
>>>>>> Kind regards
>>>>>> Suzuki
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Mike
>>>>>>>
>>>>>>>> Rob/Krzysztof,
>>>>>>>>
>>>>>>>> Do you have any recommendations for describing the 'hard wired
>>>>>>>> ports' ?
>>>>>>>>
>>>>>>>> e.g:
>>>>>>>>
>>>>>>>> component {
>>>>>>>>        input_ports {
>>>>>>>>           component_input_port0: port@0 {
>>>>>>>>               ...
>>>>>>>>               <hard-wired-to*> = &component_output_port0;
>>>>>>>>           };
>>>>>>>>           ...
>>>>>>>>       };
>>>>>>>>
>>>>>>>>       output_ports {
>>>>>>>>         componentne_output_port0: port@0 {
>>>>>>>>             ...
>>>>>>>>             <hard-wired-to> = &component_input_port0;
>>>>>>>>         };
>>>>>>>>         ...
>>>>>>>>       };
>>>>>>>>
>>>>>>>> };
>>>>>>>>
>>>>>>>> *Need a better suitable property than "hard-wired-to".
>>>>>>>>
>>>>>>>>
>>>>>>>> Suzuki
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Best,
>>>>>>>>>
>>>>>>>>> Tao
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> "If they are simply acting as a "LINK" (or HWFIFO ?) " I'm not
>>>>>>>>>>> sure what's the meaning
>>>>>>>>>>
>>>>>>>>>> i.e, Like TMC-ETF in HWFIFO mode. In this mode, the TMC-ETF is
>>>>>>>>>> acting like a cache for easing ATB data load, by providing h/w 
>>>>>>>>>> buffering.
>>>>>>>>>> (In your case, it may not be providing any buffering, it doesn't
>>>>>>>>>> matter either way, as it is not visible to the driver).
>>>>>>>>>>
>>>>>>>>>> Suzuki
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> of this. Could you describe it in detail?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Best,
>>>>>>>>>>>
>>>>>>>>>>> Tao
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Suzuki
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>      drivers/hwtracing/coresight/coresight-core.c  | 81
>>>>>>>>>>>>> ++++++++++++++++---
>>>>>>>>>>>>>      .../hwtracing/coresight/coresight-platform.c  |  5 ++
>>>>>>>>>>>>>      include/linux/coresight.h                     |  2 +
>>>>>>>>>>>>>      3 files changed, 75 insertions(+), 13 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>>>>>>>>>>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>>>>>>>>>>> index 5dde597403b3..b1b5e6d9ec7a 100644
>>>>>>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>>>>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>>>>>>>>>>> @@ -113,15 +113,63 @@ struct coresight_device
>>>>>>>>>>>>> *coresight_get_percpu_sink(int cpu)
>>>>>>>>>>>>>      }
>>>>>>>>>>>>>      EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
>>>>>>>>>>>>>      +static struct coresight_device
>>>>>>>>>>>>> *coresight_get_source(struct list_head *path)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    struct coresight_device *csdev;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    if (!path)
>>>>>>>>>>>>> +        return NULL;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    csdev = list_first_entry(path, struct coresight_node,
>>>>>>>>>>>>> link)->csdev;
>>>>>>>>>>>>> +    if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
>>>>>>>>>>>>> +        return NULL;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    return csdev;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +/**
>>>>>>>>>>>>> + * coresight_source_filter - checks whether the connection
>>>>>>>>>>>>> +matches
>>>>>>>>>>>>> the source
>>>>>>>>>>>>> + * of path if connection is binded to specific source.
>>>>>>>>>>>>> + * @path:    The list of devices
>>>>>>>>>>>>> + * @conn:    The connection of one outport
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Return zero if the connection doesn't have a source binded
>>>>>>>>>>>>> + or
>>>>>>>>>>>>> source of the
>>>>>>>>>>>>> + * path matches the source binds to connection.
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +static int coresight_source_filter(struct list_head *path,
>>>>>>>>>>>>> +            struct coresight_connection *conn) {
>>>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>>>> +    struct coresight_device *source = NULL;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    if (conn->source_label == NULL)
>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    source = coresight_get_source(path);
>>>>>>>>>>>>> +    if (source == NULL)
>>>>>>>>>>>>> +        return ret;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    if (strstr(kobject_get_path(&source->dev.kobj, 
>>>>>>>>>>>>> GFP_KERNEL),
>>>>>>>>>>>>> +            conn->source_label))
>>>>>>>>>>>>> +        ret = 0;
>>>>>>>>>>>>> +    else
>>>>>>>>>>>>> +        ret = -1;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    return ret;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>>      static struct coresight_connection *
>>>>>>>>>>>>>      coresight_find_out_connection(struct coresight_device 
>>>>>>>>>>>>> *src_dev,
>>>>>>>>>>>>> -                  struct coresight_device *dest_dev)
>>>>>>>>>>>>> +                  struct coresight_device *dest_dev,
>>>>>>>>>>>>> +                  struct list_head *path)
>>>>>>>>>>>>>      {
>>>>>>>>>>>>>          int i;
>>>>>>>>>>>>>          struct coresight_connection *conn;
>>>>>>>>>>>>>            for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
>>>>>>>>>>>>>              conn = src_dev->pdata->out_conns[i];
>>>>>>>>>>>>> +        if (coresight_source_filter(path, conn))
>>>>>>>>>>>>> +            continue;
>>>>>>>>>>>>>              if (conn->dest_dev == dest_dev)
>>>>>>>>>>>>>                  return conn;
>>>>>>>>>>>>>          }
>>>>>>>>>>>>> @@ -312,7 +360,8 @@ static void coresight_disable_sink(struct
>>>>>>>>>>>>> coresight_device *csdev)
>>>>>>>>>>>>>        static int coresight_enable_link(struct 
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>                       struct coresight_device *parent,
>>>>>>>>>>>>> -                 struct coresight_device *child)
>>>>>>>>>>>>> +                 struct coresight_device *child,
>>>>>>>>>>>>> +                 struct list_head *path)
>>>>>>>>>>>>>      {
>>>>>>>>>>>>>          int ret = 0;
>>>>>>>>>>>>>          int link_subtype;
>>>>>>>>>>>>> @@ -321,8 +370,8 @@ static int coresight_enable_link(struct
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>          if (!parent || !child)
>>>>>>>>>>>>>              return -EINVAL;
>>>>>>>>>>>>>      -    inconn = coresight_find_out_connection(parent, 
>>>>>>>>>>>>> csdev);
>>>>>>>>>>>>> -    outconn = coresight_find_out_connection(csdev, child);
>>>>>>>>>>>>> +    inconn = coresight_find_out_connection(parent, csdev, 
>>>>>>>>>>>>> path);
>>>>>>>>>>>>> +    outconn = coresight_find_out_connection(csdev, child,
>>>>>>>>>>>>> + path);
>>>>>>>>>>>>>          link_subtype = csdev->subtype.link_subtype;
>>>>>>>>>>>>>            if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG
>>>>>>>>>>>>> &&
>>>>>>>>>>>>> IS_ERR(inconn))
>>>>>>>>>>>>> @@ -341,7 +390,8 @@ static int coresight_enable_link(struct
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>        static void coresight_disable_link(struct 
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>                         struct coresight_device *parent,
>>>>>>>>>>>>> -                   struct coresight_device *child)
>>>>>>>>>>>>> +                   struct coresight_device *child,
>>>>>>>>>>>>> +                   struct list_head *path)
>>>>>>>>>>>>>      {
>>>>>>>>>>>>>          int i;
>>>>>>>>>>>>>          int link_subtype;
>>>>>>>>>>>>> @@ -350,8 +400,8 @@ static void coresight_disable_link(struct
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>          if (!parent || !child)
>>>>>>>>>>>>>              return;
>>>>>>>>>>>>>      -    inconn = coresight_find_out_connection(parent, 
>>>>>>>>>>>>> csdev);
>>>>>>>>>>>>> -    outconn = coresight_find_out_connection(csdev, child);
>>>>>>>>>>>>> +    inconn = coresight_find_out_connection(parent, csdev, 
>>>>>>>>>>>>> path);
>>>>>>>>>>>>> +    outconn = coresight_find_out_connection(csdev, child,
>>>>>>>>>>>>> + path);
>>>>>>>>>>>>>          link_subtype = csdev->subtype.link_subtype;
>>>>>>>>>>>>>            if (link_ops(csdev)->disable) { @@ -507,7 +557,7 @@
>>>>>>>>>>>>> static void coresight_disable_path_from(struct
>>>>>>>>>>>>> list_head *path,
>>>>>>>>>>>>>              case CORESIGHT_DEV_TYPE_LINK:
>>>>>>>>>>>>>                  parent = list_prev_entry(nd, link)->csdev;
>>>>>>>>>>>>>                  child = list_next_entry(nd, link)->csdev;
>>>>>>>>>>>>> -            coresight_disable_link(csdev, parent, child);
>>>>>>>>>>>>> +            coresight_disable_link(csdev, parent, child,
>>>>>>>>>>>>> + path);
>>>>>>>>>>>>>                  break;
>>>>>>>>>>>>>              default:
>>>>>>>>>>>>>                  break;
>>>>>>>>>>>>> @@ -588,7 +638,7 @@ int coresight_enable_path(struct list_head
>>>>>>>>>>>>> *path, enum cs_mode mode,
>>>>>>>>>>>>>              case CORESIGHT_DEV_TYPE_LINK:
>>>>>>>>>>>>>                  parent = list_prev_entry(nd, link)->csdev;
>>>>>>>>>>>>>                  child = list_next_entry(nd, link)->csdev;
>>>>>>>>>>>>> -            ret = coresight_enable_link(csdev, parent, 
>>>>>>>>>>>>> child);
>>>>>>>>>>>>> +            ret = coresight_enable_link(csdev, parent, child,
>>>>>>>>>>>>> + path);
>>>>>>>>>>>>>                  if (ret)
>>>>>>>>>>>>>                      goto err;
>>>>>>>>>>>>>                  break;
>>>>>>>>>>>>> @@ -802,7 +852,8 @@ static void coresight_drop_device(struct
>>>>>>>>>>>>> coresight_device *csdev)
>>>>>>>>>>>>>       */
>>>>>>>>>>>>>      static int _coresight_build_path(struct 
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>                       struct coresight_device *sink,
>>>>>>>>>>>>> -                 struct list_head *path)
>>>>>>>>>>>>> +                 struct list_head *path,
>>>>>>>>>>>>> +                 struct coresight_device *source)
>>>>>>>>>>>>>      {
>>>>>>>>>>>>>          int i, ret;
>>>>>>>>>>>>>          bool found = false;
>>>>>>>>>>>>> @@ -814,7 +865,7 @@ static int _coresight_build_path(struct
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>            if (coresight_is_percpu_source(csdev) &&
>>>>>>>>>>>>> coresight_is_percpu_sink(sink) &&
>>>>>>>>>>>>>              sink == per_cpu(csdev_sink,
>>>>>>>>>>>>> source_ops(csdev)->cpu_id(csdev))) {
>>>>>>>>>>>>> -        if (_coresight_build_path(sink, sink, path) == 0) {
>>>>>>>>>>>>> +        if (_coresight_build_path(sink, sink, path, source)
>>>>>>>>>>>>> + == 0) {
>>>>>>>>>>>>>                  found = true;
>>>>>>>>>>>>>                  goto out;
>>>>>>>>>>>>>              }
>>>>>>>>>>>>> @@ -825,8 +876,12 @@ static int _coresight_build_path(struct
>>>>>>>>>>>>> coresight_device *csdev,
>>>>>>>>>>>>>              struct coresight_device *child_dev;
>>>>>>>>>>>>>                child_dev =
>>>>>>>>>>>>> csdev->pdata->out_conns[i]->dest_dev;
>>>>>>>>>>>>> +        if (csdev->pdata->out_conns[i]->source_label &&
>>>>>>>>>>>>> + !strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
>>>>>>>>>>>>> + csdev->pdata->out_conns[i]->source_label))
>>>>>>>>>>>>> +            continue;
>>>>>>>>>>>>>              if (child_dev &&
>>>>>>>>>>>>> -            _coresight_build_path(child_dev, sink, path) 
>>>>>>>>>>>>> == 0) {
>>>>>>>>>>>>> +            _coresight_build_path(child_dev, sink, path,
>>>>>>>>>>>>> + source)
>>>>>>>>>>>>> == 0) {
>>>>>>>>>>>>>                  found = true;
>>>>>>>>>>>>>                  break;
>>>>>>>>>>>>>              }
>>>>>>>>>>>>> @@ -871,7 +926,7 @@ struct list_head
>>>>>>>>>>>>> *coresight_build_path(struct coresight_device *source,
>>>>>>>>>>>>>            INIT_LIST_HEAD(path);
>>>>>>>>>>>>>      -    rc = _coresight_build_path(source, sink, path);
>>>>>>>>>>>>> +    rc = _coresight_build_path(source, sink, path, source);
>>>>>>>>>>>>>          if (rc) {
>>>>>>>>>>>>>              kfree(path);
>>>>>>>>>>>>>              return ERR_PTR(rc); diff --git
>>>>>>>>>>>>> a/drivers/hwtracing/coresight/coresight-platform.c
>>>>>>>>>>>>> b/drivers/hwtracing/coresight/coresight-platform.c
>>>>>>>>>>>>> index 9d550f5697fa..f553fb20966d 100644
>>>>>>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>>>>>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>>>>>>>>>>>> @@ -205,6 +205,7 @@ static int
>>>>>>>>>>>>> of_coresight_parse_endpoint(struct
>>>>>>>>>>>>> device *dev,
>>>>>>>>>>>>>          struct fwnode_handle *rdev_fwnode;
>>>>>>>>>>>>>          struct coresight_connection conn = {};
>>>>>>>>>>>>>          struct coresight_connection *new_conn;
>>>>>>>>>>>>> +    const char *label;
>>>>>>>>>>>>>            do {
>>>>>>>>>>>>>              /* Parse the local port details */ @@ -243,6
>>>>>>>>>>>>> +244,10 @@ static int of_coresight_parse_endpoint(struct
>>>>>>>>>>>>> device *dev,
>>>>>>>>>>>>>              conn.dest_fwnode = 
>>>>>>>>>>>>> fwnode_handle_get(rdev_fwnode);
>>>>>>>>>>>>>              conn.dest_port = rendpoint.port;
>>>>>>>>>>>>>      +        conn.source_label = NULL;
>>>>>>>>>>>>> +        if (!of_property_read_string(ep, "label", &label))
>>>>>>>>>>>>> +            conn.source_label = label;
>>>>>>>>>>>>> +
>>>>>>>>>>>>>              new_conn = coresight_add_out_conn(dev, pdata, 
>>>>>>>>>>>>> &conn);
>>>>>>>>>>>>>              if (IS_ERR_VALUE(new_conn)) {
>>>>>>>>>>>>>                  fwnode_handle_put(conn.dest_fwnode);
>>>>>>>>>>>>> diff --git a/include/linux/coresight.h
>>>>>>>>>>>>> b/include/linux/coresight.h index e8b6e388218c..a9c06ef9bbb2
>>>>>>>>>>>>> 100644
>>>>>>>>>>>>> --- a/include/linux/coresight.h
>>>>>>>>>>>>> +++ b/include/linux/coresight.h
>>>>>>>>>>>>> @@ -167,6 +167,7 @@ struct coresight_desc {
>>>>>>>>>>>>>       * struct coresight_connection - representation of a
>>>>>>>>>>>>> single connection
>>>>>>>>>>>>>       * @src_port:    a connection's output port number.
>>>>>>>>>>>>>       * @dest_port:    destination's input port number 
>>>>>>>>>>>>> @src_port is
>>>>>>>>>>>>> connected to.
>>>>>>>>>>>>> + * @source_label: source component's label.
>>>>>>>>>>>>>       * @dest_fwnode: destination component's fwnode handle.
>>>>>>>>>>>>>       * @dest_dev:    a @coresight_device representation of 
>>>>>>>>>>>>> the
>>>> component
>>>>>>>>>>>>>              connected to @src_port. NULL until the device is
>>>>>>>>>>>>> created @@ -195,6 +196,7 @@ struct coresight_desc {
>>>>>>>>>>>>>      struct coresight_connection {
>>>>>>>>>>>>>          int src_port;
>>>>>>>>>>>>>          int dest_port;
>>>>>>>>>>>>> +    const char *source_label;
>>>>>>>>>>>>>          struct fwnode_handle *dest_fwnode;
>>>>>>>>>>>>>          struct coresight_device *dest_dev;
>>>>>>>>>>>>>          struct coresight_sysfs_link *link;
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>> _______________________________________________
>>>> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe 
>>>> send an email to
>>>> coresight-leave@lists.linaro.org
>>> _______________________________________________
>>> CoreSight mailing list -- coresight@lists.linaro.org
>>> To unsubscribe send an email to coresight-leave@lists.linaro.org
>>
> 

-- 
Thanks,
Tingwei


