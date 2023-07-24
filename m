Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0615D75ED97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGXIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjGXIaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C02133
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690187367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DNzHbGom77n0zpxl+676gi9KyXFJ85R3IBrxW//ask=;
        b=K8kmA+7dSOblqZadST5t/3eJ4VGRbLlp2oUN00eDKQIGR1spm5Nq6A62il1JjEuSuAsXqS
        Ayrgda/ypu7909N1w+mpX/4k8cAz65W8GdjoY+PzWfw8++1t+K8fY9y7XvzynL/Nga5U8u
        zKKZLBt4bcAzaB8KQCQr7xheqKWBmZs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-7pJngeyrMSSoh4pATWiHIA-1; Mon, 24 Jul 2023 04:29:25 -0400
X-MC-Unique: 7pJngeyrMSSoh4pATWiHIA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so25617385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187365; x=1690792165;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DNzHbGom77n0zpxl+676gi9KyXFJ85R3IBrxW//ask=;
        b=RGyn0IkzVVVNfw40p065UUki85fNN6WfbOGyjpCGVlZnChutEG5amkkRlvodk7OSZG
         PPuyDPBsvQIVvEjcr49cb4GbNh5iLpAdqcTAHQX7xz+CEdvpt6GB76IIUJzBfVPcHtZX
         3bK/J7mmHZ9zQu6AH2UGD+v44wxekjj5Cmy9rsZpFGNJI4AU1Fclq47hYHH/f0ugqH4q
         9YiY76Hyy4aJU7vFoaPhFZrS1h5BTaQ+tY46b6X+x1ErqZjhFqG1b+twvZ7chzh5f8Fn
         lsdJRA8oSpHlJ3ylQ5ifV9V4TNZ73Am3fltwXC0p0n0FYPoX3q3JmUD8FjTI6X7JdGBD
         seUA==
X-Gm-Message-State: ABy/qLanBqsx2tfvVGwSoR7GpdMLZTGS85W3FqFVdJ9vjGHrdBRTszUO
        9RBXJRkDPPGh41+9lSGzoEWfZ2GsUbS4+jNQWKqwVOxFXExi6+Esf1+zodQRRCA0u2XSxzW3sU3
        2lr08z7zmu5w2EKtVPm6bT4YL
X-Received: by 2002:a05:600c:2308:b0:3f7:3991:e12e with SMTP id 8-20020a05600c230800b003f73991e12emr7402837wmo.1.1690187364803;
        Mon, 24 Jul 2023 01:29:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJflnC/NPtGCRbFCR9C92TkIUPD7R5nWkt94QfcSqyyptU/48AkbkWHtvlGEwx8uIuiIpKVQ==
X-Received: by 2002:a05:600c:2308:b0:3f7:3991:e12e with SMTP id 8-20020a05600c230800b003f73991e12emr7402823wmo.1.1690187364547;
        Mon, 24 Jul 2023 01:29:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003fba92fad35sm12223151wmi.26.2023.07.24.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:29:24 -0700 (PDT)
Message-ID: <dbf871ad-1768-18d0-318f-86df33df7446@redhat.com>
Date:   Mon, 24 Jul 2023 10:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/6] KVM: s390: interrupt: Fix single-stepping ISKE
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230721120046.2262291-1-iii@linux.ibm.com>
 <20230721120046.2262291-6-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230721120046.2262291-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.23 13:57, Ilya Leoshkevich wrote:
> kvm_s390_skey_check_enable() does not emulate any instructions, rather,
> it clears CPUSTAT_KSS and arranges for ISKE to run again. Therefore,
> skip the PER check and let ISKE run happen. Otherwise a debugger will
> see two single-step events on the same ISKE.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   arch/s390/kvm/intercept.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index d2f7940c5d03..8793cec066a6 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -630,8 +630,7 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   		rc = handle_partial_execution(vcpu);
>   		break;
>   	case ICPT_KSS:
> -		rc = kvm_s390_skey_check_enable(vcpu);
> -		break;
> +		return kvm_s390_skey_check_enable(vcpu);
>   	case ICPT_MCHKREQ:
>   	case ICPT_INT_ENABLE:
>   		/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

