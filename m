Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717747AE709
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjIZHmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIZHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40892
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695714097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atusoG9wLQHzNwdybhnCWWKEaRPb6i3DYWEjDPOaKuc=;
        b=jOxjFjjZpe02XAH6eoMjprTJGjkGQiuOJu3jfXfI0AkBxxxXeZhk9shwz6In/UgiI/IMev
        D0TggMu4NJJKJS/f/FemVwFCgA/IDlgwrrRIRs8yhC8P0zENDfB0DN7dgYG62c52+UE7Xz
        ChrRXq4ob/r4R2kYP/DKJhGh8TDE024=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ZRBD1q--Mt6mn0WKrBBCAQ-1; Tue, 26 Sep 2023 03:41:36 -0400
X-MC-Unique: ZRBD1q--Mt6mn0WKrBBCAQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae42088b4bso671318166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695714095; x=1696318895;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atusoG9wLQHzNwdybhnCWWKEaRPb6i3DYWEjDPOaKuc=;
        b=AUOL4+PKlCkVQH/My1T5oV77XcXqlZEqUAYktNpDG0TuqFUPekqrn35RAL2y5fugZB
         +RFdEEjLWXSv0Qdlma1l1kW3rpBSUyCo5EOeciECXK81DKO/ZM0Z0SFJMyw/mvySUbdV
         bC8dvAszjKmkp90t3CU7VPLve1dk1WnwqBV6tMN0cHkiW9IdtMVRLStVvtboKsmz6Qbc
         VNqVUvVzH3EyRcaiwFK4viidIGxPapwT8XhXh0PSruGddoz8N/hd5BpmYPNF6JBsC2Gb
         tIC1YkFloqa9VhTYdAdyqlzT/4YD74HuLIs4f6VKHJyMb0B44USF9RGwslwQYfVYt8zt
         urRg==
X-Gm-Message-State: AOJu0YxAkN0kDy5w83WIQGw4Vhj4ocy69PimCvSb1DFA1AD2MIk2hHs/
        Fo5U/qDMcVlt0R837fHrhrjqNYsJ+fs94ypjeg3KqDP7Nk6ihG0XadIJEddlimlfj+r+icgH8ku
        knTR8qxdXjtW1wRTaneBrk88r
X-Received: by 2002:a17:907:7e84:b0:9ae:621b:af03 with SMTP id qb4-20020a1709077e8400b009ae621baf03mr10616494ejc.39.1695714095215;
        Tue, 26 Sep 2023 00:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZltpF2NY+qzQbeBmRGD2q15t7/K/DfBoa93SjpUV40Z+HXpuF36wm4hWjCH3lMzLPvhAg4g==
X-Received: by 2002:a17:907:7e84:b0:9ae:621b:af03 with SMTP id qb4-20020a1709077e8400b009ae621baf03mr10616468ejc.39.1695714094803;
        Tue, 26 Sep 2023 00:41:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:600:933b:ca69:5a80:230d? (p200300cbc73f0600933bca695a80230d.dip0.t-ipconnect.de. [2003:cb:c73f:600:933b:ca69:5a80:230d])
        by smtp.gmail.com with ESMTPSA id rh27-20020a17090720fb00b009930c80b87csm7493458ejb.142.2023.09.26.00.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 00:41:34 -0700 (PDT)
Message-ID: <ae2be79c-a030-a4d2-0d89-15efa17fe77c@redhat.com>
Date:   Tue, 26 Sep 2023 09:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/4] mm/ksm: add "smart" page scanning mode
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230926040939.516161-1-shr@devkernel.io>
 <20230926040939.516161-2-shr@devkernel.io>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230926040939.516161-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.23 06:09, Stefan Roesch wrote:
> This change adds a "smart" page scanning mode for KSM. So far all the
> candidate pages are continuously scanned to find candidates for
> de-duplication. There are a considerably number of pages that cannot be
> de-duplicated. This is costly in terms of CPU. By using smart scanning
> considerable CPU savings can be achieved.
> 
> This change takes the history of scanning pages into account and skips
> the page scanning of certain pages for a while if de-deduplication for
> this page has not been successful in the past.
> 
> To do this it introduces two new fields in the ksm_rmap_item structure:
> age and remaining_skips. age, is the KSM age and remaining_skips
> determines how often scanning of this page is skipped. The age field is
> incremented each time the page is scanned and the page cannot be de-
> duplicated. age updated is capped at U8_MAX.
> 
> How often a page is skipped is dependent how often de-duplication has
> been tried so far and the number of skips is currently limited to 8.
> This value has shown to be effective with different workloads.
> 
> The feature is currently disable by default and can be enabled with the
> new smart_scan knob.
> 
> The feature has shown to be very effective: upt to 25% of the page scans
> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
> a similar de-duplication rate can be maintained.

Thinking about it, what are the cons of just enabling this always and 
not exposing new toggles? Alternatively, we could make this a 
compile-time option.

In general, LGTM, just curious if we really have to make this configurable.

-- 
Cheers,

David / dhildenb

