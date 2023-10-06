Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC47BB753
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjJFMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjJFMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714CEC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696594041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mo9zpx89HxvD+wCjQVsipj/wDUSBSLOEMGb8AiuZqs8=;
        b=dHo2kEQj5ChQwvRToogBeePTDu4Lk8D2MDieQu2bvmDEKm4GWDrWOD7vi7kH+JL3QlOdWP
        rgipB9A4rqVNN4sSXtwoiK7iW1nN3nv77xo+TCuJW1DbnvdANYkSVLKv9hql2El/U5WOBe
        L9J/XlBj77GHTkuzGIspWtuLjIafQQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-6E9XyrP-PL-xXxdckkGKLg-1; Fri, 06 Oct 2023 08:07:19 -0400
X-MC-Unique: 6E9XyrP-PL-xXxdckkGKLg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-321726b0238so1341608f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696594038; x=1697198838;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mo9zpx89HxvD+wCjQVsipj/wDUSBSLOEMGb8AiuZqs8=;
        b=MTe3m0PjQPtT1NCFEUBl7Q2yQge5Y80bqGMPuPsjB0CvYPJZs8dyYVEhX8/ruwWqd/
         /NdstTwvzUdlsFYRYhizAD+uVGgsOjotwKsMYUiPVG+Il6/6v4tCMRc2jbLktaq748Q4
         MItPpBcis+kA0HkFiZ3MgMKON380fowm03g+Ulu+f7Kd8KlVIC7eh4tm4wlj3KRZNZy7
         UgtwjJ0izENr3QO//7uRuPf8abufTuHGYU555h22+tf9LkP2APlr4v3V0sQ0aLJkIYIs
         CDCoxQ+2yuUNmty5bs+6QEY5SicLqdwN428U5unDFHQm+fr6mleUNoi9sNV/1GMmmSbm
         7qfA==
X-Gm-Message-State: AOJu0YzrliemOTVL/O4b+tvg+Z6y8suelvwVILkgv+wWwWKuX/yIDLaB
        MfDgqMli5a40OZIj+98Touky/HhI9iIkcqNKvSXCNIsAsV7XdxsP2cAtTcsHONTIlO0lNZHfeZE
        JSDKeqDEn04qHs1Ndt3QR25Rd
X-Received: by 2002:a5d:60d1:0:b0:321:7052:6406 with SMTP id x17-20020a5d60d1000000b0032170526406mr7192664wrt.12.1696594038570;
        Fri, 06 Oct 2023 05:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpduvGP/C6QnolRK8aHspaHKLXehNdqORMvSI32y4q5yebiSCRs3O9GH2N+lutkWDhTkxXzA==
X-Received: by 2002:a5d:60d1:0:b0:321:7052:6406 with SMTP id x17-20020a5d60d1000000b0032170526406mr7192641wrt.12.1696594038066;
        Fri, 06 Oct 2023 05:07:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id j14-20020adff54e000000b003233a31a467sm1516389wrp.34.2023.10.06.05.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:07:17 -0700 (PDT)
Message-ID: <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
Date:   Fri, 6 Oct 2023 14:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        keescook@chromium.org, ebiederm@xmission.com, oleg@redhat.com,
        yzaikin@google.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        dave@stgolabs.net, sonicadvance1@gmail.com, joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230907204256.3700336-1-gpiccoli@igalia.com>
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

On 07.09.23 22:24, Guilherme G. Piccoli wrote:
> Currently the kernel provides a symlink to the executable binary, in the
> form of procfs file exe_file (/proc/self/exe_file for example). But what
> happens in interpreted scenarios (like binfmt_misc) is that such link
> always points to the *interpreter*. For cases of Linux binary emulators,
> like FEX [0] for example, it's then necessary to somehow mask that and
> emulate the true binary path.

I'm absolutely no expert on that, but I'm wondering if, instead of 
modifying exe_file and adding an interpreter file, you'd want to leave 
exe_file alone and instead provide an easier way to obtain the 
interpreted file.

Can you maybe describe why modifying exe_file is desired (about which 
consumers are we worrying? ) and what exactly FEX does to handle that 
(how does it mask that?).

So a bit more background on the challenges without this change would be 
appreciated.

-- 
Cheers,

David / dhildenb

