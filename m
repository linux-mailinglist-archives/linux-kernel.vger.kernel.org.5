Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394AA753C92
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjGNOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGNOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:08:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858B173B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:08:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so2173917f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689343710; x=1691935710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CCTxlwbQxhJI8AjrVEOUZWY0xdsbdlM7lzLUFvpZaOw=;
        b=Epxzr3XL5e4l4EW5F1qcJuGwFaWaAKMyUrJ6o8b9279TiYT1DPkVw9n9VyrGKX81VP
         4NMMaNt9bNTbaumv8RDjF4SPxWB2+OVYzGd+RorQnp4PSz0JVqwBsWY3ZvjV1c2+e319
         wLcI3SUl86ka89+CZQup0ABsPjOAO3BJRaRldRraShuo9NTqY8nBZ/ZBHaRF7+z1INi6
         wq20yT1l0CJRZ4zpVx8A6mE5Cuyo8AIK6EkYe+HlsLcefR5mfxjdPBn8R6+/HFAl+9O9
         KaD9e7obgvyO8cfpJfNwZuHuaXeyPCsbPQUvAVrDq6g3PnESr2GoKBe0pqt233Ed2LLT
         wIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343710; x=1691935710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCTxlwbQxhJI8AjrVEOUZWY0xdsbdlM7lzLUFvpZaOw=;
        b=hRp8pcbFn+ZALbDRnE4Yk/1UExbRap7dQ6g7RRrQdyP++2C0HAZdtPYVWWqkVSqu/2
         KS6nN5g1JloGVSKYBfScVFNtO/UXUEJa8BPYqux4wNCunLfRHpZPdx2PHrYBdq8OUQol
         aHRnzNpLHD2PPyvzXbiqdB1U+OPCxdr5quCOZuXcreytsMF3tMe4xv8dYxRltMntdiM8
         entiwb1vnAmYxkGoGfT/jEdS3NR4Zz4xhOYBHABaX2dJv7Zrv0P6rohU/JwCovA1lZSE
         45+qoyUQi9NVb2CM/1c7jLXCe/tloDdelq9UYp+Z8jOBKdqKe6RK+DwjWlNnkaRE1mbb
         Nvkw==
X-Gm-Message-State: ABy/qLa9qZy6kpGJffwNHLu/IOC9TgqukdvwHs5pvIvtfx6BRXdeIwPA
        SIgHlHwW7amvEKAMCQCCrttNy3D+gh0E2tOAeFc=
X-Google-Smtp-Source: APBJJlEpU6teBRxalbQaxqFA5Wcp9eZRMT6nz+si2nYovlnOj8Uco3YCmrFRlWeYn7N8iuMrMlbkbQ==
X-Received: by 2002:adf:f106:0:b0:316:efb9:101d with SMTP id r6-20020adff106000000b00316efb9101dmr1848531wro.25.1689343709864;
        Fri, 14 Jul 2023 07:08:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s14-20020adfea8e000000b00301a351a8d6sm11057698wrm.84.2023.07.14.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:08:27 -0700 (PDT)
Date:   Fri, 14 Jul 2023 17:08:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>, Wang Ming <machel@vivo.com>,
        opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org,
        ntb@lists.linux.dev, Allen Hubbe <allenbh@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jon Mason <jdmason@kudzu.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Message-ID: <5d0cd0e0-d92e-42d3-a6d9-ec9fc3229b7b@kadam.mountain>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
 <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:44:11PM +0200, Markus Elfring wrote:
> > > It is expected that most callers should _ignore_ the errors
> > > return by debugfs_create_dir() in tool_setup_dbgfs()
> …
> > The patch itself is correct for sure:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> How does such information fit to the Linux development requirement
> for imperative change descriptions?
> 

Markus, you already replied to this thread.

Greg, HCH, Matthew Wilcox and Krzysztof Kozlowski have all asked you to
stop.  Those are respected kernel maintainers.  You should listen to
them.

If you see a bug, that's useful.  But if you're just nitpicking the
commit message, that's not useful.  We have explained this many times as
clearly as we know how.

> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94
> 
> 
> How do you think about to add the tag “Fixes” because of the deletion
> of an inappropriate error detection?

No.  It's not a bug fix so a Fixes tag is innappropriate.

regards,
dan carpenter

