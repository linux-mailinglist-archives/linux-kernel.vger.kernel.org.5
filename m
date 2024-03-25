Return-Path: <linux-kernel+bounces-117075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B43488A6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5631F61844
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FA839E0;
	Mon, 25 Mar 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g.clemson.edu header.i=@g.clemson.edu header.b="vvsgXy/O"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE8548E7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371483; cv=none; b=Fkr0Otd78davCecG5SOqtMresiqFmXbiMDsTsyOwIpIgIPsFmBe+xxw4nfAuAInCRpNeoHm0BHImctjYlijlaeLnAKeyTMNlr5pF7APLrP0ZKwzkMAVykwiTfKUXJ0D2nzhrxAndU5hatOOV1t0TbJJvXRizcjbmFI77ZWvW8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371483; c=relaxed/simple;
	bh=B1wAbk/C+LPupcyaL1z2b3SMb+zNDqBRInZ6t+t6piM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmBuAc2h78SnNz1MagrUQ4EUAyBP87P7x2PfdyaGc2hevWZ9cQtCQPU3zP6c2Xs2wVTFN3gZHblLKUhhphQUtgVokJScOHMxNtLinbrNleZFVwP+ShwnEkvolUOI6a3Uu1JYjc+f6QSU4jUuznBMFJzqpvz63X+PUkMMK+xm6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=g.clemson.edu; spf=pass smtp.mailfrom=g.clemson.edu; dkim=pass (2048-bit key) header.d=g.clemson.edu header.i=@g.clemson.edu header.b=vvsgXy/O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=g.clemson.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.clemson.edu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61149e50602so8969727b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.clemson.edu; s=google; t=1711371480; x=1711976280; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMQfXtIqVS/OIi7oM+IRMIhVPPKoKmf2XqobljSQq3U=;
        b=vvsgXy/Ohglq+g5g9mz7GBJIupEgGCu/XPOj2pBxC96sgulxmsqI7QqZomdbSjh1kn
         xtOElnZLmuXQexDpHL0EQ+RbvammSpLtzb5bGPN9yJJg2cesvYknw/Uf7ZYqVzcaBQOm
         Nk7NNC9mv5jsFQ+c2eoQj4VmLXyGpFFNvb/23+eUeBDDETPrwTnZZGeRyP5N6nZsHJ5x
         6EV05aHGsXfmP7UH8NShGfftfqA6vJazsz577mVCRoC4HhshcxDBd2FLXGma4oUhaSPL
         eARfiKnzK+4paRWvNbc3vE89QY6dQQ6DHALhJvU4ZayeynfPznhj9ePtpRFX/TBpGluk
         4ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711371480; x=1711976280;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMQfXtIqVS/OIi7oM+IRMIhVPPKoKmf2XqobljSQq3U=;
        b=SYmEOCGzFMCDCc3JKPjorUDqIOdKGJzswPdf/G81HurCeMzF/ACZ5tGVCOVKo8FwDU
         mGvCSfYzWo6eSyhpO/46r7grCO/JwIVZVCrmi7l7B15AVmBYbI6QF5j7ROnoaN/fjDdU
         1YYVD4qRiucwDUvgxCHMHdgeBe8krbq1Vw2JWbWsoUZkxx5vJAD/wrg55+SIFG1RLGfp
         p+LTcj4UzmjBWZM8g6ifUtWfJkMCqwRhzTTavxh+HpXCN9HqXphWA5C2eiebtD4R5Tno
         FOciNQgyNNcwEYEStEjfRTajuzz3ZXAc1dBxo2lKdKYMTX4uytvXuatm3L+MPxTMJOJc
         +NJg==
X-Forwarded-Encrypted: i=1; AJvYcCUqoAPNyItAkmfmS8fueNquZy8rNc62OfRqawiA0gWGEX3rGLVSqSSYUIf1EaNz3bk9F9rP2aTsJ8rAE52S+Ko94gQsyDhmY2YocevX
X-Gm-Message-State: AOJu0Yxd1kvKs3OPrtcZIzUA7Zs8GcQeKa59JNYmvZsNRFYytHLWts9Q
	R8ztCDMxKQWvVV7SRBAYxXNP7oLn08Ln3hcVEnS60yi2nn9UiSpzQGtZ/HQM2g==
X-Google-Smtp-Source: AGHT+IFfODCE2okzJ0vPa5cn4qJeVHB9Ae+diOJbKfyd4XdyvwQoc+pXmNnBaMsgdpG+d9wZFVbs9A==
X-Received: by 2002:a81:8903:0:b0:611:967e:1d45 with SMTP id z3-20020a818903000000b00611967e1d45mr570030ywf.15.1711371480503;
        Mon, 25 Mar 2024 05:58:00 -0700 (PDT)
Received: from mephi-laptop.localnet (47.177.21.198.tigernet.wifi.dyn.clemson.edu. [198.21.177.47])
        by smtp.gmail.com with ESMTPSA id ep18-20020a05690c2c9200b00610c63ce18dsm998924ywb.65.2024.03.25.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:58:00 -0700 (PDT)
From: Emilio Mendoza Reyes <emendoz@g.clemson.edu>
To: neil.armstrong@linaro.org, dianders@chromium.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject:
 Re: [PATCH 2/2] drm/panel: Promote warn_dev to WARN for invalid calls in
 drm_panel.c
Date: Mon, 25 Mar 2024 08:46:16 -0400
Message-ID: <4878769.GXAFRqVoOG@mephi-laptop>
In-Reply-To: <87jzlqk5xr.fsf@intel.com>
References: <2388112.ElGaqSPkdT@mephi-laptop> <87jzlqk5xr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1881631.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1881631.tdWV9SEqCh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Emilio Mendoza Reyes <emendoz@g.clemson.edu>
Date: Mon, 25 Mar 2024 08:46:16 -0400
Message-ID: <4878769.GXAFRqVoOG@mephi-laptop>
In-Reply-To: <87jzlqk5xr.fsf@intel.com>
MIME-Version: 1.0

On Monday, March 25, 2024 5:37:52=E2=80=AFAM EDT Jani Nikula wrote:
> Please use git format-patch and/or send-email to send patches, without
> the inline PGP.
Yeah, sorry about that. I only noticed it was inline PGP after I sent the
patches. I didn't know if it would be okay to resend right after since I
didn't want to email spam. Sorry!

> Please use dev_WARN() which will handle the device specific warns for
> you, including dev_name().
Alright I changed my patch to use dev_WARN. The new version is at the
end of this email. Thank you for your time. Let me know if I there is
anything else to change.

Thanks,
EMR


Subject: [PATCH] drm/panel: Promote warn_dev to dev_WARN for invalid calls =
in
 drm_panel.c

Partially solve todo in kernel doc by promoting dev_warn calls to
dev_WARN.
Link: https://www.kernel.org/doc/html/v6.8/gpu/todo.html#clean-up-checks-fo=
r-already-prepared-enabled-in-panels

Signed-off-by: Emilio Mendoza Reyes <emendoz@clemson.edu>
=2D--
 drivers/gpu/drm/drm_panel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index cfbe020de54e..4459f4f5fe66 100644
=2D-- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -114,7 +114,7 @@ int drm_panel_prepare(struct drm_panel *panel)
 		return -EINVAL;
=20
 	if (panel->prepared) {
=2D		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
+		dev_WARN(panel->dev, "Unexpected attempt to prepare an already prepared =
panel\n");
 		return 0;
 	}
=20
@@ -162,7 +162,7 @@ int drm_panel_unprepare(struct drm_panel *panel)
 		return -EINVAL;
=20
 	if (!panel->prepared) {
=2D		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n=
");
+		dev_WARN(panel->dev, "Unexpected attempt to unprepare an already unprepa=
red panel\n");
 		return 0;
 	}
=20
@@ -208,7 +208,7 @@ int drm_panel_enable(struct drm_panel *panel)
 		return -EINVAL;
=20
 	if (panel->enabled) {
=2D		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
+		dev_WARN(panel->dev, "Unexpected attempt to enable an already enabled pa=
nel\n");
 		return 0;
 	}
=20
@@ -246,7 +246,7 @@ int drm_panel_disable(struct drm_panel *panel)
 		return -EINVAL;
=20
 	if (!panel->enabled) {
=2D		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
+		dev_WARN(panel->dev, "Unexpected attempt to disable an already disabled =
panel\n");
 		return 0;
 	}
=20
=2D-=20
2.44.0


--nextPart1881631.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTcaZbABwnECYA0cZI0LAN3EqikFgUCZgFyGAAKCRA0LAN3Eqik
FpFuAP4/1QuAz/TJZuulntE7Vh0B9fC++3b8IMjZjxBRd369WwEAxeqpvHwRFFmN
3W4H7asKnWDJeQl2nAz8RswSfucKgg4=
=Lpy8
-----END PGP SIGNATURE-----

--nextPart1881631.tdWV9SEqCh--




