Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE578311F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHUTvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHUTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:51:01 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F8FD;
        Mon, 21 Aug 2023 12:51:00 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68a56401b9aso758613b3a.1;
        Mon, 21 Aug 2023 12:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647459; x=1693252259;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xx5Uthgldx00An2/L6ejuAbCLX0Oztz/EL/6IJtQiIs=;
        b=QMkRU04FfAufVI4zmlgq7pyHbkesIRifEx4Pb7VIvaE72fQc2t0+o3/qIez6JhjMSU
         m/SQrg5MG+ZuJ8arTx+JJ7eQ9+CevcBEE4n5gGhm+mV4vmRcRKslM0ev3u1qklkWMw3I
         Bp8D7n5A3+sl8a5ZrV8W+QZHUpoWp3CeCBqPJSSw7/CBi52VQAVsF3bYOUUSDDc4uBtE
         uPM7/1pIb/HkGnvhtkoCZYERqyFE69TDwEit9IkhxS25pJETCu4iTBuJ7jd3z/40SA/W
         i5m1MJYaLZPFY2VHuIIPm2W8pT5Px4z4o40NUcYSM1gSywVwPnU/7x7o6PY6FoQJKaZF
         G9kQ==
X-Gm-Message-State: AOJu0Yy15mb6GMAzy2rDX/PWIBhJWxTqcWpPvhEV/UTinDawzuBY327C
        ntLDKmyn63EDBBoDe0sqHwg=
X-Google-Smtp-Source: AGHT+IFPsthbkyU8yghE0Hqd5iE5QOP15RmMlYWL8ipmJSQdr5giU4o4ZbDJLuJ1Jd/K1fUF/2B4Lw==
X-Received: by 2002:a05:6a21:3e01:b0:13e:fe55:b99f with SMTP id bk1-20020a056a213e0100b0013efe55b99fmr5088264pzc.56.1692647459311;
        Mon, 21 Aug 2023 12:50:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ef58:6534:ec7a:8ab2? ([2620:15c:211:201:ef58:6534:ec7a:8ab2])
        by smtp.gmail.com with ESMTPSA id l9-20020a635b49000000b00565dd935938sm6640860pgm.85.2023.08.21.12.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 12:50:58 -0700 (PDT)
Message-ID: <baecaad7-7124-b9ae-ab79-1b7c6fa95c98@acm.org>
Date:   Mon, 21 Aug 2023 12:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next] scsi: core: fix double free in raid_component_add()
Content-Language: en-US
To:     Zhu Wang <wangzhu9@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dan.carpenter@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230819080345.149144-1-wangzhu9@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230819080345.149144-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/23 01:03, Zhu Wang wrote:
> Previous commit 04b5b5cb0136 ("scsi: core: Fix possible memory leak if
> device_add() fails") introduced a double free when device_add() failed.
> When device_add() failed, the put_device(&rc->dev) is called, which will
> call raid_component_release(), and this function will call
> put_device(rc->dev.parent) and kfree(rc), but in the error path of
> raid_component_release() above two functions are called again, so 'rc' are
> freed twice.
> 
> We do not just revert the patch, since the memory allocated by
> dev_set_name() is not released in the error path, it should be released
> through calling put_device(&rc->dev) which will call kobject_cleanup(),
> and the device name will be released in it. Though the commit 04b5b5cb0136
> ("scsi: core: Fix possible memory leak if device_add() fails") fixed the
> memory leak, it didn't consider the double free problem. We removed
> put_device(rc->dev.parent) and kfree(rc) in the error path, and we moved
> put_device(&rc->dev) after rd->component-count--, since after
> put_device(&rc->dev) is called, 'rc' is freed, so list_del(&rc->node)
> cannot be called again.
> 
> Fixes: 04b5b5cb0136 ("scsi: core: Fix possible memory leak if device_add() fails")
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> ---
>   drivers/scsi/raid_class.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
> index 711252e52d8e..86ed1f66d749 100644
> --- a/drivers/scsi/raid_class.c
> +++ b/drivers/scsi/raid_class.c
> @@ -248,11 +248,9 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
>   	return 0;
>   
>   err_out:
> -	put_device(&rc->dev);
>   	list_del(&rc->node);
>   	rd->component_count--;
> -	put_device(component_dev);
> -	kfree(rc);
> +	put_device(&rc->dev);
>   	return err;
>   }
>   EXPORT_SYMBOL(raid_component_add);

Please consider replacing the above patch by the patch below:

[PATCH] scsi: Remove raid_component_add()

The raid_component_add() function was added to the kernel tree via
patch "[SCSI] embryonic RAID class" (2005). Remove this function since
it never has had any callers in the Linux kernel.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/scsi/raid_class.c  | 38 --------------------------------------
  include/linux/raid_class.h |  4 ----
  2 files changed, 42 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 898a0bdf8df6..99f806d1d317 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -218,44 +218,6 @@ static void raid_component_release(struct device *dev)
  	kfree(rc);
  }

-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
  struct raid_template *
  raid_class_attach(struct raid_function_template *ft)
  {
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 6a9b177d5c41..e50416ba9cd9 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,7 +77,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, state)
  	
  struct raid_template *raid_class_attach(struct raid_function_template *);
  void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-



