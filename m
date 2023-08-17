Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A877F9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352365AbjHQOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352390AbjHQOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460DA30F1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D052167391
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D5C433C8;
        Thu, 17 Aug 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692284066;
        bh=zNN/g2JEV2MQM8Bk9Kb5enaybQWGkgP+9T/6BrJgIxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oV/uPJOHtATL/EGrGtqxS8C+/lo+NIBrSI9qdUo6DCw5snH/vLu5tQBL9n+ma4bOO
         0FvDGCC9urv+ylLk/ElEii1mEunlhnNgUH92lfZQYW/goFKxBnb069ZLVCmMe/mD2x
         oFcUyOrkIL06is9bTa5jJChAGKFelHO8DsTr6bXEukQEkBberZ4bve88NxO33M3UlI
         PnJGshBYJFuS3g1QQqcJTOogj+N0YDTcXx250Ee4oOybQ9BXVO/MCq12Ky7k36NL+5
         TenAk5v3Pdx+p8TWmyFcSciEPzyRMwQHpt5pEp0FdAc7m8Zwe/zvy4kfwOfZIjAcjP
         yh888be2oTHpw==
Date:   Thu, 17 Aug 2023 07:54:24 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230817145424.g7hkq7zj2iotaedn@treble>
References: <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
 <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
 <20230816160757.oegndrcnf2fvt7l3@treble>
 <20230816173531.GMZN0I40DEFE38Zxuz@fat_crate.local>
 <20230816182940.xw67h5xbilqpb5au@treble>
 <20230816185830.GOZN0cVl/pJcZUiPGY@fat_crate.local>
 <20230817090727.GBZN3jT0+gH2iTyeOF@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817090727.GBZN3jT0+gH2iTyeOF@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:07:27AM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 15 Aug 2023 11:53:13 +0200
> Subject: [PATCH] x86/srso: Correct the mitigation status when SMT is disabled
> 
> Specify how is SRSO mitigated when SMT is disabled. Also, correct the
> SMT check for that.
> 
> Fixes: e9fbc47b818b ("x86/srso: Disable the mitigation on unaffected configurations")
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20230814200813.p5czl47zssuej7nv@treble

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
