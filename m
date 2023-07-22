Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C675D957
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGVDMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGVDME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:12:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F833A9D;
        Fri, 21 Jul 2023 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6BOeP5XWcYuDsCh165K3twTxqZxGBagDOmzb4lGSWR8=; b=3J7/kxHx7WvK9wmf1ITy080leR
        IlAgjN03fIhG83CLKfbMwLIP1KdcDb77wvZ55HXz/B8P9SJ54E/PebwdY8wZQYTFkWOiNZ633nVX0
        og7Dc9N+iaBRFM5PZQVzkvQWif5ge2miLH6ss+DrwLKP59XtpTVtKzT9z5G2Lfb3Pw1EhKqxtgU6r
        AivJY3DIg4CHLschO9cDb6qCCFyyMuv6+rLP0KhLzvumeC7Cvr3iK6uia1STo3OgGpclYH+XOanYo
        7ahsuffhW4xbjvbDye4DX+9gRKZhc0+KZNDLF9c43U3A9iNPKOkYSnQP7132scohxBmzffWrj/kjL
        ubKAgSJA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qN32E-00FhJy-2E;
        Sat, 22 Jul 2023 03:11:58 +0000
Message-ID: <233853ab-235b-d4dd-cd69-588d1a83ce4f@infradead.org>
Date:   Fri, 21 Jul 2023 20:11:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB)
 driver
Content-Language: en-US
To:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-scsi@vger.kernel.org,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/21/23 18:40, Shyam Saini wrote:
> diff --git a/drivers/rpmb/Kconfig b/drivers/rpmb/Kconfig
> new file mode 100644
> index 000000000000..f2a9ebdc4435
> --- /dev/null
> +++ b/drivers/rpmb/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015-2019, Intel Corporation.
> +
> +config RPMB
> +	tristate "RPMB partition interface"
> +	help
> +	  Unified RPMB partition interface for RPMB capable devices such as
> +          eMMC and UFS. Provides interface for in kernel security controllers to

Indent the line above with one tab + 2 spaces instead of many spaces.

> +	  access RPMB partition.
> +
> +	  If unsure, select N.

Do we want a separate subdir in drivers/ for various "misc" drivers?
with only one driver in it?

Will there be other drivers in rpmb?

Thanks.
-- 
~Randy
