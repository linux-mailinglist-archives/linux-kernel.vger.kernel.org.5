Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D457709EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjHDUnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHDUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F64ECB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7162D620B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCC3C433C8;
        Fri,  4 Aug 2023 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181766;
        bh=h38XqAf/cJuAIlpBpr4KFvmbr9bN/47iqdte68UwsFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eir7av81r/doV7BE+4HwQFpwwtTYplldGx/4AWT4vOhTRbOI0yFoD3TvFECqE86Qr
         22pjN3cW2OUBfeeaTUSGfG6R+aebkt4+TpCYUGq2ahP2c7L2yw+ANcRUVTE1Lbh2G+
         fRW2lTYdPFJekqGBV/z3r2MQsT5ni690118tow1ghkzYie2sXMTP1f+Z+CROaqMHkv
         mr4nXnYSHdxlNDqgsrM2gJ/rD5Q0y54IGvXsVGC4N1YV3SBeRV//7qUKTz50NUBN66
         UkX6ithIAj+PzhLVKUEniqcQoqNRgtH2DnINfoI+2NdAPa9v9VoaUpTqv1eZLUF6pn
         7khrR6hFrEXtA==
Date:   Fri, 4 Aug 2023 22:42:41 +0200
From:   Simon Horman <horms@kernel.org>
To:     "huangjie.albert" <huangjie.albert@bytedance.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 02/10] xsk: add
 dma_check_skip for  skipping dma check
Message-ID: <ZM1iwWnQ+derTtfS@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-3-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-3-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:04:28PM +0800, huangjie.albert wrote:
> for the virtual net device such as veth, there is
> no need to do dma check if we support zero copy.
> 
> add this flag after unaligned. beacause there are 4 bytes hole

nit: beacause there are 4 bytes hole
  -> Because there is a 4 byte hole.
