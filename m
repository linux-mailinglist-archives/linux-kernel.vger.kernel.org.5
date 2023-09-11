Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23A79BE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355980AbjIKWCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbjIKO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:58:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B19E40;
        Mon, 11 Sep 2023 07:58:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC149C433C8;
        Mon, 11 Sep 2023 14:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694444328;
        bh=ElBM/KqIFBZMLgqkcIjsypNkZ50Q+YUJl4HU6zRkfek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAFGBX6lY9IYbWAu8h+uiNoMOiLaq26BbLyEvk5MjFus/HU1S/U7h5ES2T/fCoIH3
         Czh3CnX3xHkdzrzT3AJXYqb8hZbRM+9TlmsU46IqUBO/xJkMt3vzl7C6rGEd/HpkI7
         y9ZsN8N7b5qZhsEcb+SuKxRut34O9vTIFQaDALCno2Q1pEZCPjz4ZcHKNva3AsR/al
         s0jJLRJTkl8MauZ0TSUhwLFgh+yv1I/621//5LBw/4FhJtKHRj6fwMNXxw3u7EOrbh
         kJbOdFi3jUNHtEuVTMi4q4UxqMOvXtSxZhxXMiV7JJgJzbPjI0xcTNMmTlMOsIAdPe
         7h1CLd0GHHaiA==
Received: (nullmailer pid 1247017 invoked by uid 1000);
        Mon, 11 Sep 2023 14:58:46 -0000
Date:   Mon, 11 Sep 2023 09:58:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in
 of_changeset_action()
Message-ID: <169444431966.1246837.7857965062714574561.robh@kernel.org>
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Sep 2023 10:03:50 +0300, Dan Carpenter wrote:
> Smatch complains that the error path where "action" is invalid leaks
> the "ce" allocation:
>     drivers/of/dynamic.c:935 of_changeset_action()
>     warn: possible memory leak of 'ce'
> 
> Fix this by doing the validation before the allocation.
> 
> Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/of/dynamic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!

