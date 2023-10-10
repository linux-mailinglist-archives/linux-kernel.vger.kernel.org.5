Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F87BF1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442104AbjJJEed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJJEea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:34:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A179D;
        Mon,  9 Oct 2023 21:34:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A4MbnH011486;
        Tue, 10 Oct 2023 04:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h+xYZXf3TthVaMWl32/9t7I95EMpI9mieV0YTz8YW3Y=;
 b=Rt4QfytzNbxMAZaudt3dfjyKTDXNXGszXcSNKz0UIKxUfSr57NyTZ0MksV6THKyifuvq
 GLXHRQORt2eN0W8HfqPGULCkLcCbPB3h2FgTOGYs1C7/hWN7mDJmUH7pXEf/Qidz6nB+
 gXzyPuM4FeG+EgVnLTHE2j0tAoLmZDDBUW8C19Phpb7PYuJVMXjnphMkK8HMP9BtWH/6
 /HOvF4YOY9sDqlpDkpgspNHlUF/iQ6HpCj5Ii2i0jVyFvKxH83mq4yN31ulfpC12XOSU
 q7i9qtXk4tozHPlCp0OSOPhP2c+9ztMzNZATu/IpzPmA1TXkli0N45myqFUE6OSXEosP Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh4tc632-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 04:34:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39A4YO8Q027524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 04:34:24 GMT
Received: from [10.216.23.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 21:34:20 -0700
Message-ID: <57a37689-fc6b-4804-8057-df31f4df5441@quicinc.com>
Date:   Tue, 10 Oct 2023 10:04:17 +0530
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
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OI9vnyMsUm3OYQXbZRNPYxTfQvNVSoZZ
X-Proofpoint-ORIG-GUID: OI9vnyMsUm3OYQXbZRNPYxTfQvNVSoZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 5:50 AM, Maciej Żenczykowski wrote:
> On Mon, Oct 9, 2023 at 5:17 PM Maciej Żenczykowski <maze@google.com> wrote:
>>
>> On Mon, Oct 9, 2023 at 7:20 AM Krishna Kurapati
>> <quic_kriskura@quicinc.com> wrote:
>>>
>>> Currently the NCM driver restricts wMaxSegmentSize that indicates
>>> the datagram size coming from network layer to 1514. However the
>>> spec doesn't have any limitation. For P2P connections over NCM,
>>> increasing MTU helps increasing throughput.
>>>
>>> Add support to configure this value before configfs symlink is
>>> created. Also since the NTB Out/In buffer sizes are fixed at 16384
>>> bytes, limit the segment size to an upper cap of 15014. Set the
>>> default MTU size for the ncm interface during function bind before
>>> network interface is registered allowing MTU to be set in parity
>>> with wMaxSegmentSize.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   drivers/usb/gadget/function/f_ncm.c | 51 +++++++++++++++++++++++++++++
>>>   drivers/usb/gadget/function/u_ncm.h |  2 ++
>>>   2 files changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>>> index feccf4c8cc4f..eab297b22200 100644
>>> --- a/drivers/usb/gadget/function/f_ncm.c
>>> +++ b/drivers/usb/gadget/function/f_ncm.c
>>> @@ -103,6 +103,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
>>>   /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>>>   #define TX_TIMEOUT_NSECS       300000
>>>
>>> +#define MAX_DATAGRAM_SIZE      15014
>>> +
>>>   #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
>>>                                   USB_CDC_NCM_NTB32_SUPPORTED)
>>>
>>> @@ -1408,6 +1410,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>>          ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
>>>
>>>          if (cdev->use_os_string) {
>>> +               ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
>>>                  f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
>>>                                             GFP_KERNEL);
>>>                  if (!f->os_desc_table)
>>> @@ -1469,6 +1472,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>>
>>>          status = -ENODEV;
>>>
>>> +       ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
>>
>> I think you need byte swap here.
>>
>>> +
>>>          /* allocate instance-specific endpoints */
>>>          ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>>>          if (!ep)
>>> @@ -1569,11 +1574,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>>>   /* f_ncm_opts_ifname */
>>>   USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>>>
>>> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
>>> +                                             char *page)
>>> +{
>>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>>> +       u32 segment_size;
>>> +
>>> +       mutex_lock(&opts->lock);
>>> +       segment_size = opts->max_segment_size;
>>> +       mutex_unlock(&opts->lock);
>>> +
>>> +       return sprintf(page, "%u\n", segment_size);
>>> +}
>>> +
>>> +static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
>>> +                                              const char *page, size_t len)
>>> +{
>>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>>> +       int ret;
>>> +       u32 segment_size;
>>> +
>>> +       mutex_lock(&opts->lock);
>>> +       if (opts->refcnt) {
>>> +               ret = -EBUSY;
>>> +               goto out;
>>> +       }
>>> +
>>> +       ret = kstrtou32(page, 0, &segment_size);
>>> +       if (ret)
>>> +               goto out;
>>> +
>>> +       if (segment_size > MAX_DATAGRAM_SIZE) {
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
>>> +
>>> +       opts->max_segment_size = segment_size;
>>> +       ret = len;
>>> +out:
>>> +       mutex_unlock(&opts->lock);
>>> +       return ret;
>>> +}
>>> +
>>> +CONFIGFS_ATTR(ncm_opts_, max_segment_size);
>>> +
>>>   static struct configfs_attribute *ncm_attrs[] = {
>>>          &ncm_opts_attr_dev_addr,
>>>          &ncm_opts_attr_host_addr,
>>>          &ncm_opts_attr_qmult,
>>>          &ncm_opts_attr_ifname,
>>> +       &ncm_opts_attr_max_segment_size,
>>>          NULL,
>>>   };
>>>
>>> @@ -1616,6 +1666,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
>>>                  kfree(opts);
>>>                  return ERR_CAST(net);
>>>          }
>>> +       opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
>>
>> and not here.  ie. max_segment_size should be native endian
>>
>>>          INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
>>>
>>>          descs[0] = &opts->ncm_os_desc;
>>> diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
>>> index 5408854d8407..d3403cf13f17 100644
>>> --- a/drivers/usb/gadget/function/u_ncm.h
>>> +++ b/drivers/usb/gadget/function/u_ncm.h
>>> @@ -31,6 +31,8 @@ struct f_ncm_opts {
>>>           */
>>>          struct mutex                    lock;
>>>          int                             refcnt;
>>> +
>>> +       u32                             max_segment_size;
>>>   };
>>>
>>>   #endif /* U_NCM_H */
>>> --
>>> 2.42.0
>>>
>>
>> That said, I don't really follow what this is doing...
> 
> Also
> 
> static struct usb_cdc_ether_desc ecm_desc = {
> ...
> .wMaxSegmentSize = cpu_to_le16(ETH_FRAME_LEN),
> 
> ^ I think this should be deleted now, right?  since it's always overwritten?
> And if it isn't always overwritten, that would be a bug I think, cause
> what happens if you bring up 2 ncm devices and only change the setting
> on the 1st?

Actually, keeping it or removing it doesn't affect because the default 
value of this will be set in bind call via opts->max_segment_size. And 
this max_segment_size variable is defaulted to ETH_FRAME_LEN in 
alloc_inst. After bind, writing to this value doesn't take effect. 
Before the netdev interface was registered, if this value is updated 
then MTU is changed automatically for this interface. If there are two 
NCM devices, then each of them will have their own instance of 
wMaxSegmentSize property in their usb_gadget/g1/functions/ncm.X 
directories and both of them are defaulted ETH_FRAME_LEN if the configfs 
property is not disturbed. In case only one needs to change, we can 
change via configfs and the other stays as ETH_FRAME_LEN only.

Regards,
Krishna,
