Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64D1755E65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGQIZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGQIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8015E4E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 473F860C83
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A55C433C7;
        Mon, 17 Jul 2023 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689582321;
        bh=doFHr3QF6bY8ddY9UhfVjgKC7xXSlDDrpfA6E5eb81U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QryReVgmTffP0w3I9RGl4nFKC8sPFjHYkCtysJYPg9S/Sf6VJ5cTUoEpRNchMMySi
         x7bglbzQ/qOk6boZWTyNhibd4AoOatma0gz+uTxQBTUuiqtdWdj6bM1Vvs1GsWAtZN
         dMqewzojwlGJ+PjCkWr8Z+0dWkSctwS5qn4lmMtuSJYNjqORgaXJO8JFgkQ+F2t4Wm
         K8biyc4nm3dSHuA1g8DF7SLnxv4mVWZu0h0reo8TnsHBnOgjtRq+m+SkZ7gJ1r8JAs
         WXgY8cLs670wDadgVhj0UfiKgETTnFZMtx8WRyITd5OlDdD3Tbv435GR5sn+63IZDz
         +JtGNxVZmgPgg==
Date:   Mon, 17 Jul 2023 10:25:18 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, afd@ti.com,
        hns@goldelico.com, matthew.brost@intel.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, dakr@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] drm/imagination: Add GPU ID parsing and
 firmware loading
Message-ID: <fd2daftonqrd6ae2pc6jlyw5zv4n4hhmzb5ifnrhb24kjpzecp@vk74clsdhy2l>
References: <20230714142700.111897-1-sarah.walker@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7f4trdj3svh4pmk2"
Content-Disposition: inline
In-Reply-To: <20230714142700.111897-1-sarah.walker@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7f4trdj3svh4pmk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 03:27:00PM +0100, Sarah Walker wrote:
> +/**
> + * pvr_device_gpu_fini() - GPU-specific deinitialization for a PowerVR device
> + * @pvr_dev: Target PowerVR device.
> + */
> +static void
> +pvr_device_gpu_fini(struct pvr_device *pvr_dev)
> +{
> +	release_firmware(pvr_dev->fw_dev.firmware);
> +}
> +

Since you call that function at remove time, I think you can register a
devm action using devm_add_action_or_reset() to remove the need to call
it explicitly (and probably the need to have pvr_device_fini() in the
first place)

Maxime

--7f4trdj3svh4pmk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLT67gAKCRDj7w1vZxhR
xXSKAP9sDARcLROGvAko1J3uZQb/zCiLFU6sAlcdkH63quaN4QD9EaD0LaWdahRi
9dKFxXH1g5VK/dbuuzt8CBjXUQEMKwk=
=GtC6
-----END PGP SIGNATURE-----

--7f4trdj3svh4pmk2--
