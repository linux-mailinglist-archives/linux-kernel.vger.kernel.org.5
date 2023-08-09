Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D7D7755BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHIIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHIIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B61FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691570717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25xn04LBqXZpHWYq1GCyF/s06Zr82F97gBHsG00KrhE=;
        b=RNmh6rbXLC78aJ71t3yOI854mQRbzBWml5geoF/uY27ChSMT/RgT1Stn758YijcnqPtkca
        xsaDZH8mB7277gs30JRAUMUWNTsVz3AGEblhHOgCD3IHB7BMbjWZysmNZ0qjukbI8pVrFg
        VTQm96RgRktYKNtCkPL8zH+vtnXXGhU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-hDkieobINle-e12zKqTgsw-1; Wed, 09 Aug 2023 04:45:15 -0400
X-MC-Unique: hDkieobINle-e12zKqTgsw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe0f24e801so6432069e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 01:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691570714; x=1692175514;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25xn04LBqXZpHWYq1GCyF/s06Zr82F97gBHsG00KrhE=;
        b=eW4/ajMR7wNMsGkDsEsXlR5zRc7coUlTfpLSISh1V5tI8zEmTIXvFcKyIRqSgaloQ/
         P8mB8qzT+TqXyTKbUOcMkq/TxsFgHnpAg6xwcbLBiP2Ibc2TdRqcJyyT4nopDlgW1rEM
         r2IDffGrKHeV5DROhqcqjMihyfmSRbzbE1PaVlPwmVIQvKPfLKkBup8WejEKRdtk3thM
         LheZvNOasFjkSPM86Ussd2B21OJ1atDPczLabIOH/7cL1CdIgzmOW9qoZ9g+Y7qqbW9m
         bZQ2yz8tsn4cjknWcLYwgek/x0nSPn3Em9+/w9lDCmxI6NYf3ig4wrxw9se+PoKRbftD
         Q/DQ==
X-Gm-Message-State: AOJu0YxBtLB0Gbznluc8kPT3Rx93kq25IUrlziS92Tkj1lZ82hmq3vXF
        SiZ9vE2VbYvf2uxt3jEYfyxYt4caZiGbXdjEU0gNesPvaiMWelMpoPff6kOcPhkbT+PGa2BXfWQ
        VXDdPWVxmeP+QyZ3Tb5MDIpgIwz+Oj4oU
X-Received: by 2002:a2e:98d1:0:b0:2ba:18e5:106d with SMTP id s17-20020a2e98d1000000b002ba18e5106dmr1225119ljj.1.1691570714400;
        Wed, 09 Aug 2023 01:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrBjsWYV/sqaAv48pc5EhuM1T8uSpnL+4lUdPGd//OkNBiz2K3XtGjh//OSr3+g8r4ELpQmQ==
X-Received: by 2002:a2e:98d1:0:b0:2ba:18e5:106d with SMTP id s17-20020a2e98d1000000b002ba18e5106dmr1225107ljj.1.1691570713996;
        Wed, 09 Aug 2023 01:45:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5? (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de. [2003:cb:c70e:6800:9933:28db:f83a:ef5])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b003fbc9d178a8sm1289112wmb.4.2023.08.09.01.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:45:13 -0700 (PDT)
Message-ID: <f1241306-f527-2a21-02d8-ff63167aa698@redhat.com>
Date:   Wed, 9 Aug 2023 10:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/compaction: remove unused parameter pgdata of
 fragmentation_score_wmark
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230809094910.3092446-1-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230809094910.3092446-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.23 11:49, Kemeng Shi wrote:
> Parameter pgdat is not used in fragmentation_score_wmark. Just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

