Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7275B1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjGTOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjGTOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9312708
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689864694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkiNNvhZXBOhwappo5DsNfWFblN13jxPHvb5/iriC0Y=;
        b=VocUckPowaQyB9yrnL79v6fwLPnFNx4VQiVbf1dzJRob3jMWqtemnaB7O5Oe+pcpHidqoq
        Ees2sRGi/r8AVZhPD/kJmMYOorJCli1BhQZKSr1DRU2JMInwQOBelIYpwk3Vab2a5O2fpd
        Tu4LKrs1KvAoGdOEQWA3+PopAMMX6SQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-FWTRTPPtOqCQa3KUFDiKBw-1; Thu, 20 Jul 2023 10:51:33 -0400
X-MC-Unique: FWTRTPPtOqCQa3KUFDiKBw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635a4267cf5so11067006d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864692; x=1690469492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkiNNvhZXBOhwappo5DsNfWFblN13jxPHvb5/iriC0Y=;
        b=gTL2g+mBOkl/Kpa+HqSl8ZWHs1Z0mtolwCzLJOLwoj+szlzLZN/U3E3FEFvHzaTK3S
         zLdnNIRr3lkhGvRhMKaJQK1E4NlcFC+ZQkjl107RTaxCr74rqnXL7z7oadF5KeNVhpWl
         p5n/H3zEWnMBbbhlX74Kws42tqrMTFY+Yyfp9O3pIS0iwC2qFLRahr0cyV1l9lAGgs9P
         C93/U3ZyhTmfR8rjodsGQfuGIjjUwyZkpwDX0EPyAMDFr0aEGHwb2dzotg9ohtWrxyLo
         U+ujWTeRejz0tOZe1hOFtZj0xlnYb0b0bHwPrDh93j4v/yO1sbJ6Q36k8u/EACNXKJ6A
         l0ng==
X-Gm-Message-State: ABy/qLatlF4za+g6yEvl1kW76T5VBwZJRQ7h4y463MnmR22jFMTrpCXq
        0sw13PfxRSqj2tgPy17wCFiP+V1ZAzQQQl3FCjNhJbgm68ndaGuT10RxRFJV8u5+w+e0XzlW97K
        gWGugqQpjGpMl4hQbpubHmoKo
X-Received: by 2002:a0c:e012:0:b0:63c:c041:ef7c with SMTP id j18-20020a0ce012000000b0063cc041ef7cmr4998996qvk.16.1689864692600;
        Thu, 20 Jul 2023 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG9WiVjMAJC0jyp6FJ1iLPNYyic/lNvrnvPP6HMAfS4d7vXSpGs/eQms+dzXXL9v8chg2XyA==
X-Received: by 2002:a0c:e012:0:b0:63c:c041:ef7c with SMTP id j18-20020a0ce012000000b0063cc041ef7cmr4998979qvk.16.1689864692339;
        Thu, 20 Jul 2023 07:51:32 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id u4-20020a0cf1c4000000b006375f9fd170sm429007qvl.34.2023.07.20.07.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:51:31 -0700 (PDT)
Message-ID: <251d9862-e335-243e-d65a-c5538b4df253@redhat.com>
Date:   Thu, 20 Jul 2023 09:51:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: allow building a kernel without buffer_heads
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>
References: <20230720140452.63817-1-hch@lst.de>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20230720140452.63817-1-hch@lst.de>
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

On 7/20/23 9:04 AM, Christoph Hellwig wrote:
> Hi all,
> 
> This series allows to build a kernel without buffer_heads, which I
> think is useful to show where the dependencies are, and maybe also
> for some very much limited environments, where people just needs
> xfs and/or btrfs and some of the read-only block based file systems.
> 
> It first switches buffered writes (but not writeback) for block devices
> to use iomap unconditionally, but still using buffer_heads, and then
> adds a CONFIG_BUFFER_HEAD selected by all file systems that need it
> (which is most block based file systems), makes the buffer_head support
> in iomap optional, and adds an alternative implementation of the block
> device address_operations using iomap.  This latter implementation
> will also be useful to support block size > PAGE_SIZE for block device
> nodes as buffer_heads won't work very well for that.
> 
> Note that for now the md software raid drivers is also disabled as it has
> some (rather questionable) buffer_head usage in the unconditionally built
> bitmap code.  I have a series pending to make the bitmap code conditional
> and deprecated it, but it hasn't been merged yet.
> 
> Changes since v1:
>   - drop the already merged prep patches
>   - depend on FS_IOMAP not IOMAP
>   - pick a better new name for block_page_mkwrite_return
> 
Hi Christoph,

Gfs2 still uses buffer_heads to manage the metadata being pushed through 
its journals. We've been reducing our dependency on them but eliminating 
them altogether is a large and daunting task. We can still work toward 
that goal, but it will take time.

Bob Peterson

