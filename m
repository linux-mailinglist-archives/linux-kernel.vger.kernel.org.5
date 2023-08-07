Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8437727B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjHGO3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjHGO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:29:43 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7941C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:29:40 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C8463143;
        Mon,  7 Aug 2023 16:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1691418578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kA1+D+3H2O2aFjUoPnK6l19oOD5Ur6ZKtE5pF9DiyrQ=;
        b=eFKKXTRsQ5FzZVZiwYtWnHL1WE7Ng8mksBUOxEJ+NI6H5/HnaS71fiiBHRaqPTxxIprLo2
        vhwSo7HNcOTU4R5kATq1CjUhT/C8K8YuwlnYXKIAJBML1pSpWTJEPmtOuKjK+A1ip0Wy2L
        xY2+35BIlsHms+x3aoTO44vFmYOjxEIofSex3MKkEc1oa4amTm7M8sRcuWR9js2XjfFgVM
        16O+P9DYA9NxgKKJ/SLDZqi37SUiMzcAyuNFIMJJcedDiC302h+l2zRXMeSJgSu2lVxJO3
        +bbOm4uHndzgjaOs3peK04cWW8eWPXHKgeOJrgaprM3y7kPZc3GfNCm9UeqMZQ==
MIME-Version: 1.0
Date:   Mon, 07 Aug 2023 16:29:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Walle <mwalle@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 06/41] mtd: spi-nor: default page_size to 256 bytes
In-Reply-To: <20230807154754.70e994fa@xps-13>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
 <20230807-mtd-flash-info-db-rework-v1-6-3d3d5bef4ba4@kernel.org>
 <20230807154754.70e994fa@xps-13>
Message-ID: <cebd793208c9956e0c7be1b528e16627@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

>> +	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> 
> Would you mind clarifying this? It does not look right, while
> perhaps it is. But TBH, I have no idea what params->page_size will be
> after this assignment.

It's info->page_size, it's a shortcut [1].

I'm not the first one using it (in fact I was explicitly asked to use 
it,
e.g. in gpio subsys):

$ grep -r "?:" **/*.c |wc -l
1268

-michael

[1] https://en.wikipedia.org/wiki/Elvis_operator
