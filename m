Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C452E810CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjLMIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F789A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702457046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qfqVQSJRAi4yLOOtJPJSCDtKhzln1Z+5pNkKF7qquFs=;
        b=S2BJL0ibHsu01h4lCM81At37tX0Vfy8uJmzWlM1zr+P7joZ8amP6uUg493ipByCCxcqE9V
        AoZ1cB8yJYHUAB/tlbrFIAXxGCHeeiDPqk/NMkbpN8r164OgkzwsVq3LmbQbgtHTcKCK8W
        YyZ6yDUCTJUmwYmYEn4kZsIbDM2+UH0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-JI1E2iIwPtCmQCW67nosig-1; Wed, 13 Dec 2023 03:44:04 -0500
X-MC-Unique: JI1E2iIwPtCmQCW67nosig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33342e25313so5672106f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457044; x=1703061844;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfqVQSJRAi4yLOOtJPJSCDtKhzln1Z+5pNkKF7qquFs=;
        b=u+VQ5lEYRfyALiopipnsv/zj1nIhV64UBCAyQ6liKMlrgFVZcfNporn5nSjn+Wdo5b
         zTQyfDtv/ECwRy90g+c8dim6wKTQKHnr/wRMI7lZ8LURZQMoJXlU2anS22jA00hq6uPG
         L0g3whrjxG4fYnIIs4nIRJ1R9VK2+hu31mJmFCFkW1OOJrxtm/OPuAgC2UzfgH476lz3
         Vlj7gY9LNdRPn43LRzb1TJ/+qXAeSTs7af72A1v//SbzIo76IIDVlOW4xrFxuKb06TlE
         9v0rdy+yeCi/FNTi2RFVAuumfD3+3NbVzryri3HMAVERrlYwmiZoshJ3BfgfeVWaUNyG
         LfBQ==
X-Gm-Message-State: AOJu0YySBHqK3ppXgp5mDLNSad77dLHe90oL/m9ONT9fsme1F/UosTtM
        TZnbi8tMofVjNZG9naAF38vkOwHXvXZunlsv1mfNzYSEUHHvtG5eRyQNpXxCaOdaJZilvzhAd+M
        P2/By0Fm5zbipVjCmxR48wGq9nxgyz2wH
X-Received: by 2002:a05:6000:194d:b0:333:e8d:99d8 with SMTP id e13-20020a056000194d00b003330e8d99d8mr3730300wry.36.1702457043777;
        Wed, 13 Dec 2023 00:44:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG88dmgge6yrjWrlgDuSdPh9cn2yZG5BY1u9wbP4iSYbFPi536vo12xDX0CrFJL3sRy/OLwXA==
X-Received: by 2002:a05:6000:194d:b0:333:e8d:99d8 with SMTP id e13-20020a056000194d00b003330e8d99d8mr3730286wry.36.1702457043179;
        Wed, 13 Dec 2023 00:44:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6e00:7e5:5f4d:f300:5d52? (p200300cbc7096e0007e55f4df3005d52.dip0.t-ipconnect.de. [2003:cb:c709:6e00:7e5:5f4d:f300:5d52])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00336421f1818sm194453wrv.112.2023.12.13.00.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 00:44:02 -0800 (PST)
Message-ID: <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
Date:   Wed, 13 Dec 2023 09:44:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
To:     David Stevens <stevensd@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20231211114346.1132386-1-stevensd@google.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231211114346.1132386-1-stevensd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.23 12:43, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 

Hi David,

> Add a wakeup event for when the balloon is inflating or deflating.
> Userspace can enable this wakeup event to prevent the system from
> suspending while the balloon is being adjusted. This allows
> /sys/power/wakeup_count to be used without breaking virtio_balloon's
> cooperative memory management.


Can you add/share some more details

> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++------
>   1 file changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1fe93e93f5bc..811d8937246a 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -119,6 +119,11 @@ struct virtio_balloon {
>   	/* Free page reporting device */
>   	struct virtqueue *reporting_vq;
>   	struct page_reporting_dev_info pr_dev_info;
> +
> +	/* State for keeping the wakeup_source active while adjusting the balloon */
> +	spinlock_t adjustment_lock;
> +	u32 adjustment_seqno;

Using a simple flag that gets set when updating the balloon size and 
test-and-clear when testing for changes should be easier to get.

bool adjustment_balloon_size_changed;

or sth like that.

> +	bool adjustment_in_progress;
>   };
>   
>   static const struct virtio_device_id id_table[] = {
> @@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
>   	queue_work(vb->balloon_wq, &vb->report_free_page_work);
>   }
>   
> +static void start_update_balloon_size(struct virtio_balloon *vb)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vb->adjustment_lock, flags);
> +	vb->adjustment_seqno++;
> +	if (!vb->adjustment_in_progress) {
> +		vb->adjustment_in_progress = true;
> +		pm_stay_awake(&vb->vdev->dev);
> +	}
> +	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
> +
> +	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
> +}
> +
> +static void end_update_balloon_size(struct virtio_balloon *vb, u32 seqno)
> +{
> +	spin_lock(&vb->adjustment_lock);
> +	if (vb->adjustment_seqno == seqno && vb->adjustment_in_progress) {
> +		vb->adjustment_in_progress = false;
> +		pm_relax(&vb->vdev->dev);
> +	}
> +	spin_unlock(&vb->adjustment_lock);
> +}
> +
>   static void virtballoon_changed(struct virtio_device *vdev)
>   {
>   	struct virtio_balloon *vb = vdev->priv;
> @@ -444,8 +474,7 @@ static void virtballoon_changed(struct virtio_device *vdev)
>   
>   	spin_lock_irqsave(&vb->stop_update_lock, flags);
>   	if (!vb->stop_update) {
> -		queue_work(system_freezable_wq,
> -			   &vb->update_balloon_size_work);
> +		start_update_balloon_size(vb);
>   		virtio_balloon_queue_free_page_work(vb);
>   	}
>   	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> @@ -473,22 +502,29 @@ static void update_balloon_size_func(struct work_struct *work)
>   {
>   	struct virtio_balloon *vb;
>   	s64 diff;
> +	u32 seqno;
>   
>   	vb = container_of(work, struct virtio_balloon,
>   			  update_balloon_size_work);
> -	diff = towards_target(vb);
>   
> -	if (!diff)
> -		return;
> +	spin_lock(&vb->adjustment_lock);
> +	seqno = vb->adjustment_seqno;
> +	spin_unlock(&vb->adjustment_lock);
>   
> -	if (diff > 0)
> -		diff -= fill_balloon(vb, diff);
> -	else
> -		diff += leak_balloon(vb, -diff);
> -	update_balloon_size(vb);
> +	diff = towards_target(vb);
> +
> +	if (diff) {
> +		if (diff > 0)
> +			diff -= fill_balloon(vb, diff);
> +		else
> +			diff += leak_balloon(vb, -diff);
> +		update_balloon_size(vb);
> +	}
>   
>   	if (diff)
>   		queue_work(system_freezable_wq, work);
> +	else
> +		end_update_balloon_size(vb, seqno);

What if we stop the workqueue and unload the driver -- see 
remove_common() -- won't you leave pm_stay_awake() wrongly set?

>   }
>   
>   static int init_vqs(struct virtio_balloon *vb)
> @@ -992,6 +1028,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>   			goto out_unregister_oom;
>   	}
>   
> +	spin_lock_init(&vb->adjustment_lock);
> +	device_set_wakeup_capable(&vb->vdev->dev, true);


I'm a bit confused: Documentation/driver-api/pm/devices.rst documents

"
The :c:member:`power.can_wakeup` flag just records whether the device 
(and its driver) can physically support wakeup events.  The
:c:func:`device_set_wakeup_capable()` routine affects this flag.
"

...

"
Whether or not a device is capable of issuing wakeup events is a 
hardware matter, and the kernel is responsible for keeping track of it.
"

But how is the virtio-balloon device capable of waking up the machine? 
Your patch merely implies that the virtio-baloon device is capable to 
prohbit going to sleep.

What am I missing?

-- 
Cheers,

David / dhildenb

