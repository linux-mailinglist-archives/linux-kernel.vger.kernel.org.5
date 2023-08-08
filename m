Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30092774147
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHHRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjHHRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:02 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9571F19
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:06:58 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C34AEEA5;
        Tue,  8 Aug 2023 08:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1691476690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhsEcFqZiHgGcTZd80cthbmqzTC3QEK1gP/svUayE5c=;
        b=Qr5b9UWfKwaskhKYb08Z0hRxrxO/+5No8pVLMACXu+7xSBtXE8PbAmuo29iw2Nn6DxuiY5
        viIu1NGcT5T/JVaee08JPKoz3LmwWzhWsD03VCETZplaX0LgcR8nNtwEkzykR2WYou/w7S
        lYWaa9rs3CrRYaN5WbX7twLGkIHlNosjpVgCZuP0Iwttyfjc4xT97AAvUKWqe8WtqngCWh
        8Y0UgP4+Y82cRTGOqWML/6lb/Hf+MgvgOSj6TYfkTM5vVXKxaelbAxzBo15dJZlF0igbUY
        Wd2w2luUYE39Sujgg7f4paxKiOUcE/GfR4t2pbZGu16nGeK67GZKUj63I3P3qw==
MIME-Version: 1.0
Date:   Tue, 08 Aug 2023 08:38:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v9 2/7] nvmem: core: Return NULL when no nvmem layout is
 found
In-Reply-To: <20230808062932.150588-3-miquel.raynal@bootlin.com>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
 <20230808062932.150588-3-miquel.raynal@bootlin.com>
Message-ID: <5270b7f6e571d4016eb7018745fc0e88@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-08 08:29, schrieb Miquel Raynal:
> Currently, of_nvmem_layout_get_container() returns NULL on error, or an
> error pointer if either CONFIG_NVMEM or CONFIG_OF is turned off. We
> should likely avoid this kind of mix for two reasons: to clarify the
> intend and anyway fix the !CONFIG_OF which will likely always if we use
> this helper somewhere else. Let's just return NULL when no layout is
> found, we don't need an error value here.
> 
> Link: 
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
> Fixes: 266570f496b9 ("nvmem: core: introduce NVMEM layouts")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Michael Walle <michael@walle.cc>
