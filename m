Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7327ABB33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjIVVht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIVVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:37:47 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883DC1;
        Fri, 22 Sep 2023 14:37:42 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-692a885f129so1287372b3a.0;
        Fri, 22 Sep 2023 14:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695418662; x=1696023462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLqEBhAlMkPX+Dn8nS29WI6I17tSvmMyFsE5yPt5Elo=;
        b=K24ho1oRDlqB8p20or4zSczMSNka9D5anKfbvYALC8XovSkd08EkIB1L6gGzO05Jwf
         ulXgHXs++RE0kkH/DVYvYxXyl13k1okqoaDPL/jjtr/wVKnSnM+9bs52y3QAdrgznQnO
         LT+m5mrTy6EUMOfHzxTztxMxO8v5n4b1oSQi+G8agw/W4PjlV7rJEbvkeNtOcOh7VHo4
         +4ntrMIpgTjEc7dCwRo+p9EAFUyc3xHC82VwmKSIkyuPxsx0kOH5VDTI6prVl21sawn+
         XWCH88bJVm2MSjZCd8bKomj5S5MoVUDRPy37J4bK9HOx0ARbafYTFdDX2ITWQzYRAG0b
         u2MA==
X-Gm-Message-State: AOJu0YwrkFcFzgbOb/qXXh5+M0uDQJxpxHCWzjc72s+mfA3dcjqzalUq
        IZ5jw6Kq9TsMqayd2DTwbVI=
X-Google-Smtp-Source: AGHT+IFiaytuz1ewXfl+c3OSQRSc5DdzwEvPUsadJuMAYOF6GPe/oRD9ijOEXXIyFGZMxR2qVH4r3A==
X-Received: by 2002:a05:6a00:24cf:b0:68f:e810:e86f with SMTP id d15-20020a056a0024cf00b0068fe810e86fmr648287pfv.28.1695418661634;
        Fri, 22 Sep 2023 14:37:41 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id e15-20020a62ee0f000000b00686fe7b7b48sm3639737pfi.121.2023.09.22.14.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 14:37:41 -0700 (PDT)
Message-ID: <f01f34ae-156f-446c-8bf4-f52c439a0f5d@acm.org>
Date:   Fri, 22 Sep 2023 14:37:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] scsi: zfcp: Fix a double put in zfcp_port_enqueue
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     linux-scsi@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        James Bottomley <James.Bottomley@suse.de>,
        Swen Schillig <swen@vnet.ibm.com>,
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230922074631.9408-1-dinghao.liu@zju.edu.cn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230922074631.9408-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 00:46, Dinghao Liu wrote:
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index df782646e856..ad0ef9546501 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -552,7 +552,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
>   
>   	if (device_register(&port->dev)) {
>   		put_device(&port->dev);
> -		goto err_out;
> +		goto err_register;
>   	}
>   
>   	write_lock_irq(&adapter->port_list_lock);
> @@ -565,5 +565,6 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
>   
>   err_out:
>   	zfcp_ccw_adapter_put(adapter);
> +err_register:
>   	return ERR_PTR(retval);
>   }

goto labels should be named after the code below the goto label instead
of reflecting where the goto statement comes from.

Thanks,

Bart.
