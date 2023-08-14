Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95A77B638
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbjHNKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjHNKMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:12:06 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85487171A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:11:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 40E4B40E019C;
        Mon, 14 Aug 2023 10:11:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XPslDBwXDHIs; Mon, 14 Aug 2023 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692007903; bh=/O9fn8QGZ3gDAatYZoz8dvwyIrZcaYK98Ic935cyokU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0BeA6vgNt5+eT5JIyLAFdLXLktFVV8oTRR9y8BQArm/klkXRzjqX18BaMy+jELEv
         OSxkap0IgKAry1MtEDRz/9nwC9GBFCk0Xz9LkNO+t8pvTbsrCLBqM4raDQth1R/z48
         fv//3CZv4BkwQB/MhUTO2ithEoFn0nxt7bzsopxadvX1kp3RtU3kd8NGTU4rbYnZrG
         5+2VAIVYx0P3EXifwOO+JBSEUtxFfyT7N1LnfUl9NUALajDS1p6yJH3YuUFh5xyJv3
         SLxeDpFxvYRmkZwks14p61dLZDN9r66P50Un0y5BNuaaiohdRzFlM+6BEo/BBXi1ow
         +thdt0qT81+e3uebFnBxOcNfJi+GH6mjV/V/7UNb48N2vOBbc1A5dZ7ox9G+Bq/g6j
         Dc+pPCaPaaVQXdCRcHhm2dwi5hKDjjR6DIQT2dwAO07eBdWgWM2YwN8Wxi4KEaN+e1
         3Y9Mv/d+2zTqNNoClwr0M6PKvNRNlF96KmFZAa67r2QUjqhTiQokqQIt2rNaWrsnW/
         NdMIcByvWIHPQXiGISypmod27Yi3pD3KyTIbe4xz5uPAlYg5FKxYB2xIwbxJ9y0ym+
         g8Fl15rsJxeySozxDyr3O6ySlDZBY7CN4tyE8UWytgShOVH30btAgBUZqUipzd30nu
         pVxFCZbuJbL8RKmnNIeTfc4c=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1030240E0197;
        Mon, 14 Aug 2023 10:11:39 +0000 (UTC)
Date:   Mon, 14 Aug 2023 12:11:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Does srso safe RET mitigation require microcode update?
Message-ID: <20230814101134.GBZNn91uTmNImxRDXr@fat_crate.local>
References: <79c179acaa6ec4e1cf112ae2dfce8370694a5089.camel@xry111.site>
 <20230814091012.GAZNnvdD6JX/4E679D@fat_crate.local>
 <0338eb8b-6b60-313c-e6eb-faca071c5227@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0338eb8b-6b60-313c-e6eb-faca071c5227@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:47:54AM +0200, Rainer Fiebig wrote:
> "* 'Mitigation: safe RET':
>
>    Software-only mitigation. It complements the extended IBPB microcode
>    patch functionality by addressing User->Kernel and Guest->Host
>    transitions protection."
>
> Now, what does that mean: partial mitigation or also no mitigation
> without microcode?

It *complements*! Meaning, for a full safe RET mitigation, you need the
microcode on Zen3/4.

Would that explain it better?

"First of all, it is required that the latest microcode be loaded for
mitigations to be effective. That means that for the User->User
aspect of the mitigation to be effective, one needs the updated
microcode for Zen3 and Zen4 generations. In addition, one needs to
*enable* the User->User mitigation which is part of the spectre_v2_user
controls:

  - conditional IBPB:

  where each process can select whether it needs an IBPB issued around
  it PR_SPEC_DISABLE/_ENABLE etc, see Spectre Side Channels. That is the
  default setting

  - strict:

  i.e., always on - by supplying spectre_v2_user=on on the kernel
  command line."

IOW, without microcode, you do not mitigate the User->User aspect of the
mitigation but you mitigate the other vectors with safe RET.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
