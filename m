Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E355479779A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjIGQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbjIGQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:28:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D1211D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:15:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6941F66072AE;
        Thu,  7 Sep 2023 08:56:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694073412;
        bh=q75sDFLtsd4dXey/PJJXXBizzHw/kHvzSiXOWVo/1k4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diMx+z98IjGho6YklpvLmaYBJe2mGsynD+qPIgA94H2LsIOHzozkUe/uUoyAr+5xF
         3V1WmyslaLaNtmca/NGR0SrMur8rHq/XbFWKVgp1edqUJWQqXDqjfTMkufwFcNuzVo
         dYGuVrdOPm1p2FE48dKqhyDhwz9kfnx8Xx8CLKWCdO5NGMrKk67yRo4EmaeJswV1lc
         DLhL8cKfSgn/3nNePV/yCrDgW5l8Ml0EBjITjPYVdGQqa6FdtnsQrD9TBiJsNp+WtN
         nR4a62W/6NSGe4MVEZAiVeuZavymHdxIpWpgFS1P+bMhpTXRiCmuq6CAYR2G95YClq
         yuQGNVkeWMyew==
Date:   Thu, 7 Sep 2023 09:56:49 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v2 2/7] drm/gpuvm: rename struct
 drm_gpuva_manager to struct drm_gpuvm
Message-ID: <20230907095649.13dbd49c@collabora.com>
In-Reply-To: <20230906214723.4393-3-dakr@redhat.com>
References: <20230906214723.4393-1-dakr@redhat.com>
        <20230906214723.4393-3-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Sep 2023 23:47:10 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> Rename struct drm_gpuva_manager to struct drm_gpuvm including
> corresponding functions. This way the GPUVA manager's structures align
> very well with the documentation of VM_BIND [1] and VM_BIND locking [2].
> 
> It also provides a better foundation for the naming of data structures
> and functions introduced for implementing a common dma-resv per GPU-VM
> including tracking of external and evicted objects in subsequent
> patches.

I'm fine with this rename, but I feel like some bits are missing in
this patch. I see a few functions taking a drm_gpuvm object and still
being prefixed with drm_gpuva_ (I'm not talking about functions that
only manipulate a drm_gpuva object, but those updating the the VM state,
like the sm_map/unmap helpers), and I think it'd be preferable to
rename the source files and the Kconfig option too.
