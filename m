Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88F7798A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbjIHPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjIHPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:44:11 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F501FF2;
        Fri,  8 Sep 2023 08:44:02 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-26d50a832a9so1738565a91.3;
        Fri, 08 Sep 2023 08:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187842; x=1694792642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsFpBp1iOychJuJJ7GPCZs+E2CRFMb0GWiZRHuwanc8=;
        b=WQrN5K/S+nX4oP8pVsELxkveEcfeULMakgP7PHeZ/z61SAcSk1oM8n8V1NE0SasyIx
         v6iKCvDg4+nZ/4M1Uc38z8mguUE/KVmYZRLNUc0rOzWPRZEEkWwr1C+/+Y6XvNc2/U+/
         WFFetM3vUf8mFxbG/uS1X4Wb8/UtqYgwm6nn0S0L58y8ptmMvtTLoiig4M+sm7oUDR3O
         5gaFtYNGniy7kgA4GtzSkaoiWed9h2FrDr20hePIvmR5k15SsZlGz8E1OxJJQKCGoDvb
         aJLpvORrSv3Wypex1wuyPVFv5QATbt32dRaDJt80FSBASJiJmUdXyzzeYcis3ds88Zpx
         wtTw==
X-Gm-Message-State: AOJu0YxXlZC3AHV3sU470jHeLS//HeH8Zh5Nw5aEEjpuaVkhm92mXGkr
        lInYvO9uWr0APzznpv04Y/w=
X-Google-Smtp-Source: AGHT+IGJUusUCZ4506LsQdCeW3WgQORt7eGXWD0XUYtBExhbIigtYdVwyzpdUEYQzFA/2jrp9VH8kA==
X-Received: by 2002:a17:90a:c88:b0:268:29a3:bd05 with SMTP id v8-20020a17090a0c8800b0026829a3bd05mr2573201pja.48.1694187841658;
        Fri, 08 Sep 2023 08:44:01 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a840200b00260a5ecd273sm1464513pjn.1.2023.09.08.08.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:44:00 -0700 (PDT)
Message-ID: <d5e3a6e6-882d-4f75-8eef-5f3e1058f921@acm.org>
Date:   Fri, 8 Sep 2023 08:43:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add sysfs attributes to control
 WB buffer resize function
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230908102113.547-1-luhongfei@vivo.com>
 <20230908102113.547-4-luhongfei@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230908102113.547-4-luhongfei@vivo.com>
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

> +What:		/sys/bus/platform/drivers/ufshcd/*/enable_wb_buf_resize
> +What:		/sys/bus/platform/devices/*.ufs/enable_wb_buf_resize
> +Date:		Sept 2023
> +Contact:	Lu Hongfei <luhongfei@vivo.com>
> +Description:
> +		The host can decrease or increase the WriteBooster Buffer size by setting
> +		this file.
> +
> +		======  ======================================
> +		   00h  Idle (There is no resize operation)
> +		   01h  Decrease WriteBooster Buffer Size
> +		   02h  Increase WriteBooster Buffer Size
> +		Others  Reserved
> +		======  ======================================
> +
> +		The file is write only.

The name "enable_wb_buf_resize" seems misleading to me. 
"wb_buf_resize_control" is probably a better name for this attribute 
since this attribute can be used to increase and decrease the WB buffer 
size.

> +	if (hba->dev_info.wspecversion < 0x410 ||
> +	    !hba->dev_info.b_presrv_uspc_en) {
> +		dev_err(dev, "The WB buf resize is not allowed!\n");
> +		return -EINVAL;
> +	}

Please leave out the version number check. There probably will be UFS 
4.0 devices that will implement this feature.

Thanks,

Bart.
