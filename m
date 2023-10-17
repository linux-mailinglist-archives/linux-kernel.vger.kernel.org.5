Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229F37CCF09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:15:38 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A27ED;
        Tue, 17 Oct 2023 14:15:37 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e5bc692721so3432826fac.0;
        Tue, 17 Oct 2023 14:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577336; x=1698182136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zUohBhM2mgKneqqIllIieESuwIKjaG+ILxik6Us3n8=;
        b=A00og0sbOvj0CEFXjxaEM5V5jpFguxh5X4NA8+zRXeGujIzAiwvjcl8FXyIXC2t+Vg
         ZewggWsZPdtfpxP9SVnfOa8VCyNI8egFJhrYywN4KeTz/UIwHVhZ7ko1adp3uwdTkZiA
         Bgcw95X8uhAgwZiS4AOIitXRMK/flwVLv4FsyU1ME7tQsLwav0/pY+I5IR1I5skglAI8
         mideW7P3nCLNRt2SFYDP73KlV2K38gEhA653dg3mYNMEck/ocsECQKYgHFOzYt7Us2Hp
         e7knhcaUWGbOqV1CFYwEHb4zl3/8Obr1SsorUkx+r9V2cmOL282k8YaWqNq8GPfrabgE
         VLFg==
X-Gm-Message-State: AOJu0Yw6/Y7s3x6jxLZZCc8ccWHSOy28HrhF+/PP9pHgzV7sjDuFAYnB
        H8eETyTtcb6NrbkY26mm7kc=
X-Google-Smtp-Source: AGHT+IH5jdOBSm9n25THVbZv0ul9/hKI6l5alnVindOCYvHbgoC3R1XyDUkkjO4fDle0/WtyOuv6kQ==
X-Received: by 2002:a05:6870:d188:b0:1e9:bb3a:9a89 with SMTP id a8-20020a056870d18800b001e9bb3a9a89mr4023070oac.47.1697577336272;
        Tue, 17 Oct 2023 14:15:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id o9-20020a655209000000b005b46e691108sm282600pgp.68.2023.10.17.14.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:15:35 -0700 (PDT)
Message-ID: <b3334a8c-fb48-4b98-8571-8d85cbd4ed1e@acm.org>
Date:   Tue, 17 Oct 2023 14:15:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231016020847.1270258-1-haowenchao2@huawei.com>
 <20231016020847.1270258-2-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231016020847.1270258-2-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/23 19:08, Wenchao Hao wrote:
> +	/*
> +	 * device_blocked is not set at mostly time, so check it first
> +	 * and return token when it is not set.
> +	 */
> +	if (!atomic_read(&sdev->device_blocked))
> +		return token;

This patch looks like an improvement to me. But I don't think that the
above comment is useful. I propose to move it into the patch
description.

> -		/*
> -		 * unblock after device_blocked iterates to zero
> -		 */
> -		if (atomic_dec_return(&sdev->device_blocked) > 0)
> -			goto out_dec;
> -		SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
> -				   "unblocking device at zero depth\n"));
> +	/*
> +	 * unblock after device_blocked iterates to zero
> +	 */
 > +	if (scsi_device_busy(sdev) > 1 ||
 > +	    atomic_dec_return(&sdev->device_blocked) > 0) {
 > +		sbitmap_put(&sdev->budget_map, token);
 > +		return -1;
 >   	}

Please make the above comment match the new code, e.g. by changing it
into the following: "Only unblock if no other commands are pending and
if device_blocked has decreased to zero".

Thanks,

Bart.
