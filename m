Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578477C4D87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjJKIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjJKIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:47:55 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F33B99C;
        Wed, 11 Oct 2023 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
        Content-Type; bh=z/u3FDFmAn4HYmmU69zyXVjoUFijdECuZcVLA9K/leA=;
        b=Hj2+hwGAkRKBrUZq+D7Xh/XAXb03GSrEYoyhQfOykvzpuF9VN05LXo9cjTBLEO
        vhhKhtLCfWWtsjlgO7slr6RSvTKhuYyJRGSNDCHc9amvWx1J5k69OgcnC1hQD1I2
        GJASx/s0gTkS9R91EkUJlhcTs3Z/s5o7LeJCozAIZ9CFo=
Received: from [172.20.10.2] (unknown [39.144.139.13])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDn916kXSZl6IAFAQ--.44147S3;
        Wed, 11 Oct 2023 16:32:37 +0800 (CST)
Message-ID: <bef5a084-9a6c-daaf-dad9-89cb5fc32bf9@163.com>
Date:   Fri, 28 Aug 2043 01:17:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-watchdog@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Wu, Xing Tong" <XingTong.Wu@siemens.com>, jan.kiszka@siemens.com,
        tobias.schaffner@siemens.com, cedric.hombourger@siemens.com,
        gerd.haeussler.ext@siemens.com
From:   "xingtong.wu" <xingtong_wu@163.com>
Subject: wdat_wdt: Problem with WDAT using shared registers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wDn916kXSZl6IAFAQ--.44147S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw47Zw1DAFWkury3Cw13twb_yoW8Wr45pa
        y5CFWjkrWvgr48uF4UXw1UCayrWFW7J3yayr4xA34Y9FWYkFWF9F9IyF1Fq3WDJr97WF1Y
        9ryDtr1fA3yDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jPWrJUUUUU=
X-Originating-IP: [39.144.139.13]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiOwcG0GC5nyLT8gAAsv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_DATE_IN_FUTURE_Q_PLUS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I want to use the wdat_wdt to support a watchdog of SIONCT (a multi-function device
(mfd)), and I register instructions for wdat_wdt in BIOS, it need registers 0x2e-0x2f
to access the watchdog, then register 0x2e-0x2f will be forever occupied by platform
device wdat_wdt, see the code: https://elixir.bootlin.com/linux/v6.6-rc5/source/drivers/acpi/acpi_watchdog.c#L180

but the 0x2e-0x2f are special, they are used for a multi-function device --SIONCT, the
device have many pins can not only support features for watchdog, but also other
features like leds, fans, temperature monitor... there are drivers for these pins, e.g.
gpio-f7188x, nct6775, w83627hf... these driver use the shared register 0x2e-0x2f. 

So the issue happened, the wdat_wdt occupied the shared register 0x2e-0x2f, then
the other driver can not load.

Here is the msg I collected from my device:

root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# cat /proc/ioports 
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  002e-002e : wdat_wdt
  002f-002f : wdat_wdt

It will cause other SIONCT drivers can not load, e.g.
root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# modprobe gpio-f7188x
modprobe: ERROR: could not insert 'gpio_f7188x': No such device

And dmesg info is:
[  213.559168] gpio-f7188xI/O address 0x002e already in use

Same reason for other drivers:
root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# modprobe nct6775
modprobe: ERROR: could not insert 'nct6775': No such device

Do you have any idea for the wdat_wdt to add support for multi-function device?

BRS
Xing Tong Wu

