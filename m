Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4E7D9652
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjJ0LSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0LSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:18:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6876D187
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:18:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACCFC433C8;
        Fri, 27 Oct 2023 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698405526;
        bh=ChKI5CnRqli2HtpDxqYBsjQ7jd8800uzKWtd8Vt64oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLXTITAHInEv6CDg60jpeXI1TJctnEsGS/2JqotMkdQtv7TEvs3wO0dkdd/AeGMZf
         JhZ4UmNcDRGStzoSc0uixwv36lkBkwjROEueWNEqQWLzpQgek1uCfhtKOb7VFQXe2c
         CKdLHqfz1IN71X7/WrbsxqyCbnvV3bt3Cxh9RfKg=
Date:   Fri, 27 Oct 2023 13:18:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH reworded] Revert "nvmem: add new config option"
Message-ID: <2023102731-scorebook-equator-3f11@gregkh>
References: <20231023102759.31529-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023102759.31529-1-zajec5@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:27:59PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
> 
> Config option "no_of_node" is no longer needed since adding a more
> explicit and targeted option "add_legacy_fixed_of_cells".
> 
> That "no_of_node" config option was needed *earlier* to help mtd's case.
> 
> DT nodes of MTD partitions (that are also NVMEM devices) may contain
> subnodes. Those SHOULD NOT be treated as NVMEM fixed cells.
> 
> To prevent NVMEM core code from parsing subnodes a "no_of_node" option
> was added (and set to true in mtd) to make for_each_child_of_node() in
> NVMEM a no-op. That was a bit hacky because it was messing with
> "of_node" pointer to achieve some side-effect.
> 
> With the introduction of "add_legacy_fixed_of_cells" config option
> things got more explicit. MTD subsystem simply tells NVMEM when to look
> for fixed cells and there is no need to hack "of_node" pointer anymore.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Greg: I reworded this PATCH's commit message. It's hopefully clear now
>       that this revert is OK only with the "add_legacy_fixed_of_cells".

Much nicer, now applied, thanks!

greg k-h
