Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BED7BF1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442107AbjJJEi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:38:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C79F;
        Mon,  9 Oct 2023 21:38:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A4Nsoi022244;
        Tue, 10 Oct 2023 04:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mCoJMjKwOGb5tq5Xvfc6bP1qHmAQ55B4LAkf1KFg3GQ=;
 b=SQ8MiMyqAM+E82am5Ft7PTEpUGZACp+63YavvWlKPLimuumJWXJoJXAyMvbWuvpVlYGz
 CtJOG8tYMTwpCzSDUOVjpbk8IlZBMJ7yaLMuTm7M4R9alnjyxXwyK+LfiVHov8W0TAIo
 x706LCyqZ8VvmZH87ZQDckhUKf63AON2K7aMsPihVFr6XvBYpYynSH3OmxPn3uLiONs2
 tCNX/OdRotkSCvmBFE9mclSQbJiV3yw6WoKhB+re87vXUNzEy7918Nnd9pTb9DGPpwGR
 Yo1G1mZ/mfH/z2/vrDD/PBkfi7Xpgryo4Cgn43OumBlpSkaJVOr4rjIGvA3EfJCNoZwS jQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmw3j07sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 04:38:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39A4cIt6032285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 04:38:18 GMT
Received: from [10.216.23.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 21:38:14 -0700
Message-ID: <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com>
Date:   Tue, 10 Oct 2023 10:08:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
 <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
 <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
 <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SyUPlJyTZLHQsdKS9CkjL6IfTNjkE9M2
X-Proofpoint-ORIG-GUID: SyUPlJyTZLHQsdKS9CkjL6IfTNjkE9M2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_02,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 6:07 AM, Maciej Żenczykowski wrote:
> On Mon, Oct 9, 2023 at 5:20 PM Maciej Żenczykowski <maze@google.com> wrote:
>>
>> On Mon, Oct 9, 2023 at 5:17 PM Maciej Żenczykowski <maze@google.com> wrote:
>>>
>>> On Mon, Oct 9, 2023 at 7:20 AM Krishna Kurapati
>>> <quic_kriskura@quicinc.com> wrote:
>>>>
>>>> Currently the NCM driver restricts wMaxSegmentSize that indicates
>>>> the datagram size coming from network layer to 1514. However the
>>>> spec doesn't have any limitation. For P2P connections over NCM,
>>>> increasing MTU helps increasing throughput.
>>>>
>>>> Add support to configure this value before configfs symlink is
>>>> created. Also since the NTB Out/In buffer sizes are fixed at 16384
>>>> bytes, limit the segment size to an upper cap of 15014. Set the
>>>> default MTU size for the ncm interface during function bind before
>>>> network interface is registered allowing MTU to be set in parity
>>>> with wMaxSegmentSize.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>   drivers/usb/gadget/function/f_ncm.c | 51 +++++++++++++++++++++++++++++
>>>>   drivers/usb/gadget/function/u_ncm.h |  2 ++
>>>>   2 files changed, 53 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>>>> index feccf4c8cc4f..eab297b22200 100644
>>>> --- a/drivers/usb/gadget/function/f_ncm.c
>>>> +++ b/drivers/usb/gadget/function/f_ncm.c
>>>> @@ -103,6 +103,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
>>>>   /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>>>>   #define TX_TIMEOUT_NSECS       300000
>>>>
>>>> +#define MAX_DATAGRAM_SIZE      15014
>>>> +
>>>>   #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
>>>>                                   USB_CDC_NCM_NTB32_SUPPORTED)
>>>>
>>>> @@ -1408,6 +1410,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>>>          ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
>>>>
>>>>          if (cdev->use_os_string) {
>>>> +               ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
>>>>                  f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
>>>>                                             GFP_KERNEL);
>>>>                  if (!f->os_desc_table)
>>>> @@ -1469,6 +1472,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>>>
>>>>          status = -ENODEV;
>>>>
>>>> +       ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
>>>
>>> I think you need byte swap here.
>>>
>>>> +
>>>>          /* allocate instance-specific endpoints */
>>>>          ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>>>>          if (!ep)
>>>> @@ -1569,11 +1574,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>>>>   /* f_ncm_opts_ifname */
>>>>   USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>>>>
>>>> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
>>>> +                                             char *page)
>>>> +{
>>>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>>>> +       u32 segment_size;
>>>> +
>>>> +       mutex_lock(&opts->lock);
>>>> +       segment_size = opts->max_segment_size;
>>>> +       mutex_unlock(&opts->lock);
>>>> +
>>>> +       return sprintf(page, "%u\n", segment_size);
>>>> +}
>>>> +
>>>> +static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
>>>> +                                              const char *page, size_t len)
>>>> +{
>>>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>>>> +       int ret;
>>>> +       u32 segment_size;
>>>> +
>>>> +       mutex_lock(&opts->lock);
>>>> +       if (opts->refcnt) {
>>>> +               ret = -EBUSY;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       ret = kstrtou32(page, 0, &segment_size);
>>>> +       if (ret)
>>>> +               goto out;
>>>> +
>>>> +       if (segment_size > MAX_DATAGRAM_SIZE) {
>>>> +               ret = -EINVAL;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       opts->max_segment_size = segment_size;
>>>> +       ret = len;
>>>> +out:
>>>> +       mutex_unlock(&opts->lock);
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +CONFIGFS_ATTR(ncm_opts_, max_segment_size);
>>>> +
>>>>   static struct configfs_attribute *ncm_attrs[] = {
>>>>          &ncm_opts_attr_dev_addr,
>>>>          &ncm_opts_attr_host_addr,
>>>>          &ncm_opts_attr_qmult,
>>>>          &ncm_opts_attr_ifname,
>>>> +       &ncm_opts_attr_max_segment_size,
>>>>          NULL,
>>>>   };
>>>>
>>>> @@ -1616,6 +1666,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
>>>>                  kfree(opts);
>>>>                  return ERR_CAST(net);
>>>>          }
>>>> +       opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
>>>
>>> and not here.  ie. max_segment_size should be native endian
>>>
>>>>          INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
>>>>
>>>>          descs[0] = &opts->ncm_os_desc;
>>>> diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
>>>> index 5408854d8407..d3403cf13f17 100644
>>>> --- a/drivers/usb/gadget/function/u_ncm.h
>>>> +++ b/drivers/usb/gadget/function/u_ncm.h
>>>> @@ -31,6 +31,8 @@ struct f_ncm_opts {
>>>>           */
>>>>          struct mutex                    lock;
>>>>          int                             refcnt;
>>>> +
>>>> +       u32                             max_segment_size;
>>>>   };
>>>>
>>>>   #endif /* U_NCM_H */
>>>> --
>>>> 2.42.0
>>>>
>>>
>>> That said, I don't really follow what this is doing...
>>
>> Also
>>
>> static struct usb_cdc_ether_desc ecm_desc = {
>> ...
>> .wMaxSegmentSize = cpu_to_le16(ETH_FRAME_LEN),
>>
>> ^ I think this should be deleted now, right?  since it's always overwritten?
>> And if it isn't always overwritten, that would be a bug I think, cause
>> what happens if you bring up 2 ncm devices and only change the setting
>> on the 1st?
> 
> One last thing...
> 
> static int ncm_unwrap_ntb(struct gether *port,
> ...
> unsigned frame_max = le16_to_cpu(ecm_desc.wMaxSegmentSize);
> 
> ^ is this a problem now if we have >1 gadget?
> how does it work then?


You are right. This would effect unwrap call and the wMaxSegmentSize is 
used directly. Thanks for the catch. I didn't test with 2 NCM interfaces 
and hence I wasn't able to find this bug. Perhaps changing this to 
opts->max_segment_size would fix the implementation as unwrap would 
anyways be called after bind.

Regards,
Krishna,
