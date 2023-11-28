Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9237FB099
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjK1CbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1CbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:31:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FA18F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:31:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397BBC433C8;
        Tue, 28 Nov 2023 02:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701138683;
        bh=12Z7HzUo3/r0spozVJVoWPFG9KwgUbNUj53Z2ukP+rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hhL9uGfi10LhJYV8ay6kFzT/RkQdxTbkIUx5qvrpzkzYA2vhoJn8BN0cSowQCq9lz
         7OfrQR28sPUC9e3x+8LJr35rF+vGcp4DlwCg5LmEd1UsGDdZ9QCXtxzg08C/P4T5hW
         46yz76Y1YRf3/3k1h4KoyQ/GZ5d13GRuGkpPHlh22Bb377cvtG+azedvcXbcphQb5V
         S6PQPnv/biGq5G5CZzISAKfvUxz+IO6IZi2dOXCx7fbH54JUdOPC3bN0G3NFyIZH2A
         NnebbFjnWao5lvOVoKAv4ORwZnrgE0n57noE3mNoU3tbAN5Inosb/01lorDUzxxSqh
         QFJ/WXZlBYl3g==
Date:   Mon, 27 Nov 2023 18:31:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] octeontx2-af: Fix possible buffer overflow
Message-ID: <20231127183122.1e51a444@kernel.org>
In-Reply-To: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
References: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 00:08:02 +0300 Elena Salomatkina wrote:
> A loop in rvu_mbox_handler_nix_bandprof_free() contains
> a break if (idx == MAX_BANDPROF_PER_PFFUNC),
> but if idx may reach MAX_BANDPROF_PER_PFFUNC
> buffer '(*req->prof_idx)[layer]' overflow happens before that check.
> 
> The patch moves the break to the
> beginning of the loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e8e095b3b370 ("octeontx2-af: cn10k: Bandwidth profiles config support").
> Signed-off-by: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Marvell folks, at least one of you has to review this. Please see:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
