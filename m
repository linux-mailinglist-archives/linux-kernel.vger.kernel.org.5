Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524FC7C4DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbjJKI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbjJKI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:59:26 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8F594
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:59:24 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B1A4F40E00B3;
        Wed, 11 Oct 2023 08:59:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YtHiCukQjjnw; Wed, 11 Oct 2023 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697014758; bh=Ra4gGr8i5aF7eW6uqhyYs6+xTztov7BDCF3Z2tq0RLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XR1p5GSNScnO6AT3aY8zUcMjWVhEebh586SQtl1WWhgfb5sDC/JuxBS4N49QW20Ti
         8zKnP40/FrmqMqjQMDeaS5l1N0RVf0z6yk/th4HSQuA7CArnGpmY9cwKS/r+hY1lLh
         13k+QrLwiEbCk/ki+kS3efxFgcl/sJdHoXVUQrUxBuVtEhZIpXZ9mMk3Qo21GGHZTn
         bewut8YpevLaGx0cwS4CUtAaHLFItZPHkExaQ1mxaWOim4z+bJT9J2SC3yVcNBT8cv
         +xaWajBmqvcmNnLvviEskUKMgfocJWTIQvtTJbNcYOBeGfGu/dAyVZTpY3IT02+a2j
         kvQs6vfSjXYAdbLvvQL80PZb8zzWtk2jn696+ymHIZGBGEzFiCf6HXIHN8f/pszhli
         uqEVfgTN3diLFCHD6z8sC2V5Q8+OP/Db6AQJ/Fy6GebP+95vuKY3KnSt7IhoXE7BQI
         cG3HV1yY3W+/cfoGp7mdrlKiJif98iOCXNiTF5Ym5luuYyval5tRlRJc8iWRJwlO89
         Cd/TBh97gXjeOi75ib9rzPPmfUFicSHnjDeNq4YN1sgPzF4tm+nirCBfH1mMu9JBxa
         kIN1umaWHOEf82W9sbH723tzt++iPuLzfalnFbYqHl1+Tnp4EhJ5V1qEv3aK3g3c5d
         xTDcerLk65seXZCif36nCABY=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D34E240E01AA;
        Wed, 11 Oct 2023 08:59:15 +0000 (UTC)
Date:   Wed, 11 Oct 2023 10:59:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
Message-ID: <20231011085907.GAZSZj2+ofC0S2ykDB@fat_crate.local>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
 <797F7A00-541E-4333-B653-1120DF5C56B1@exactcode.com>
 <20231006093244.GAZR/UPJidkn7GIGeL@fat_crate.local>
 <20231010083956.GEZSUN3OKuYSyU182V@fat_crate.local>
 <8AD7373A-7FAF-4823-9D8F-1EDF60EEAB6D@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8AD7373A-7FAF-4823-9D8F-1EDF60EEAB6D@exactcode.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:18:57PM +0200, Ren=C3=A9 Rebe wrote:
> On the first day the patch so far appears to have prevented
> the spurious #UD exception to appear again.
>=20
> Tested-by: Ren=C3=A9 Rebe <rene@exactcode.de>

Thanks for reporting and testing!

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
