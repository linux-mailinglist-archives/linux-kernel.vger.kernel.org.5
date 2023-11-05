Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32A07E12AA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjKEIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:55:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960AEE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:55:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699174512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+scDlDhNhkUPIshK5XB+h8FHetyDO/Mc6Boo17zPpg=;
        b=dG37TWZuavaMQfosqPxCDLUlRQFhum2NYQtMTSKFCDwpKzsZ+IL7MZ6lWvAgHDUNCoQfDU
        3NwVsIMb1SX/empXV4zoXTIPCtniuOXkY7unTGEplkcJlKgIL9553VIBu85Oaycj1ZNNel
        PiWXTfL59detwIW1Rmd0xGTMCX84nirgLwZXCYJ0GylH7DekZddZoE6nQfTRmCeBxAMXpI
        kzpRyMrzBREziXcHBFV041C+3x/aSulY7GE+H0gpHL2EWz6kNHUCG9Q/xDY0WiJVFPnoUX
        qFwp65ENeOjDYroIb2hUW4S7yHe2NbdiZW6dM4aaEDamxXqE8l0cFSZY34Ww8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699174512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+scDlDhNhkUPIshK5XB+h8FHetyDO/Mc6Boo17zPpg=;
        b=q7GAEMPYyQ0uAcTxscpbCQH3x3bU4xe6KMBPB8vGkNgoScg5KE5PIDTjM0/M/av27nmqRe
        teReQ6U6yEm58kBg==
To:     Marc Zyngier <maz@kernel.org>, Fang Xiang <fangxiang3@xiaomi.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] irqchip/gic-v3-its: Flush ITS tables before writing
 GITS_BASER<n> registers in non-coherent GIC designs.
In-Reply-To: <87o7g96duv.wl-maz@kernel.org>
References: <20231030083256.4345-1-fangxiang3@xiaomi.com>
 <87o7g96duv.wl-maz@kernel.org>
Date:   Sun, 05 Nov 2023 09:55:11 +0100
Message-ID: <87bkc8inps.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04 2023 at 09:56, Marc Zyngier wrote:
> On Mon, 30 Oct 2023 08:32:56 +0000,
> Fang Xiang <fangxiang3@xiaomi.com> wrote:
>> 
>> In non-coherent GIC design, ITS tables should be clean and flushed
>> to the PoV of the ITS before writing GITS_BASER<n> registers, otherwise
>> the ITS would read dirty tables and lead to UNPREDICTABLE behaviors.
>> 
>> The ITS always got clean tables in initialization with this fix, by
>> observing the signals from GIC.
>> 
>> Furthermore, hoist the quirked non-shareable attributes earlier to
>> save effort in tables setup.
>> 
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
>> Tested-by: Fang Xiang <fangxiang3@xiaomi.com>
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>

Shouldn't this have a Fixes tag? My guess is:

a8707f553884 ("irqchip/gic-v3: Add Rockchip 3588001 erratum workaround")
