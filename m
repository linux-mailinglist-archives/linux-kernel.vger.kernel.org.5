Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1177FD8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjK2Nxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjK2NxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE2C10E4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701266005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCRlZ8oiqaJTBcB7G2DHmy/vp26Z550XjGVY3C3y2Oo=;
        b=Bp9Ils0fKZ2EoAPIbvNkEYO+UTkL9GZnYvtvkblh6i2jQZZG9Gqz3chpLjxWdg2DTktc6m
        T8qSvLoOwChGOhqlNXbwdjYB8D+ehWhrn+994v2dRi8+RGCD2vL57mDxm057XIpUKUckGI
        l1l9XKeGzGju1uNsk/ahLJnDTOqDFT0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-2OdiCDlEOZOw-NvwKQTMcg-1; Wed, 29 Nov 2023 08:53:24 -0500
X-MC-Unique: 2OdiCDlEOZOw-NvwKQTMcg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-462997a9dacso2009483137.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266004; x=1701870804;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCRlZ8oiqaJTBcB7G2DHmy/vp26Z550XjGVY3C3y2Oo=;
        b=QdjO9bkqhPLrsTd3Jq0XiRAVW/zszqKSJBdNQUGttCOQku+kQhy5DphBrdgzQ/AEDC
         iQSAzueumcVyPEktwuRj1Qt7+ekyiO+HIyi2DtD3oaqDhmMJSUwSKO3X9+AVvmFunKeN
         uzNai3F7dAVRpYgRrcmwFb3KD/urdRTqNNLA90tK0BYtJQnS9JqYoJ7AlsQ57hoqdd+1
         D8EvWqsLIpnxJGJ72AtbVhGsx1CALP32YB3HrEWkY1BrCxapfGy2KraNVMvxjCfE767A
         MIFKIOtBmom+pHyEdiCr69E1xVQETyXwsV9nAZNRai/IT6ercEhYjFpzoSXmekprbs+k
         ADEA==
X-Gm-Message-State: AOJu0YxnzPVz7oOtoO/kc7De/1p4RrzmDjJII55b41wcfRzjw42UZlMQ
        Rm0Bg2Ax1DPxTSKx8fFCFXDq0iV8OynMjYWjdBYp7WazUoD4wuTRv0j33LsCQ0+GeCo+DCPvRmK
        h7kVefpXAqDMPz4Nw1fJhp8cG
X-Received: by 2002:a05:6102:34d1:b0:464:4f99:67cd with SMTP id a17-20020a05610234d100b004644f9967cdmr898014vst.25.1701266003949;
        Wed, 29 Nov 2023 05:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6XeoX3LySftJvfhNd92B8TROaD2k49rLLui+JpiO50N4F9wBA4UISs6o9ymk2BLyZlpB5+Q==
X-Received: by 2002:a05:6102:34d1:b0:464:4f99:67cd with SMTP id a17-20020a05610234d100b004644f9967cdmr897999vst.25.1701266003740;
        Wed, 29 Nov 2023 05:53:23 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id s7-20020a0cf647000000b0067a4396f9cdsm3018175qvm.8.2023.11.29.05.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 05:53:23 -0800 (PST)
Message-ID: <ac7a90a7-4d29-059b-fbff-6b67e6f5c2d3@redhat.com>
Date:   Wed, 29 Nov 2023 08:53:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Attreyee Mukherjee <tintinm2017@gmail.com>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
In-Reply-To: <20231129132527.8078-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 08:25, Bagas Sanjaya wrote:
> I was prompted to write this little grammar fix series when reading
> the fix from Attreyee [1], with review comments requesting changes
> to that fix. So here's my version of the fix, with reviews from [1]
> addressed (and distinct grammar fixes splitted).
> 

Typical kernel workflow would be for Attreyee to incorporate feedback
and post their v2 after a day or two.  From the format they posted, it
appears to be a first(ish) kernel contribution post.  Let's be kind and
patient so they we all may benefit from the practice of iterating on
their patch.

-- 
Joe

