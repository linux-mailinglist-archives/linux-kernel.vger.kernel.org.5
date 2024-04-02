Return-Path: <linux-kernel+bounces-128216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6D8957B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C78528523B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFE12BF37;
	Tue,  2 Apr 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv4LJepa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3786128
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070312; cv=none; b=ixIWx0dwy71qniwJXnjHMS0cX7hCfJhOJRELvlAxGHDvI8sHRS04rk0byQFUSlxX96OCqVT9zpAdiI0QMi5uZ6LpygeN1qNVj7O9L/t04d84CThWmv5kAnAJLrXWXTejyAVKhrECChr6EbA11TLBeBQ64kDMmcVFT6JN7cqtuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070312; c=relaxed/simple;
	bh=0zgHtiVe8xYLLsFCLpEBlvHEkoV6cJVT1KEvui+GKzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0ffgIAXOn5Pf9clKp3jJIEqAC3eqtxVwTL4XjJapkwQ7UxXS90Jz/leHPTvKewDKczMEXO9l0difSAa4EGGvKG2DfBH44xxpjIew55X36R9mkEI88b5FFmdlyyLJh5Gb53IxcZ8WpGasF4gdTepFrPkPOZ15WkC9WwSH4WqPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv4LJepa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712070310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLq2tKtQyU+Xs0r4v3F/+9g6JN1kAENgWuL95Uf8uiI=;
	b=Sv4LJeparFXwEEaHSGPZ+pOCRBYknDee5bSw0+QKxopDIUmqb885BSqevy7SmtLTShJ/Z/
	v4ILnAE5caWXbBSvYrXpPMdrTMMIHRsSyaRiZW05rxnAxOQ23MOofFXowIoLbii9za/PSz
	ycdw/Km5at2G6Q0/YvWyWn9+sUHXRvs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-A_W73WPmO7qZ77IfUZ03iA-1; Tue, 02 Apr 2024 11:05:08 -0400
X-MC-Unique: A_W73WPmO7qZ77IfUZ03iA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a450265c7b6so282745566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 08:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712070307; x=1712675107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLq2tKtQyU+Xs0r4v3F/+9g6JN1kAENgWuL95Uf8uiI=;
        b=p0b4sCeR81MOut8/bY2onKCjyBWY7mDJpfFHCdjfF6iMVjNOjDw22qTzajDSkEr7g5
         N1jrgj7Z7W4sMSBgbgLLYUrggyBYlzr3IiYXnUbTY9joykwIxSikHZdfGvNQM6HzHqhP
         p9uhJzp7xXRGNB1AARliEmFMiJdZo4rUcpTYO7glbT5D1hveWq38ZU5BBUX4BLL9uFiP
         nvD8BSUzfGeXJYwhuU/tF6U1g2hvGuCEZMtV31sZ1AUkx/3lUy1mcAf5lXX663Ne7YWu
         AdtYKXTZ4XBlrEyPpOTQF63KPQXnyr6FKgcoxUA4YgLEdPOm6lEO38yeJ1JZYrZWd6NF
         ZBNA==
X-Forwarded-Encrypted: i=1; AJvYcCXQjFUk/x/AwJ5fJKQPSlgMPcWQ20Cf0YSRG1g25mk2sTq1vnlOAqOZOhV6tXi6y03skja+f959L2oVKQrnE0PVpQfyHWDbxj8LRXvE
X-Gm-Message-State: AOJu0YyGC5OAWQrB4TUVH3gYGXGbB0RKMlVnGxz/NMOcLMRCY3Q4qPGY
	S1cn9sGB3Ig9GLIdfHMhweSkDYXvreqEHqe+yfSV0Q8z8kydHe91dIu/DMN8+Kfj1lpZeM6bTGB
	1qaZCFs0IJuvlaO1PlK4jXxK/ddSyTmMfA5aEG/aQZoeEbqvn/4MdkhBJVSrqYA==
X-Received: by 2002:a17:906:6152:b0:a4c:de71:54f7 with SMTP id p18-20020a170906615200b00a4cde7154f7mr8156484ejl.27.1712070307206;
        Tue, 02 Apr 2024 08:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErvFV/CA6M7Wb3IGxb9REEDxn3nHfFMnRbiWOefA61noi+7+L9ilwruGial88ntKLm0HuCtA==
X-Received: by 2002:a17:906:6152:b0:a4c:de71:54f7 with SMTP id p18-20020a170906615200b00a4cde7154f7mr8156459ejl.27.1712070306609;
        Tue, 02 Apr 2024 08:05:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id ga13-20020a1709070c0d00b00a473f5ac943sm6588626ejc.37.2024.04.02.08.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:05:06 -0700 (PDT)
Message-ID: <12fc7d61-54c0-4089-b885-1ae124708ae6@redhat.com>
Date: Tue, 2 Apr 2024 17:05:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] drm/vboxvideo: fix mapping leaks
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>,
 dakr@redhat.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 stable@kernel.vger.org
References: <20240328175549.GA1574238@bhelgaas>
 <ffe0e534166f14483d0a6a37342136b7aec9c850.camel@redhat.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ffe0e534166f14483d0a6a37342136b7aec9c850.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/2/24 3:50 PM, Philipp Stanner wrote:
> On Thu, 2024-03-28 at 12:55 -0500, Bjorn Helgaas wrote:
>> On Fri, Mar 01, 2024 at 12:29:58PM +0100, Philipp Stanner wrote:
>>> When the PCI devres API was introduced to this driver, it was
>>> wrongly
>>> assumed that initializing the device with pcim_enable_device()
>>> instead
>>> of pci_enable_device() will make all PCI functions managed.
>>>
>>> This is wrong and was caused by the quite confusing PCI devres API
>>> in
>>> which some, but not all, functions become managed that way.
>>>
>>> The function pci_iomap_range() is never managed.
>>>
>>> Replace pci_iomap_range() with the actually managed function
>>> pcim_iomap_range().
>>>
>>> CC: <stable@kernel.vger.org> # v5.10+
>>
>> This is marked for stable but depends on the preceding patches in
>> this
>> series, which are not marked for stable.
>>
>> The rest of this series might be picked up automatically for stable,
>> but I personally wouldn't suggest backporting it because it's quite a
>> lot of change and I don't think it fits per
>> Documentation/process/stable-kernel-rules.rst.
> 
> I agree, if I were a stable maintainer I wouldn't apply it.
> I just put them in CC so that they can make this decision themselves.
> 
>> So I think the best way to fix the vboxvideo leaks would be to fix
>> them independently of this series, then include as a separate patch a
>> conversion to the new pcim_iomap_range() in this series (or possibly
>> for the next merge window to avoid merge conflicts).
> 
> It is hard to fix independently of our new devres utility.
> Reason being that it's _impossible_ to have partial BAR mappings *with*
> the current PCI devres API.
> 
> Consequently, a portable vboxvideo would have to revert the entire
> commit 8558de401b5f and become an unmanaged driver again.
> 
> I guess you could do a hacky fix where the regions are handled by
> devres and the mappings are created and destroyed manually with
> pci_iomap_range() – but do we really want that...?
> 
> The leak only occurs when driver and device detach, so how often does
> that happen... and as far as I can tell it's also not an exploitable
> leak, so one could make the decision to just leave it in the stable
> kernels...
> 
> @Hans:
> What do you say?

In practice this has never been a problem, so I suggest we just drop
the Cc: stable .

Regards,

Hans




>>> Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>>> ---
>>>  drivers/gpu/drm/vboxvideo/vbox_main.c | 20 +++++++++-----------
>>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c
>>> b/drivers/gpu/drm/vboxvideo/vbox_main.c
>>> index 42c2d8a99509..d4ade9325401 100644
>>> --- a/drivers/gpu/drm/vboxvideo/vbox_main.c
>>> +++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
>>> @@ -42,12 +42,11 @@ static int vbox_accel_init(struct vbox_private
>>> *vbox)
>>>         /* Take a command buffer for each screen from the end of
>>> usable VRAM. */
>>>         vbox->available_vram_size -= vbox->num_crtcs *
>>> VBVA_MIN_BUFFER_SIZE;
>>>  
>>> -       vbox->vbva_buffers = pci_iomap_range(pdev, 0,
>>> -                                            vbox-
>>>> available_vram_size,
>>> -                                            vbox->num_crtcs *
>>> -                                            VBVA_MIN_BUFFER_SIZE);
>>> -       if (!vbox->vbva_buffers)
>>> -               return -ENOMEM;
>>> +       vbox->vbva_buffers = pcim_iomap_range(
>>> +                       pdev, 0, vbox->available_vram_size,
>>> +                       vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE);
>>> +       if (IS_ERR(vbox->vbva_buffers))
>>> +               return PTR_ERR(vbox->vbva_buffers);
>>>  
>>>         for (i = 0; i < vbox->num_crtcs; ++i) {
>>>                 vbva_setup_buffer_context(&vbox->vbva_info[i],
>>> @@ -116,11 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
>>>         DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
>>>  
>>>         /* Map guest-heap at end of vram */
>>> -       vbox->guest_heap =
>>> -           pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
>>> -                           GUEST_HEAP_SIZE);
>>> -       if (!vbox->guest_heap)
>>> -               return -ENOMEM;
>>> +       vbox->guest_heap = pcim_iomap_range(pdev, 0,
>>> +                       GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
>>> +       if (IS_ERR(vbox->guest_heap))
>>> +               return PTR_ERR(vbox->guest_heap);
>>>  
>>>         /* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
>>>         vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4,
>>> -1,
>>> -- 
>>> 2.43.0
>>>
>>
> 


