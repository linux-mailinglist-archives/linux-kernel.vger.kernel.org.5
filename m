Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7F7A6B90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjISTaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:30:16 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8E4CFE1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:30:10 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 6353640F39;
        Tue, 19 Sep 2023 14:30:09 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Ni6gDxYkaJzw; Tue, 19 Sep 2023 14:30:09 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id E8A0C40F3C;
        Tue, 19 Sep 2023 14:30:08 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YF4oFtho3epB; Tue, 19 Sep 2023 14:30:08 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id A297F40F39;
        Tue, 19 Sep 2023 14:30:08 -0500 (CDT)
Message-ID: <7341871f-870d-b701-fb19-8ab66480318b@foxvalley.net>
Date:   Tue, 19 Sep 2023 13:30:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
 <202309200145.BvT2lk7a-lkp@intel.com>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <202309200145.BvT2lk7a-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature was developed because there is currently no way to trace UART traffic when using an I/O port based serial port.  It can only be done with memory-mapped serial ports using CONFIG_MMIOTRACE or CONFIG_TRACE_MMIO_ACCESS.  Port I/O tracing can now be done as follows:

# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:16550A port:000002F8 irq:3 tx:60 rx:184 RTS|DTR
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3

# mount -t tracefs tracefs /sys/kernel/tracing
# cd /sys/kernel/tracing
# echo 'port >= 0x2f8 && port <= 0x2ff' > events/portio/filter
# echo 1 > events/portio/enable

(perform UART transaction on /dev/ttyS1)

# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 17/17   #P:1
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          my_app-90      [000] d..1.   130.595559: portio_write: port=0x02f9 value=0x07 io_serial_out+0x0/0x40
          my_app-90      [000] d.h2.   130.595574: portio_read: port=0x02fa value=0xc2 io_serial_in+0x0/0x80
          my_app-90      [000] d.h3.   130.595577: portio_read: port=0x02fd value=0x60 io_serial_in+0x0/0x80
          my_app-90      [000] d.h3.   130.595580: portio_read: port=0x02fe value=0x00 io_serial_in+0x0/0x80
          my_app-90      [000] d.h3.   130.595582: portio_write: port=0x02f8 value=0xc9 io_serial_out+0x0/0x40
          my_app-90      [000] d.h3.   130.595587: portio_write: port=0x02f9 value=0x05 io_serial_out+0x0/0x40
          my_app-90      [000] d.h2.   130.595590: portio_read: port=0x02fa value=0xc1 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h2.   130.745727: portio_read: port=0x02fa value=0xcc io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745733: portio_read: port=0x02fd value=0x61 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745736: portio_read: port=0x02f8 value=0xc9 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745740: portio_read: port=0x02fd value=0x61 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745742: portio_read: port=0x02f8 value=0xe8 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745744: portio_read: port=0x02fd value=0x61 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745746: portio_read: port=0x02f8 value=0x00 io_serial_in+0x0/0x80
          <idle>-0       [000] d.h3.   130.745748: portio_read: port=0x02fd value=0x60 io_serial_in+0x0/0x80
          <idle>-0       [000] dNh3.   130.745762: portio_read: port=0x02fe value=0x00 io_serial_in+0x0/0x80
          <idle>-0       [000] dNh2.   130.745765: portio_read: port=0x02fa value=0xc1 io_serial_in+0x0/0x80
