Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583E783CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjHVJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjHVJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC7113;
        Tue, 22 Aug 2023 02:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC0F611BF;
        Tue, 22 Aug 2023 09:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD36C433C7;
        Tue, 22 Aug 2023 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692695737;
        bh=NaYhwuuLQL7D2HhPJrC7Hc7Nb5lI7cYzmX+Szyowccg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zrs701lvRJ/UmAaj/jAYYQzjqsZ6Ms4zD3t2FMKHSbz0sfcg6LOnGQSHWRe9P2Afg
         aKb1UC/hPXqwjVQOpho8UPGaYJOY0WNKI50NIdd9YUGzb/hsSQSWMfCwqNqw8ELS0i
         Us4BrSzztpUOpKNSGFXiIj0XekUCawa+QWVNK2k0=
Date:   Tue, 22 Aug 2023 11:15:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] tty/sysrq: replace smp_processor_id() with
 get_cpu()
Message-ID: <2023082259-blazer-charity-b58f@gregkh>
References: <20230822090112.2601273-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822090112.2601273-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:01:11PM +0500, Muhammad Usama Anjum wrote:
> The smp_processor_id() shouldn't be called from preemptible code.
> Instead use get_cpu() and put_cpu() which disables preemption in
> addition to getting the processor id. This fixes the following bug:
> 
> [  119.143590] sysrq: Show backtrace of all active CPUs
> [  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
> [  119.144586] caller is debug_smp_processor_id+0x20/0x30
> [  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
> [  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
> [  119.145053] Call trace:
> [  119.145093]  dump_backtrace+0x0/0x1a0
> [  119.145122]  show_stack+0x18/0x70
> [  119.145141]  dump_stack+0xc4/0x11c
> [  119.145159]  check_preemption_disabled+0x100/0x110
> [  119.145175]  debug_smp_processor_id+0x20/0x30
> [  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
> [  119.145211]  __handle_sysrq+0x8c/0x1a0
> [  119.145227]  write_sysrq_trigger+0x94/0x12c
> [  119.145247]  proc_reg_write+0xa8/0xe4
> [  119.145266]  vfs_write+0xec/0x280
> [  119.145282]  ksys_write+0x6c/0x100
> [  119.145298]  __arm64_sys_write+0x20/0x30
> [  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
> [  119.145332]  do_el0_svc+0x24/0x8c
> [  119.145348]  el0_svc+0x10/0x20
> [  119.145364]  el0_sync_handler+0x134/0x140
> [  119.145381]  el0_sync+0x180/0x1c0
> 
> Cc: stable@vger.kernel.org
> Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Add "Cc: stable@vger.kernel.org" tag
> ---

This is not a resend, it is a new version, v3.  Otherwise I would be
confused with the original v2 which is different than this one...

thanks,

greg k-h
