Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26CB75433C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjGNTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjGNTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF4B4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689363124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKxVQXvv2xifA277lsMm5CJovPA2ZC2bSr4vguNtNxo=;
        b=H3+BU5vhLJ7Feoc+tJeAg5cOtbfqOB73u5SYIZxSmTkOr5SV+FkKpyxpeU0t53B9m+LPE1
        F9lSsCi42u8u29KKK/V5KxVWe6S86VKwYfC4AiFZ7tK/tXG5QTXIRFsjBL9EpuZFTvkHe1
        YR/AkC6QPEfjyoKoF7DMsOjEI0P3/DM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-zz8auy8cNCipmfbbAeuQOQ-1; Fri, 14 Jul 2023 15:32:00 -0400
X-MC-Unique: zz8auy8cNCipmfbbAeuQOQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7866b037d4dso99506439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363119; x=1691955119;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKxVQXvv2xifA277lsMm5CJovPA2ZC2bSr4vguNtNxo=;
        b=WdLixQ1B6eBXBK1arrH3IzN7eSob3UpKGkANbUPvHikpKR9mCNhOHjSCKQaZPj7PlJ
         bO7TtdJogWnt1oYkJPo3ZOWq5o3ivvj7NcwDZ+mWjHrEDf/Ct/cGrUJh5QYVm9CcwLXf
         uL8R/dk2lpscTIzNmbWHMkXViGyFlZg6cKAj50Qvl2tyjaWmFFGCileSZCnOVCAwAS+T
         bXmtsqeMmldW7dppr8qWx5E9gyFQvGcXvzPCHSv8g2btMDvc9ce82iqh+t4DG6rvZv9Z
         G5BssJv8QQVkKwpTITFAEdlIeyHfsVINotvKW7ACNzKlxcEUvWgaC3s8l+Y130O5FrrL
         szwA==
X-Gm-Message-State: ABy/qLbOxWhDc1WT3MxszYV01y1ojNdqA7eFc0eYzDRDMUEmz/pmypeK
        tNEPbrVJKwjUvK87+6RjhaaHxtGcJ9S73ctJYRi9aa8Kk7F2A8mVbBhEAoylKqXrqkRX5vAmn0X
        H/1GtjZJAbabhe8mYttZXD32x
X-Received: by 2002:a5d:8897:0:b0:783:727b:7073 with SMTP id d23-20020a5d8897000000b00783727b7073mr5297460ioo.20.1689363119680;
        Fri, 14 Jul 2023 12:31:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdnKw4epFNpNmUmXDYSNIXBnhkkmj0pxQ/KnYRs6JyUKxyNNg/Cf2A8utgvw6R6/ieOShXUg==
X-Received: by 2002:a5d:8897:0:b0:783:727b:7073 with SMTP id d23-20020a5d8897000000b00783727b7073mr5297445ioo.20.1689363119425;
        Fri, 14 Jul 2023 12:31:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z2-20020a02cea2000000b004290f6c15bfsm2803545jaq.145.2023.07.14.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:31:58 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:31:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Roxana Bradescu <roxabee@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kvm/vfio: avoid bouncing the mutex when adding
 and deleting groups
Message-ID: <20230714133156.3e584eab.alex.williamson@redhat.com>
In-Reply-To: <20230714183800.3112449-2-dmitry.torokhov@gmail.com>
References: <20230714183800.3112449-1-dmitry.torokhov@gmail.com>
        <20230714183800.3112449-2-dmitry.torokhov@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 11:37:57 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Stop taking kv->lock mutex in kvm_vfio_update_coherency() and instead
> call it with this mutex held: the callers of the function usually
> already have it taken (and released) before calling
> kvm_vfio_update_coherency(). This avoid bouncing the lock up and down.
> 
> The exception is kvm_vfio_release() where we do not take the lock, but
> it is being executed when the very last reference to kvm_device is being
> dropped, so there are no concerns about concurrency.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: new patch.
> 
>  virt/kvm/vfio.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index cd46d7ef98d6..9868e7ccb5fb 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -122,8 +122,6 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
>  	bool noncoherent = false;
>  	struct kvm_vfio_group *kvg;
>  
> -	mutex_lock(&kv->lock);
> -
>  	list_for_each_entry(kvg, &kv->group_list, node) {
>  		if (!kvm_vfio_file_enforced_coherent(kvg->file)) {
>  			noncoherent = true;
> @@ -139,8 +137,6 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
>  		else
>  			kvm_arch_unregister_noncoherent_dma(dev->kvm);
>  	}
> -
> -	mutex_unlock(&kv->lock);
>  }
>  
>  static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
> @@ -157,7 +153,7 @@ static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
>  	/* Ensure the FD is a vfio group FD.*/
>  	if (!kvm_vfio_file_is_group(filp)) {
>  		ret = -EINVAL;
> -		goto err_fput;
> +		goto out_fput;
>  	}
>  
>  	mutex_lock(&kv->lock);
> @@ -165,30 +161,27 @@ static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
>  	list_for_each_entry(kvg, &kv->group_list, node) {
>  		if (kvg->file == filp) {
>  			ret = -EEXIST;
> -			goto err_unlock;
> +			goto out_unlock;
>  		}
>  	}
>  
>  	kvg = kzalloc(sizeof(*kvg), GFP_KERNEL_ACCOUNT);
>  	if (!kvg) {
>  		ret = -ENOMEM;
> -		goto err_unlock;
> +		goto out_unlock;
>  	}
>  
> -	kvg->file = filp;
> +	kvg->file = get_file(filp);
>  	list_add_tail(&kvg->node, &kv->group_list);
>  
>  	kvm_arch_start_assignment(dev->kvm);
>  	kvm_vfio_file_set_kvm(kvg->file, dev->kvm);
> -
> -	mutex_unlock(&kv->lock);
> -
>  	kvm_vfio_update_coherency(dev);
>  
> -	return 0;
> -err_unlock:
> +	ret = 0;

Nit, let's initialize ret = 0 when it's declared to avoid this.  Series
looks good to me otherwise.  Thanks,

Alex

> +out_unlock:
>  	mutex_unlock(&kv->lock);
> -err_fput:
> +out_fput:
>  	fput(filp);
>  	return ret;
>  }
> @@ -224,12 +217,12 @@ static int kvm_vfio_group_del(struct kvm_device *dev, unsigned int fd)
>  		break;
>  	}
>  
> +	kvm_vfio_update_coherency(dev);
> +
>  	mutex_unlock(&kv->lock);
>  
>  	fdput(f);
>  
> -	kvm_vfio_update_coherency(dev);
> -
>  	return ret;
>  }
>  

