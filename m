Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2C77B913
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjHNMxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHNMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:53:06 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E194
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:53:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E391040E0196;
        Mon, 14 Aug 2023 12:53:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BCRUEbTkMEpH; Mon, 14 Aug 2023 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692017580; bh=oeHBEWvonmkHqTzAX1tmL+zX2cqupv+iys/IhcfXR1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOyHu5eAylFUYjlPBZDNIL+aLmF7Ir+QT6smawT1RSNJaN08dDVDOSkopkL1fB70B
         T9ANIWWELol5Hd/LIsbFVPHNNit1JyrrlVodez32nLrI5Zk5lP0xtYPv7afpM+F71S
         U+vkXV58ayxvWR6zKtJ6PkpvHbEbMyN7yFIATjxEglXWKwQuL8Hhjg6PF2bH2a1J5A
         yL9kRjEeunoeZsGgv4OiG8Bqr7Lwfu1Qa5/6JjxTAGa5jbEr5HEv1l5OhB5tYBjfHw
         zn8dtzy43UzpGZ7eHRKekmGtkxZBATRxV63qA03rQ2o9rBWRdZjm2Og5ztvadYWJvF
         EdqPPOuS04jw7x1iN699MYXVDLz1TkBaTVQFm5YNY3TmLpSNs0AQJmWxhOvGRdPRPf
         iG6JiB3z97DdwsAibUJlrB4PyXHow0r0XdaMaSXaFMH2kmi5fKPj8GDrluOs2wijMS
         ezIqXW1V/SS4GJ4PgzLmchFYfDFogSzu1NluYociKeNWQdpwv25o3cgAgZx+sAaBcS
         Y8WepRi5Kn3tQhv8WWkKAuonM23N+bWlBbEzw6M7RsexP9naW5tgxpWNQTySuETrsJ
         5EnrKf6ScE2PbQyCLQRdBpzLR9rbEVsnKLgFW0LbBAczepeQnkFwhoDKPps+5DMt4n
         lmgnAe8eZ3BHOMqgpLCd9D/o=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76AC340E0195;
        Mon, 14 Aug 2023 12:52:55 +0000 (UTC)
Date:   Mon, 14 Aug 2023 14:52:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Does srso safe RET mitigation require microcode update?
Message-ID: <20230814125249.GCZNojoW8pC+ToOews@fat_crate.local>
References: <79c179acaa6ec4e1cf112ae2dfce8370694a5089.camel@xry111.site>
 <20230814091012.GAZNnvdD6JX/4E679D@fat_crate.local>
 <0338eb8b-6b60-313c-e6eb-faca071c5227@mailbox.org>
 <20230814101134.GBZNn91uTmNImxRDXr@fat_crate.local>
 <9294eeed-e354-48e3-a0fe-8f917074ef8f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9294eeed-e354-48e3-a0fe-8f917074ef8f@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:21:01PM +0200, Rainer Fiebig wrote:
> OK, thanks.  So I think a reasonable approach for ordinary users would
> be to update to the latest (LTS-) kernel, use the defaults for the
> mitigations and update to the new AGESA when available.

Yap, pretty much.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
