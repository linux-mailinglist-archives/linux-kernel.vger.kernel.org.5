Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1C7CC57E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbjJQODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjJQODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:03:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F610F5;
        Tue, 17 Oct 2023 07:03:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF4DC433C9;
        Tue, 17 Oct 2023 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697551412;
        bh=2RVI5unbkvVvHNVKtdp3DCbxXfoaBxvBCnrwaiQJnEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpavnQq/MPo+pRHK9jljG3aSapy1YrAdo4fsHCIi6p9j0Abu+wjfv+1s7Ubb4zo/p
         emRJzomSM8xjNOvcBjk2YwyyEbFEa0ZSFneEVQf/susg2FIFDBOwY48WEokjxjO6tQ
         W4b+4BJYfZ7Yv8xMBLa111npbFLXnnXBr2aZTdY6RbLezHxJZ8ieQZPwdzDv3sGb+B
         P0srpgPZOnrbM1ZxbpVWXDwX+yQNIpMSlxz1G83huCFGtN3cZHWGQk6AwXaIhXHU8z
         cRqnNmvQ9+5M/fJlQiHMJa78ykdbIwmAHq9k9f9g2e7WWzpsfPGKejhozMy3By1DaE
         mlRTqtdiZmAxw==
Date:   Tue, 17 Oct 2023 15:03:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Message-ID: <39b003bc-df89-4e0b-929e-2c42354aaa86@sirena.org.uk>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
 <ZS6PKYMXDfAVTeLw@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rPnpHSvbtDULm9wM"
Content-Disposition: inline
In-Reply-To: <ZS6PKYMXDfAVTeLw@FVFF77S0Q05N>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rPnpHSvbtDULm9wM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2023 at 02:42:01PM +0100, Mark Rutland wrote:

> So unless sve_alloc() failed, at the instant the IRQ was taken:

> * `task->thread.sve_state` should be non-NULL
> * `task->thread_info.flags & TIF_SVE` should be 0

> ... so if `task->thread.sve_state` becomes NULL, I wonder if we end up
> accidentally blatting that as part of the context switch? I can't immedaitely
> see how/

We're possibly missing a fpsimd_bind_task_to_cpu() somewhere since all
the hilarity with KVM means that we don't use the task_struct to save
state, though the task that's taking the SVE trap shouldn't be impacted
there if it didn't set TIF_SVE yet.  There *is* a window where we have
TIF_SVE set but didn't yet do the rebind but that should be in a preempt
disabled section.

--rPnpHSvbtDULm9wM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUulCsACgkQJNaLcl1U
h9CDrwf9F5vaNDd43zZltxM9I4iAWUwV9jTzBwFgYdJJYE7zCJi/jFFpka6sO9PS
TdCruypGFw/39o5A3Mblh6BlMiWRg+2qV/I9XcZBI8EITUFc9s/HsMF2SrcV9HWH
n41FheFZQLVmuWQHRsqUdGJOpLSSk8HZV8VUvh0MoR1KNmYzosdK1ZOR3DxPgaDr
PTar2ZaiaS3xc+EBMTfBBHExnUKKY6ASrMPHO61o82lVIFx8JGw49IGbiKAwEvpY
Bt9vnUiPQKISnKoDGpuUZC0TbTVtzoa/crdXcHJpCHTd7evZe2t6TyXOISc3kdBe
5coGUVzldurIxR14J48phXawZwmsOw==
=beHi
-----END PGP SIGNATURE-----

--rPnpHSvbtDULm9wM--
