Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7547BDC63
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbjJIMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbjJIMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:40:58 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10991;
        Mon,  9 Oct 2023 05:40:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D192A40E0187;
        Mon,  9 Oct 2023 12:40:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id svqpzAPLcT1r; Mon,  9 Oct 2023 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696855251; bh=e/DFUX3F3oyfThG7u4pDB9FaS5L33LSdcFtsyTpbLsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqcSUYkHGfasUgj96cuQ3UQccLU0tMbGeBCKfPWsjvqPDpwShi+ljpDDPhPmqYngH
         3bIUBiNqacgEQFRsc7j3EpmiU4e+e6B8LwEEUVCFcVTBBqdN72SXNVcaQUeppB6lUi
         LiTE/0Ny70T/W4mm0+03h7v5CH1ZJWK3CHvKMWSttS8AwHLsUxYK5SzTvaUa9wJeHR
         +bOLxXcHcZb91NWzLeS/GPR/Lu8xUtN8dlK412U+Mll2aJWJ/WWhJfx7xCKpjVhT77
         osXeNtkhyrzwd8IyKd2eGs3WzUslEOmNH1QtWNt5t913Ejbe/8iwrRjMHK2q+zpjL0
         +/vs0oZBC6esYE4t4uTxxr9wDk4D83yPRpsgt+ZkwXMXDE+CYud2QVarhH00o6Pfki
         BOh6vyrScSmLzB8RJLFaaCCXSh2CsHLpj3XRSJXlsbLoxbks5pUiF/QH7k2ngIVWTu
         /xPu17qDraWeIuQ36zEQKnyiE5lrOPt0MjccOOoTrru5CtzOkTo0sVrkcaBuy27UnB
         fDAskrrdzNaUMHtEDIFfH5GC6QLE2QO4CSlOvj8NxuIQZz5h92r8G0fbocMNri8zu0
         b0FRUYCgVtC3+40VF/8TtEdh6RmP0/fXM76Tp9Nou46X4aHhOchz3TO/QAMnT/IbcV
         KHl17f4nK/Aw1tJr2OrBUiKQ=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4BF440E0177;
        Mon,  9 Oct 2023 12:40:38 +0000 (UTC)
Date:   Mon, 9 Oct 2023 14:40:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, corbet@lwn.net, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v4 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Message-ID: <20231009124033.GBZSP0wcAT494wHWqG@fat_crate.local>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:53:52AM -0700, Reinette Chatre wrote:
> This work conflicts with Babu's series [1] that is also ready for inclusion.
> We could wait for outcome of next level review to determine who will need

Who is "next level review"?

> to rebase. It may help to provide a snippet of the conflict resolution
> in anticipation of Babu's series being merged first (I will propose exactly
> the same to Babu for the scenario of this work merged first).

Just lemme know which ones I should merge first and the others can be
rebased on top.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
