Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E786785BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbjHWPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjHWPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885BCEF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766E164847
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CBBC433CA;
        Wed, 23 Aug 2023 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692804181;
        bh=MwvciWjJAxrGTHVjYjuHMxSMWQJURLQ+4pJNMNFITpw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xw+CuoaDzA4jVZFlSn4MdBYYlizTsgBZIk+RD988KutEHGl9ju/msFCSCTbPLB1JB
         0SDd/DlnaUfs5uiAo+J3fGMmFpPAOb7z7PHlodg+J6ONfyuqWVw5npXxBWrmP9uBft
         wCuYbihiWAl8JSZuTCsKdtMuyVsf3fd/gFiKyIN6vJNWYRRJKryiDRu3kD3qeNmiBd
         j5kvnaEXMZrAmeUg+zLVFx65M8aJukNVgNgHTvSlCps9pFUolgXhPJIOx7LFmgu+Qy
         Qc4lt4G4m64HgHcd8kgDEzO/xOpmCZuUOjV/x4XmAk42rNUgDvCVnjjZm9woC26P1B
         jdAaz2b5FGC7w==
Message-ID: <4994e087-47cc-6b32-1daf-abf7026bdca4@kernel.org>
Date:   Wed, 23 Aug 2023 23:22:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] erofs: adapt folios for z_erofs_readahead()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-7-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-7-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/17 16:28, Gao Xiang wrote:
> It's a straight-forward conversion except that readahead_folio()
> will do folio_put() in advance but it doesn't matter since folios
> are still locked.
> 
> As before, since file-backed folios (pages for now) are locked, so
> we could temporarily use folio->private as an internal counter to
> indicate split parts of each folio for the corresponding pclusters
> to decompress.
> 
> When such counter becomes zero, the folio will be finally unlocked
> (see compress.h and z_erofs_onlinepage_endio()).
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
