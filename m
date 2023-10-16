Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9AA7CA069
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjJPHTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJPHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0EE3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697440691;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMH50QiNx/RpA27e+HDzQ/UaGOzrlDiikAqZXGGX460=;
        b=Vyru7MUzdBs0oCRtlD4H//QT/x3vDD9nRYtBJPzX1oStNSOFVCyIakzEpyfqY+L3kyRezA
        cZrFfPV/f3kTI2ERFlBccAez/igT3jiVC1KpKqDSp4KDKjjkmGuSIq3veAUeUrxaEl64aU
        gKa9KZcaWaMJ6q8trOK6KUvlIX0wxpI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-isGz_7-MNo6vg2ajm3tdmg-1; Mon, 16 Oct 2023 03:18:10 -0400
X-MC-Unique: isGz_7-MNo6vg2ajm3tdmg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-457dc70bba9so375990137.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440689; x=1698045489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMH50QiNx/RpA27e+HDzQ/UaGOzrlDiikAqZXGGX460=;
        b=Squ+33U96juM9mRUOpoJsukQ17KqDmlDXwUwIbzmgbKFQYZs2VLQ43qo9kJAU7qvhL
         kDVB1xR4HfOUadqxPl3MGXNyFe/0cwFD/A7arm/aYwsCJxhKjFKLoDguGyYzCMDiEhuK
         9ppQ+RPqdy10f+X/tYjuRcSMTRxBdiPZ5HGYpm8eSFWX6K3pyXI05j20eTfhrfUjWX1B
         c+g/VG5QfGjsjxfcSTeK7zrbhbEZMuKqkewVntdUkTh7vDwtSGVADT8TXb4fpjHtb3a3
         IxkgCDS9oSvt4hYiHCOJ+GhC95p+vORKZr5JAFjUDcmRoFz5pS3I1um393LHntgXd038
         TUcw==
X-Gm-Message-State: AOJu0YzywOj9csV8iL9f3qpMX8gtNApJcggEWA2zA7u3l2CUzCle//jG
        O/xMJvhDxM1lUZeHHdsgEPu8/NMPKRStdiPZkRyucWfPGadXNEhrciWii0M6PknDhRUmCLfgrcH
        3Ab0eC1oO6EG3zMyd2Z+ito9t
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id c8-20020a056102318800b00457b01c4a8emr8522089vsh.7.1697440689466;
        Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrYKoQ8rnr5V8nFuKW8RRuaP7a7IwQbOXpJHv3bolS3RrOuy5SapWm+qgVLdmd8Y1bvVE4YA==
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id c8-20020a056102318800b00457b01c4a8emr8522084vsh.7.1697440689214;
        Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p17-20020ae9f311000000b00772662b7804sm2784186qkg.100.2023.10.16.00.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 00:18:08 -0700 (PDT)
Message-ID: <6b9b570c-8d73-eb64-40a7-fe7492e68be5@redhat.com>
Date:   Mon, 16 Oct 2023 09:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [RESEND PATCH v2] vhost: Allow null msg.size on
 VHOST_IOTLB_INVALIDATE
Content-Language: en-US
To:     eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
        jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvmarm@lists.linux.dev
Cc:     stable@vger.kernel.org
References: <20230927140544.205088-1-eric.auger@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230927140544.205088-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/23 16:05, Eric Auger wrote:
> Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
> entries") Forbade vhost iotlb msg with null size to prevent entries
> with size = start = 0 and last = ULONG_MAX to end up in the iotlb.
>
> Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
> only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
> message types to fix a regression observed with batching hit.
>
> Still, the introduction of that check introduced a regression for
> some users attempting to invalidate the whole ULONG_MAX range by
> setting the size to 0. This is the case with qemu/smmuv3/vhost
> integration which does not work anymore. It Looks safe to partially
> revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
> with null size. vhost_iotlb_del_range() will compute a correct end
> iova. Same for vhost_vdpa_iotlb_unmap().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
> Cc: stable@vger.kernel.org # v5.17+
> Acked-by: Jason Wang <jasowang@redhat.com>
Gentle Ping.

Thanks

Eric
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c71d573f1c94..e0c181ad17e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		goto done;
>  	}
>  
> -	if ((msg.type == VHOST_IOTLB_UPDATE ||
> -	     msg.type == VHOST_IOTLB_INVALIDATE) &&
> -	     msg.size == 0) {
> +	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
>  		ret = -EINVAL;
>  		goto done;
>  	}

