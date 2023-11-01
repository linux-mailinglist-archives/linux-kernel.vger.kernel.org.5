Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195EF7DE4C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjKAQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjKAQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:39:23 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C5FD;
        Wed,  1 Nov 2023 09:39:21 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cc5b7057d5so27921185ad.2;
        Wed, 01 Nov 2023 09:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856761; x=1699461561;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM0Epbc1VMsDZrKerag8ZHHcxFKYveaKX4D+B9iSczU=;
        b=jc3Z1kYyJwh3r/0bHfu+1pU4HQ0Fikis8gS6rCNUAOZJEcaxarxStBXvpxVziP7PSh
         QKk8ci7K8zPE0d1enZld4W3MtBZnwS0aoJ9uelWiZCqZsgBjZm9cO7Ox8yg29i+LjJbk
         lEai8mTZ9TcC+BQA4dWgL5ahZeRleecYZbeJb4wTrOeLWHcwJ2f1akJ5hG1VIRklx5ol
         XmeT3oEWtmslIB95sEn14LzIMh0SoI+nKNDbDnK69M4Qgo8woSE6VGeCKCIL09wRIuDb
         DK6XgnE5mKZmH0IFJI4bKOPNIQY9JJuO+1Wl91RkNeVdcAtdzzsr90fCjWm4Wox/I8r8
         cNGQ==
X-Gm-Message-State: AOJu0YzMphC9ThYd/78r36ZK2HeiPs/jVNyh60c3I+3ngXBarbYfMKwu
        q8+ni0sKhT5xBTRXvxcDE2Q=
X-Google-Smtp-Source: AGHT+IG+ePtK7gezuiDT0seDNZm61TlcX5XFImUVDpc5j+Lyf8x+fcruW72VB8hxivZLJYBw2BZvGw==
X-Received: by 2002:a17:903:228f:b0:1cc:543b:b361 with SMTP id b15-20020a170903228f00b001cc543bb361mr7919656plh.43.1698856760603;
        Wed, 01 Nov 2023 09:39:20 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2312:f48f:8e12:6623? ([2620:15c:211:201:2312:f48f:8e12:6623])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001c898328289sm1542038plg.158.2023.11.01.09.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 09:39:20 -0700 (PDT)
Message-ID: <e1ed8776-d8ad-49f2-bf8f-2759256e33e9@acm.org>
Date:   Wed, 1 Nov 2023 09:39:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: Process abort completed command in
 MCQ mode
Content-Language: en-US
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com
References: <CGME20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519@epcas2p3.samsung.com>
 <20231101084504.79087-1-hy50.seo@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231101084504.79087-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 01:45, SEO HOYOUNG wrote:
> In MCQ mode, the case where OCS is updated to aborted is as follows
>   1. when abort processing is completed
>   2. When a duplicate command occurs

What is a "duplicate command"? The UFSHCI driver guarantees that each
SCSI command has a unique tag.

> In case of 1 situation, cmd should be re-request.

It should be resubmitted by the SCSI error handler. The UFSHCI driver
does not have to request this explicitly. See also the code at the end
of scmd_eh_abort_handler().

>   	case OCS_ABORTED:
> -		result |= DID_ABORT << 16;
> +		if (cqe)
> +			eec = le32_to_cpu(cqe->status) & MASK_EEC;
> +
> +		if (is_mcq_enabled(hba) && !eec)
> +			result |= DID_REQUEUE << 16;
> +		else
> +			result |= DID_ABORT << 16;
>   		break;

I don't think this change is necessary. Additionally, introducing
different behavior for MCQ compared to legacy mode in this code path is
suspicious. Why should how commands are queued affect how aborts are
processed?

Thanks,

Bart.

