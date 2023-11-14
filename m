Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C157EB039
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjKNMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKNMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E9189
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699966243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+dtR7uxZYKr8ZF2Mvilnq0MwzlXpAsQU4Jpz/lAT/98=;
        b=DlDbcEIeXX/clHcRl+5PvqRIj1d99M55+LA8IA5aD2uc1TavOW2AIbC3NhNNv5/u5rdJyV
        TyZQOFB0U0kBDvEOclTDfC1svJzkY3Ocjw2nJQxvcq/dHSPVioPG75COBleoDsYiw9S6YC
        1O+V2wK0tEETmhmHsxB3lg2kgHnSeJs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-TcUbLnZ2M6CzLU9qKKHwrA-1; Tue, 14 Nov 2023 07:50:41 -0500
X-MC-Unique: TcUbLnZ2M6CzLU9qKKHwrA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7788ea971caso614989285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966241; x=1700571041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dtR7uxZYKr8ZF2Mvilnq0MwzlXpAsQU4Jpz/lAT/98=;
        b=mMRybikYjmKaxApp4sWXGitr48/XqE0xhEt19lngbw+MuXv7UUaaiwQooRDzU9hUH/
         88pGmrZm6AEHhb/OaP7Q7rZLAG7jtABYcwHXMWCzw1O3Kn99ThHB4fKXB10Q7hHyHKiw
         08DYZ/1JnyOHzHuboYMEBMGxJQks1CRjv2Qgr6Tql+tf4cmElAfTuVL+eVC9OM0bVgSy
         gWESrjWWNrwjUzGAu6gLiSXRT5GIqyzr5Ja19BZ0MICsY6I91nl4AlqAaJQNzwNFxxIW
         2MBQIMnXNBwl7dsHEIM5xZxbZ0BkM6Wa78x+/uzYjD2BHPqUbA7//By31nrqkUOMawT0
         Yj8w==
X-Gm-Message-State: AOJu0YwMnckPaygujQcacMJnHLPqoDcwLz2AIBR1CrCReelJJMD4A9EE
        BvlknurElQ0zqMk3Y1SQhiZ9PfelMkRMi+t/rlqk1qOt2OB0CMAiUVaukQyzHEP39rEFITtIjEM
        ww8EgpXBJKlAWQkWDXrs0gwx3Fy5TnMDu
X-Received: by 2002:ae9:f808:0:b0:779:e2f2:2be3 with SMTP id x8-20020ae9f808000000b00779e2f22be3mr1984104qkh.30.1699966241034;
        Tue, 14 Nov 2023 04:50:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2/zjHMfgKXBv77NBDBXPIwXJPe13B0ErZi3LiGA1sLO98BkmbiIkPxtcXMwHgeV07sNodaA==
X-Received: by 2002:ae9:f808:0:b0:779:e2f2:2be3 with SMTP id x8-20020ae9f808000000b00779e2f22be3mr1984089qkh.30.1699966240746;
        Tue, 14 Nov 2023 04:50:40 -0800 (PST)
Received: from [192.168.157.119] ([12.191.197.195])
        by smtp.googlemail.com with ESMTPSA id r17-20020a05620a299100b00767177a5bebsm2607897qkp.56.2023.11.14.04.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 04:50:39 -0800 (PST)
Message-ID: <3cfe0285-bf5a-4a0b-ae72-f5008c71d28e@redhat.com>
Date:   Tue, 14 Nov 2023 13:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the kvm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231114141326.38a3dcd4@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231114141326.38a3dcd4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 04:13, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/filesystems/api-summary:74: fs/anon_inodes.c:167: ERROR: Unexpected indentation.
> Documentation/filesystems/api-summary:74: fs/anon_inodes.c:168: WARNING: Block quote ends without a blank line; unexpected unindent.

This reproduces with the version of sphinx in
Documentation/sphinx/requirements.txt.  The fix is
simply this, for which I will send a patch:

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e02f4e2e2ece..0496cb5b6eab 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -163,8 +163,10 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
   *
   * Create a new anonymous inode and file pair.  This can be done for two
   * reasons:
+ *
   * - for the inode to have its own security context, so that LSMs can enforce
   *   policy on the inode's creation;
+ *
   * - if the caller needs a unique inode, for example in order to customize
   *   the size returned by fstat()
   *
@@ -250,8 +252,10 @@ EXPORT_SYMBOL_GPL(anon_inode_getfd);
   *
   * Create a new anonymous inode and file pair.  This can be done for two
   * reasons:
+ *
   * - for the inode to have its own security context, so that LSMs can enforce
   *   policy on the inode's creation;
+ *
   * - if the caller needs a unique inode, for example in order to customize
   *   the size returned by fstat()
   *

Paolo

