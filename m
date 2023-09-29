Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54D7B3A24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjI2Sl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjI2Sl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231AC19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696012835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBk17Zm5TcRZSPAJIt6L6fahmLzkpIUYt8FtZjTtkgw=;
        b=OxFL3CxMD1QRpn2b8vzbXszQY4Q31Wz36Oxlj1dtHo9wpNM6ScWY/klOi3HZIlFaRCcByg
        EtEv+sJ1ZmDD8yByP5tv2aTIKzt5ZJWQ2tT+oBsUmL7exIrdWcavswEVBSC10wKiGej0UQ
        q68WRK5+fGhhGf+GBDzvIj5tpfwMyyw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-5avktyzmNEeDg947-6ZUDg-1; Fri, 29 Sep 2023 14:40:33 -0400
X-MC-Unique: 5avktyzmNEeDg947-6ZUDg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4197fa36adaso7939041cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012833; x=1696617633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBk17Zm5TcRZSPAJIt6L6fahmLzkpIUYt8FtZjTtkgw=;
        b=gFzFy55W7kPYqRXKY0/vcD/ROLMAaFBefozIZP1H+0V63aPsaQzWYVNvPiYvMj4+1Y
         DGnqy87xxeLg9vLqqKQyCSD4Qyj1n5wIF1U7Avm6qFWNSefnpYwcNlfiGmOvoKg8Lfk3
         Jb0V3QtbI5KCUG4nMvAdngM1fgtY3fabNKQQK9IS3fgPVuv4IfxFezT8JNXsTn4QIyHK
         OlWu9Z9UFAW67DCa1h+1QX2GG8SWaQY1pi2M6RdFRvTLgKq4Mu8915YqXQbXnkyz0n6e
         CMLY+OSLtXsIiowzel6S8NkjhUW7MCsywlFCjZJfbHkIEfHORxYsvFHDxYjVNkVbktDC
         SxOA==
X-Gm-Message-State: AOJu0Yym3uLq+KUUG1vbXUxTC6StQLYROjzAqjmuzPGpwgPZbXD4NsDO
        auNDyW9xDcc/IJWsLJryF2s0nB4hZxuMCFFz5Mr6cuuiMEOefINFCJXvkaWJRPpo+t5N8h7EqhJ
        VHnoqNyKzAWHnv63Jw8dGKn6t
X-Received: by 2002:ac8:7d91:0:b0:419:4f1e:7ea9 with SMTP id c17-20020ac87d91000000b004194f1e7ea9mr6172379qtd.3.1696012833048;
        Fri, 29 Sep 2023 11:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwASWCl5cZ1JPkXdR7F8OEtFHMXuQkyf5k8zTIL92lAUzma1wamU3ODUvk5iZJIg+H+IXjAg==
X-Received: by 2002:ac8:7d91:0:b0:419:4f1e:7ea9 with SMTP id c17-20020ac87d91000000b004194f1e7ea9mr6172362qtd.3.1696012832708;
        Fri, 29 Sep 2023 11:40:32 -0700 (PDT)
Received: from fedora ([107.171.218.122])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8124b000000b004181234dd1dsm955698qtj.96.2023.09.29.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:40:32 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:40:30 -0400
From:   Adrien Thierry <athierry@redhat.com>
To:     Deepti Jaggi <quic_djaggi@quicinc.com>
Cc:     james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        bp@alien8.de, tony.luck@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_psodagud@quicinc.com
Subject: Re: [PATCH] EDAC/device: Add sysfs notification for UE,CE count
 change
Message-ID: <ZRcaHl9QBQzYoQaa@fedora>
References: <20230731220059.28474-1-quic_djaggi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731220059.28474-1-quic_djaggi@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepti,

On Mon, Jul 31, 2023 at 03:00:59PM -0700, Deepti Jaggi wrote:
> A daemon running in user space collects information on correctable
> and uncorrectable errors from EDAC driver by reading corresponding
> sysfs entries and takes appropriate action.
> This patch adds support for user space daemon to wait on poll() until
> the sysfs entries for UE count and CE count change and then read updated
> counts instead of continuously monitoring the sysfs entries for
> any changes.
> 
> Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
> ---
>  drivers/edac/edac_device.c       | 16 ++++++++++++++++
>  drivers/edac/edac_device.h       |  8 ++++++++
>  drivers/edac/edac_device_sysfs.c | 20 ++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 8c4d947fb848..7b7aec4da6b9 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -587,12 +587,20 @@ void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
>  	if (instance->nr_blocks > 0) {
>  		block = instance->blocks + block_nr;
>  		block->counters.ce_count += count;
> +
> +		/* Notify block sysfs attribute change */
> +		if (block->kn_ce)
> +			sysfs_notify_dirent(block->kn_ce);
>  	}
>  
>  	/* Propagate the count up the 'totals' tree */
>  	instance->counters.ce_count += count;
>  	edac_dev->counters.ce_count += count;
>  
> +	/* Notify instance sysfs attribute change */
> +	if (instance->kn_ce)
> +		sysfs_notify_dirent(instance->kn_ce);
> +
>  	if (edac_device_get_log_ce(edac_dev))
>  		edac_device_printk(edac_dev, KERN_WARNING,
>  				   "CE: %s instance: %s block: %s count: %d '%s'\n",
> @@ -633,12 +641,20 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>  	if (instance->nr_blocks > 0) {
>  		block = instance->blocks + block_nr;
>  		block->counters.ue_count += count;
> +
> +		/* Notify block sysfs attribute change */
> +		if (block->kn_ue)
> +			sysfs_notify_dirent(block->kn_ue);
>  	}
>  
>  	/* Propagate the count up the 'totals' tree */
>  	instance->counters.ue_count += count;
>  	edac_dev->counters.ue_count += count;
>  
> +	/* Notify instance sysfs attribute change */
> +	if (instance->kn_ue)
> +		sysfs_notify_dirent(instance->kn_ue);
> +
>  	if (edac_device_get_log_ue(edac_dev))
>  		edac_device_printk(edac_dev, KERN_EMERG,
>  				   "UE: %s instance: %s block: %s count: %d '%s'\n",
> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> index fc2d2c218064..459514ea549e 100644
> --- a/drivers/edac/edac_device.h
> +++ b/drivers/edac/edac_device.h
> @@ -127,6 +127,10 @@ struct edac_device_block {
>  
>  	/* edac sysfs device control */
>  	struct kobject kobj;
> +
> +	/* kern fs node for block ue_count and ce count attributes*/
> +	struct kernfs_node *kn_ue;
> +	struct kernfs_node *kn_ce;
>  };
>  
>  /* device instance control structure */
> @@ -141,6 +145,10 @@ struct edac_device_instance {
>  
>  	/* edac sysfs device control */
>  	struct kobject kobj;
> +
> +	/* kern fs node for block ue_count and ce count attributes*/
> +	struct kernfs_node *kn_ue;
> +	struct kernfs_node *kn_ce;
>  };
>  
>  
> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 5e7593753799..d1e04a9296c7 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -562,6 +562,13 @@ static int edac_device_create_block(struct edac_device_ctl_info *edac_dev,
>  	}
>  	kobject_uevent(&block->kobj, KOBJ_ADD);
>  
> +	/*
> +	 * Save kernfs pointer for ue count and ce count
> +	 * to notify from any context when attributes change
> +	 */
> +	block->kn_ue = sysfs_get_dirent(block->kobj.sd, "ue_count");
> +	block->kn_ce = sysfs_get_dirent(block->kobj.sd, "ce_count");
> +
>  	return 0;
>  
>  	/* Error unwind stack */
> @@ -594,6 +601,9 @@ static void edac_device_delete_block(struct edac_device_ctl_info *edac_dev,
>  		}
>  	}
>  
> +	block->kn_ue = NULL;
> +	block->kn_ce = NULL;
> +

Isn't there a possibility for a race condition here? It seems to me that
between the moment the attribute files are removed with
sysfs_remove_file() a few lines above, and the moment block->kn_ue and
block->kn_ce are nulled, sysfs_notify_dirent() can be called from
edac_device_handle_ce_count() with an block->kn_ce that refers to a
deleted file.

>  	/* unregister this block's kobject, SEE:
>  	 *	edac_device_ctrl_block_release() callback operation
>  	 */
> @@ -660,6 +670,13 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
>  	edac_dbg(4, "Registered instance %d '%s' kobject\n",
>  		 idx, instance->name);
>  
> +	/*
> +	 * Save kernfs pointer for ue count and ce count
> +	 * to notify from any context when attributes change
> +	 */
> +	instance->kn_ue = sysfs_get_dirent(instance->kobj.sd, "ue_count");
> +	instance->kn_ce = sysfs_get_dirent(instance->kobj.sd, "ce_count");
> +
>  	return 0;
>  
>  	/* error unwind stack */
> @@ -682,6 +699,9 @@ static void edac_device_delete_instance(struct edac_device_ctl_info *edac_dev,
>  
>  	instance = &edac_dev->instances[idx];
>  
> +	instance->kn_ue = NULL;
> +	instance->kn_ce = NULL;
> +
>  	/* unregister all blocks in this instance */
>  	for (i = 0; i < instance->nr_blocks; i++)
>  		edac_device_delete_block(edac_dev, &instance->blocks[i]);
> -- 
> 2.31.1
>

Best,
Adrien

