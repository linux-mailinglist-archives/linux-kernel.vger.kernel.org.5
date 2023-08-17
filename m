Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DC77FA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352643AbjHQPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352738AbjHQPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:03:17 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB7271B;
        Thu, 17 Aug 2023 08:03:13 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bee82fad0fso18653365ad.2;
        Thu, 17 Aug 2023 08:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284593; x=1692889393;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkyNVwau1UkJkpgmnHLFLBBi23j/yIVeTDH1Jc5k/Qg=;
        b=d19XwFkMrdswzgSoG+8AW7IETyaDR/HsRU3DVwt8i7TOMl7eanYrdaGiA9eAMvsV5e
         UZxln3/8OGe/ItNO190R8kQas16F6rSwrrEsNUfzeaqNl53AKALkpB9gI6ajXSXClF2t
         +QcCHPisVcdJsq6iU6piFV6A7tHP5XjIaVGXDKdIbi85JtPUVHOALhvyUWJZssskpreC
         zDLs2NxBReOEq6BDpwRY9aBacd1NWOduEEE11i9a5Qfs4mvu6iPqJFYFAHxvOOk23+TU
         tQSDNZp16mcybyJxSYnn1dQaOLmFtuGl2ucTzO5AcRB9C5fHWmAwV2gAR74/LewmRUUH
         NeqQ==
X-Gm-Message-State: AOJu0Yzna/UnoBbObEpyRHpBahmTx9A1r53asG01wtz8NM+kjj0RGBHk
        Cv/EP3qSr2fzzNo7SFHM6ElHpZKujzY=
X-Google-Smtp-Source: AGHT+IFzTe6mUffmd4kapTQ7pVQiqSk1++WWnA9Gzt+QXxx8XNfvImd5LK5Q/zhrd6OKLIKwbwl4BQ==
X-Received: by 2002:a17:902:db0e:b0:1b7:e49f:1d with SMTP id m14-20020a170902db0e00b001b7e49f001dmr5240397plx.62.1692284592802;
        Thu, 17 Aug 2023 08:03:12 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:dfd:6f25:f7be:a9ca? ([2620:15c:211:201:dfd:6f25:f7be:a9ca])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001b8a8154f3fsm15250113plh.270.2023.08.17.08.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:03:11 -0700 (PDT)
Message-ID: <b9ade5d5-a160-5ecb-8dc5-777e8a586d51@acm.org>
Date:   Thu, 17 Aug 2023 08:02:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RESEND PATCH v3 2/2] ufs: poll HCS.UCRDY before issuing a UIC
 command
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        kwangwon.min@samsung.com, junwoo80.lee@samsung.com,
        wkon.kim@samsung.com
References: <cover.1690939662.git.kwmad.kim@samsung.com>
 <CGME20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e@epcas2p2.samsung.com>
 <9c7ccbfb8fe05c29ab3e31d9cd14e6b91065b8b0.1690939662.git.kwmad.kim@samsung.com>
 <f1e154c4-bbb3-18a2-cb7a-41adae292b48@intel.com>
Content-Language: en-US
In-Reply-To: <f1e154c4-bbb3-18a2-cb7a-41adae292b48@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 04:26, Adrian Hunter wrote:
> And perhaps the following is neater:
> 
> 	u32 val;
> 
> 	return !read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
> 				  500, UIC_CMD_TIMEOUT * 1000, false, hba,
> 				  REG_CONTROLLER_STATUS);

Would the above make readers of that code wonder whether read_poll_timeout()
perhaps returns a boolean? Wouldn't it be better to test the
read_poll_timeout() return value as follows?

  	return read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
  				  500, UIC_CMD_TIMEOUT * 1000, false, hba,
  				  REG_CONTROLLER_STATUS) == 0;

Thanks,

Bart.
