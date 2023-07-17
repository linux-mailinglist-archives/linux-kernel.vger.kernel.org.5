Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36FE75603C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGQKTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6049116
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHoWeT3k0oCkctBou/LGtLiwy9OrswcWyu5I5fkSu4w=;
        b=SR4sYQRbE3WnRFEL5/b9z253V8WlABvcy5kKfS1nTt1GtuIyx/KEIorxVYUhaHxLf9B3E7
        mJkmyeQcbhBXiiuFSBjLTRyS3rnXblCozB+yKAqbonoJ3AkphsDimEIbN24sFKqUAFlQum
        sQpODi4HW3F4KdpOCT2K6UiaBXoJqag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-8X8Ntq1OOx-kJ4jbCmLb-g-1; Mon, 17 Jul 2023 06:18:26 -0400
X-MC-Unique: 8X8Ntq1OOx-kJ4jbCmLb-g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fb40d0623bso18638425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589105; x=1692181105;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHoWeT3k0oCkctBou/LGtLiwy9OrswcWyu5I5fkSu4w=;
        b=RpOP9Dzjo55p+DnGd6ZLFC3Y2Sqsu1Blo6+w18Juzs0t3MYQfsMjf/Yk7lhSAEW93A
         jaW5Ojja/jewKbf8iw/I2onxjwohbRNc+LmfsGwGjqFo3IMhTv1aZnYRcZeJ3nC0dFcY
         s2fXDnhPhmf069IPkOkKKdOW08GlAHcaZOGIT3DGeWb4lSF8aq7gSWcxx41SEA+QQ9MH
         Iu/oluNaGZiEBpq8RFXYeaT/t7QCarQ5tc82348OVenFpmRgZ1F0hqHdR6EptoGG0ZmV
         k0cGsmfrtl+Ea04qpffNJTFAxVxi8s7ByC6kqEZ5aASF5oJV4VPT0gbyUbCG9qFeEBba
         5now==
X-Gm-Message-State: ABy/qLZBvUf2BENa3gOrq0gJtHYjM1cSpmWn77yiIGDQSYyHdaxQRZie
        c5gjd4C1v3FY0DpWJq+PvjD7YUf8shbgjOaB482sAhNVqI/7T/nNyvL9vRR1XRh8hUzAJneUTNV
        cpfgctqoASfe8HGd5j/xlubG5
X-Received: by 2002:a1c:6a0d:0:b0:3f6:d90:3db with SMTP id f13-20020a1c6a0d000000b003f60d9003dbmr8051510wmc.3.1689589105606;
        Mon, 17 Jul 2023 03:18:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXAwEt0G3ocK6LYcFJskU04JFjKbNuVps4YWOxcmWZoC06B/+aK8efLQhnmEvJQ7sJw5Luzw==
X-Received: by 2002:a1c:6a0d:0:b0:3f6:d90:3db with SMTP id f13-20020a1c6a0d000000b003f60d9003dbmr8051496wmc.3.1689589105245;
        Mon, 17 Jul 2023 03:18:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c224600b003fbc89af035sm7737306wmm.17.2023.07.17.03.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:18:24 -0700 (PDT)
Message-ID: <2c3b08b8-2824-998e-6571-ec4960862420@redhat.com>
Date:   Mon, 17 Jul 2023 12:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/mm_init.c: drop node_start_pfn from
 adjust_zone_range_for_zone_movable()
To:     Haifeng Xu <haifeng.xu@shopee.com>, rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230717065811.1262-1-haifeng.xu@shopee.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717065811.1262-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 08:58, Haifeng Xu wrote:
> node_start_pfn is not used in adjust_zone_range_for_zone_movable(), so
> it is pointless to waste a function argument. Drop the parameter.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

