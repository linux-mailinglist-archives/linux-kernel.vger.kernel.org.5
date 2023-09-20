Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4891E7A6FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjITAb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITAb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:31:26 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 022D5AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:31:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 81FDF40F95;
        Tue, 19 Sep 2023 19:31:20 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VxMHyQuBtiv0; Tue, 19 Sep 2023 19:31:20 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 3382740F9A;
        Tue, 19 Sep 2023 19:31:20 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id x1V0nMIAzcHq; Tue, 19 Sep 2023 19:31:20 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id E1AE740F95;
        Tue, 19 Sep 2023 19:31:19 -0500 (CDT)
Message-ID: <07d3a395-48e9-c1ab-27bb-e48c41951a86@foxvalley.net>
Date:   Tue, 19 Sep 2023 18:31:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Content-Language: en-US
From:   Dan Raymond <draymond@foxvalley.net>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
 <202309200145.BvT2lk7a-lkp@intel.com>
 <7341871f-870d-b701-fb19-8ab66480318b@foxvalley.net>
In-Reply-To: <7341871f-870d-b701-fb19-8ab66480318b@foxvalley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature can also be used with boot-time tracing by adding
"trace_event=portio" to the kernel command line.  This will show,
for example, what port accesses were performed by the UART driver
when it loaded:

# dmesg | grep 16550
[    0.395213] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.395487] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.395886] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
# cat /sys/kernel/tracing/trace | grep 'port=0x02f'
            init-1       [000] d..1.     0.399132: portio_read: port=0x02f9 value=0x00 io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399138: portio_write: port=0x02f9 value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399143: portio_read: port=0x02f9 value=0x00 io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399145: portio_write: port=0x02f9 value=0x0f io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399151: portio_read: port=0x02f9 value=0x0f io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399152: portio_write: port=0x02f9 value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399154: portio_read: port=0x02fc value=0x00 io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399156: portio_read: port=0x02fb value=0x00 io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399158: portio_write: port=0x02fb value=0xbf io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399160: portio_write: port=0x02fa value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399162: portio_write: port=0x02fb value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399163: portio_write: port=0x02fa value=0x01 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399165: portio_read: port=0x02fa value=0xc1 io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399167: portio_write: port=0x02fb value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399169: portio_write: port=0x02fc value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399171: portio_write: port=0x02fa value=0x01 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399173: portio_write: port=0x02fa value=0x07 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399175: portio_write: port=0x02fa value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399176: portio_read: port=0x02f8 value=0x00 io_serial_in+0x0/0x80
            init-1       [000] d..1.     0.399178: portio_write: port=0x02f9 value=0x00 io_serial_out+0x0/0x40
            init-1       [000] d..1.     0.399203: portio_write: port=0x02fc value=0x00 io_serial_out+0x0/0x40
