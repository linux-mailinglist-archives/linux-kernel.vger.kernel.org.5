Return-Path: <linux-kernel+bounces-158029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CA8B1A66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A8D1F223C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0B3C097;
	Thu, 25 Apr 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z0pDTZgx"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E43BBEA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023689; cv=none; b=sLKK7yGhS7dCBWwpRWOHnpr/+HIxA0fVBUggnOYCGNmXg2m9BgfZA6RQNl6JjIc2kLHH4527m0WTOpMok8FIIKmMyye0UKhQRW9Sf+ZYislMW9kWrY62LVKM5dLvi/Uij82oHzSxljymRPWfpr0oLEXijpWiDDRNVThTKHQbiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023689; c=relaxed/simple;
	bh=EJTC3wowI1j2u2TKzcLePfke7haCbSp9UOfnO38aLsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr15xLxMrpFXf+UYgNpUipC0YM8ePnve5/pertBm7TI2Yw8w6fyJABpFUUKwcJdLEiCuO0/VmswnyDx5TYN3Rezk1Emws6QHnFFpPZcaOEvZGTlSUIqVVHOdLb4PHUpbpedlH/1OSd0h9bxwMXnSHQWyLUtMZcNV0/S/MtZOooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z0pDTZgx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecff9df447so638644b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714023687; x=1714628487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiVVv+CXcN+CvM+zB+3igsIJaaE0zH8C5SDY181CcQk=;
        b=Z0pDTZgxcfwcesXia1wJRS9dt9hJ40n7xfQfhvhIvateALKUbfdTJpwZV2HRcQtO4q
         4+QnDt/wYZEjcw2CToBQ6pXYEhQQ8QhCR/T+W6h+jV08oiysmY8tjPBiXYhrLTrml69r
         cjh68P9+NuBDtifHELS9ofoANW0QvBvSEDMK9RH1iI3LrsDiMHYbwnZI4uuSf/tdMbmC
         bn2V39ZMkwQa2kBhv4eNeM2IobLGyOSKCNa1vYsLA/BxBu2fZ6lIvEef9usvCJbyQ0Oy
         yHQq+0PUEnptnT/m3/AMLzHZoAX/fAN+x14/acGlnArhiGX65Sj3h8vHA9fMmMMJ2Nyv
         l44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023687; x=1714628487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiVVv+CXcN+CvM+zB+3igsIJaaE0zH8C5SDY181CcQk=;
        b=IYcCbGHCZqxkR/9mHTAzHT2y6eYuXTkOdVEbm7rpkb/6lk4XG8VhjsPDlAE3LZqOFc
         nQPs5p2SY4v5fk/ob9n50/IbmGKbdHkTyNm+zROvcdc7JJb7WSpwClebzjC2iON+JGcC
         xVnBBJD0FbgjWTlCRX6pTi9beTULDcTHw8k2x0LrVRevePao24xYMUj6RM6+ly5IMaPL
         0oeSX+zvUFXbOYyx1pNNUyKsmQhuyY2geIhyceH1r4ry8DzLhf+6GI0AnMeypHaVBksF
         ogGb52sW93s1wIYF/MzCZbKHhMDf1M7IG5OJz91Ss5pjhKV9OSgInI1ZJ6ZPUMVvFBca
         GTgA==
X-Forwarded-Encrypted: i=1; AJvYcCWu+zmi9pv9zvqvXMUJGT3Chd1NOLW6Lr+1eLv0zTCg47gQJ/aNs+mg3m27jIIrsXaIBVW1dUVByv8XuM/JRnc4tUkWVKve+NBYrWCt
X-Gm-Message-State: AOJu0Ywxijq0MvmmloRcxU3dn1jGuhDTmDQ7vC0Qz71ldNrNXk0L62VD
	/rRoyud6zEJ/ea+0KXEn+R+9qXHZrAvYDlJO1Nk81HuoYEgpBjunodaDyWuWoP7X+7vYgha2IL3
	4
X-Google-Smtp-Source: AGHT+IHNJBsklbaNtuhephdNcHI3SdblGcDt0X5IXkyJ+9Sg3RqlYnd4/Js8ZPm7qlkq9lbveXh7Sg==
X-Received: by 2002:a05:6a00:1492:b0:6ed:1c7:8c5d with SMTP id v18-20020a056a00149200b006ed01c78c5dmr5655256pfu.12.1714023687307;
        Wed, 24 Apr 2024 22:41:27 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm12333974pfr.38.2024.04.24.22.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:41:26 -0700 (PDT)
Message-ID: <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
Date: Thu, 25 Apr 2024 13:41:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cachefiles: flush ondemand_object_worker during clean
 object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>, Baokun Li <libaokun1@huawei.com>,
 zhujia.zj@bytedance.com
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-4-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033409.2735257-4-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for catching this. How about adding a Fixes tag.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>


在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
> From: Hou Tao <houtao1@huawei.com>
> 
> When queuing ondemand_object_worker() to re-open the object,
> cachefiles_object is not pinned. The cachefiles_object may be freed when
> the pending read request is completed intentionally and the related
> erofs is umounted. If ondemand_object_worker() runs after the object is
> freed, it will incur use-after-free problem as shown below.
> 
> process A  processs B  process C  process D
> 
> cachefiles_ondemand_send_req()
> // send a read req X
> // wait for its completion
> 
>             // close ondemand fd
>             cachefiles_ondemand_fd_release()
>             // set object as CLOSE
> 
>                         cachefiles_ondemand_daemon_read()
>                         // set object as REOPENING
>                         queue_work(fscache_wq, &info->ondemand_work)
> 
>                                  // close /dev/cachefiles
>                                  cachefiles_daemon_release
>                                  cachefiles_flush_reqs
>                                  complete(&req->done)
> 
> // read req X is completed
> // umount the erofs fs
> cachefiles_put_object()
> // object will be freed
> cachefiles_ondemand_deinit_obj_info()
> kmem_cache_free(object)
>                         // both info and object are freed
>                         ondemand_object_worker()
> 
> When dropping an object, it is no longer necessary to reopen the object,
> so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
> to complete.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/cachefiles/ondemand.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index d24bff43499b..f6440b3e7368 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -589,6 +589,9 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   		}
>   	}
>   	xa_unlock(&cache->reqs);
> +
> +	/* Wait for ondemand_object_worker() to finish to avoid UAF. */
> +	cancel_work_sync(&object->ondemand->ondemand_work);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

