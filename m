Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06FF7685F4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjG3ORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG3ORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A11D3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1661660C85
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3813C433C8;
        Sun, 30 Jul 2023 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690726637;
        bh=/SgtMSC4gFWZmhxWNtgshquG2Pqs3414Skm+heLmjis=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q+KeLsHOXV4yh/Gebrk5sQoIu4B3MB+9eRfzf7/9Cuvk8b4e23bi0eeT+9caELcfx
         4Nz81yP9OMGyU0P8w4LvKZx6s6ZNfKrR/CaItNQ7n+HGIeWmP3otxeLJFuJHVxZuFj
         h5UtRmXz/Co1bmvj1IO1CDSbNP7h757xKBWwJvYUArpbJSPuoQ87CdaEp/5aAZld+5
         C520t9rNHJWmaAUBgrpsRpXTXX6XDFROCiffBGDk3qJx2cUV/juVSk6SytscekXOEq
         /XoRzuzX7nM/5LqaoE65l8bdjTOHUzbwLATxS8NctwhPctQ0jJulYVDcmjO49xtes2
         uHRbd2ALXJxKA==
Message-ID: <9735ac90-d5bd-2cfa-2ac2-d381faa18747@kernel.org>
Date:   Sun, 30 Jul 2023 22:17:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] erofs: DEFLATE compression support
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230730141245.6691-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230730141245.6691-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/30 22:12, Gao Xiang wrote:
> Add DEFLATE compression as the 3rd supported algorithm.
> 
> DEFLATE is a popular generic-purpose compression algorithm for quite
> long time (many advanced formats like gzip, zlib, zip, png are all
> based on that) as Apple documentation written "If you require
> interoperability with non-Apple devices, use COMPRESSION_ZLIB. [1]".
> 
> Due to its popularity, there are several hardware on-market DEFLATE
> accelerators, such as (s390) DFLTCC, (Intel) IAA/QAT, (HiSilicon) ZIP
> accelerator, etc.  In addition, there are also several high-performence
> IP cores and even open-source FPGA approches available for DEFLATE.
> Therefore, it's useful to support DEFLATE compression in order to find
> a way to utilize these accelerators for asynchronous I/Os and get
> benefits from these later.
> 
> Besides, it's a good choice to trade off between compression ratios
> and performance compared to LZ4 and LZMA.  The DEFLATE core format is
> simple as well as easy to understand, therefore the code size of its
> decompressor is small even for the bootloader use cases.  The runtime
> memory consumption is quite limited too (e.g. 32K + ~7K for each zlib
> stream).  As usual, EROFS ourperforms similar approaches too.
> 
> Alternatively, DEFLATE could still be used for some specific files
> since EROFS supports multiple compression algorithms in one image.
> 
> [1] https://developer.apple.com/documentation/compression/compression_algorithm
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
