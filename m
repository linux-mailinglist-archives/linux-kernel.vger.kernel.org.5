Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948757B81A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbjJDODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbjJDODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:03:34 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FBCAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:03:29 -0700 (PDT)
Received: from [IPV6:2a02:8109:aa40:4e0:b5c6:9671:3477:8fde]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 04 Oct 2023 14:03:25 +0000
Message-ID: <14c52402-ebc8-4425-9871-1663a87182ef@sdfg.com.ar>
Date:   Wed, 4 Oct 2023 16:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] seccomp: Split set filter into two steps
To:     Hengqi Chen <hengqi.chen@gmail.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com,
        Alban Crequy <albancrequy@linux.microsoft.com>
References: <20231003083836.100706-1-hengqi.chen@gmail.com>
Content-Language: en-US
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20231003083836.100706-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 10:38, Hengqi Chen wrote:
> This patchset introduces two new operations which essentially
> splits the SECCOMP_SET_MODE_FILTER process into two steps:
> SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.
> 
> The SECCOMP_LOAD_FILTER loads the filter and returns a fd
> which can be pinned to bpffs. This extends the lifetime of the
> filter and thus can be reused by different processes.

A quick question to see if handling something else too is 
possible/reasonable to do here too.

Let me explain our use case first.

For us (Alban in cc) it would be great if we can extend the lifetime of 
the fd returned, so the process managing a seccomp notification in 
userspace can easly crash or be updated. Today, if the agent that got 
the fd crashes, all the "notify-syscalls" return ENOSYS in the target 
process.

Our use case is we created a seccomp agent to use in Kubernetes 
(github.com/kinvolk/seccompagent) and we need to handle either the agent 
crashing or upgrading it. We were thinking tricks to have another 
container that just stores fds and make sure that never crashes, but it 
is not ideal (we checked tricks to use systemd to store our fds, but it 
is not simpler either to use from containers).

If the agent crashes today, all the syscalls return ENOSYS. It will be 
great if we can make the process doing the syscall just wait until a new 
process to handle the notifications is up and the syscalls done in the 
meantime are just queued. A mode of saying "if the agent crashes, just 
queue notifications, one agent to pick them up will come back soon" (we 
can of course limit reasonably the notification queue).

It seems the split here would not just work for that use case. I think 
we would need to pin the attachment.

Do you think handling that is something reasonable to do in this series too?

I'll be afk until end next week. I'll catch up as soon as I'm back with 
internet :)



Best,
Rodrigo
