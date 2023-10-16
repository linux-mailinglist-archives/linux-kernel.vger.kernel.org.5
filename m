Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1387CB4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjJPUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjJPUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:48:51 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D5E1;
        Mon, 16 Oct 2023 13:48:49 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c434c33ec0so31592735ad.3;
        Mon, 16 Oct 2023 13:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489329; x=1698094129;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV9prvHA0M7QZinlPb4BQohxb6H26VD1PfEbZdebscE=;
        b=v4DyTWJr3pNB3KbHIypP7K96FMywZAOb8y+GXRGvvZE6Hr2zX8uqPpU9P4Q0j8zZ6Y
         /itKtgScVFwa97JLiWm+XtlTNBpTXi8bzKHSDdSZla35PQY60HO4/VU7Q9tp8t3XHdQK
         B9I4D3SQFL5s6uJnUHreylLu2qLyH0zMmnf7cEvIBDCJtZXEJSJtC+TdsuIxE/OmhR1L
         HKdDN4A6qBPxMrxu0rHOsfaIVQhn2rCX1b6Q2U3w+ClALO9Y5B1pIb807QAWXFNkTbmU
         7S7ubXya5O0ZDRLi4dIZr7Pf3ptgBJr+ILqlWs5LApnEq0//La1p59imV4oJQOlsfueC
         G/Kw==
X-Gm-Message-State: AOJu0YwjaLHA86TiDfzO3hW6BNgTT30bzOeQTKzQriEpJuOuWsXC/s3Z
        6A+DYdOgxXaNhcwhVfg+vVV43t2YTyD/Eg==
X-Google-Smtp-Source: AGHT+IFkvv/tv6RjlLyjM0ofju9bgKhWNmucCnhXIAxUZJd7JXif6CjF1EnK44LVsjoeQYMP3cL81Q==
X-Received: by 2002:a17:903:1206:b0:1bb:6875:5a73 with SMTP id l6-20020a170903120600b001bb68755a73mr499453plh.2.1697489328546;
        Mon, 16 Oct 2023 13:48:48 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001c88f77a156sm51257plh.153.2023.10.16.13.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:48:48 -0700 (PDT)
Message-ID: <fb983fa3-bf4d-42aa-b5c3-4927504c32d9@acm.org>
Date:   Mon, 16 Oct 2023 13:48:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi_status_is_good() uses __KERNEL__ constants.
Content-Language: en-US
To:     enh <enh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
References: <CAJgzZorfiG26TCfwNBVYJkkkVBAQowJhRUtX4EzWSxwZbfNoyw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJgzZorfiG26TCfwNBVYJkkkVBAQowJhRUtX4EzWSxwZbfNoyw@mail.gmail.com>
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

On 10/16/23 13:42, enh wrote:
> Without this missing #ifdef, userspace code trying to use this header
> directly won't compile. glibc manually removes it, bionic removes it
> using a script. If we add this, the preprocessor can remove it instead.

Is that the right solution? Shouldn't these software projects be
modified such that <scsi/scsi.h> is *not* included?

Thanks,

Bart.

