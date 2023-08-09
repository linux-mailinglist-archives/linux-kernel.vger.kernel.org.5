Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C22775FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjHIMxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjHIMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:53:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A811FF6;
        Wed,  9 Aug 2023 05:53:40 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 152ED8675B;
        Wed,  9 Aug 2023 14:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1691585619;
        bh=hw4RzyctmlzANozqK6Bkc7KRJ5UeoA5H+3nKatGwGc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eG0nhmKGeIcfqHKL61L0dN5+ZAaEywiZszF1HcDhgx15LbZSoQODOS4qdcOG95SEx
         QcSQs25D/mekzkI4adxNEYJ4xLtOF4LO6C0Fdyw4cqJSt7P7fahcZW+lpq6SV9iPW/
         pfSvjUYmBHMDrTcKa4N10PG4qnNQjaSTyMVo0SBs+yoclYFMjM12h+PRzzkDWFwlBe
         AqwUj+ryjajDjULVMa6UGI1dD5Yem3mxa9UrNpmlqhyqKYtdBUX3ssq4SnKeM1nfic
         lq8h2BCNCiXzrJmXh5UfMR1jQ01NkaKNv8zB9W8CEVy962ISPXT6CzRQKe/wGsvX0V
         7i+wXVd1Hm9kA==
Message-ID: <85118937-c5fe-8f5c-5033-285f67087f64@denx.de>
Date:   Wed, 9 Aug 2023 14:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: build failure after merge of the leds-lj tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Lee Jones <lee@kernel.org>
Cc:     Isai Gaspar <isaiezequiel.gaspar@nxp.com>, #@denx.de,
        Basically@denx.de, rewrite@denx.de, the@denx.de, driver@denx.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230809131733.67238c8a@canb.auug.org.au>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230809131733.67238c8a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 05:17, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the leds-lj tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> FATAL: modpost: drivers/leds/leds-pca995x: sizeof(struct i2c_device_id)=32 is not a modulo of the size of section __mod_i2c__<identifier>_device_table=600.
> Fix definition of struct i2c_device_id in mod_devicetable.h
> 
> Presumably caused by commit
> 
>    ee4e80b2962e ("leds: pca995x: Add support for PCA995X chips")
> 
> I have reverted that commit for today.

Ah doh, the fix is trivial, proper patch is coming in a bit.

diff --git a/drivers/leds/leds-pca995x.c b/drivers/leds/leds-pca995x.c
index 3ac99a433fcd2..78215dff14997 100644
--- a/drivers/leds/leds-pca995x.c
+++ b/drivers/leds/leds-pca995x.c
@@ -187,7 +187,7 @@ static const struct of_device_id pca995x_of_match[] = {
         { .compatible = "nxp,pca9955b", .data = (void *)PCA995X_TYPE_B },
         {},
  };
-MODULE_DEVICE_TABLE(i2c, pca995x_of_match);
+MODULE_DEVICE_TABLE(of, pca995x_of_match);

  static struct i2c_driver pca995x_driver = {
         .driver = {

