Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F667975A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbjIGPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjIGPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:41:55 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4C30C1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:38:01 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fa455cd94so847834a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101026; x=1694705826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9pwsHA/yFXz5TMVVPrRwdaKFOzScIsvpubE8Q7tink=;
        b=eIlPSZw6sHNIhJ+P3s53tXKOwmP7jtNxECdPAhBoZPS9CD4wdEXIlruUrmWcbWPeXV
         jZ69M4u6l78LNI7HrZGXLo9Po4yARCbVPYWEveVwyo4A5zKb80rDWy7kghV8SO8ZmIft
         oCRvY9z+0Q2vsX8iu2v4WCk3ANK2BL6WEVkQNGEnMt3BQE3Dox+hbfcgnRBcRhx818CV
         R78lOoqJ4FPplmap/Ew3WYF9YygXaaHWJL7WWNeOtYfKLzF9cxRlhjkZE9YeVVUJuDjF
         F+gKqQqeaAaDHvGt6j+vv+OGe1HQy9j7H6h1UM1uAY74iHfKLZKgym40PjYMjmx3fcUS
         3Dew==
X-Gm-Message-State: AOJu0YzOFbyTuzUMzqmRB88kbTwI40Mr8A3ow7+LEjvRJDTpnDPi2mQV
        d1g1EaPsHFoTOcNhYioAtqT5hxvCShI=
X-Google-Smtp-Source: AGHT+IE76STsgB80LctsfEUoLkC+AcSiQvyjBnrMMjVoiTqsFz9y1m+cS8DakXdAfGVBYyc+6ucvQg==
X-Received: by 2002:a17:902:bd45:b0:1bc:6266:d0e4 with SMTP id b5-20020a170902bd4500b001bc6266d0e4mr15770046plx.69.1694094333665;
        Thu, 07 Sep 2023 06:45:33 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:279c:7e31:89f1:d5dc:6cc? ([2601:642:4c05:279c:7e31:89f1:d5dc:6cc])
        by smtp.gmail.com with ESMTPSA id je15-20020a170903264f00b001b89f6550d1sm12920365plb.16.2023.09.07.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 06:45:33 -0700 (PDT)
Message-ID: <e39a18d2-7abe-4de8-a57c-980f859d79df@acm.org>
Date:   Thu, 7 Sep 2023 06:45:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scsi: ufs: core: allow host driver to enable wb
 buffer resize function
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230907073622.1731-1-luhongfei@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230907073622.1731-1-luhongfei@vivo.com>
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

On 9/7/23 00:35, Lu Hongfei wrote:
> Since UFS4.1 will support the WB buffer resize function, the host could
> choose to enable or disable it as needed.
> 
> Introduce a flag UFSHCD_CAP_WB_BUF_RESIZE to provide the host with the
> ability to enable or disable WB buffer resize function.
> 
> UFSHCD_CAP_WB_BUF_RESIZE is only valid when UFSHCD_CAP_WB_EN is set.

Please drop this patch. It should be sufficient that WB buffer resizing
can be controlled via sysfs. I don't think that the host driver should
be able to decide whether or not this functionality is enabled.

Additionally, when reposting this patch series, please include a cover
letter such that e-mail clients that support threading group these
patches into a series.

Thanks,

Bart.
