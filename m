Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0971D7A4E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIRQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjIRQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:19:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C2359F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:59:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 160EB1FF4F;
        Mon, 18 Sep 2023 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695047746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5GqvT7I7TwNxkIgcBAkxvwIrrsobgjxUNhAyhO2TG0=;
        b=WFhcrZBp9GRwPncyU4nO8fMBLecSSAJP9vYbBL6xd0muDFlkPkRt7DKkCB2lE279Hhpnmz
        /guvbkOZRIwdFX65x8JwDTT1Ok2XVAnoXYGTRu8IMw2TJQCM/+QwEMmMmduYGiKABO0adb
        oPle5fmpvlKAu6TeRZ3K4/pstbdmHHo=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B18022C142;
        Mon, 18 Sep 2023 14:35:45 +0000 (UTC)
Date:   Mon, 18 Sep 2023 16:35:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 6/8] printk: nbcon: Add sequence handling
Message-ID: <ZQhgQMqHzZ1WMvjo@alley>
References: <20230916192007.608398-1-john.ogness@linutronix.de>
 <20230916192007.608398-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916192007.608398-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-09-16 21:26:05, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add an atomic_long_t field @nbcon_seq to the console struct to
> store the sequence number for nbcon consoles. For nbcon consoles
> this will be used instead of the non-atomic @seq field. The new
> field allows for safe atomic sequence number updates without
> requiring any locking.
> 
> On 64bit systems the new field stores the full sequence number.
> On 32bit systems the new field stores the lower 32 bits of the
> sequence number, which are expanded to 64bit as needed by
> folding the values based on the sequence numbers available in
> the ringbuffer.
> 
> For 32bit systems, having a 32bit representation in the console
> is sufficient. If a console ever gets more than 2^31 records
> behind the ringbuffer then this is the least of the problems.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
