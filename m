Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CB76CD1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjHBMkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjHBMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2B2D5B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690979921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fMrjSn9bbm0eVGFEHLPQSUpT9jkYQhCgCqVOLuzqsE=;
        b=H2LPSqWlqaOE1m5YxTMYL+Ipm6ZtbZvpQiPhgCPApC7NYWgR8xgB1cV3BVSE0gazZ6u56h
        4m1mOrfmH8sV5qubX76h52NGfejwi6wY6KqdykgftF1vXlgaCn42bo/+FVCFvQ5yoxHTIO
        gXnvPnMNr97EsoSSUH9byVUmH0BSDRs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-W0oeRb2ZOxW7h2w3rZVYUQ-1; Wed, 02 Aug 2023 08:38:40 -0400
X-MC-Unique: W0oeRb2ZOxW7h2w3rZVYUQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9fa64db5cso18366211fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979919; x=1691584719;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fMrjSn9bbm0eVGFEHLPQSUpT9jkYQhCgCqVOLuzqsE=;
        b=L1ada6WvZGUsThOEXG6bo+mVG5AvDY8HnPpUb0mOSYHtD1iGeu5QrpmCh7De7RGtB+
         bUWgA4cDasK8mgdwqhNNI/ufQ9T+4mmp3lzBOy/+7cpjYkzLRhmIwBJoW9ycR83rAWgu
         4pqVCrtTM3XYguw2lf09CdFraq6fYlgjgNFNhdPAH2Sfd/0ng1MMVSR/DX8HWEFliVV7
         LlG3E5LFD7NmqgTGl/5c9lV+u/GZXi51YG/v2mfdZt02UDWZ+IcVFWp/Gm4fCMPkrAiQ
         tklnJUBgZ0yz/P2plr66qhTHNs78ERl4WlPWwA9/AYT0XeV1PvmWPkI4wSYdWfT+1+Bs
         Fo0A==
X-Gm-Message-State: ABy/qLbEw820TToOzir6nrYBCskVcg6t5ZLYPnSqN68Ch2GV6YYwqMt0
        DBQ7cMInnV6auifA/sytSif1Womr5hAem8zUQWhIwSCKEbv17/05um2bCF45rR0YbbpsyhJchq5
        37OGvtA8/t1JPYmPJtCk5/AsO
X-Received: by 2002:a2e:920b:0:b0:2b6:af60:6342 with SMTP id k11-20020a2e920b000000b002b6af606342mr4822170ljg.40.1690979918794;
        Wed, 02 Aug 2023 05:38:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGS9E3dwJMfibVL9VXJMIiXb8USEiJlZJaU2Rilabt3jjGnTSyEuYjAZXbtoBvqyIlaYzJbIA==
X-Received: by 2002:a2e:920b:0:b0:2b6:af60:6342 with SMTP id k11-20020a2e920b000000b002b6af606342mr4822156ljg.40.1690979918391;
        Wed, 02 Aug 2023 05:38:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbcdba1a52sm1599151wma.3.2023.08.02.05.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:38:36 -0700 (PDT)
Message-ID: <4c6f4269-c67d-d15b-9a43-c510726e77bc@redhat.com>
Date:   Wed, 2 Aug 2023 14:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] mm: migrate: use __folio_test_movable()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-5-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802095346.87449-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.23 11:53, Kefeng Wang wrote:
> Use __folio_test_movable(), no need to convert from folio to page.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

