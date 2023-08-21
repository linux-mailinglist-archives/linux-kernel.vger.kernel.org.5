Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CEC78295D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjHUMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjHUMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40CEC2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338DD615A4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCCC433C9;
        Mon, 21 Aug 2023 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692621983;
        bh=QfHr3TwVh0T7XtdDdQup26sjK2MUEm2PDVaOMB9YabQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OItiQnv2kToKJYVpaO12QlNqdbLzISLy0lG6eDvWfj3XBoYT6B7es+0UmOQVby2wC
         U96R/UdUNJravQqH6qYfp44U59V9RP0Q2HTc0skh0p8DfMNSB3TQEoHnXlvhJuLKRv
         3p4DVCDZIMe0M9m3dmR7DsuFgKbK710ftY/V/344ah0eLb+MmXpDOTuQN2OaL7ApMg
         W96iFF7QSqdaHvuGqpYQcJlohjvaGdhzO9wfjMQRXj4qehOZbMgCKgPuBqdCX+H37D
         JmA7jd6cKd+U48S9lQb0sJRpl0/lyJbt/GCQWusa/zhXpheL1qo82Jb0LHQrS5owP/
         3C/1+3iNS/4nQ==
Date:   Mon, 21 Aug 2023 13:46:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Message-ID: <12a8953b-2182-43a6-8b4e-6026aa83bf4d@sirena.org.uk>
References: <20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org>
 <20230821121049.GA19670@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8/R8UoP1GQFsbqkL"
Content-Disposition: inline
In-Reply-To: <20230821121049.GA19670@willie-the-truck>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8/R8UoP1GQFsbqkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 01:10:50PM +0100, Will Deacon wrote:
> On Mon, Aug 07, 2023 at 11:20:38PM +0100, Mark Brown wrote:

> > I did some instrumentation which counted the number of SVE access traps
> > and the number of times we loaded FPSIMD only register state for each task.
> > Testing with Debian Bookworm this showed that during boot the overwhelming
> > majority of tasks triggered another SVE access trap more than 50% of the
> > time after loading FPSIMD only state with a substantial number near 100%,
> > though some programs had a very small number of SVE accesses most likely
> > from startup. There were few tasks in the range 5-45%, most tasks either

> Do you have any performance numbers to motivate this change? It would be
> interesting, for example, to see how changing the timeout value affects
> the results for some real workloads.

I agree, unfortunately I don't yet have a hardware setup so I can't do
those benchmarks myself at the minute - I just have the access trap
counting I mentioned in the commit message.  Last time I saw numbers the
access traps were about 70% of a syscall in a microbenchmark and we're
already suppressing them for non-blocking syscalls so I'd not expect
anything *too* revolutionary.

--8/R8UoP1GQFsbqkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTjXJoACgkQJNaLcl1U
h9BIxwf/W/qEBRrqU2Vyd4/z4dVG+W54+stFaOqp4GsblUMLtOTqLElb+dNpcKw9
4/enu/53458MGm4tr8iGy6LcJBitSROXtX89LZfeddnFsmttA+RRA0jZGmRLbT3G
Ia63OhHoJYrRkT7RrZVBomJgyQV86omq9Mf7mCttNchFywb9Cm7RaXpMwJ9lYxVo
cvG8tQq/WnKSvOgs8eR+PfrN2wi//8cmIPFarH6a8pFNh0zbkV6vcvY+zOen6Y3W
aSI+I+Nlt92BkrxNrG3X36GgIv0WRJzXoUfBQcqM0XN5mZNUAUP+5VulZ6nzQM5o
GsF4QoZQ2b9mUWbKT4Qqsx4S95n+Mw==
=Ko14
-----END PGP SIGNATURE-----

--8/R8UoP1GQFsbqkL--
