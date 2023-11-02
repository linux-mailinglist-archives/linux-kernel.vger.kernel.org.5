Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2E7DFABE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjKBTPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKBTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:15:38 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C0184;
        Thu,  2 Nov 2023 12:15:36 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1cc938f9612so5437115ad.1;
        Thu, 02 Nov 2023 12:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952533; x=1699557333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+32vB581hzmFY06dbkkG5Ku+sXQfolP2uRxPBBpw/0=;
        b=GWkIOfB/vSmCGVbqi34tiA/A8gqxhEFHD6cWWEQSrASKuJq4XtnMKLe9UA4zoUbaXX
         OwYxopRMcXtUY7+q53rrHKNmCeiEch09rbJW3bDSGzIhWbDNH7qPslok5Yo7R5wuDLg4
         20swDRUYbZs70Y3ZIYj1KZj9yXMiGgwmn53zdH9/w4z8MNHdwX3Fs8kq0fJoShmKyHOo
         +PdAYGQ9MyNCAVWny5Xm4q0YvUmq5Iif8JDJmyhTavrAoNGH33nikekoWF8/78qvVrHp
         NqS3LQKMGAZe/LzTId7B9vjA1wgDgnW6YRnEzILg/uipnsy3BG2ZRM4ayprpV2YsKATP
         R5JA==
X-Gm-Message-State: AOJu0Yz71J/+uxA1ugB3sf586mMXWHJv1brV4d9VAr9yYtOMxvpn00RR
        hQM0YU+pdXxdxh/8qbRXYesl8ug4TyA=
X-Google-Smtp-Source: AGHT+IFyB05wi+a/eG/YQ1Na65WBGYrjXb0/KwBD8cobt8pwQS6rMJJxY+nlRQqkNhMEnWdm3gsKhQ==
X-Received: by 2002:a17:902:ea01:b0:1cc:47a6:12b8 with SMTP id s1-20020a170902ea0100b001cc47a612b8mr14760705plg.46.1698952533338;
        Thu, 02 Nov 2023 12:15:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:87f7:9784:4475:1cd4? ([2620:15c:211:201:87f7:9784:4475:1cd4])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902744500b001c60ba709b7sm80157plt.125.2023.11.02.12.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 12:15:32 -0700 (PDT)
Message-ID: <64a6315d-76df-49c8-aa57-a0576c53b6ef@acm.org>
Date:   Thu, 2 Nov 2023 12:15:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>, naomi.chu@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, casper.li@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
 <20231102052426.12006-2-naomi.chu@mediatek.com>
 <20231102163728.GB20943@thinkpad>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231102163728.GB20943@thinkpad>
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

On 11/2/23 09:37, Manivannan Sadhasivam wrote:
> Where is the changelog?

I think it's here: 
https://lore.kernel.org/linux-scsi/20231102052426.12006-1-naomi.chu@mediatek.com/

Bart.

