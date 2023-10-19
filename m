Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423247D0144
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbjJSSUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346352AbjJSSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:20:46 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ECA11F;
        Thu, 19 Oct 2023 11:20:44 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-27d23f1e3b8so29646a91.1;
        Thu, 19 Oct 2023 11:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739644; x=1698344444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7vDvNz6BQO2aw2lrYmPjXprDOYt8FbI7nemZ3te0lQ=;
        b=DhNn27RAPrOBMpkkXC8fgPivysbSL6LY5QidA0Jse/SPh5wR75y9DZAxELq0R5YyQ6
         4hQvhdVhTPSyoC3F43ImrCqTlAJQvM98nhrSYonCzwX6kQnM/gnJyWt9BV3hLvrjg0/x
         QBMN11wEdQrS/cErYoFSv7jUaye+jL3UWvypiSL1MKSScIfFD/vPmZJYxF0/OlGgghcj
         J39dtmO5tAGKfUnG/WtWJacFxEyEeUkp0FR/RVaXVLM//PYZIUT4DIqk38IgJhHbl1T4
         /zxxN1buqeHk4htIWVmPeCFpr+uYYCN99a7t8G1hY08/K47NmTMwl3x/ktWmIM8fiVnM
         Kl1A==
X-Gm-Message-State: AOJu0YwDgA4u+vvJKbVr38DqgrDYiBeE9JVwOn4QNMS/RFVvl+tKKqZW
        Nkul9YZBlRxyqTLDE9jJu/Y=
X-Google-Smtp-Source: AGHT+IHLvlmNMcFMWxSwriIsRlybnjbvrnsIbfuCI095aX/soipMtp1C6oFTKung7GTUB7phSX8R+w==
X-Received: by 2002:a17:90a:df89:b0:27c:f48e:e245 with SMTP id p9-20020a17090adf8900b0027cf48ee245mr2886389pjv.24.1697739643885;
        Thu, 19 Oct 2023 11:20:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3306:3a7f:54e8:2149? ([2620:15c:211:201:3306:3a7f:54e8:2149])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902ee4400b001c877f27d1fsm17322plo.11.2023.10.19.11.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:20:43 -0700 (PDT)
Message-ID: <ec1a2b51-6b46-441d-99e2-8e5bc48ba2d2@acm.org>
Date:   Thu, 19 Oct 2023 11:20:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] scsi: ufs: core: support WB buffer resize function
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <quic_cang@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230911055810.879-1-luhongfei@vivo.com>
 <86e5cc25-80f7-451b-9067-a220c7a2c39e@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <86e5cc25-80f7-451b-9067-a220c7a2c39e@vivo.com>
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

On 10/18/23 21:50, Lu Hongfei wrote:
> Are there any new developments in this group of patches?

The JEDEC ballot about resizing the WriteBooster buffer has not yet been
approved. Please wait with posting patches that implement support for a
JEDEC feature until agreement has been reached in JEDEC.

Thanks,

Bart.

