Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C473754172
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjGNRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjGNRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D73AAB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:53:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37AA161D9B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF584C433C7;
        Fri, 14 Jul 2023 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689357136;
        bh=Q9mezWlx47FebY29tWWEXbHoAxzft3y2EeUU3sZ0gkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FLwX4HmX2J4hRmpABq6/J0Cp639OF2XY5geuZlVWMHG8hD+tvdkhL3D7hXDw+XsVo
         GTWzxiyFMqEbEQO48a8ctdZPliEp9bEvCwFEggf+uoD7jkhPzb+Bkj87TVDu6xaai9
         luEPYgasVrQUleaJ/JkYvlR3s1cvUC66fjPn0GFBGxzy9h/pn90+oiZAnTDhfjxmEy
         LUeOnU1au67JqPJBetoxluJm8r8IuFengcH/1micfGkjnT1KaOiqySmnGwnEsxM0l/
         wAgzNyXJYun6Nu6qseq7LfnXh2YwU0nHmQHklFz5JtCGOw6aps5sf3BGEHY2Dn0BB1
         7tNnToNT240yg==
Date:   Fri, 14 Jul 2023 10:52:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <yunshenglin0825@gmail.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230714105214.39ad4e4d@kernel.org>
In-Reply-To: <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
        <20230707170157.12727e44@kernel.org>
        <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
        <20230710113841.482cbeac@kernel.org>
        <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
        <20230711093705.45454e41@kernel.org>
        <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
        <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
        <20230712102603.5038980e@kernel.org>
        <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 20:16:34 +0800 Yunsheng Lin wrote:
> > I should have clarified that "types.h" should also include pure
> > function declarations (and possibly static line wrappers like
> > pure get/set functions which only need locally defined types).  
> 
> So "types.h" is not supposed/allowed to include any header and
> it can include any function declarations and static line wrappers
> which do not depend on any other header? It means we need to forward
> declaring a lot of 'struct' type for function declarations, right?

Only those used in function prototypes. Pointers in structures 
are somewhat special and don't require fwd declaration.

> If it is the case, the "types.h" does not seems to match it's
> naming when we can not really define most of the 'struct' in "types.h",
> such as 'struct page_pool' need to include some header in order to
> have definition of 'struct delayed_work'.

Obviously. And refcount.h, and types.h.

> Similar issue for 'helpers.h', as it will include most of the
> definition of 'struct', which are not really helpers, right?
