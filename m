Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1A7BB84F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjJFM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBEE83
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696597060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P72uFFNSSE0vKJxm+IxXc41kWoWIl9UwGtfO5HDJM5Q=;
        b=i5PNPn6eGUxmO2gloekuPPyf4v+Lk3SpIHOdqG8AXMOj7I+GPaBD7irfFbXP+F3h5eInfg
        eLlOHGcgrLQvPL+2k/LjnWdaFBT+Q7krt0h5DdLBSddE6xLtbNt7LB+Zuefx0ZEN8hFKDv
        CXfvkgCVhg8RsWMhxqBlWb2XiN82AGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-wfOR4xrHPfqUGmMwYzmCdQ-1; Fri, 06 Oct 2023 08:57:39 -0400
X-MC-Unique: wfOR4xrHPfqUGmMwYzmCdQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso15373865e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696597058; x=1697201858;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P72uFFNSSE0vKJxm+IxXc41kWoWIl9UwGtfO5HDJM5Q=;
        b=jJudgyGMpprMwUAZYaW1enx1EHnvi/L0M3OtbAHw488ah+PJOCqWBP94ZouYcLZKkQ
         wHpb6T5Ka3D9MXup9VwzXmGhRgZC+L66hYkrNXMgHb1eQmqefABfT9AFQfbUR5vTLuG4
         iGrsJznz28E3CDeR2/fzhe+tcegnDldq0EDP0aJ6c6ZeRfPhkii4UpkCCecsovA32nbA
         a5LBgOl1j0HSt8A7XhPCzQLi1w0p6ls3vILTcpGw7PpS6M3cAasJcfQKb31HcB+zZWQz
         /pZl2xK2HkaXsZy19FWMHI9on0dcx8dTCW61Mgw2PrNfmOCpF3Y8jNi10lSw624n3vA2
         HIbw==
X-Gm-Message-State: AOJu0YxzpRK6F/QXAAftGWYxugoXu7Unuv6uWeoNfujjJkEXbsyZ5s1h
        o3SK9vmEKwJ85rvVo336zJNJi9qgrDP1ZAisM6b3ZR5417CZCR7g/reWUFP1fu5IEqch6c7Niv5
        X1EJDNnMSiCRqbl6mf6KsN1Af
X-Received: by 2002:a05:600c:246:b0:405:3455:567e with SMTP id 6-20020a05600c024600b004053455567emr7145384wmj.5.1696597058120;
        Fri, 06 Oct 2023 05:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrmfJjyHMGFkRyzL7jLKZQ/tiiPpNKiRqiRcZEXdHFLDwxFTEU/qgtwVj7K45dXKQXT6eRQ==
X-Received: by 2002:a05:600c:246:b0:405:3455:567e with SMTP id 6-20020a05600c024600b004053455567emr7145346wmj.5.1696597057619;
        Fri, 06 Oct 2023 05:57:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe78e000000b0032196c508e3sm1612224wrm.53.2023.10.06.05.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:57:37 -0700 (PDT)
Message-ID: <4131ade7-c790-053c-99cb-3544f3c6523d@redhat.com>
Date:   Fri, 6 Oct 2023 14:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/4] mm/gup: adapt get_user_page_vma_remote() to never
 return NULL
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1696288092.git.lstoakes@gmail.com>
 <00319ce292d27b3aae76a0eb220ce3f528187508.1696288092.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <00319ce292d27b3aae76a0eb220ce3f528187508.1696288092.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.23 01:14, Lorenzo Stoakes wrote:
> get_user_pages_remote() will never return 0 except in the case of
> FOLL_NOWAIT being specified, which we explicitly disallow.
> 
> This simplifies error handling for the caller and avoids the awkwardness of
> dealing with both errors and failing to pin. Failing to pin here is an
> error.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

