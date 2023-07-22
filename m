Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965A75DCB0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGVM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:56:25 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E326AD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:56:23 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 25D8ED5D;
        Sat, 22 Jul 2023 14:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1690030581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cY+GrMkoeu4t+Kjc7C8tGN4af1/bHwoNAXDrlL7QiTU=;
        b=dqozFwTzC3vGF8iiG+UQvWXSZGvdG1SK+BuYvJuHHFmGFXqp6+iEjkd9H0rSKfOTPF+DTC
        R6tK7HAGRu0XUOnGk9/aCkcaG/b9E5+jC703XG8TNtpr0+ie2D8ADJ2yFFfrCqSdzVs3xV
        bkOeQnqd5XN1/EMG/TLjdjhGd0yEtnUS1SGsHT2cYBgIppqW8aetwPMiuQXhSsQj2qD0pB
        wOiHgPRCRaULrYVQbrOyC3bH+/cw/8leNzCMViX6q+GjLMrXzZng3JZpzKYJxSgG26tSab
        fLzoJ6XZ2+EvyTd0QfxS4rxCbQ/fo8GYkF54TmlGGk8t8iqqLUw4t02a3KGgUA==
MIME-Version: 1.0
Date:   Sat, 22 Jul 2023 14:56:20 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: let SFDP determine the flash and sector
 size
In-Reply-To: <20230722045901.9872-1-tudor.ambarus@linaro.org>
References: <20230722045901.9872-1-tudor.ambarus@linaro.org>
Message-ID: <56b679ea1b2424a55a8dc390ba23e7af@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-07-22 06:59, schrieb Tudor Ambarus:
> sector_size is used to determine the flash size and the erase size in
> case of uniform erase. n_sectors is used to determine the flash_size.
> But the flash size and the erase sizes are determined when parsing 
> SFDP,
> let SFDP determine them.

Great! I have a similar patch in my preparation for the flash info
cleanup, but for all the flashes.

The flash size is overwritten if PARSE_SFDP is set anyway. So
that's fine. The sector_size is used for the erase ops and the BP
locking. The erase ops should be initialized with the BFPT, too.
So whats left is the BP locking, which is just used for gd25q256.
For now we'd need to leave the sector_size there.

Would you also drop the size and sector size for all other
PARSE_SFDP flashes?

In any case:
Reviewed-by: Michael Walle <michael@walle.cc>

-michael
