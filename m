Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A38770E00
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHEGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEGFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:05:21 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEA44ED0;
        Fri,  4 Aug 2023 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1691215516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yFtMnGLfEgodoGei2h8UZe336PyKSdPdvngnYXixpuk=;
        b=mnIpEaYqalGvm/XZ2MCRMjBcckZXRSyH5eNPNCEyomrA1LMmwPHuE64jRdARiRpPRCrHoB
        viphSUE6F/W7jKtbWFdqFJcUVEx5YiTj3O/Lh1xzOxncrA0o1KqEJEjsfaHhEK/4fHO8eZ
        XQbmBdxQaDkwHOEkin7OctVmp3XOwhk=
From:   Sven Eckelmann <sven@narfation.org>
To:     Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        stable@vger.kernel.org
Subject: Re: [PATCH net] batman-adv: Fix TT global entry leak when client roamed back
Date:   Sat, 05 Aug 2023 08:05:13 +0200
Message-ID: <2693362.mvXUDI8C0e@sven-l14>
In-Reply-To: <20230804093936.22257-1-repk@triplefau.lt>
References: <20230804093936.22257-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12259810.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12259810.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Aug 2023 08:05:13 +0200
Message-ID: <2693362.mvXUDI8C0e@sven-l14>
In-Reply-To: <20230804093936.22257-1-repk@triplefau.lt>
References: <20230804093936.22257-1-repk@triplefau.lt>
MIME-Version: 1.0

On Fri, 04 Aug 2023 11:39:36 +0200, Remi Pommarel wrote:
> When a client roamed back to a node before it got time to destroy the
> pending local entry (i.e. within the same originator interval) the old
> global one is directly removed from hash table and left as such.
> 
> But because this entry had an extra reference taken at lookup (i.e using
> batadv_tt_global_hash_find) there is no way its memory will be reclaimed
> at any time causing the following memory leak:
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Fix TT global entry leak when client roamed back
      commit: d25ddb7e788d34cf27ff1738d11a87cb4b67d446

Kind regards,
	Sven
--nextPart12259810.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTN5pkACgkQXYcKB8Em
e0ap+A//aSI43I++QPAWQlTYcHVDZcDtCcVIk9qdSEvQtO62jJZYnBYyLZdvkcvY
/cQTjjSZY08wCzU3c9TEHPPnrZruRD+pDNn3m64izZhQ2BmAuHwIztociQytinan
I3oDTBL7wZYZu+66t/5NtRyD4vVE0Vr+1s0U1TR2DYkGALKsD9VGJOGKGLAJSF2i
PgDVjjDgqkEtdjvTnpC3a4phFumVfJLgNJBuuQ7FYEb+VQf37Wect8du4dMy+GNw
ifpZ+bqXWFKt0WP5M8r8T4M+NIpm3cS6a0ij3q4IVNI6xWzpmWjIiP2UG6lzpHna
BXOfPm2F7ArycTyyijg30hnTv3oV43Xpyy/vqMA7jRQRmnpeh9l96Rsew/MOouPQ
KUco8AazBnqOmX5fqpu1+uZFC+7h/ADVaUF6sbgfSQtyxPp0ggBAIAAAaHFfvGP+
1qLhIHCGPjdQVqRNpSHR85x5V5NYdlKwa91f/LE2oKz4Yt207/LNTeUfmYxeykz5
FsBwZPf77gdBCn0V533zqgreZ6aldqXp6+SWcbrKPChoV0h9AhfCsRQZGs+q4L6Q
Iwrh/iP+RQzWWLS/l6Xj9P6GSks3326kcWFPQwssdtXTZXPWAAhQ+m8lzIXbcaJ1
UGHrl6QLoNNr4/pnqCuTQmECHnSlMj//uB+KE1HaLp3JQZtV6z0=
=dwZT
-----END PGP SIGNATURE-----

--nextPart12259810.O9o76ZdvQC--



