Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D95782505
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjHUIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHUIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:01:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D2A8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:01:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7611C2297B;
        Mon, 21 Aug 2023 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692604894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BBh7KO/rWIsvAPTT++pOv5NwgOadfrFZd4xxBSpVDM=;
        b=D+29zRSPO8o1VT2rMtedAIfwBcukofUh8QNyewcvhZGT0A6Qx7xyXh0p4K6oxKXVGdCnoi
        cFNdll2cQHuiU2U0jGxKk0w9cFYrFp9zdNFQo3JeXw7DJqvwTzB/AmLTZ29ANA50FjKY3g
        eahwssSEZK94HVMWOdEFmmB3IESojA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692604894;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BBh7KO/rWIsvAPTT++pOv5NwgOadfrFZd4xxBSpVDM=;
        b=fziSU3tsUIaB5AQnsBUTlaTDgVMRkSEm3IlmPKTyVEVAcgutZzV9eX/xiO6/Cra3zoHcHg
        Pb11Hl3R3r8nKFAA==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 0110A2C143;
        Mon, 21 Aug 2023 08:01:33 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id E2BEA4AB2B4; Mon, 21 Aug 2023 10:01:33 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
In-Reply-To: <CAHh=Yk8upMOdhma4EDZj_TsA2rf8=MQVrP2sidhmwBh3G-ix-Q@mail.gmail.com>
        (Nylon Chen's message of "Mon, 21 Aug 2023 15:51:14 +0800")
References: <20230615072302.25638-1-nylon.chen@sifive.com>
        <20230615-unvisited-deceit-9beab8ce987a@wendy>
        <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
        <20230615-luxurious-rewire-84ff9d639fea@wendy>
        <20230615084310.GA780@hsinchu15> <mvmo7lh2ip6.fsf@suse.de>
        <20230615094732.GA8710@hsinchu15>
        <CAHh=Yk8upMOdhma4EDZj_TsA2rf8=MQVrP2sidhmwBh3G-ix-Q@mail.gmail.com>
X-Yow:  Th' PINK SOCK... soaking... soaking... soaking...
 Th' PINK SOCK... washing... washing... washing...
 Th' PINK SOCK... rinsing... rinsing... rinsing...
Date:   Mon, 21 Aug 2023 10:01:33 +0200
Message-ID: <mvmy1i4ako2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 21 2023, Nylon Chen wrote:

> If RISC-V were to support the unwind table in the future, would we
> need to re-enable it? Would this require implementing related
> changes(module relocation type handler) at that time?

I'm not quite sure I understand your question.  Nothing in the kernel
makes use of unwind tables on RISC-V, so there is no point in generating
them.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
