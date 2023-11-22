Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7067F4E98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjKVRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKVRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:43:27 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7641A8;
        Wed, 22 Nov 2023 09:43:23 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso56362a91.1;
        Wed, 22 Nov 2023 09:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675003; x=1701279803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4noLHZHP8DG8f0jSc42YW/UY/J1Cld0V7RgDGdZcuY=;
        b=trUNQ0aJw69ZQBqeX6Vc61/xB3b/qpfdpPyXFTAq41icDgIUVWnlLGEDKofe7l2E6a
         PDAgsroyNU1MdNGhA0VKZBxg+T0SSDQ2D2sAUtkX9nlqYLdKX/ozEzf0ID8eapEF/G3M
         Yqp7UQBqH6+zmeF3qtAev6nH/HvTf5hyY5arIghmke271YuStAYNTY69bCs1wj3fGu0v
         D6pLSBabdca35P6C4x2bth3WBRLhJSTsBTkIGLOxUTyyXq5KHO4ZzGiW6hSxHEInv/Y4
         ppf8UvVHRtdykcUt7YEFZ+FQzUcqPdHI56MxqgyGU7CRuwKW9EAohFwqUfgE0Ads/aUD
         ZpXA==
X-Gm-Message-State: AOJu0Yw1LGUWBjpC7fr0vQt8kYnszMSmMG+bUlMfXGoH7EgFSecsvfFK
        F00ZRlFT9U6EB0pYsZi3cuo=
X-Google-Smtp-Source: AGHT+IEYALxEwgV/PmnICD40M/m8KypQNqE+vaQx1j7micwYtbwYb7z7RqgfBXspMU3TVLOMFCKFew==
X-Received: by 2002:a17:90b:1c8a:b0:27d:b87b:a9d4 with SMTP id oo10-20020a17090b1c8a00b0027db87ba9d4mr3796607pjb.7.1700675002575;
        Wed, 22 Nov 2023 09:43:22 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9d34:90db:9557:9413? ([2620:0:1000:8411:9d34:90db:9557:9413])
        by smtp.gmail.com with ESMTPSA id u24-20020a17090abb1800b002802a080d1dsm15392pjr.16.2023.11.22.09.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:43:21 -0800 (PST)
Message-ID: <b10de3fb-b6b9-4d8f-a940-93723adbd321@acm.org>
Date:   Wed, 22 Nov 2023 09:43:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
References: <20231122172512.103748-1-beanhuo@iokpp.de>
 <20231122172512.103748-2-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231122172512.103748-2-beanhuo@iokpp.de>
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

On 11/22/23 09:25, Bean Huo wrote:
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -126,7 +126,6 @@ enum uic_link_state {
>   	((h)->curr_dev_pwr_mode == UFS_POWERDOWN_PWR_MODE)
>   #define ufshcd_is_ufs_dev_deepsleep(h) \
>   	((h)->curr_dev_pwr_mode == UFS_DEEPSLEEP_PWR_MODE)
> -
>   /*
>    * UFS Power management levels.
>    * Each level is in increasing order of power savings, except DeepSleep
> @@ -1408,6 +1407,13 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
>   	return 0;
>   }
>   
> +static inline bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
> +{
> +	return (hba->clk_gating.active_reqs || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
> +		hba->outstanding_reqs || hba->outstanding_tasks || hba->active_uic_cmd ||
> +		hba->uic_async_done);
> +}

Since the above function is only used in drivers/ufs/core/ufshcd.c,
please move it back to that source file. The public header file
include/ufs/ufshcd.h is for definitions and declarations used by both
the UFS driver core and the UFS driver host files.

Thanks,

Bart.
