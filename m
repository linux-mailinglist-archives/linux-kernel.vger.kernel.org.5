Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48488038F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjLDPhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjLDPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:37:18 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116DFB6;
        Mon,  4 Dec 2023 07:37:25 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2B7240E024E;
        Mon,  4 Dec 2023 15:37:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 57rtjTuPDXSa; Mon,  4 Dec 2023 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701704240; bh=kaO/sau2mcBySd1FCm7TU34cOIPXB62AwClHCJS5wzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCrLi1ypAd/XYvkwQQ7YfPFOXIME9Y6BGRO4HnAzbbz65mfnQXnZaBmWF/hyaLdhW
         2eiNCRdqtuV75pLDUKfY/l3q2H3N/Sf0KB6TXR54l909KX0ylb3zytv8fjC8TLpRT/
         0/K6Hv+U2u2g7HCZe/cluFhbJmsoxfYAf8UxhP2y9/KLk7QOTEAPwD7JXWUzzLPGl1
         qKdFwAKTI24kGWKd6QCCQlUt1RhxmfCrWXgS7G/45YtAtFBg0+QGzl9Ps4YFqF/XkK
         dsYGlV7VakK8U+my8ej9eDAsGEaifng25JOfzRPJdL0uZmj7PjrqYOVofipMoOweXs
         dgvT2XWzGviloH8Lv66OREJDar/Tihdjc9hk7Jw6ID9+Pd+iWJJsGWbFKfoC8SItxi
         kJdSI6MuPboMy+lBY5sr8Yz6VsuQy5sdeKmu1tNA45WF0l4tXE2jeKMHAyV3KEKLfK
         +RJA3woPFCKAIu7b8afKztce7d5+Z7uTDXG/ZbTw0SqJylXoTNcbKUAollqo+sT6kX
         fQLRNNdljwROMZ57Ss0sJyRhFLqdL3HCIEHSzVBAxeQqy+KavbKiuIkEOp538fIveD
         wYoht3bG9RXpSHBQVwF9x42yiy6vj+MPjSFPsx6FDeXDyETHM8/O7FAinpw3PFnIEI
         8TAQRWTaONKRLKtz+8wCgNGI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DA2840E0195;
        Mon,  4 Dec 2023 15:36:47 +0000 (UTC)
Date:   Mon, 4 Dec 2023 16:36:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, alex.williamson@redhat.com,
        naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        tony.luck@intel.com, linmiaohe@huawei.com, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, shiju.jose@huawei.com,
        bhelgaas@google.com, pabeni@redhat.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, anuaggarwal@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, mochs@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-edac@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: Change ghes code to allow poison of
 non-struct pfn
Message-ID: <20231204153646.GCZW3yDgal3gztpDRY@fat_crate.local>
References: <20231123003513.24292-1-ankita@nvidia.com>
 <20231123003513.24292-4-ankita@nvidia.com>
 <20231202232319.GAZWu8Z6gsLp1kI5Dw@fat_crate.local>
 <20231204143650.GB1493156@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231204143650.GB1493156@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:36:50AM -0400, Jason Gunthorpe wrote:
> It wasn't removed. patch 1 moved it to memory_failure() where it makes
> a lot more sense.

Why is this a separate patch then?


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
