Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CFD7AE08E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjIYVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYVK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:10:29 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 85D35109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:10:22 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id A6158410A4;
        Mon, 25 Sep 2023 16:10:21 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 59Enhg-zmMGu; Mon, 25 Sep 2023 16:10:21 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 5827141030;
        Mon, 25 Sep 2023 16:10:21 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id gV-ALChgn-ry; Mon, 25 Sep 2023 16:10:21 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 12DC140F10;
        Mon, 25 Sep 2023 16:10:21 -0500 (CDT)
Message-ID: <62596842-2389-889c-752b-632cee7a6da7@foxvalley.net>
Date:   Mon, 25 Sep 2023 15:10:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Content-Language: en-US
From:   Dan Raymond <draymond@foxvalley.net>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        Peter Zijlstra <peterz@infradead.org>
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
In-Reply-To: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
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

Can I get more feedback on this please?  I think I've addressed all of
Peter Zijlstra's concerns:

1) cannot use early_console->write()

   That is not true.  Everything that includes boot.h (ie.
   'arch/x86/boot/early_serial_console.c') will not change due to the
   '#ifdef BOOT_BOOT_H' guard.  Also tracing will not be compiled in
   unless 'CONFIG_TRACEPOINTS' is true.  Finally, tracing will be
   disabled at boot until the user mounts the tracefs and explicitly
   enables 'portio' events.  When tracing is disabled the trace
   routines execute a nop instruction and return immediately.

2) tracing relies on RCU which might not be alive yet and might
   itself be the problem

   RCU is not needed unless/until tracing is enabled.  I also
   demonstrated that port I/O tracing works correctly during boot by
   testing this patch with "trace_event=portio" on the command line.

I plan to submit another patch due to the compiler warning reported
by the "kernel test robot".  Before I do that I would like to get
more feedback so I can address any other concerns or suggestions.

