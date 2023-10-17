Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F77CC614
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjJQOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjJQOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D86F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697553678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01TY56NkyHmcpi7USmUTiXNPdmvd07nV+JUshBS/8os=;
        b=QFQXjupSpn3kewdP2iv4Mqj/VGdWITumtemGYIE77cdNdcqBhO8orcKnu/8LEpbhM6Qhxg
        A8EEvw1BVUBPxOVDQZmqBXJajmpdwKKEa2HthFNjGt4hB7OiPbim/CnS1buaA9tsFi1Rjw
        elLXcABCd5TjnTtqL7mmz/2P9P8r9VM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-462_jQMiOy2DXtGU2VC0VA-1; Tue, 17 Oct 2023 10:41:17 -0400
X-MC-Unique: 462_jQMiOy2DXtGU2VC0VA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d120c28afso64819836d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553676; x=1698158476;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01TY56NkyHmcpi7USmUTiXNPdmvd07nV+JUshBS/8os=;
        b=mAJRq4Aybz2fBjBKoce/Lowh8wOHQyf07U/alC5GWBZJ4mD4rz2GpVKgLD8/RTpb03
         Hd94s6y48KglYiralSkrbgvh+LmVnLGRJ+g3lxiw2yYIV45MMiEC52Loelk47lQ4DEmo
         uWuCYK0NCqQOQ4juazvE6b8dlPGd+vQSeMPqG5A7kN5Ra7CUsEsJifBea6b1v+JC25Ay
         b7pejsJ7FwHKGNbtzndDWJDEHhgY8z5XM/G3ATNgbrQZlAwYcT6BPyvIynQJyRxcjSgv
         0k/uerNNUnCsQhHx+g9Vr5haxSpRkG2Uh1y4XKWujL9UMUgT7Dei3O6E6TninwnxxDYA
         1QKQ==
X-Gm-Message-State: AOJu0YzqkWts2taDildoiyfGL011nU7YBQKBDwqycJO9B9vnqXCkpUGV
        uWfmZLi5K0S9T3JRRYOs9lBPoCj8xoJN3tJQAnLAqtNZW7pajZleiw7T0865b3lw4kZEmCxt9IY
        /skGIZ5iZMNPWzAnKuxpU7Qf+Wt5BqZ8U
X-Received: by 2002:a05:6214:2a4a:b0:66d:476:8940 with SMTP id jf10-20020a0562142a4a00b0066d04768940mr2624118qvb.46.1697553676380;
        Tue, 17 Oct 2023 07:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2i6SRrgyHNlbie20y7iQVcriCE8Zz3D5pXueu8QcrHqFf5kP9qHnVfriktEnojKu84Kku0w==
X-Received: by 2002:a05:6214:2a4a:b0:66d:476:8940 with SMTP id jf10-20020a0562142a4a00b0066d04768940mr2624099qvb.46.1697553676113;
        Tue, 17 Oct 2023 07:41:16 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id eu19-20020ad44f53000000b0064f4e0b2089sm600989qvb.33.2023.10.17.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:41:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Angelina Vu <angelinavu@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com
Subject: Re: [PATCH] hv_balloon: Add module parameter to configure balloon
 floor value
In-Reply-To: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
References: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
Date:   Tue, 17 Oct 2023 16:41:13 +0200
Message-ID: <87jzrl71me.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Angelina Vu <angelinavu@linux.microsoft.com> writes:

> Currently, the balloon floor value is automatically computed, but may be
> too small depending on app usage of memory. This patch adds a balloon_floor
> value as a module parameter that can be used to manually configure the
> balloon floor value.
>
> Signed-off-by: Angelina Vu <angelinavu@linux.microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 64ac5bdee3a6..87b312f99b2e 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1101,6 +1101,10 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
>  	}
>  }
>  
> +unsigned long balloon_floor;
> +module_param(balloon_floor, ulong, 0644);
> +MODULE_PARM_DESC(balloon_floor, "Memory level (in megabytes) that ballooning will not remove");
> +
>  static unsigned long compute_balloon_floor(void)
>  {
>  	unsigned long min_pages;
> @@ -1117,6 +1121,9 @@ static unsigned long compute_balloon_floor(void)
>  	 *    8192       744    (1/16)
>  	 *   32768      1512	(1/32)
>  	 */
> +	if (balloon_floor)
> +		return MB2PAGES(balloon_floor);
> +
>  	if (nr_pages < MB2PAGES(128))
>  		min_pages = MB2PAGES(8) + (nr_pages >> 1);
>  	else if (nr_pages < MB2PAGES(512))

A module parameter is probably useful for debugging but it can hardly be
applied in production environments as it must be 'one size fits all' and
e.g. for different VM sizes it can be different (that's the purpose of
compute_balloon_floor() heuristics). 

In fact, does it has to be statically set? Can we have a sysfs entity so
this can be a policy (userspace decision)? We can keep the current
compute_balloon_floor() as the default but users will be able to adjust
accordingly.

-- 
Vitaly

