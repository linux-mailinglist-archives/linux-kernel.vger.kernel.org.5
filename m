Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFA77E749
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjHPRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345090AbjHPRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:10:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D462102;
        Wed, 16 Aug 2023 10:10:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D86FE21881;
        Wed, 16 Aug 2023 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692205804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3qfw7b6VtzK+oTiKTKRt1wxgxkLu2IP8WGIMKZ1KeE=;
        b=kfBE/ABLvbtRdT4Y/oml8zlIJJ8h7FdyIYd4nRtVX0Wi6fPLluFlhY7ixN9uVtginkmrLn
        Vp8OPN5Ds9K/JLuC9ypAlrYEv2CQibwbo/Kt9kFby84knAhWIqILT9SMLJRHHryzKQQMFq
        oHd5BSJgFu0uZn0hY2gPnsNAqakD1ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692205804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3qfw7b6VtzK+oTiKTKRt1wxgxkLu2IP8WGIMKZ1KeE=;
        b=p+3ad/X+2eMGyAeJ998W4vtW8ha4B42XTW69wVxk+sgxO+ihH2PBBTTsLOXvplboxAWViU
        o5Ej2tQfbghoTuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 695DF1353E;
        Wed, 16 Aug 2023 17:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bvKSGOwC3WQoSgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Aug 2023 17:10:04 +0000
Message-ID: <25b4000b-b61d-c109-0d5c-f71656d896d4@suse.de>
Date:   Wed, 16 Aug 2023 19:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND] scsi: fcoe: Fix potential deadlock on
 &fip->ctlr_lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bigeasy@linutronix.de,
        dave@stgolabs.net, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816155524.5913-1-dg573847474@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230816155524.5913-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 17:55, Chengfeng Ye wrote:
> There is a long call chain that &fip->ctlr_lock is acquired by isr
> fnic_isr_msix_wq_copy() under hard irq context. Thus other process
> context code acquiring the lock should disable irq, otherwise
> deadlock could happen if the irq preempt the execution while the
> lock is held in process context on the same CPU.
> 
> [ISR]
> fnic_isr_msix_wq_copy()
>   -> fnic_wq_copy_cmpl_handler()
>   -> fnic_fcpio_cmpl_handler()
>   -> fnic_fcpio_flogi_reg_cmpl_handler()
>   -> fnic_flush_tx()
>   -> fnic_send_frame()
>   -> fcoe_ctlr_els_send()
>   -> spin_lock_bh(&fip->ctlr_lock)
> 
> [Process Context]
> 1. fcoe_ctlr_timer_work()
>   -> fcoe_ctlr_flogi_send()
>   -> spin_lock_bh(&fip->ctlr_lock)
> 
> 2. fcoe_ctlr_recv_work()
>   -> fcoe_ctlr_recv_handler()
>   -> fcoe_ctlr_recv_els()
>   -> fcoe_ctlr_announce()
>   -> spin_lock_bh(&fip->ctlr_lock)
> 
> 3. fcoe_ctlr_recv_work()
>   -> fcoe_ctlr_recv_handler()
>   -> fcoe_ctlr_recv_els()
>   -> fcoe_ctlr_flogi_retry()
>   -> spin_lock_bh(&fip->ctlr_lock)
> 
> 4. -> fcoe_xmit()
>   -> fcoe_ctlr_els_send()
>   -> spin_lock_bh(&fip->ctlr_lock)
> 
> spin_lock_bh() is not enough since fnic_isr_msix_wq_copy() is a
> hardirq.
> 
> These flaws were found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> The patch fix the potential deadlocks by spin_lock_irqsave() to
> disable hard irq.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>   drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

