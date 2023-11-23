Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494377F63AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbjKWQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjKWQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:10:09 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C3F9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=6MDJzQW6p5t0CMfzt3lesKn8SgjBF5SbK9ItM13EcbY=; b=GD/7uBqzVdpVYhJLlemFOalNlp
        3Ux9HsL5jlgr55zSdBHKpxKKr2mmrgZbM4Dtyc0b7xUYspHwX6dvuHm4xBrmgyHezYY2YgwWuiWzx
        V6AsTNhwjAuqm2/7yEH//hkuq2TWJIuib9dQY+wvqhwOUSGl3AjNFVUHN4Er2I5v0zU4qDMlWt+eg
        YlcEwLD4ob/gN7k/riu26ksAQFY5qavqKhcFFeQXdTBF5lMVglr3jOlX3yDOFGdrYHEGxIQkB9BTa
        vwyO+ZmxxinYaTHmB/tyu3pjv6K2gn26/AtSJK0hOzwLh6dNU6GY5PG3Xny/xvrzfC0/oRNB1gP6N
        91cNg1fw==;
Received: from 189-69-166-209.dial-up.telesp.net.br ([189.69.166.209] helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1r6CHA-006Sic-Ky; Thu, 23 Nov 2023 17:10:00 +0100
Message-ID: <189e733e-7056-45c4-a5c6-3371f8219b7e@igalia.com>
Date:   Thu, 23 Nov 2023 13:09:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] futex: Add compat_sys_futex_waitv for 32bit
 compatibility
Content-Language: en-US
To:     Wei Gao <wegao@suse.com>
References: <20231123053140.16062-1-wegao@suse.com>
Cc:     tglx@linutronix.de, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@redhat.com,
        peterz@infradead.org, Arnd Bergmann <arnd@kernel.org>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20231123053140.16062-1-wegao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+CC Arnd]

Hi Wei,

Em 23/11/2023 02:31, Wei Gao escreveu:
> From: wei gao <wegao@suse.com>
> 
> Current implementation lead LTP test case futex_waitv failed when compiled with
> -m32. This patch add new compat_sys_futex_waitv to handle m32 mode syscall.
> 
> The failure reason is futex_waitv in m32 mode will deliver kernel with struct
> old_timespec32 timeout, but this struct type can not directly used by current
> sys_futex_waitv implementation.
> 
> The new function copy main logic of current sys_futex_waitv, just update parameter
> type from "struct __kernel_timespec __user *" to "struct old_timespec32 __user *,"
> and use get_old_timespec32 within the new function to get timeout value.
> 

From, what I recall, we don't want to add new syscalls with 
old_timespec32, giving that they will have a limited lifetime. Instead, 
userspace should be able to come up with a 64-bit timespec 
implementation for -m32.

Thanks,
	André
