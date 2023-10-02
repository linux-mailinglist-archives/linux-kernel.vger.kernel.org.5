Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665F37B50C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbjJBLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD75B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696244391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNg3nEOpUwhfLtl4Gfv+d61zrXncWfZX/sb9x36c/O4=;
        b=Kg/Qf9MnggE64wzKikXttXxSKSBZ/u9toNDRKqzKcXxdy5O3bq5paoKknl7fvshx7XtEI8
        HuIspAOckrdxSMh7mwhxvZ8nXqvwPcNr9jTJaBGNwMIYsRajd9U/bk/lXoxyspbG83haIi
        gJn5z0rM0YTrYduCksyxcFkjnvEA958=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-VIlZqTmqNBi_eyQO1T6l6w-1; Mon, 02 Oct 2023 06:59:27 -0400
X-MC-Unique: VIlZqTmqNBi_eyQO1T6l6w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-321726b0238so11712320f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244366; x=1696849166;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNg3nEOpUwhfLtl4Gfv+d61zrXncWfZX/sb9x36c/O4=;
        b=OxIRPw3c8DjuSaEkOiqJjEllYy8shegocirAt++WFx5u0Vq5m9qU9tmWCa9+SlgHNL
         4xYLQS78lzDIiNgdnEenhDLVgDrB8ddJ7MzF2yJvD5MaV5xrrcSzvRx0fA0JbiyRxxV5
         zEab0UINa46mqzXbEs4wUzjHcbII5vaBWhgo8TEJ0vw7Ecm9bMK/6PDas3PwYLyYw3T0
         99j9K28cNnZiFdii+gucl45Gpzas8NScQ48ORAtRpPOcakH1cVNnPAVkV7QzvHWJeGMB
         FisaY/BnggBK0M0U4WwsPtAv6HeAYyjrVkZQIKrZRDoYPg9q9+cJ+hYWQHj9uVqMoOx6
         nv8Q==
X-Gm-Message-State: AOJu0Yw2jVdL0ttzup20xM/nQYUdjBSu9xuaHWATzQm1zfiutvdvi5OY
        mq2bLOqUQH32hdk6wENZ5AVuoyLmd8OjvV1nReIxWf5ZbTKwytDbAh5X9pjCdORVV/60oTWG1E8
        RSbYzW8bFRuuFflw8xbSjyNWj
X-Received: by 2002:adf:e5d0:0:b0:324:8700:6421 with SMTP id a16-20020adfe5d0000000b0032487006421mr9940111wrn.3.1696244366408;
        Mon, 02 Oct 2023 03:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7+/wspCQe+ttuEnailDH3oMbBRWqWZxM95GNarmAdNoJ0f4ILn2ZzlLcxnZxSeOljT6fouA==
X-Received: by 2002:adf:e5d0:0:b0:324:8700:6421 with SMTP id a16-20020adfe5d0000000b0032487006421mr9940090wrn.3.1696244365935;
        Mon, 02 Oct 2023 03:59:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdcc5000000b0031c6581d55esm28162012wrm.91.2023.10.02.03.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 03:59:25 -0700 (PDT)
Message-ID: <428d07a6-bdc6-c12b-1b7e-e271bd841ff5@redhat.com>
Date:   Mon, 2 Oct 2023 12:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mm: make __access_remote_vm() static
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
References: <cover.1696174961.git.lstoakes@gmail.com>
 <70436dcf596565770e604a4fc4e8f27a14c85166.1696174961.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <70436dcf596565770e604a4fc4e8f27a14c85166.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.23 18:00, Lorenzo Stoakes wrote:
> access_remote_vm() passes through parameters to __access_remote_vm()
> directly, so remove the __access_remote_vm() function from mm.h aand use
> access_remote_vm() in the one caller that needs it (ptrace_access_vm()).
> 

Wondering why we even still have __access_remote_vm() in the first 
place, if it really should just be access_remote_vm() directly.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

