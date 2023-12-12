Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4D80EA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbjLLLR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346320AbjLLLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:17:23 -0500
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C675F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:17:24 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 8BE8711D04A2;
        Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 8BE8711D04A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1702379841; bh=x2Jm0xUedAtS0RUe8qmWwG38faX4FDQ1yRUOKkXwBI0=;
        h=From:To:CC:Subject:Date:From;
        b=gxcsFfRDr17YUaZXFg0rWjatkX9tAvNJ2Gul2BbjiUQr0McXov/6OwDxqjxr/7AdF
         IfKdmNOfweNTRcpNzjHAwABK5CvsvZ0z0EJHxnmkVelD1hn8PG6aOGcAJSUGWZuWEd
         f+G9UNnFfQZ7MSPaZBevzgEDWDSLMGagjq0hT8vs=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 875673029CDE;
        Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russ Gorby <russ.gorby@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Topic: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Index: AQHaLOzG4q0VQXlQGEK0PfABOy9uPw==
Date:   Tue, 12 Dec 2023 11:17:21 +0000
Message-ID: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/12 02:27:00 #22664189
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reports memory leak issue at gsmld_attach_gsm() in
5.10 stable releases. The reproducer injects the memory allocation
errors to tty_register_device(); as a result, tty_kref_get() isn't called
after this error, which leads to tty_struct leak.
The issue has been fixed by the following patches that can be cleanly
applied to the 5.10 branch.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller
