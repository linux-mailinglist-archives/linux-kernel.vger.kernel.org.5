Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB87803C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjLDSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BA29A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701712915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgk9x1S32YbyFYXGxABkNOgzyytMxhu0dcjiBukmT2Y=;
        b=XmIRnwi65NaLC3qUEPTz3h/uFVXZ2fE/q0RizxOJD7UyiplFENtm2593snXC5HTtFkdoJK
        JZ66CCMRca3TdQYouGN94urWHWF+Svp6atRkNXf9GRSHPPvBgTogjDozTBSrFGeXDLqY2b
        2+JZNlmiCy0bUk98jJ07EOFB9iT+/qA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-cjB6v5wXNbqOR0dpzGVPcg-1; Mon, 04 Dec 2023 13:01:52 -0500
X-MC-Unique: cjB6v5wXNbqOR0dpzGVPcg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77de7dacb57so428456485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712910; x=1702317710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgk9x1S32YbyFYXGxABkNOgzyytMxhu0dcjiBukmT2Y=;
        b=MQSnPPi4bc8eUSleoL3ZwEp7LA9qn0dRDE7/eUivMWP2yuArNn2kaFiljwdMCjKFG6
         +tW3y59D4fdBZhvHwW6KN1HDZjzkp+nOxGrkDFMUGEHawxxTVT4rCAh9+hGcJjO0pejs
         YFtn0aXZN8RTB1hbxfWmCpTnSF7pk0rurqC6PzE5BncQfJZ6KcM28Iqqg2Aojp+lvL/U
         UBlEeZy9KKhQhaDxyRxu4UvGh4rdpfE5UZbYzlCvAxlX4IBQe8uf/aU9hyfCKXd/0Tpt
         UnagVnE5TKWOLYqa9G0691h4VsGtbkmd3Bpf0C2lauQlvM9Rl7lO5PrXs8TeDa9FNXtE
         O9Qw==
X-Gm-Message-State: AOJu0YxwkeZtAqFRxMGjra3bxgimr9NVom8xXqaGYxoZ3PhM5Mc06jAT
        KrQdI1ehHXUmARGGhgfcjgace1bcAU3BXHXvv0KcCiqggQYaPDoZNNY64ckE9u8vqnhLknOIdM+
        GFBV9aJ9gNQ5nODPtiGVXGWbyb2uZT85oqhldr8inyTT0lliczzwjA+4YNNL6A5QQwDjuan3LYs
        4kW+Y2NRlYMxE=
X-Received: by 2002:a05:620a:1d08:b0:76f:d65:af24 with SMTP id dl8-20020a05620a1d0800b0076f0d65af24mr6184524qkb.27.1701712910621;
        Mon, 04 Dec 2023 10:01:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQb6iGQRFDsjsW47QtTUSChPuX7AEzvmrR3xoj2Dr2YRJaCUeHyzkIKktc/Mz92zwG+o7y7Q==
X-Received: by 2002:a05:620a:1d08:b0:76f:d65:af24 with SMTP id dl8-20020a05620a1d0800b0076f0d65af24mr6184503qkb.27.1701712910247;
        Mon, 04 Dec 2023 10:01:50 -0800 (PST)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a288500b0077d8526bcdesm4421229qkp.86.2023.12.04.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:01:49 -0800 (PST)
Message-ID: <61b5e9bd-3b09-4580-ace1-01d3d361c79d@redhat.com>
Date:   Mon, 4 Dec 2023 13:01:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: extlog fix null dereference check
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        David Arcari <darcari@redhat.com>,
        Don Zickus <dzickus@redhat.com>,
        David Malcolm <dmalcolm@redhat.com>
References: <20231204180037.383583-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20231204180037.383583-1-prarit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Top posting and just adding a few interested parties ...

On 12/4/23 13:00, Prarit Bhargava wrote:
> The gcc plugin -fanalyzer [1] tries to detect various
> patterns of incorrect behaviour.  The tool reports
> 
> drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
> drivers/acpi/acpi_extlog.c:307:12: warning: check of ‘extlog_l1_addr’ for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
>      |
>      |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>      |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>      |      |                                                  |
>      |      |                                                  (1) pointer ‘extlog_l1_addr’ is dereferenced here
>      |  307 |         if (extlog_l1_addr)
>      |      |            ~
>      |      |            |
>      |      |            (2) pointer ‘extlog_l1_addr’ is checked for NULL here but it was already dereferenced at (1)
>      |
> 
> Fix the null dereference check in extlog_exit().
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Static-Analyzer-Options.html
> 
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>   drivers/acpi/acpi_extlog.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eae..193147769146 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -303,9 +303,10 @@ static int __init extlog_init(void)
>   static void __exit extlog_exit(void)
>   {
>   	mce_unregister_decode_chain(&extlog_mce_dec);
> -	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> -	if (extlog_l1_addr)
> +	if (extlog_l1_addr) {
> +		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>   		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> +	}
>   	if (elog_addr)
>   		acpi_os_unmap_iomem(elog_addr, elog_size);
>   	release_mem_region(elog_base, elog_size);

