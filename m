Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433747B97F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjJDWZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjJDWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:25:26 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D985DD8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:25:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6F2E40E019B;
        Wed,  4 Oct 2023 22:25:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n9qBn8b4CMDs; Wed,  4 Oct 2023 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696458315; bh=EiwAAjwjSjz0ZgvaDDNabKgbn/F0A0FPDLTUB0mCu9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYQPjdHFKwXp0S88lcDR30T+4REbveHCK648u7kk0r3C9AaOjMp9hRpr+8BcmGOSC
         Sz9UYPxYG4iDSDpJdwM2q6CUy2k63+yquwLBqKig09QOJacWn9/1XnoHz/emS6uPB2
         JbdPy0BKGHLZ+JxCmw5yOQo40wKdWrtYj8P4pDXg4PnXj5U8VcWpXB/hQBvfXi+a99
         OAA8b2270hIqXWGup10++huXUjLSGVmkrt04+4i+FvlXv+27Ncjpb2MMLQDXyOfOW+
         myi7l86mucXwMp3bST7iwgkBlFEj1oyjjPdqJmEiOettb95Vd0E2xXQG4fRhmj8PDQ
         iNBe4m31kwMxgeGcZFC3DULBa7COPOIYXXAcZ4LNjeh1z+i6DSqt4ZRD3o5XcWkH/Y
         PGWiMepPQcaiD+SVQsIFeYvO0DJTIb2zZBsTksc3XqiGUKmSSVrmCjj2E0KGejaRuW
         Wwp+zsQw7oFQ8jxUHtQUdsIGeLJpHGdnKBW/9htoJ4chbm6zJDTaMKQ+HKeUyQrjfK
         /s1UrZzB9xy2s0KLkdXPLt/A68FotzxcI+KPURUWCMO24Azji+9dw+W7IApJIxE9bD
         wpyLwDnFO+qFuvUv+t5e9BDOWBzLrD4pMk/GbQ2Y6k/0Z0lcJaqk6Wn8HWtzA5VVci
         +bx4I42zjheEJv6bp1+KCJiA=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC35A40E019D;
        Wed,  4 Oct 2023 22:25:12 +0000 (UTC)
Date:   Thu, 5 Oct 2023 00:25:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
Message-ID: <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 05:29:32PM +0200, Ren=C3=A9 Rebe wrote:
> during cross compiling our =E2=80=9CEmbedded=E2=80=9D Linux Distributio=
n T2 (https://t2sde.org) I observers some random illegal instruction buil=
d errors since we got ourselves a Ryzen 7950x on launch day a year ago:

Thanks for reporting. I'm looking into it.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
