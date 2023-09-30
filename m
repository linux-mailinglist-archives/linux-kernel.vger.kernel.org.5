Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E17B413E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjI3OvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjI3OvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:51:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9AC1B2;
        Sat, 30 Sep 2023 07:51:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E70CC433AD;
        Sat, 30 Sep 2023 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696085469;
        bh=/lLYV8RvUqyUZptiSLATFeHJqg+Lsns2VaQMO9wB+FQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H7Ws5/2qRmB4uJOVCDWKpwBIby8e0t3fSlOaRbpd0W9Oime3fkedtF/SqUSDLb1lt
         VgMJ5I7DOjAkfkUJ08GQY+H1U8a2xO90GwN+zhu1YgHHnjlj3NQvoPxiVqOFfDn+aW
         aVprqmb0HWfchE2Mbcx/pY4W8msSAbCeYdTt8plHDvRfb95swJFDjLYGzLwvDXgMfA
         8v9YmAPNlwAcsLeJiB8vl+iP/DsQoPqJmIcFz39//YVkJezQtQEiv43rKUZipeggtf
         w/qozQ7+yUOgzjzDRndqSo2duYO8j6MX5m39r26ueTdqkZwM0WwbuvNOxvJEvE6bAM
         xY0dFIivHzzeA==
Date:   Sat, 30 Sep 2023 15:51:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/27] staging: iio: resolver: ad2s1210: use regmap
 for config registers
Message-ID: <20230930155107.47bf5b1d@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-10-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-10-fa4364281745@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:23:15 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This makes use of the regmap API to read and write the configuration
> registers. This simplifies code quite a bit and makes it safer
> (previously, it was easy to write a bad value to the config registers
> which causes the chip to lock up and need to be reset).
> 
> This chip has multiple modes of operation. In normal mode, we do not use
> regmap since there is no addressing - data is just bitshifted out during
> the SPI read. In config mode, we use regmap since it requires writing
> the address (with read/write flag) before reading and writing.
> 
> We don't use the lock provided by the regmap because we need to also
> synchronize with the normal mode SPI reads and with the various GPIOs.
> 
> There is also a quirk when reading registers (other than the fault
> register). If the address/data bit is set in the value read, then it
> indicates there is a configuration parity error and the data is not
> valid. Previously, this was checked in a few places, but not
> consistently. Now, we always check it in the regmap read function.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

This was a complex change, so I'm partly relying on the fact it clearly
works after the change to be sure it is correct ;)

Anyhow, code is much cleaner and probably right, so applied to the
togreg branch of iio.git and pushed out as testing for all the normal
reasons.

Thanks,

Jonathan


