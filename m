Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2E759FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGSUfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGSUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA01FFB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689798810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeQ58+s3ydNE+ZDeEXKKQs2muy+W6aZRCJL3P8BTRTA=;
        b=fZ1o4ffoozJsY43x9ijfutipjuUtQ7qplI5T74rfE93rYNhU3ko7WXjoYAH0HWIKDv7acC
        aPyxqrUUw6vwDgGFTJiWrYT90t+fl1wipIUfKyR+7p/IPQ7qfWyjcx6Pts8HFFRVkgp0e9
        KlPi2htYv2P5akJjW+Y835ihMv4unjE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-KrVnUVPmNReR6tIkrCK0cw-1; Wed, 19 Jul 2023 16:33:29 -0400
X-MC-Unique: KrVnUVPmNReR6tIkrCK0cw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76735d5eb86so12336085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798808; x=1692390808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeQ58+s3ydNE+ZDeEXKKQs2muy+W6aZRCJL3P8BTRTA=;
        b=SJEt796ne1PRbSlS32gtRzbdJm8ICY1OSFDa0piXr8p4me4ZUrCIuEFMt1igZg/9g7
         uJFxCzHNIHhp+z2NrN9M2x7sgjt+308Bc4x5lFRM6303uwEkiAQjUvPG9oBeDQh/ICtd
         xCnNc5l2TlOHvV3zkUdTEJZ6+/N0flMsc9j8w6SJ9auBh62+N2JZPhIMO6udoRdsbgs+
         0S/THrYUOvjESzR1WdSrQ3d4LQ3RTmjkK/pBYhRHXOFij05TFhdZbz/RBLxdxfKjM1XQ
         ocTJ/x1G7z56WwVMIE1JK58bsG+xFB0KZJORnfw5Yjxt7xFSYzOFAt5xeO/NbRcLPvBt
         qRqQ==
X-Gm-Message-State: ABy/qLaIsV5TSwbDKvOYhwp3/OISv+LfzVU/90cFimGzAQNavUK6ObKf
        djM0za4byxEMXIsFeL6cpfw2XxRyYZHY5CCJCdaACjZtqKZ2VNgByIz8JMg8VYSiDOCHGzouKgy
        jj9sK+pLRJBkT0mBupgN5WmCR
X-Received: by 2002:a05:620a:371c:b0:763:c8be:819b with SMTP id de28-20020a05620a371c00b00763c8be819bmr5048324qkb.22.1689798808620;
        Wed, 19 Jul 2023 13:33:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqBWtCASiAcFBaiA8YWEIzWIlDpnk2lVpBXhi5uff2SKgxs9dYZCzbWtWj4ULUu1wD2Y9kVQ==
X-Received: by 2002:a05:620a:371c:b0:763:c8be:819b with SMTP id de28-20020a05620a371c00b00763c8be819bmr5048312qkb.22.1689798808379;
        Wed, 19 Jul 2023 13:33:28 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id v14-20020ae9e30e000000b00767f6391ccesm1478741qkf.135.2023.07.19.13.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 13:33:27 -0700 (PDT)
Message-ID: <b6941f79-5c9e-7c22-bee1-a00d32bea009@redhat.com>
Date:   Wed, 19 Jul 2023 16:33:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] x86: Rewrite ret_from_fork() in C
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, Brian Gerst <brgerst@gmail.com>,
        jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        joao@overdrivepizza.com, tim.c.chen@linux.intel.com,
        live-patching@vger.kernel.org
References: <20230623225529.34590-1-brgerst@gmail.com>
 <20230623225529.34590-3-brgerst@gmail.com> <ZLf_Z5dCSm7zKDel@alley>
From:   Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <ZLf_Z5dCSm7zKDel@alley>
Content-Type: text/plain; charset=UTF-8
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

On 7/19/23 11:21, Petr Mladek wrote:
> On Fri 2023-06-23 18:55:29, Brian Gerst wrote:
>> When kCFI is enabled, special handling is needed for the indirect call
>> to the kernel thread function.  Rewrite the ret_from_fork() function in
>> C so that the compiler can properly handle the indirect call.
> 
> This patch broke livepatching. Kthreads never have a reliable stack.
> It works when I revert it.
> 

Just curious -- did the selftests catch this anywhere?  I'm not 100%
clear on what trees / frequency they all run, so maybe Petr you found
this by code inspection or other means?

-- 
Joe

