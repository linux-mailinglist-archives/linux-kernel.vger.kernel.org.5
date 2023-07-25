Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9676271F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGYXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGYXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:00:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8C172E;
        Tue, 25 Jul 2023 16:00:41 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PMFfaU032110;
        Tue, 25 Jul 2023 22:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2pFySXKPFM81kXlQzIVKlnvEWXbOdlylxbolS5QUAAU=;
 b=GKMhJgsGuOyVr/Fzx8npFQqER2kjdyKBoYCbSs5v9P8k32IOyKUskRI854DFCFPjGUCz
 1bFGelgHcVMyaFhzdOR3XkgC8HPCU3CeIj1Ln79uKnLeQHTB1xHP2ExqcyAuMiV/ij7p
 Jgo7mT0Bju7DDnE6B5R9u7l6l/qEAgWaHYnrSSO6fjmWhw00CQ5T237szAKm9M1i3IS+
 z7qUYO1QRUj0lLEXZP1+O7C84VM3zmGYydygGTsUsY0B9D0LlFy3qBVaa6P/PNobqDFA
 rjEZMhtHY9twBVHszmNCTT/PncO8jtMpzV1Ypolzz9wZ/y/lViiu7ZaI12omKIn2DknV Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dauhhwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:59:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMxwOR028551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:59:58 GMT
Received: from [10.110.23.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 15:59:57 -0700
Message-ID: <243ee81d-d46d-e05a-1fcd-35e6301a39cd@quicinc.com>
Date:   Tue, 25 Jul 2023 15:59:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 18/32] sound: usb: Introduce QC USB SND offloading
 support
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <quic_jackp@quicinc.com>, <pierre-louis.bossart@linux.intel.com>,
        <oneukum@suse.com>, <albertccwang@google.com>,
        <o-takashi@sakamocchi.jp>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-19-quic_wcheng@quicinc.com>
 <87bkg0v4ce.wl-tiwai@suse.de>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87bkg0v4ce.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7AYH6eHmajjPxJdpkNnu3V5fahHix3Nj
X-Proofpoint-ORIG-GUID: 7AYH6eHmajjPxJdpkNnu3V5fahHix3Nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=978 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250196
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 7/25/2023 12:26 AM, Takashi Iwai wrote:
> On Tue, 25 Jul 2023 04:34:02 +0200,
> Wesley Cheng wrote:
>>
>> --- a/sound/usb/Kconfig
>> +++ b/sound/usb/Kconfig
>> @@ -165,6 +165,21 @@ config SND_BCD2000
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called snd-bcd2000.
>>   
>> +config QC_USB_AUDIO_OFFLOAD
>> +	tristate "Qualcomm Audio Offload driver"
>> +	depends on QCOM_QMI_HELPERS
>> +	select SND_PCM
> 
> So the driver can be enabled without CONFIG_SND_USB_AUDIO?  It makes
> little sense without it.
> Or is it set so intentionally for testing purpose?
> 

Thanks for the review.  I'll change this to be dependent on 
CONFIG_SND_USB_AUDIO...it shouldn't exist in the end use case w/o it.

> About the code:
> 
>> +/* Offloading IOMMU management */
>> +static unsigned long uaudio_get_iova(unsigned long *curr_iova,
>> +	size_t *curr_iova_size, struct list_head *head, size_t size)
>> +{
>> +	struct iova_info *info, *new_info = NULL;
>> +	struct list_head *curr_head;
>> +	unsigned long va = 0;
>> +	size_t tmp_size = size;
>> +	bool found = false;
>> +
>> +	if (size % PAGE_SIZE) {
>> +		dev_err(uaudio_qdev->dev, "size %zu is not page size multiple\n",
>> +			size);
>> +		goto done;
> 
> This can be easily triggered by user-space as it's passed directly
> from the mmap call, and it implies that you can fill up the messages
> easily.  It's safer to make it debug message or add the rate limit.
> 
> Ditto for other error messages.
> 

Got it, I'll make sure to address the above dev_err().

>> +static void disable_audio_stream(struct snd_usb_substream *subs)
>> +{
>> +	struct snd_usb_audio *chip = subs->stream->chip;
>> +
>> +	if (subs->data_endpoint || subs->sync_endpoint) {
>> +		close_endpoints(chip, subs);
>> +
>> +		mutex_lock(&chip->mutex);
>> +		subs->cur_audiofmt = NULL;
>> +		mutex_unlock(&chip->mutex);
>> +	}
> 
> Now looking at this and...
> 
>> +static int enable_audio_stream(struct snd_usb_substream *subs,
>> +				snd_pcm_format_t pcm_format,
>> +				unsigned int channels, unsigned int cur_rate,
>> +				int datainterval)
>> +{
> 
> ... this implementation, I wonder whether it'd be better to modify and
> export  snd_usb_hw_params() snd snd_usb_hw_free() to fit with qcom
> driver.  Then you can avoid lots of open code.
> 

I think the problem is that snd_usb_hw_params assumes that we've already 
done a PCM open on the PCM device created by USB SND.  However, with the 
offload path, we don't reference the USB PCM device, but the one created 
by the platform sound card.  Hence, I don't have access to the 
snd_pcm_substream.

I attempted to derive snd_pcm_substream from snd_usb_substream, but 
since PCM open isn't run, it doesn't provide a valid structure.

What do you think about adding a wrapper to snd_usb_hw_params?  Have a 
version that will take in snd_usb_substream, and another that is 
registered to hw_params().

> In general, if you see a direct use of chip->mutex, it can be often
> done better in a different form.  The use of an internal lock or such
> from an external driver is always fragile and error-prone.
> 
> Also, the current open-code misses the potential race against the
> disconnection during the operation.  In snd-usb-audio, it protects
> with snd_usb_lock_shutdown() and snd_usb_unlock_shutdown() pairs.
> 

I agree...I think then the best approach would be something like the 
above, ie:

int snd_usb_hw_params(struct snd_pcm_substream *substream,
			     struct snd_pcm_hw_params *hw_params)
{
	struct snd_usb_substream *subs = substream->runtime->private_data;

	snd_usb_ep_attach(subs, hw_params);
...

int snd_usb_ep_attach(...)
{
	//implementation of current code in snd_usb_hw_params()
}
EXPORT_SYMBOL(snd_usb_ep_attach);

>> +static int __init qc_usb_audio_offload_init(void)
>> +{
>> +	struct uaudio_qmi_svc *svc;
>> +	int ret;
>> +
>> +	ret = snd_usb_register_platform_ops(&offload_ops);
>> +	if (ret < 0)
>> +		return ret;
> 
> Registering the ops at the very first opens a potential access to the
> uninitialized stuff.  Imagine a suspend happens right after this
> point.  As the ops is already registered, it'll enter to the
> suspend_cb callback and straight to Oops.
> 
>> +static void __exit qc_usb_audio_offload_exit(void)
>> +{
>> +	struct uaudio_qmi_svc *svc = uaudio_svc;
>> +
>> +	qmi_handle_release(svc->uaudio_svc_hdl);
>> +	flush_workqueue(svc->uaudio_wq);
>> +	destroy_workqueue(svc->uaudio_wq);
>> +	kfree(svc);
>> +	uaudio_svc = NULL;
>> +	snd_usb_unregister_platform_ops();
> 
> Similarly, the unregister order has to be careful, too.
> 

Let me re-organize it a bit more.

Thanks
Wesley Cheng
