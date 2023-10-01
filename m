Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79EF7B48A1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjJAQcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:32:54 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12EDD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:32:50 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 969DA15278A8;
        Sun,  1 Oct 2023 18:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696177967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kzlx67CZy1QScrq/jKerHGDJqCFa+KgwdJ4AQpm3+/U=;
        b=wBqt2wD+/+KVgBjumuMHmn7e24m7vh0dC5jcwSmWh+WHGJfdxoit0e8N0UgyRmw0UW66w8
        TjqbY0kuJHHuNvHOC4fbYnt73wJogoap/aGirEUX1vDiKQkno2VY1axPktvNwrbuB21OhG
        8AszvDBNaOI55a6C9VdO1TN3kLWcOps=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: [REGRESSION] BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250
Date:   Sun, 01 Oct 2023 18:32:34 +0200
Message-ID: <13360591.uLZWGnKmhe@natalenko.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2904309.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2904309.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Oct 2023 18:32:34 +0200
Message-ID: <13360591.uLZWGnKmhe@natalenko.name>
MIME-Version: 1.0

Hello.

I've got a VM from a cloud provider, and since v6.5 I observe the following kfence splat in dmesg during boot:

```
BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250

Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ] (in kfence-#108):
 drm_gem_put_pages+0x186/0x250
 drm_gem_shmem_put_pages_locked+0x43/0xc0
 drm_gem_shmem_object_vunmap+0x83/0xe0
 drm_gem_vunmap_unlocked+0x46/0xb0
 drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
 drm_fb_helper_damage_work+0x96/0x170
 process_one_work+0x254/0x470
 worker_thread+0x55/0x4f0
 kthread+0xe8/0x120
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1b/0x30

kfence-#108: 0x00000000cda343af-0x00000000aec2c095, size=3072, cache=kmalloc-4k

allocated by task 51 on cpu 0 at 14.668667s:
 drm_gem_get_pages+0x94/0x2b0
 drm_gem_shmem_get_pages+0x5d/0x110
 drm_gem_shmem_object_vmap+0xc4/0x1e0
 drm_gem_vmap_unlocked+0x3c/0x70
 drm_client_buffer_vmap+0x23/0x50
 drm_fbdev_generic_helper_fb_dirty+0xae/0x310
 drm_fb_helper_damage_work+0x96/0x170
 process_one_work+0x254/0x470
 worker_thread+0x55/0x4f0
 kthread+0xe8/0x120
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1b/0x30

freed by task 51 on cpu 0 at 14.668697s:
 drm_gem_put_pages+0x186/0x250
 drm_gem_shmem_put_pages_locked+0x43/0xc0
 drm_gem_shmem_object_vunmap+0x83/0xe0
 drm_gem_vunmap_unlocked+0x46/0xb0
 drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
 drm_fb_helper_damage_work+0x96/0x170
 process_one_work+0x254/0x470
 worker_thread+0x55/0x4f0
 kthread+0xe8/0x120
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1b/0x30

CPU: 0 PID: 51 Comm: kworker/0:2 Not tainted 6.5.0-pf4 #1 8b557a4173114d86eef7240f7a080080cfc4617e
Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
Workqueue: events drm_fb_helper_damage_work
```

This repeats a couple of times and then stops.

Currently, I'm running v6.5.5. So far, there's no impact on how VM functions for me.

The VGA adapter is as follows: 00:02.0 VGA compatible controller: Cirrus Logic GD 5446

Please check.

Thanks.

-- 
Oleksandr Natalenko (post-factum)
--nextPart2904309.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUZnyIACgkQil/iNcg8
M0tJmQ/8DhTcxuPGXLnGUgCfwyogSk1PChHX3rmyptaGWxzJGH5ztqyjcdoHIYkI
38js69NPzumIuHUMhGF6ipb7ZDkqfhJTzVAWyf7s86Aau9SBWFkUDieoIxqm6CaJ
CyIxgTtVi2FalaIZiRcrJOW4bOy7tujJKlEvz43RBSoHHgBEjSx3dCYiGHNWxvWw
pG3SFZLdDNKzZs1kUdrfwqft6OxOvA85hATzVJDKs7OvMuYDCU2trDspGVs9XVa6
I99s6DJGA2uGENneAlgwti8ACY3xH+IkfNI6Fe/9vIqQYHFHpTnKqyp3HbUN18fS
En8QDtGCNChlHwFEWcB7HaFW9VXg89lpWM9MRyuSixVFijbq/vFt1AJMUEgUhYEu
nGm68xtaE/OktfzsMuOm3VV5pt4Q5MfgbFMql/a1VBpqt+NQH1jf3U6X6Mu3CBrN
QWUaQGgZMfF4y15r+lBKkDr4mrdH5kdWNu2kP5MNG8qixn4XrxCd/EkRvN4QpstC
pP+lpwVuoPpDYnqOm//zhS3p+sJdTN5B9IhBhrFOCdgisLzIyJzyLlTjDi+CRGS9
NXLPrzvFUxfpgy23N41lqYUvShb3WXsHnSWtULbrFv3J1JN/rCQ+I9tk7HuXW6W/
SPJzW28+5hoTrUF7EPl84GYXm0dJBU0BA1atbhfqFJO/AKaWHKo=
=wsqg
-----END PGP SIGNATURE-----

--nextPart2904309.e9J7NaK4W3--



