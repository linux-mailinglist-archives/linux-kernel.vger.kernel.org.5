Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4332C7A3FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjIREIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIREHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF8F116
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695010001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RyEnCFT5C38bhUURLkGzvUajSXRR1/fSXXPcrqWJ/i0=;
        b=LwdVkMPnlBKCXg4FMg9VrDqBR7wr6kSj7A0SE+1eY0cXvztUB6b9f+OE8r6g8e361zID8n
        PBXxJQda3vx9zcUxcXCgi46i6OLdNfT1qT6YlZi8ROXipesbPD4MR+O9BgRdMk9j+mp8Cx
        j5fNGvB2I7lar2hUhu/kfh2fRiQ53ss=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-cCtDEGxUM1qALjiaRjXBpQ-1; Mon, 18 Sep 2023 00:06:38 -0400
X-MC-Unique: cCtDEGxUM1qALjiaRjXBpQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c387a09de4so32202435ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695009997; x=1695614797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyEnCFT5C38bhUURLkGzvUajSXRR1/fSXXPcrqWJ/i0=;
        b=mr6Qiev3hy2skWpVN+pWPTBmSRi3dmCIkDNxgp9drFdsXIBlJSb0ruJicZyNC5yqjn
         im4YIJ04TZkj3AqUzFFbrl7hibBOazdHDSeFBkyvUs3KfjUpSRhRFgBwPrk82htsa2qJ
         Ojy7gomntbx2/M1++UAtPuDtX26l9gTdBcMmkWp37wKiE74kZoo9yMXMwhoR3Y8PZvOP
         IBXWkqiPlm+ZkI93wsTmiun08heyROfMpXAL2VM1iXTztzA6wBcd904VY6fp7cUVxqTQ
         q90W80GbcOQCbYSkTxnmTi+rF9VHgUTGDtm082YlOUEK9EIpJJSnMqiWQOcCva+kJHxa
         OBjA==
X-Gm-Message-State: AOJu0YwyFFJCGUKkSdrFSDmjeryTWhWH+8FNymrbi6PWQ3i5xkplu21U
        tKrZHA9IpIR8kdWjE67wX3ff7fjVAOkQ/Iu68mR48I8mA6PSmwER/e9EdSFqV8mWj2IG7nNz0X8
        1ZJ7In3X6MZBNUkM8sHs5MGd7
X-Received: by 2002:a17:902:ed13:b0:1c4:2639:fcac with SMTP id b19-20020a170902ed1300b001c42639fcacmr6826548pld.44.1695009997182;
        Sun, 17 Sep 2023 21:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF065/Z94SfXDjWgy8eNRhRV8ONjtcc1kg9eJW1xxYmQI4hKUxuHGFuBMDdEioAhl0IB04WA==
X-Received: by 2002:a17:902:ed13:b0:1c4:2639:fcac with SMTP id b19-20020a170902ed1300b001c42639fcacmr6826541pld.44.1695009996903;
        Sun, 17 Sep 2023 21:06:36 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id ju3-20020a170903428300b001bdb8c0b578sm5892366plb.192.2023.09.17.21.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 21:06:36 -0700 (PDT)
Message-ID: <4e5aaed1-bf7d-18a8-0f77-8f29bb2e43bc@redhat.com>
Date:   Mon, 18 Sep 2023 14:06:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 12/35] ACPI: Use the acpi_device_is_present()
 helper in more places
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-13-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-13-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 02:38, James Morse wrote:
> acpi_device_is_present() checks the present or functional bits
> from the cached copy of _STA.
> 
> A few places open-code this check. Use the helper instead to
> improve readability.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/scan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 691d4b7686ee..ed01e19514ef 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>   	int error;
>   
>   	acpi_bus_get_status(adev);
> -	if (adev->status.present || adev->status.functional) {
> +	if (acpi_device_is_present(adev)) {
>   		/*
>   		 * This function is only called for device objects for which
>   		 * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>   	int error;
>   
>   	acpi_bus_get_status(adev);
> -	if (!(adev->status.present || adev->status.functional)) {
> +	if (!acpi_device_is_present(adev)) {
>   		acpi_scan_device_not_present(adev);
>   		return 0;
>   	}

