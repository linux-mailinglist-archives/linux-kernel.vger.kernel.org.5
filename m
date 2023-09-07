Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6447797470
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjIGPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345107AbjIGPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146B19B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694100759;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LglCnmsSm9cwfpFlqnr7JUE1NH9ptGkqmJUAdBvVp8g=;
        b=OkWl80waTV2LNHxfFIYkmzBF4kkG8Pr+cRQyZuR27b0l92hV1oJLEYV0NK7rcpBOhBPqww
        x/EqkihQs2RoMntcA23HatByLtAdW2myHqCzBzM522WAcekJuJdyw6hYrcUcDFAGyUbHmf
        ScruYbUyoQ/te2F+Or3saTTdpBTTNtk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-RLyOm8lNMGKJWDleATDsbw-1; Thu, 07 Sep 2023 10:21:24 -0400
X-MC-Unique: RLyOm8lNMGKJWDleATDsbw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31aea5cf0f5so697728f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 07:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694096482; x=1694701282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LglCnmsSm9cwfpFlqnr7JUE1NH9ptGkqmJUAdBvVp8g=;
        b=VpG50NKH06LMwHajVSglFIl3RWLth+uiaQaOyc0ZpM1yrVnkwPlhQXprEtcVO2IJN9
         ioDhgZsHvwzr5wTnOTi4eCyhJtqT4H9BPSzawSrHMwMBL54sgb9fE70nrbWacPjVgDzR
         eZHhMJ2S8ZA/DvR6utFN1xal5DqdICZp2J4T5fp3TTlxqudd+1yPiZnr+Dru2GbzRkIu
         Bdz3aEV/JPQOjUtcON8aKWzBIcpyRJ2VNd52XX34/CjRIP0KcmGeImNMROYnTBMLbJyw
         k4Iis2uDSH3c6KTopdJByY/zChL3I07+QU36gOGWXrnkxtQYY0QDrFgb6ql5Blbnr19G
         4jFw==
X-Gm-Message-State: AOJu0YxVT7F10/ScN9zV+YPv9GsfrCGIZAoMUqqYIBzDcIq7/ftxnCv3
        dn/onEFgOfttSS+SNdjTBXPtMOg4ZsRDU22C6AcKBFY11R1y/7arVMsP2fTd3xBs25l4IKenV0b
        JDnsfbACwzkHVbGBj6jyeYgRlJjS3qL4E
X-Received: by 2002:a5d:654d:0:b0:317:1b08:b317 with SMTP id z13-20020a5d654d000000b003171b08b317mr4766224wrv.6.1694096482617;
        Thu, 07 Sep 2023 07:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+wAZoGUFZ5L33EjPRRR6PH6ZBIxSFyJkTnzLHNd+ONfr0VBusQvOVWFfA3E7tbWAyv3/9Nw==
X-Received: by 2002:a5d:654d:0:b0:317:1b08:b317 with SMTP id z13-20020a5d654d000000b003171b08b317mr4766198wrv.6.1694096482246;
        Thu, 07 Sep 2023 07:21:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f12-20020adffccc000000b003143c9beeaesm23365778wrs.44.2023.09.07.07.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 07:21:21 -0700 (PDT)
Message-ID: <e28cd056-9b54-1e5d-7602-c5acfc7f4ea7@redhat.com>
Date:   Thu, 7 Sep 2023 16:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
 <20230904153403.GB815284@myrica>
 <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
 <ba38b6d90e1f24f249ed8a18e65c403be6ff90e9.camel@linux.ibm.com>
 <20230906132031.GA1528947@myrica>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230906132031.GA1528947@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/6/23 15:20, Jean-Philippe Brucker wrote:
> On Wed, Sep 06, 2023 at 09:55:49AM +0200, Niklas Schnelle wrote:
>> On Mon, 2023-09-04 at 17:33 +0100, Robin Murphy wrote:
>>> On 2023-09-04 16:34, Jean-Philippe Brucker wrote:
>>>> On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
>>>>> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
>>>>> dma-iommu deferred flush scheme. This results inn a significant increase
>>>> in
>>>>
>>>>> in performance in exchange for a window in which devices can still
>>>>> access previously IOMMU mapped memory. To get back to the prior behavior
>>>>> iommu.strict=1 may be set on the kernel command line.
>>>> Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
>>>> well, because I've seen kernel configs that enable either.
>>> Indeed, I'd be inclined phrase it in terms of the driver now actually 
>>> being able to honour lazy mode when requested (which happens to be the 
>>> default on x86), rather than as if it might be some 
>>> potentially-unexpected change in behaviour.
>>>
>>> Thanks,
>>> Robin.
>> I kept running this series on a KVM guest on my private workstation
>> (QEMU v8.0.4) and while running iperf3 on a passed-through Intel 82599
>> VF. I got a bunch of IOMMU events similar to the following as well as
>> card resets in the host.
>>
>> ..
>> [ 5959.338214] vfio-pci 0000:04:10.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0037 address=0x7b657064 flags=0x0000]
>> [ 5963.353429] ixgbe 0000:03:00.0 enp3s0: Detected Tx Unit Hang
>>                  Tx Queue             <0>
>>                  TDH, TDT             <93>, <9d>
>>                  next_to_use          <9d>
>>                  next_to_clean        <93>
>>                tx_buffer_info[next_to_clean]
>>                  time_stamp           <10019e800>
>>                  jiffies              <10019ec80>
>> ...
>>
>> I retested on v6.5 vanilla (guest & host) and still get the above
>> errors so luckily for me it doesn't seem to be caused by the new code
>> but I can't reproduce it without virtio-iommu. Any idea what could
>> cause this?
> Adding Eric in case this looks familiar.
Unfortunately no idea of what could cause those page faults. On ther
other hand I mostly test on ARM and INTEL.

Thanks

Eric
>
> I don't have hardware to test this but I guess QEMU system emulation may
> be able to reproduce the issue since it has an AMD IOMMU (unmaintained)
> and igb, I can give that a try.
>
> Thanks,
> Jean
>
>>>>> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
>>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>>> ---
>>>>>   drivers/iommu/virtio-iommu.c | 12 ++++++++++++
>>>>>   1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>>>>> index fb73dec5b953..1b7526494490 100644
>>>>> --- a/drivers/iommu/virtio-iommu.c
>>>>> +++ b/drivers/iommu/virtio-iommu.c
>>>>> @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>>>>>   	return viommu_sync_req(vdomain->viommu);
>>>>>   }
>>>>>   
>>>>> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
>>>>> +{
>>>>> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
>>>>> +
>>>>> +	if (!vdomain->nr_endpoints)
>>>>> +		return;
>>>> As for patch 1, a NULL check in viommu_sync_req() would allow dropping
>>>> this one
>>>>
>>>> Thanks,
>>>> Jean
>> Right, makes sense will move the check into viommu_sync_req() and add a
>> coment that it is there fore the cases where viommu_iotlb_sync() et al
>> get called before the IOMMU is set up.
>>
>>>>> +	viommu_sync_req(vdomain->viommu);
>>>>> +}
>>>>> +
>>>>>   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>>>>>   {
>>>>>   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
>>>>> @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>>>>>   	switch (cap) {
>>>>>   	case IOMMU_CAP_CACHE_COHERENCY:
>>>>>   		return true;
>>>>> +	case IOMMU_CAP_DEFERRED_FLUSH:
>>>>> +		return true;
>>>>>   	default:
>>>>>   		return false;
>>>>>   	}
>>>>> @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>>>>>   		.map_pages		= viommu_map_pages,
>>>>>   		.unmap_pages		= viommu_unmap_pages,
>>>>>   		.iova_to_phys		= viommu_iova_to_phys,
>>>>> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>>>>>   		.iotlb_sync		= viommu_iotlb_sync,
>>>>>   		.iotlb_sync_map		= viommu_iotlb_sync_map,
>>>>>   		.free			= viommu_domain_free,
>>>>>
>>>>> -- 
>>>>> 2.39.2
>>>>>

