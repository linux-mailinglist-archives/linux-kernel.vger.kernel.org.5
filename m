Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCC779FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjHLMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:10:45 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48A93
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 05:10:46 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD98440E0191;
        Sat, 12 Aug 2023 12:10:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RLNOa3dP117p; Sat, 12 Aug 2023 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691842241; bh=YkHTbeBnbULkAw4MARezfclIsy1CqEIKcEgdX/M6Ylk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4MmKuFlQReFAVQmsv7IWMXc6zDbEaVcMFYjKUnPVQHpl3rkrj2jgp2yaM9WVRchu
         CvFIRUXn484OD1BFKrtEpB0mXCRzuwmYKObwjiMcmNN3BQoFzFpET6NwKysqKB2wpq
         zhV8eWAl/MU064kJ+Mvjj1aRpbZyRkllZmm09RS7sCruOOaGdiCvfdc3UD5wCrKKVJ
         HtDx5LNEHGc+XZILIHcE7EYggvV6fyHV9dP7jmcGtkXTm2ImN328R4aieAzDbYLASQ
         RWP3p6WEBjCPCIKKYfXb1f30Rg/wieEBPZVdqG53v5arRlmVGUCSgM2SWzc5dnbx7r
         wZwcNHBY+aT49GSGc4c9cz/UdCuycZEExEhfcaMbuMFnWSq2TrpFCLnR3J4EI7f95O
         rxGMrWfEQU30RYuQn1oVdG0aY6eEFpTAThcDtDjJCZcWimk7PpJ0iCWCfDHE91kZ3D
         mwJGxHCF7aUeGimon0Au+B9LnH8S4RKTkYtbnwGMbdaCnU5McCLO3fq9vpEF5Da3sV
         4WJxMnbW6bceYaVtRHdPmn/r1J2YOl1Jbnedi0GNtEWj4yoV2ZK9QSncklGIrYrskc
         zjoxv0e1FKdBEewbdp62mn7bfcVewnSvm8W7VW+sBHd/ELhjlUHBQA+ET/Lr+xC+09
         f5LcMuNZn4tO48TTHMkiDOz8=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C808C40E0185;
        Sat, 12 Aug 2023 12:10:34 +0000 (UTC)
Date:   Sat, 12 Aug 2023 14:10:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230812121034.GDZNd2umHEqcQNaFbJ@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
 <20230812112404.GB749618@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230812112404.GB749618@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:24:04PM +0200, Peter Zijlstra wrote:
> That very experience wants me to avoid doing it again :-/ But you all
> really want to keep the parameter, can we at least rename it something
> you can remember how to type, like 'srso=' instead of this horrific
> 'spec_rstack_overflow=' thing?

I'm all for short'n'sweet but last time I did that, Linus said we should
have option names which aren't abbreviations which don't mean anything.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
